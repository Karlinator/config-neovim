return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {},
      })

      vim.keymap.set("n", "<leader>gf", function()
        vim.lsp.buf.format({
          filter = function(client)
            return client.name ~= "tsserver"
          end,
        })
      end, {})
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettierd",
          "eslint_d",
          "stylua",
          "gitsigns",
          "gitrebase",
          "codespell",
          "mypy",
          "rpmspec",
          "chackmake",
        },
        automatic_installation = false,
        handlers = {},
      })
    end,
  },
}
