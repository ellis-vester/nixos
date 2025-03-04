local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.csharpier,
    null_ls.builtins.formatting.terraform_fmt
  },
}

vim.keymap.set('n', '<leader>bf', vim.lsp.buf.format, { desc = "[B]uffer [F]ormat "})
