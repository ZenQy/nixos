{
  source,
  lib,
  buildNpmPackage,
}:

buildNpmPackage (finalAttrs: {
  inherit (source) pname version src;

  npmDepsHash = "sha256-Rkbeffkks//gr16QXgDmoD1Uu3ALA9qOOR0Hx/WPJ/o=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  NODE_OPTIONS = "--openssl-legacy-provider";

  postPatch = ''
    mv .env.example .env
    sed -i "s|path.dirname(fileURLToPath(import.meta.url))|process.cwd()|g" server/src/db/index.ts
    sed -i "s|../../data|data|g" server/src/db/index.ts
  '';

  installPhase = ''
    for d in cli client server
    do
      mkdir -p $out/$d
      mv $d/dist $out/$d/
    done
    mv server/node_modules $out/server
    mv {node_modules,shared} $out
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
