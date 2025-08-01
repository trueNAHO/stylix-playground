# Starship configuration documentation: https://starship.rs/config
{ mkTarget, ... }:
mkTarget {
  name = "starship";
  humanName = "Starship";

  configElements =
    { colors }:
    {
      programs.starship.settings = {
        palette = "base16";
        palettes.base16 = with colors.withHashtag; {
          black = base00;
          bright-black = base03;
          white = base05;
          bright-white = base07;

          # Starship calls magenta purple.
          purple = magenta;
          bright-purple = bright-magenta;

          inherit
            # Set Starship's standard normal color names.
            red
            orange
            yellow
            green
            cyan
            blue
            magenta
            brown

            # Set Starship's standard bright color names.
            bright-red
            bright-yellow
            bright-green
            bright-cyan
            bright-blue
            bright-magenta

            # Add base16 names to the template for custom usage.
            base00
            base01
            base02
            base03
            base04
            base05
            base06
            base07
            base08
            base09
            base0A
            base0B
            base0C
            base0D
            base0E
            base0F

            # Add base24 names to the template for custom usage.
            base10
            base11
            base12
            base13
            base14
            base15
            base16
            base17
            ;
        };
      };
    };
}
