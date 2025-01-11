{ pkgs, ... }: {
  services = {
    gnome.gnome-keyring.enable = true;
    mysql = {
      enable = true;
      package = pkgs.mysql80;
      # https://github.com/LnL7/nix-darwin/issues/339
      dataDir = "/usr/local/var/postgres";
    };
  };

  environment.systemPackages = with pkgs; [
    mysql-workbench
  ];
}
