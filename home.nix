{ config, pkgs, ... }:

{
  home.username = "miro";
  home.homeDirectory = "/home/miro";

  # --- Packages ---
  home.packages = with pkgs; [
    # Desktop Apps
    firefox
    chromium
    google-chrome
    zed-editor
    vlc
    qalculate-gtk
    bitwarden-desktop
    gimp
    obsidian
    rustdesk

    # CLI Tools
    neovim
    htop
    nethogs

    # gh
    ripgrep # Faster grep, highly recommended

    # Fonts
    nerd-fonts.jetbrains-mono

    # Gnome Extensions
    gnomeExtensions.clipboard-indicator

    nil
    nixd

    rclone

    texlive.combined.scheme-full

    docker
    act
  ];

  # --- Services ---

  services.ssh-agent.enable = true;

  # --- Program Configuration ---

  # SSH
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "thesisr" = {
        hostname = "100.91.26.65";
        user = "omar";
        forwardAgent = true;
        identityFile = "~/.ssh/id_ed25519";
        addKeysToAgent = "yes";
      };
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };

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
      nethogs = "sudo ${pkgs.nethogs}/bin/nethogs";
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
