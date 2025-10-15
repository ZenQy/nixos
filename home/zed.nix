{
  agent = {
    default_model = {
      model = "claude-sonnet-4";
      provider = "zed.dev";
    };
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
      language_servers = [ "nixd" ];
    };
    Rust = {
      language_servers = [ "rust-analyzer" ];
    };
    Vue = {
      language_servers = [ "vue-language-server" ];
    };
    YAML = {
      enable_language_server = false;
    };
  };
  lsp = {
    gopls = { };
    rust-analyzer = { };
    vue-language-server = { };
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
