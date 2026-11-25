{ lib, ... }:
{
  programs = {
    doom-emacs = {
      enable = true;
      # doomDir = "./doom";
    };

    direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    foot = {
      enable = true;
      settings = lib.mkForce {
        main = {
          font = "MesloLGS Nerd Font:style=regular:size=14";
        };
        colors-dark = {
          alpha = 0.7;
        };
      };
    };

    git = {
      enable = true;
      settings = {
        user = {
          email = "cole@colepng.com";
          name = "Cole Kauder-McMurrich";
        };

        alias = {
          "lg" =
            "log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        };
      };

      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };

    firefox.enable = true;

    neovim = {
      enable = false;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      sideloadInitLua = false;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };
  };
}
