require('which-key').setup {
  notify = false,
}

-- Document existing key chains
require('which-key').register {
  { '', group = '[C]ode' },
  { '', group = '[D]ocument' },
  { '', group = 'Git [H]unk' },
  { '', group = '[R]ename' },
  { '', group = '[S]earch' },
  { '', group = '[T]oggle' },
  { '', group = '[W]orkspace' },
  { '', desc = '', hidden = true, mode = { 'n', 'n', 'n', 'n', 'n', 'n', 'n' } },
}

-- visual mode
require('which-key').register {
  { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
}
