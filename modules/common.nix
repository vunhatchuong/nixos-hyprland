{ config, pkgs, lib, systemSettings, userSettings, ... }:
{
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.ronny = {
    isNormalUser = true;
    home = "/home/ronny";
    extraGroups = [ "docker" "wheel" ];
    # Generated with 'mkpasswd'
    hashedPassword = "$y$j9T$Ws0o6OJC/SEaRtJMt9Z82.$KJWl1EQNy/lUAzAggFswuSNmG09xugIRhkjjIGgiXF7";
  };

  # Enable auto-mount feature
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.enableAllTerminfo = true;
}
