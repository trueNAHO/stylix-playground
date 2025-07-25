{
  pkgs,
  config,
  lib,
  nixosConfig ? null,
  ...
}:
{
  options.stylix.targets.qt = {
    # TODO: Replace `nixosConfig != null` with
    # `pkgs.stdenv.hostPlatform.isLinux` once [1] ("bug: setting qt.style.name
    # = kvantum makes host systemd unusable") is resolved.
    #
    # [1]: https://github.com/nix-community/home-manager/issues/6565
    enable = config.lib.stylix.mkEnableTargetWith {
      name = "QT";
      autoEnable = nixosConfig != null;
      autoEnableExpr = "nixosConfig != null";
    };

    platform = lib.mkOption {
      description = ''
        Selects the platform theme to use for Qt applications.

        Defaults to the standard platform theme used in the configured DE in NixOS when
        `stylix.homeManagerIntegration.followSystem = true`.
      '';
      type = lib.types.str;
      default = "qtct";
    };
  };

  config = lib.mkIf (config.stylix.enable && config.stylix.targets.qt.enable) (
    let
      icons =
        if (config.stylix.polarity == "dark") then
          config.stylix.icons.dark
        else
          config.stylix.icons.light;

      recommendedStyles = {
        gnome = if config.stylix.polarity == "dark" then "adwaita-dark" else "adwaita";
        kde = "breeze";
        qtct = "kvantum";
      };

      recommendedStyle = recommendedStyles."${config.qt.platformTheme.name}" or null;

      kvantumPackage =
        let
          kvconfig = config.lib.stylix.colors {
            template = ./kvconfig.mustache;
            extension = ".kvconfig";
          };
          svg = config.lib.stylix.colors {
            template = ./kvantum.svg.mustache;
            extension = ".svg";
          };
        in
        pkgs.runCommandLocal "base16-kvantum" { } ''
          directory="$out/share/Kvantum/Base16Kvantum"
          mkdir --parents "$directory"
          cp ${kvconfig} "$directory/Base16Kvantum.kvconfig"
          cp ${svg} "$directory/Base16Kvantum.svg"
        '';
    in
    {
      warnings =
        (lib.optional (config.stylix.targets.qt.platform != "qtct")
          "stylix: qt: `config.stylix.targets.qt.platform` other than 'qtct' are currently unsupported: ${config.stylix.targets.qt.platform}. Support may be added in the future."
        )
        ++ (lib.optional (config.qt.style.name != recommendedStyle)
          "stylix: qt: Changing `config.qt.style` is unsupported and may result in breakage! Use with caution!"
        );

      home.packages = lib.optional (config.qt.style.name == "kvantum") kvantumPackage;

      qt = {
        enable = true;
        style.name = recommendedStyle;
        platformTheme.name = config.stylix.targets.qt.platform;
      };

      xdg.configFile =
        let
          qtctConf =
            ''
              [Appearance]
            ''
            + lib.optionalString (config.qt.style ? name) ''
              style=${config.qt.style.name}
            ''
            + lib.optionalString (icons != null) ''
              icon_theme=${icons}
            '';

        in
        lib.mkMerge [
          (lib.mkIf (config.qt.style.name == "kvantum") {
            "Kvantum/kvantum.kvconfig".source =
              (pkgs.formats.ini { }).generate "kvantum.kvconfig"
                {
                  General.theme = "Base16Kvantum";
                };

            "Kvantum/Base16Kvantum".source =
              "${kvantumPackage}/share/Kvantum/Base16Kvantum";
          })

          (lib.mkIf (config.qt.platformTheme.name == "qtct") {
            "qt5ct/qt5ct.conf".text = qtctConf;
            "qt6ct/qt6ct.conf".text = qtctConf;
          })
        ];
    }
  );
}
