{ config, pkgs, ... }:

{
  home.username = "miro";
  home.homeDirectory = "/home/miro";

  # --- Packages ---
  home.packages = with pkgs; [
    # Desktop Apps
    firefox
    chromium
    zed-editor
    vlc
    qalculate-gtk
    bitwarden-desktop

    # CLI Tools
    neovim
    gh
    ripgrep # Faster grep, highly recommended

    # Fonts
    nerd-fonts.jetbrains-mono

    # Gnome Extensions
    gnomeExtensions.clipboard-indicator

    # --- RStudio (IDE) ---
    # We wrap RStudio so it sees the packages we need.
    # (rstudioWrapper.override {
    #   packages = with rPackages; [
    #     ggplot2
    #     dplyr
    #     xts
    #     tidyverse
    #   ];
    # })
  ];

  # --- Program Configuration ---

  # Enable Direnv (Project Isolation)
  # When you 'cd' into a folder with a flake.nix, it loads automatically.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Git Configuration
  programs.git = {
    enable = true;
    settings = {
      user.name = "OmarElfouly";
      user.email = "omarelfouly29@gmail.com";
      init.defaultBranch = "main";
    };
  };

  # Shell Configuration (Fish)
  programs.fish = {
    enable = true;
    # interactiveShellInit = ''
    #   set fish_greeting # Disable greeting
    # '';
    shellAliases = {
      nix-new = "nix flake new -t github:nix-community/nix-direnv .";
    };
  };

  # Gnome Settings (Dconf)
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        pkgs.gnomeExtensions.clipboard-indicator.extensionUuid
      ];
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Keep this matching your install version
}
