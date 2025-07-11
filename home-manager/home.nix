{ config, pkgs, inputs, lib, ... }:

{
  home.username = "pavle";
  home.homeDirectory = "/home/pavle";
  home.stateVersion = "22.11";
  nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};

  xdg.configFile."alacritty/alacritty.toml".source = ../dotfiles/.config/alacritty/alacritty.toml;
  xdg.configFile."i3/config".source = ../dotfiles/.config/i3/config;
  xdg.configFile."nvim".source = ../dotfiles/.config/nvim;
  xdg.configFile."i3blocks".source = ../dotfiles/.config/i3blocks;

  home.file.".background-image".source = ../.background-image;
  home.file.".zshrc".source = ../dotfiles/.zshrc;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
        fzf
        jq
        tree
        python3
        librewolf
        go
        wget
        remmina
        openfortivpn
        stow

        # language servers
        lua-language-server
        yaml-language-server
        bash-language-server
        pyright
        gopls
        terraform-ls
        ansible-language-server
        docker-compose-language-service

    #  thunderbird
  ];

  programs.git = {
      enable = true;
      userName = "dpavle";
      userEmail = "dencic.pavle@gmail.com";
    };

  programs.neovim = {
  	enable = true;
  	viAlias = true;
	vimAlias = true;
  	};

	home.sessionVariables = {
		EDITOR="nvim";
	};
	home.shellAliases = {
	};

	programs.zsh = {
		enable = true;
	};

	programs.zsh.oh-my-zsh= {
		enable = true;
		plugins = ["git" "python" "docker" "fzf"];
		theme = "dpoggi";
	};

}
