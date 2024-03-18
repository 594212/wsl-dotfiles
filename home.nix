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

  programs.nixvim = {
    enable = true;

    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    colorschemes.gruvbox.enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [{
      action = "<cmd>Telescope harpoon marks<CR>";
      key = "<leader>fh";
    }];

    plugins = {
      treesitter.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<C-n>" = {
            action = "git_files";
            desc = "Telescope Git Files";
          };
          "<leader>fg" = "live_grep";
          "<leader>ff" = "find_files";
          "<leader>fb" = "buffers";
        };
      };
      harpoon = {
        enable = true;
        keymaps = {
          addFile = "mm";
          navNext = "mh";
          navPrev = "ml";
          navFile = {
            "1" = "m1";
            "2" = "m2";
            "3" = "m3";
            "4" = "m4";
          };
          toggleQuickMenu = "<leader>hh";
        };
      };
      lsp = {
        enable = true;
        servers = { 
          nil_ls.enable = true;
        };
        keymaps = {
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" =
              "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
        };
      };
      efmls-configs = {
        enable = true;
        setup.nix.formatter = "nixfmt";
      };
      lsp-format.enable = true;

           nvim-autopairs.enable = true;
      indent-o-matic.enable = true;
    };
  };
}

