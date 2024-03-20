{ pkgs, ... }: {
  home.username = "sl";
  home.homeDirectory = "/home/sl";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source

      alias cat="bat --paging=never"
      alias lzg='lazygit'
      alias fzf='sk'
      alias vi='nvim'
      zoxide init --cmd cd fish | source
    '';
  };
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    pkgs.nixfmt
    (pkgs.writeShellScriptBin "lzd" (builtins.readFile ./scripts/lzd))
  ];

  home.file = {
    ".local/bin" = {
      source = ./scripts;
      recursive = true;
    };
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sl/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { EDITOR = "hx"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nixvim = import ./modules/nixvim.nix;

  programs.git = {
    enable = true;
    userName = "sul";
    userEmail = "su1im69n@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      dialect = "us";
      ignored_commands = [ "cd" "ls" "vi" ];
      search_mode = "skim";
      show_preview = true;
      style = "compact";
    };
  };
}
