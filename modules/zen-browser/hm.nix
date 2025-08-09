{
  mkTarget,
  lib,
  config,
  options,
  ...
}:
mkTarget {
  name = "zen-browser";
  humanName = "Zen Browser";

  extraOptions = {
    profileNames = lib.mkOption {
      description = "The Zen Browser profile names to apply styling on.";
      type = lib.types.listOf lib.types.str;

      default = [ ];
      example = [ "default" ];
    };
  };

  configElements =
    lib.optionals (builtins.hasAttr "zen-browser" options.programs)
      [
        (
          { cfg }:
          {
            warnings =
              lib.optional (config.programs.zen-browser.enable && cfg.profileNames == [ ])
                ''stylix: zen-browser: `config.stylix.targets.zen-browser.profileNames` is not set. Declare profile names with 'config.stylix.targets.zen-browser.profileNames = [ "<PROFILE_NAME>" ];'.'';
          }
        )
        (
          {
            cfg,
            fonts,
          }:
          {
            programs.zen-browser.profiles = lib.genAttrs cfg.profileNames (_: {
              settings = {
                "font.name.monospace.x-western" = fonts.monospace.name;
                "font.name.sans-serif.x-western" = fonts.sansSerif.name;
                "font.name.serif.x-western" = fonts.serif.name;
              };
            });
          }
        )
        (
          {
            cfg,
            colors,
          }:
          {
            programs.zen-browser.profiles = lib.genAttrs cfg.profileNames (_: {
              settings = {
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              };

              userChrome = colors {
                template = ./userChrome.css.mustache;
                extension = ".css";
              };

              userContent = colors {
                template = ./userContent.css.mustache;
                extension = ".css";
              };
            });
          }
        )
      ];
}
