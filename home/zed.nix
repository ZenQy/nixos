{
  agent = {
    default_model = {
      model = "deepseek-sonnet-4-latest";
      provider = "deepseek";
    };
    version = "2";
  };
  auto_update = false;
  buffer_font_size = 16;
  extend_comment_on_newline = false;
  format_on_save = "on";
  indent_guides = {
    coloring = "indent_aware";
  };
  inlay_hints = {
    enabled = true;
  };
  languages = {
    Go = {
      language_servers = [ "gopls" ];
    };
    JSON = {
      enable_language_server = false;
    };
    JSONC = {
      enable_language_server = false;
    };
    Nix = {
      language_servers = [
        "nixd"
        "!nil"
      ];
    };
    Rust = {
      language_servers = [ "rust-analyzer" ];
    };
    Svelte = {
      language_servers = [ "svelteserver" ];
    };
    YAML = {
      enable_language_server = false;
    };
  };
  lsp = {
    gopls = { };
    rust-analyzer = { };
    svelteserver = { };
  };
  soft_wrap = "editor_width";
  tab_size = 2;
  tabs = {
    file_icons = true;
    git_status = true;
  };
  telemetry = {
    diagnostics = false;
    metrics = false;
  };
  theme = {
    dark = "Ayu Dark";
    light = "Ayu Light";
    mode = "dark";
  };
  ui_font_size = 16;
}
