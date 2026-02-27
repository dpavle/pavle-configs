-- override editorconfig indentation when working on yaml files in directories/repos where tab indentation is enforced
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml", callback = function() require('editorconfig').properties.indent_style = space end,
})

-- disable comment continuation on newline
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
})
