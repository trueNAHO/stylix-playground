{ lib, pkgs, ... }:
# We are using VSCodium because VSCode is an unfree package
let
  package = pkgs.vscodium;
in
{
  stylix.testbed.ui.application = {
    name = "codium";
    inherit package;
  };

  home-manager.sharedModules = lib.singleton {
    programs.vscode = {
      enable = true;
      inherit package;
    };
  };
}
