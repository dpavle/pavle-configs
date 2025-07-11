

require("nvim-tree").setup({
    view = { width = 40 }
})

local function open_nvim_tree(data)

    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
      return
    end

    vim.cmd.cd(data.file)

    require("nvim-tree.api").tree.open()
end
-- open nvim-tree on launch
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
-- auto close nvim-tree when it's the last window
vim.api.nvim_create_autocmd({ "QuitPre" }, { callback = function() vim.cmd("NvimTreeClose") end, })
