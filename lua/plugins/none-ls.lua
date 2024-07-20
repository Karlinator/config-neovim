return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.gitrebase,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.rpmspec,
        null_ls.builtins.formatting.prettierd,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
