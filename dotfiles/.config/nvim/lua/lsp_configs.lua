local lsps = {
  {'pyright'},
  {'rust_analyzer'},
  {'gopls'},
  {'jsonls'},
  {'yamlls'},
  {'bashls'},
  {'ts_ls'},
  {'terraformls'},
  {'ansiblels'},
  {'docker_compose_language_service'},
  {'lua_ls', { settings = { Lua = { diagnostics = { globals = {'vim'} } } } } },
  {'azure_pipelines_ls',
    {
      root_dir = require('lspconfig').util.root_pattern(".git", "azure_pipelines", ".azuredevops"),
      settings = {
        yaml = {
          schemas = {
            ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/main/service-schema.json"] = {
              ["file://" .. vim.fn.expand("~/.azure-devops/custom-yaml-schema.json")] = {
              "azure-pipelines.yml",
              "pipelines/*.yml",
              "*/pipelines.yml",
              "azure_pipelines/*.yml",
              ".azuredevops/pipelines/**/*.yml",
              ".azuredevops/pipelines/builds/**/*.yml",
              }
            }
          }
        }
      }
    }
  }
}

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]
  vim.lsp.enable(name)
  if config then
    vim.lsp.config(name, config)
  end
end
