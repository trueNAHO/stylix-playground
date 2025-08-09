# Stylix maintainers.
#
# This attribute set contains Stylix module maintainers that do not have an
# entry in the Nixpkgs maintainer list [1]. Entries must follow the same format
# as in Nixpkgs [1].
#
# [1]: https://github.com/NixOS/nixpkgs/blob/1da63e6cc622a0cb6fd5b86d49923e4eb1e33b70/maintainers/maintainer-list.nix
{
  # keep-sorted start case=no numeric=no block=yes
  butzist = {
    email = "adam@szalkowski.de";
    name = "Adam M. Szalkowski";
    github = "butzist";
    githubId = 2405792;
  };
  cluther = {
    name = "Chet Luther";
    email = "chet.luther@gmail.com";
    github = "cluther";
    githubId = 86579;
  };
  gideonwolfe = {
    email = "wolfegideon@gmail.com";
    name = "Gideon Wolfe";
    github = "gideonwolfe";
    githubId = 32942052;
  };
  lomenzel = {
    name = "Leonard-Orlando Menzel";
    email = "leonard.menzel@tutanota.com";
    matrix = "@leonard:menzel.lol";
    github = "lomenzel";
    githubId = 79226837;
  };
  make-42 = {
    email = "ontake@ontake.dev";
    name = "Louis Dalibard";
    matrix = "@ontake:matrix.ontake.dev";
    github = "make-42";
    githubId = 17462236;
    keys = [
      { fingerprint = "36BC 916D DD4E B1EE EE82  4BBF DC95 900F 6DA7 9992"; }
    ];
  };
  osipog = {
    email = "osibluber@protonmail.com";
    name = "Osi Bluber";
    github = "osipog";
    githubId = 87434959;
  };
  skoove = {
    email = "zie@sturges.com.au";
    name = "Zie Sturges";
    github = "skoove";
    githubId = 53106860;
  };
  # keep-sorted end
}
