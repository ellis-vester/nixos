require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" },
      },
      options = {
        nixos = {
            expr = '(builtins.getFlake "/home/ellis/nixos").nixosConfigurations.desktop.options',
        },
        home_manager = {
            expr = '(builtins.getFlake "/home/ellis/nixos").nixosConfigurations.desktop.options.home-manager.users.type.getSubOptions []',
        },
      },
    },
  },
})
