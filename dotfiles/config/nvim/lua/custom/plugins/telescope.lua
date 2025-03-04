return {
  { 'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    tag = '0.1.X',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
}
