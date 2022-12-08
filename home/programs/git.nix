let
  userName = "Gabriel Huet de Froberville";
  userEmail = "gabriel.huet-de-froberville@epita.fr";
  config = {
    core = {
      editor = "vim";
      pager = "less --tabs=4 -RFX";
    };
    init.defaultBranch = "master";
    pull.rebase = true;
  };
in
{
  enable = true;
  inherit userName userEmail;
  extraConfig = config;
}
