{
  assistant = {
    default_model = {
      provider = "zed.dev";
      model = "claude-3-7-sonnet-thinking-latest";
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
    JSON = {
      enable_language_server = false;
    };
    JSONC = {
      enable_language_server = false;
    };
    YAML = {
      enable_language_server = false;
    };
    Rust = {
      language_servers = [ "rust-analyzer" ];
    };
    Go = {
      language_servers = [ "gopls" ];
    };
    Nix = {
      language_servers = [
        "nixd"
        "!nil"
      ];
    };
    Svelte = {
      language_servers = [ "svelte-language-server" ];
    };
  };
  lsp = {
    gopls = { };
    rust-analyzer = { };
    svelte-language-server = { };
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
    mode = "dark";
    dark = "Ayu Dark";
    light = "Ayu Light";
  };
  ui_font_size = 16;
}
