--- disable editorconfig loading for .yaml buffers
--- (fixes tab indentation when working on .yaml files in directories/repos where tab indentation is enforced)
local function disable_editorconfig()
  vim.g.editorconfig = false
end
vim.api.nvim_create_autocmd("FileType", { pattern = "yaml", callback = disable_editorconfig })

-- disable comment continuation
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
})
