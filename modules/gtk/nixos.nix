{ mkTarget, ... }:
mkTarget {
  name = "gtk";
  humanName = "all GTK3, GTK4 and Libadwaita apps";

  configElements = {
    # Required for Home Manager's GTK settings to work
    programs.dconf.enable = true;
  };
}
