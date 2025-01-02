{ pkgs, ... }:
{
  services.displayManager = {
    defaultSession = "none+i3";
  };
  services.xserver = {
    enable = true;
    xkb.layout = "us";

    desktopManager.runXdgAutostartIfNone = true;

    displayManager = {
      lightdm.enable = true;
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 150 50
      '';
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        i3lock
        dmenu
     ];
    };
  };

  environment.systemPackages = with pkgs; [
    xclip
  ];
}
