{ pkgs, ... }:
let
  package = pkgs.gedit;
in
{
  stylix.testbed.ui.application = {
    name = "org.gnome.gedit";
    inherit package;
  };

  environment.systemPackages = [ package ];
}
