# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # hint electron app to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Display manager
  # services.greetd.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  networking.hostName = "zen"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  users.users.ez = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; 
     hashedPasswordFile = "/etc/nixos/secrets/ez.pass";
  };

  home-manager.users.ez = /home/ez/dotfiles/home.nix;
  home-manager.backupFileExtension = "backup";

  programs.firefox.enable = true;
  programs.starship.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim 
     wget
     neofetch
     keychain

     # Bar
     waybar

     # Screen capture
     hyprshot

     # Terminal
     alacritty
     starship

     # File manager
     ranger
     ueberzugpp

     # Font
     font-manager

     # Window switcher
     rofi-wayland

     # Wallpaper
     swww

     # Notification
     dunst
     libnotify
  ];

  # Font
  fonts.packages = with pkgs; [
     inconsolata-nerdfont
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

