{
  "update.mode" = "none";
  "breadcrumbs.enabled" = false;
  "editor.codeActionsOnSave" = {
    "source.fixAll.eslint" = true;
  };
  "editor.formatOnSave" = true;
  "editor.formatOnType" = true;
  "editor.fontFamily" = "monospace, 'Font Awesome 6 Brands Regular', 'Font Awesome 6 Free Solid', 'Font Awesome 6 Free Regular'";
  "editor.fontSize" = 16;
  "editor.tabSize" = 2;
  "editor.wordWrap" = "on";
  "editor.bracketPairColorization.enabled" = true;
  "editor.guides.bracketPairs" = "active";
  "editor.quickSuggestions" = {
    "strings" = true;
  };
  "explorer.confirmDelete" = false;
  "explorer.confirmDragAndDrop" = false;
  "extensions.autoCheckUpdates" = false;
  "extensions.autoUpdate" = false;
  "terminal.integrated.cursorStyle" = "underline";
  "terminal.external.linuxExec" = "foot";
  "terminal.integrated.fontFamily" = "monospace";
  "workbench.iconTheme" = "material-icon-theme";
  # "workbench.settings.useSplitJSON" = true;
  "workbench.startupEditor" = "newUntitledFile";
  "workbench.colorTheme" = "Monokai";
  "git.autofetch" = true;
  "git.enableSmartCommit" = true;
  "git.confirmSync" = false;
  "go.testFlags" = [
    "-v"
  ];
  "go.useLanguageServer" = true;
  "go.toolsManagement.checkForUpdates" = "off";
  "gopls" = {
    "usePlaceholders" = true;
    "completeUnimported" = true;
    "formatting.gofumpt" = true;
  };
  "material-icon-theme.files.associations" = {
    "*.db" = "Database";
  };
  "html.format.indentHandlebars" = true;
  "html.format.indentInnerHtml" = true;
  "window.zoomLevel" = 1;
  "window.titleBarStyle" = "custom";
  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "nil";
  "nix.serverSettings" = {
    "nil" = {
      # "diagnostics" = {
      #   "ignored" = [ "unused_binding" "unused_with" ];
      # };
      "formatting" = {
        "command" = [ "nixpkgs-fmt" ];
      };
    };
  };
  "files.autoSave" = "afterDelay";
  "rust-analyzer.server.path" = "/run/current-system/sw/bin/rust-analyzer";
}
