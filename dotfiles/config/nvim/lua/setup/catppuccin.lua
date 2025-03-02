require('catppuccin').setup {
  flavour = 'frappe',
  transparent_background = true,
  highlight_overrides = {
    -- Make the line numbers legible
    all = function(colors)
      return {
        LineNrAbove = { fg = colors.rosewater },
        LineNrBelow = { fg = colors.rosewater },
      }
    end,
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    mini = {
      enabled = true,
      indentscope_color = '',
    },
    neotree = true,
  },
}

vim.cmd.colorscheme 'catppuccin'
