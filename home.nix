{
  config,
  pkgs,
  inputs,
  pythonBasePackage,
  ...
}:

let
  repoRoot = inputs.self;
  omzCustomHome = "${config.home.homeDirectory}/.oh-my-zsh/custom";
in
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
    codex
    cp2k
    diffutils
    eza
    fastfetch
    fd
    fish
    fzf
    gawk
    gemini-cli
    gfortran
    gnumake
    gnupatch
    gsl
    hdf5
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
    nixfmt
    nodejs
    nushell
    pkg-config
    pythonBasePackage
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
    which
    xclip
    font-adobe-100dpi
    font-adobe-75dpi
    font-bh-ttf
    font-cursor-misc
    mkfontscale
    yarn
    zip
    zlib-ng
  ];

  # ==========================================================
  # 用户级程序配置
  # ==========================================================
  programs.home-manager.enable = true;
  home.file.".oh-my-zsh/custom/themes/rtchou.zsh-theme".source =
    "${repoRoot}/omz-config/themes/rtchou.zsh-theme";
  programs.zoxide = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cd = "z";
      ls = "eza --icons";
      ll = "eza -l --icons --git -a";
      vi = "nvim";
      vim = "nvim";
      rm = "trash";
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
      custom = omzCustomHome;
    };

    initContent = ''
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
    '';
  };
}
