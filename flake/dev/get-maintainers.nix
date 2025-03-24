{ lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.get-maintainers = pkgs.writeText "get-maintainers" (
        lib.pipe ../../stylix/meta.nix [
          (x: pkgs.callPackage x { })
          (lib.mapAttrs (_name: meta: map (m: m.github) meta.maintainers or [ ]))
          (lib.mapAttrs' (n: v: lib.nameValuePair "modules/${n}" v))
          builtins.toJSON
        ]
      );
    };
}
