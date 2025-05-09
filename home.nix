{ config, pkgs, nixvim, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dk";
  home.homeDirectory = "/home/dk";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # General purpose LSPs for Helix editor
    pkgs.vscode-langservers-extracted
    pkgs.starship
    pkgs.mycli
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # # To make a direct symlink without going through nix store and without the need
    # # to switch home-manager for the changes to take effect there is a way to do that
    # # with `config.lib.file.mkOutOfStoreSymlink` function outlined here https://discourse.nixos.org/t/how-to-manage-dotfiles-with-home-manager/30576/2

    ".config/zellij/themes/rose-pine-dawn.kdl".source = config/zellij/themes/rose-pine-dawn.kdl;
    ".config/starship.toml".source = config/starship.toml;
    ".myclirc".source = config/myclirc;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dk/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.yazi.enable = true;

  programs.zellij = {
    enable = true;
    settings = {
      theme = "rose-pine-dawn";
    };
  };

  programs.nixvim = {
    enable = true;

    colorschemes.rose-pine = {
      enable = true;
      settings.variant = "dawn";
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=globals#globals
    globals = {
      # Set <space> as the leader key
      # See `:help mapleader`
      mapleader = " ";
      maplocalleader = " ";

      # Set to true if you have a Nerd Font installed and selected in the terminal
      have_nerd_font = true;
    };

    #  See `:help 'clipboard'`
    clipboard = {
      providers = {
        wl-copy.enable = true; # For Wayland
        xsel.enable = false; # For X11
      };

      # Sync clipboard between OS and Neovim
      #  Remove this option if you want your OS clipboard to remain independent.
      # register = "unnamedplus";
    };

    # [[ Setting options ]]
    # See `:help vim.opt`
    # NOTE: You can change these options as you wish!
    #  For more options, you can see `:help option-list`
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=globals#opts
    opts = {
      # Show line numbers
      number = true;
      # You can also add relative line numbers, to help with jumping.
      #  Experiment for yourself to see if you like it!
      relativenumber = true;
    };
    
    plugins = {
      lualine.enable = true;
      cmp.enable = true;
      copilot-lua.enable = true;
      copilot-cmp.enable = true;
      copilot-chat.enable = true;

      # Useful plugin to show you pending keybinds.
      # https://nix-community.github.io/nixvim/plugins/which-key/index.html
      which-key = {
        enable = true;
      };
    };
  };
}
