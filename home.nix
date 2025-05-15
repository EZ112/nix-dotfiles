{ config, pkgs, ... }: 

{
   home.username = "ez";
   home.homeDirectory = "/home/ez";

   home.sessionVariables = {
      EDITOR = "nvim";
   };

   programs.git = {
      enable = true;
      extraConfig = {
         init.defaultBranch = "main";
	 user = {
	   name = "Izzi";
	   email = "izzidz@gmail.com";
	 };
      };
   };

   # Home Manager is pretty good at managing dotfiles. The primary way to manage
   # plain files is through 'home.file'.
   home.file = {
      ".bashrc".source = /home/ez/dotfiles/.bashrc;

      ".config/starship.toml".source = /home/ez/dotfiles/starship.toml;

      ".config/alacritty".source = /home/ez/dotfiles/alacritty;
      ".config/hypr".source = /home/ez/dotfiles/hypr;
      ".config/neofetch".source = /home/ez/dotfiles/neofetch;
      ".config/ranger".source = /home/ez/dotfiles/ranger;
      ".config/rofi".source = /home/ez/dotfiles/rofi;
      ".config/waybar".source = /home/ez/dotfiles/waybar;
   };

   # The state version is required and should stay at the version you
   # originally installed.
   home.stateVersion = "24.11";
}
