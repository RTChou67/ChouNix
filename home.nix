{ config, pkgs, ... }:

{
  home.username = "rtchou";
  home.homeDirectory = "/home/rtchou";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "25.05";

  # ==========================================================
  # 所有的软件包 (单一大列表，按字母顺序排列)
  # ==========================================================
  home.packages = with pkgs; [
    autoconf
    autogen
    automake
    bat
    black
    btop
    bzip2
    cargo
    clang-tools
    cloc
    cmake
    cp2k
    curl
    diffutils
    direnv
    eza
    fastfetch
    fd
    fish
    fzf
    gawk
    gfortran
    git
    gnumake
    gnupatch
    gsl
    hdf5
    home-manager
    htop
    hyfetch
    jq
    julia
    lazygit
    less
    libtool
    libxml2
    lsd
    lua
    luarocks
    nixfmt-rfc-style
    nodejs
    nushell
    pkg-config
    python3
    ripgrep
    shfmt
    spglib
    statix
    stylua
    trash-cli
    tree
    trexio
    unzip
    uv
    vim
    wget
    which
    xclip
    xorg.fontadobe100dpi
    xorg.fontadobe75dpi
    xorg.fontbhttf
    xorg.fontcursormisc
    xorg.mkfontdir
    xorg.mkfontscale
    yarn
    zip
    zlib-ng
    zsh-prezto
  ];

  # ==========================================================
  # 用户级程序配置
  # ==========================================================
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons --git -a";
      vi = "nvim";
      vim = "nvim";
      rm = "trash";
      cd = "z";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "history"
        "dirhistory"
        "colorize"
        "command-not-found"
      ];
      theme = "rtchou";
      custom = "/etc/nixos/omz-config";
    };

    initContent = ''
      # Conda 风格的激活函数
      activate-pybase() {
        if [[ -n "$PYBASE_ACTIVE" ]]; then
          echo "Python-base already active"
          return 0
        fi
        echo "Activating python-base environment..."
        export PYBASE_OLD_PATH="$PATH"
        export PYBASE_OLD_PYTHONPATH="$PYTHONPATH"
        export PYBASE_OLD_PS1="$PS1"
        
        # 使用 jq 安全解析环境
        source <(nix print-dev-env /etc/nixos/python-base --json | ${pkgs.jq}/bin/jq -r '.variables | to_entries | .[] | "export \(.key)=\"\(.value.value)\""')
        
        export PYBASE_ACTIVE=1
        export PS1="(pybase) $PS1"
        echo "✓ Python-base activated!"
      }

      deactivate-pybase() {
        if [[ -z "$PYBASE_ACTIVE" ]]; then
          echo "Python-base not active"
          return 0
        fi
        export PATH="$PYBASE_OLD_PATH"
        export PYTHONPATH="$PYBASE_OLD_PYTHONPATH"
        export PS1="$PYBASE_OLD_PS1"
        unset PYBASE_ACTIVE PYBASE_OLD_PATH PYBASE_OLD_PYTHONPATH PYBASE_OLD_PS1
        echo "✓ Python-base deactivated!"
      }
    '';
  };
}
