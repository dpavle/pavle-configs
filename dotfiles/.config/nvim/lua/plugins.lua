local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    use ("wbthomason/packer.nvim") -- Have packer manage itself

    -- ui & ux
    use ("nvim-tree/nvim-tree.lua")
    use ("nvim-tree/nvim-web-devicons")
    use ("romgrk/barbar.nvim")
    use ("nvim-lualine/lualine.nvim")
    use ("nvim-lua/lsp-status.nvim")

    -- qol functions and features
    use ("neovim/nvim-lspconfig")
    use {
      "royanirudd/clipboard-history.nvim",
      config = function()
        require("clipboard-history").setup({
          max_history = 30,  -- Maximum number of items to store in the clipboard history
          enable_wsl_features = false,  -- Set to true if you're using WSL and want Windows clipboard integration
        })
      end
    }
    use ("iamcco/markdown-preview.nvim")
    use ("ntpeters/vim-better-whitespace")
    use ("tpope/vim-surround")

    -- syntax highlighting
    use ("pearofducks/ansible-vim")
    use ("juliosueiras/vim-terraform-completion")
    use ("grafana/vim-alloy")

--    use {"m4xshen/autoclose.nvim", config = function()
--      require('autoclose').setup()
--    end}
--    use ("lewis6991/gitsigns.nvim")
--    use ("sindrets/diffview.nvim")
    use ('hrsh7th/cmp-nvim-lsp')
    use ('hrsh7th/cmp-buffer')
    use ('hrsh7th/cmp-path')
    use ('hrsh7th/cmp-cmdline')
    use ('hrsh7th/nvim-cmp')
    use ('hrsh7th/vim-vsnip')

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
