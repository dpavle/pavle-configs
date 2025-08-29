
local lspconfig = require('lspconfig')

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig['pyright'].setup {
  capabilities = capabilities,
}
lspconfig['rust_analyzer'].setup {
  capabilities = capabilities,
}
lspconfig['gopls'].setup {
  capabilities = capabilities,
}
lspconfig['jsonls'].setup {
  capabilities = capabilities,
}
lspconfig['yamlls'].setup {
  capabilities = capabilities,
}
lspconfig['bashls'].setup {
  capabilities = capabilities,
}
lspconfig['ts_ls'].setup {
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
