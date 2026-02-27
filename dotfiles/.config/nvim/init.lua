-- load packer and it's plugins
require("plugins")
require("lsp_configs")
require("autocmds")
require("filetypes")
require("evil_lualine")
require("nvim_cmp")
require("nvim_tree")

--- disable netrw at the very start of your init.lua
--- avoids conflicts with nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

------------------------- plugin setup ------------------------------

vim.g.terraform_completion_keys = 1
vim.g.terraform_registry_module_completion = 1

--- vim-better-whitespace
vim.g.strip_whitespace_on_save=1

-----------------------------------------------------------------------

-------------------- general vim/nvim options -------------------------

local vimopts = {
  number = true,
  tabstop = 8,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  autoindent = true,
  scrolloff = 8, -- start scrolling file before end
  swapfile = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,
  cursorline = true,
  splitbelow = true,
  wrap = false,
  termguicolors = true,
}

for key, value in pairs(vimopts) do
	vim.opt[key] = value
end

-- enable syntax highlighing and filetype specific indentation rules
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-----------------------------------------------------------------------

---------------------------- keymaps ----------------------------------

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

--- paste previous buffer hack
map("x", "<leader>p", "\"_dP", opts)

--- nvim-tree
map('n', '<leader><Tab>', '<Cmd>NvimTreeToggle<CR>', opts)

--- barbar.nvim
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

----------------------------------------------------------------------
