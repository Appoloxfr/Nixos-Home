{ pkgs }:

let
  font = "CascadiaCode";
  color_theme = "GitHub Dark Dimmed";
  icon_theme = "material-icon-theme";

  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;

  # Helper function for home-spun VS Code extension derivations
  extension = { publisher, name, version, sha256 }:
    buildVscodeMarketplaceExtension {
      mktplcRef = { inherit name publisher sha256 version; };
    };

  classics_extensions = (with pkgs.vscode-extensions; [
    esbenp.prettier-vscode
    github.copilot
    ms-azuretools.vscode-docker
    vscodevim.vim
    zhuangtongfa.material-theme
  ]) ++ (map extension [
    {
      publisher = "GitHub";
      name = "github-vscode-theme";
      version = "6.3.2";
      sha256 = "sha256-CbFZsoRiiwSWL7zJdnBcfrxuhE7E9Au2AlQjqYXW+Nc=";
    }
    {
      publisher = "PKief";
      name = "material-icon-theme";
      version = "4.25.0";
      sha256 = "sha256-/lD3i7ZdF/XOi7RduS3HIYHFXhkoW2+PJW249gQxcyk=";
    }
  ]);

  nix_extensions = (with pkgs.vscode-extensions; [
    mkhl.direnv
  ]) ++ (map extension [
    {
      publisher = "bbenoist";
      name = "nix";
      version = "1.0.1";
      sha256 = "sha256-qwxqOGublQeVP2qrLF94ndX/Be9oZOn+ZMCFX1yyoH0=";
    }

    {
      publisher = "B4dM4n";
      name = "nixpkgs-fmt";
      version = "0.0.1";
      sha256 = "sha256-vz2kU36B1xkLci2QwLpl/SBEhfSWltIDJ1r7SorHcr8=";
    }
  ]);

  js_extensions = (with pkgs.vscode-extensions; [
    dbaeumer.vscode-eslint
    jock.svg
  ]) ++ (map extension [
    {
      publisher = "standard";
      name = "vscode-standard";
      version = "2.1.3";
      sha256 = "sha256-EyaMpDBC1ePqN9hDg6s8yyhuLGbZUGDDqmhiBsmenf8=";
    }
    {
      publisher = "ms-vscode";
      name = "vscode-typescript-next";
      version = "5.0.202302090";
      sha256 = "sha256-LTB3lwu712Rxmi3hDGHP+l1DnQSjuy2fORf1df37d08=";
    }
  ]);
in
{
  enable = true;
  enableExtensionUpdateCheck = false;
  enableUpdateCheck = false;
  extensions = (
    classics_extensions
    ++ nix_extensions
    ++ js_extensions
  );

  userSettings = {
    "[nix]" = {
      "editor.defaultFormatter" = "B4dM4n.nixpkgs-fmt";
    };

    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.fontFamily" = font;
    "editor.fontLigatures" = true;
    "editor.formatOnPaste" = false;
    "editor.formatOnSave" = true;
    "editor.inlineSuggest.enabled" = true;
    "editor.insertSpaces" = true;
    "editor.tabSize" = 2;

    "eslint.options" = {
      "extensions" = [
        ".js"
        ".jsx"
        ".md"
        ".mdx"
        ".ts"
        ".tsx"
        ".vue"
      ];
    };

    "eslint.packageManager" = "yarn";

    "eslint.validate" = [
      "markdown"
      "mdx"
      "javascript"
      "javascriptreact"
      "typescript"
      "typescriptreact"
      "vue"
    ];

    "keyboard.dispatch" = "keyCode";

    "search.exclude" = {
      "**/.direnv" = true;
      "**/.git" = true;
      "**/node_modules" = true;
      "*.lock" = true;
    };

    "workbench.colorTheme" = color_theme;
    "workbench.iconTheme" = icon_theme;

    "github.copilot.enable" = {
      "*" = true;
      "plaintext" = false;
    };
  };
}
