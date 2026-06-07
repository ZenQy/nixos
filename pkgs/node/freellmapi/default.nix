{
  source,
  lib,
  buildNpmPackage,
}:

buildNpmPackage (finalAttrs: {
  inherit (source) pname version src;

  npmDepsHash = "sha256-ebkRB1JrLq3BPBsZstqsCEBAfFsyAyuQVqa82aR7Qao=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  NODE_OPTIONS = "--openssl-legacy-provider";

  postPatch = ''
    mv .env.example .env
    sed -i "s|path.dirname(fileURLToPath(import.meta.url))|process.cwd()|g" server/src/db/index.ts
    sed -i "s|../../data|data|g" server/src/db/index.ts
  '';

  installPhase = ''
    mkdir -p $out/{client,server}
    mv {node_modules,shared} $out
    mv client/dist $out/client
    mv server/dist $out/server
  '';

  meta = {
    description = "One OpenAI-compatible endpoint. Sixteen free LLM providers. ~1.7B tokens per month.";
    homepage = "https://github.com/tashfeenahmed/freellmapi";
    license = lib.licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = lib.platforms.linux;
  };
})
