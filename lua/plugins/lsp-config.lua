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
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
      lspconfig.typos_lsp.setup({})
      lspconfig.clangd.setup({})
      lspconfig.unocss.setup({})
      lspconfig.dockerls.setup({})
      lspconfig.docker_compose_language_service.setup({})
      lspconfig.eslint.setup({})
      lspconfig.html.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.jdtls.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.marksman.setup({})
      lspconfig.intelephense.setup({})
      lspconfig.pyright.setup({})
      lspconfig.sqls.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.gitlab_ci_ls.setup({})


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
