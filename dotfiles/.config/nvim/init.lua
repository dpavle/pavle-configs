-- load packer and it's plugins
require("plugins")
--require("coc")
require("evil_lualine")
require("nvim_cmp")
require("nvim_tree")
---require("bubbles")

--- disable netrw at the very start of your init.lua
--- avoids conflicts with nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

------------------------- plugin setup ------------------------------

--local lsp_status = require('lsp-status')
---require("lualine").setup({
---       sections = { lualine_c = { 'filename', { function() return vim.fn['coc#status']() end }, }, },
---       options = { theme = 'material' },
---})
---

local lspconfig = require('lspconfig')

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig['pyright'].setup {
  capabilities = capabilities,
}
lspconfig['gopls'].setup {
  capabilities = capabilities,
}
lspconfig['yamlls'].setup {
  capabilities = capabilities,
}
lspconfig['bashls'].setup {
  capabilities = capabilities,
}
---lspconfig['azure_pipelines_ls'].setup {
---  capabilities = capabilities,
---  root_dir = lspconfig.util.root_pattern(".git", "azure_pipelines", ".azuredevops"),
---  settings = {
---    yaml = {
---      schemas = {
---        --["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/main/service-schema.json"] = {
---          ["file://" .. vim.fn.expand("~/.azure-devops/custom-yaml-schema.json")] = {
---          "azure-pipelines.yml",
---          "pipelines/*.yml",  -- Adjust to match your custom pipeline paths
---          "*/pipelines.yml",
---          "azure_pipelines/*.yml",
---          ".azuredevops/pipelines/**/*.yml",
---          ".azuredevops/pipelines/builds/**/*.yml",
---        }
---      }
---    }
---  }
---}

lspconfig['terraformls'].setup {
  capabilities = capabilities
}
lspconfig['ansiblels'].setup {
  capabilities = capabilities
}
lspconfig['docker_compose_language_service'].setup {
  capabilities = capabilities
}
lspconfig['lua_ls'].setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      }
    }
  }
}

vim.g.terraform_completion_keys = 1
vim.g.terraform_registry_module_completion = 1

---------------------------------------------------------------------

vim.cmd("colorscheme nightfox")

--------------------- barbar.nvim keymaps ---------------------------

-- keymaps for switching tabs with Alt-[0-9]
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-----------------------------------------------------------------------

-------------------- general vim/nvim options -------------------------

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

--- use Windows clipboard in WSL environment

local virt_environment = io.popen('systemd-detect-virt')

if virt_environment == nil or virt_environment == '' then
  return
else
  local virt_env_out = virt_environment:read('*a')


  if virt_env_out ~= 'wsl' then
    vim.g.clipboard = {
      name = 'WslClipboard',
      copy = {
        ['+'] = 'clip.exe',
        ['*'] = 'clip.exe',
      },
      paste = {
        ['+'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r",""))',
        ['*'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r",""))',
      },
      cache_enabled = '0',
    }
  end
end

virt_environment:close()

--------------------------------------------------------------

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  desc = "Disable newline comment continuation",
})

---------------------------- keymaps ----------------------------------

vim.g.mapleader = " "

--- paste previous buffer hack
map("x", "<leader>p", "\"_dP", opts)

--- terminal binds
map('n', '<leader>t', '<Cmd>ToggleTerm<CR>', opts)
map('t', '<leader>t', '<C-\\><C-n><Cmd>ToggleTerm<CR>', opts)
map('t', '<ESC>', '<C-\\><C-n>', opts)

--- nvim-tree
map('n', '<leader><Tab>', '<Cmd>NvimTreeToggle<CR>', opts)

----------------------------------------------------------------------
vim.opt.number = true

vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
--- vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

--- disable editorconfig loading for .yaml buffers
--- (fixes tab indentation when working on yaml files in directories/repos where tab indentation is enforced)
local function disable_editorconfig()
  vim.g.editorconfig = false
end
vim.api.nvim_create_autocmd("FileType", { pattern = "yaml", callback = disable_editorconfig })

--function Get_visual_selection()
--  local s_start = vim.fn.getpos("'<")
--  local s_end = vim.fn.getpos("'>")
--  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
--  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
--  lines[1] = string.sub(lines[1], s_start[3], -1)
--  if n_lines == 1 then
--    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
--  else
--    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
--  end
--
--  return table.concat(lines)
--end
--
--local function replace_visual_selection(replacement)
--  -- Get start and end positions
--  local s_pos = vim.fn.getpos("v")
--  local e_pos = vim.fn.getpos(".")
--
--  -- Swap if needed (cursor might be at start or end)
--  if s_pos[2] > e_pos[2] or (s_pos[2] == e_pos[2] and s_pos[3] > e_pos[3]) then
--    s_pos, e_pos = e_pos, s_pos
--  end
--
--  -- Replace the selected text
----  vim.api.nvim_buf_set_text(
----    0,                      -- current buffer
----    s_pos[2] - 1,           -- start row
----    s_pos[3] - 1,           -- start col
----    e_pos[2] - 1,           -- end row
----    e_pos[3],               -- end col
----    { replacement }         -- replacement text
----  )
--    vim.api.nvim_buf_set_lines(
--      0,
--      s_pos[0],
--      s_pos[0],
--      false,
--      { replacement }
--    )
--
--  -- Exit visual mode
--  vim.api.nvim_feedkeys(
--    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
--    "x", false
--  )
--end
--
-- function Ansible_encrypt_str()
--   local str = Get_visual_selection()
-- 
--   local encrypt_string_cmd = io.popen(string.format('python ansible_vault_wrapper.py %s', str))
-- 
--   if encrypt_string_cmd == nil or encrypt_string_cmd == '' then
--   else
--     local encrypted_string = encrypt_string_cmd:read("*a")
--     replace_visual_selection('')
-- 
--   end
-- end
-- 
-- vim.cmd([[ command! AnsibleEncryptStr lua Ansible_encrypt_str()]])
-- map('v', '<leader>aes', ":<C-u>:AnsibleEncryptStr<cr>", {silent = true, noremap = true})

-- not sure if this works
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = vim.fn.globpath("/home/pavle/AzureRepos/RubySystems/RubyConfig", "**/*.{yaml,yml}", 0, 1),
  command = "set filetype=yaml.ansible"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*compose*.yml", "*compose*.yaml"},
  command = "set filetype=yaml.docker-compose"
})

vim.opt.scrolloff = 8 -- start scrolling file before end

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.wrap = false

------------------------------------------------------------------------

--- vim-better-whitespace
vim.g.strip_whitespace_on_save=1

-- enable syntax highlighing and filetype specific indentation rules
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

---vim.g.coc_filetype_map = {
---    ['yaml.ansible'] = 'ansible',
---}

