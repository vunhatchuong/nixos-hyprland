{
  config,
  pkgs,
  lib,
  systemSettings,
  userSettings,
  ...
}:
{
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  programs.zsh = {
    enable = true;
    promptInit = "";
    # TODO: Find a way to fix this hack
    shellInit = ''
      source ~/.config/zsh/.zshenv
      source ~/.config/zsh/.zprofile
    '';
  };
  users.defaultUserShell = pkgs.zsh;

  users.users.ronny = {
    isNormalUser = true;
    home = "/home/ronny";
    extraGroups = [
      "docker"
      "wheel"
    ];
    # Generated with 'mkpasswd'
    hashedPassword = "$y$j9T$Ws0o6OJC/SEaRtJMt9Z82.$KJWl1EQNy/lUAzAggFswuSNmG09xugIRhkjjIGgiXF7";
  };

  environment.enableAllTerminfo = true;
  environment.shells = with pkgs; [ zsh ];

  # Uses rust implementation of the 'switch'
  system.switch = {
    enable = false;
    enableNg = true;
  };
}
