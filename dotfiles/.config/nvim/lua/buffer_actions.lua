--- disable editorconfig loading for .yaml buffers
--- (fixes tab indentation when working on yaml files in directories/repos where tab indentation is enforced)
local function disable_editorconfig()
  vim.g.editorconfig = false
end
vim.api.nvim_create_autocmd("FileType", { pattern = "yaml", callback = disable_editorconfig })

local ansible_paths = {
  os.getenv('HOME') .. '/AzureRepos/RubySystems/RubyConfig',
  os.getenv('HOME') .. '/Ansible'
}

for _, path in ipairs(ansible_paths) do
  if vim.fn.getftype(path) == 'dir' then
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
      pattern = vim.fn.globpath(path, "**/*.{yaml,yml}", 0, 1),
      command = "set filetype=yaml.ansible"
    })
  end
end

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*compose*.yml", "*compose*.yaml"},
  command = "set filetype=yaml.docker-compose"
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  desc = "Disable comment continuation on inserted newline.",
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.env"},
  command = "set filetype=none"
})
