{
  flake.hjemModules.modprobed-db = {pkgs, ...}: {
    packages = [pkgs.modprobed-db];
    systemd.services.modprobed-db-store = {
      description = "Snapshot currently loaded kernel modules for modprobed-db";
      path = [pkgs.getent pkgs.gawk];
      serviceConfig = {
        ExecStart = "${pkgs.modprobed-db}/bin/modprobed-db storesilent";
        Type = "oneshot";
      };
    };
    systemd.timers.modprobed-db-store = {
      description = "Timer for modprobed-db snapshot";
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "5min";
      };
      wantedBy = ["timers.target"];
    };
    xdg.config.files."modprobed-db/modprobed-db.conf".text = ''
      DBPATH="/home/connor/.local/share/modprobed-db"
      COLORS=dark
    '';
  };
}
