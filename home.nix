{ config, pkgs, inputs, programs, ... }:

{
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
      alias lzd='lazydocker'
      alias fzf='sk'
      zoxide init --cmd cd fish | source
    '';
  };

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    pkgs.nixfmt
  ];

  home.file = {

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
}
