return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim"
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "typos_lsp",
          "clangd",
          "unocss",
          "dockerls",
          "docker_compose_language_service",
          "eslint",
          "html",
          "jsonls",
          "jdtls",
          "tsserver",
          "marksman",
          "intelephense",
          "pyright",
          "sqls",
          "yamlls",
          "gitlab_ci_ls",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
	  local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require('lspconfig')
      local opts = { capabilities = capabilities }
      lspconfig.lua_ls.setup(opts)
      lspconfig.typos_lsp.setup(opts)
      lspconfig.clangd.setup(opts)
      lspconfig.unocss.setup(opts)
      lspconfig.dockerls.setup(opts)
      lspconfig.docker_compose_language_service.setup(opts)
      lspconfig.eslint.setup(opts)
      lspconfig.html.setup(opts)
      lspconfig.jsonls.setup(opts)
      lspconfig.jdtls.setup(opts)
      lspconfig.tsserver.setup(opts)
      lspconfig.marksman.setup(opts)
      lspconfig.intelephense.setup(opts)
      lspconfig.pyright.setup(opts)
      lspconfig.sqls.setup(opts)
      lspconfig.yamlls.setup(opts)
      lspconfig.gitlab_ci_ls.setup(opts)


      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {})
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {})
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end
  },
}
