{
  self,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
  };

  flake.nixosModules.neovim = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      neovim
      alejandra
    ];
  };

  flake.homeModules.neovim = {...}: {
    imports = [
      inputs.nvf.homeManagerModules.default

      self.homeModules.neovimOptions
      self.homeModules.neovimLsp
      self.homeModules.neovimKeymaps
    ];

    programs.nvf = {
      enable = true;

      settings = {
        vim = {
          vimAlias = true;
          theme.transparent = true;
        };
      };
    };
  };
}
