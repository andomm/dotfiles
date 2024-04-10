return {
  'jose-elias-alvarez/null-ls.nvim',
  opts = function()
    local null_ls = require 'null-ls'
    return {
      sources = {
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.markdownlint_cli2,
      },
    }
  end,
}
