
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
require('lspconfig')['pyright'].setup {
  capabilities = capabilities,
}
require('lspconfig')['gopls'].setup {
  capabilities = capabilities,
}
require('lspconfig')['yamlls'].setup {
  capabilities = capabilities,
}
require('lspconfig')['bashls'].setup {
  capabilities = capabilities,
}
---require('lspconfig')['azure_pipelines_ls'].setup {
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

require('lspconfig')['terraformls'].setup {
  capabilities = capabilities
}
require('lspconfig')['ansiblels'].setup {
  capabilities = capabilities
}
require('lspconfig')['docker_compose_language_service'].setup {
  capabilities = capabilities
}
require('lspconfig')['lua_ls'].setup {
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

--vim.cmd("colorscheme nightfox")

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

--vim.g.clipboard = {
--  name = 'WslClipboard',
--  copy = {
--    ['+'] = 'clip.exe',
--    ['*'] = 'clip.exe',
--  },
--  paste = {
--    ['+'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r",""))',
--    ['*'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r",""))',
--  },
--  cache_enabled = '0',
--}

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  desc = "Disable New Line Comment",
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

vim.opt.termguicolors = false
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

-- not sure if this works
--vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--  pattern = vim.fn.globpath("/home/pavle/AzureRepos/RubySystems/RubyConfig", "**/*.{yaml,yml}", 0, 1),
--  command = "set filetype=yaml.ansible"
--})
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

