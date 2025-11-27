{
  source,
  lib,
  stdenv,
  pnpm,
  nodejs,
}:

stdenv.mkDerivation {
  inherit (source) pname version src;

  pnpmDeps = pnpm.fetchDeps {
    inherit (source) pname version src;
    hash = "sha256-vC403moBldwIQ1tZQb3R27vTeRzYs+RK7Dq3eC+YefY=";
    fetcherVersion = 1;
  };

  nativeBuildInputs = [
    pnpm.configHook
  ];

  buildInputs = [
    nodejs
  ];

  # 启用并行构建以提高性能
  enableParallelBuilding = true;

  buildPhase = ''
    pnpm run build
  '';

  installPhase = ''
    # 创建目标目录
    mkdir -p $out/{bin,lib}

    cp -r ./node_modules $out/lib/
    cp -r ./packages $out/lib/

    # 创建可执行文件的符号链接
    ln -sf $out/lib/packages/vite/bin/vite.js $out/bin/vite
    ln -sf $out/lib/packages/create-vite/index.js $out/bin/create-vite

    # 确保二进制文件可执行
    chmod +x $out/bin/vite $out/bin/create-vite
  '';

  # 添加固定阶段以确保所有权限正确
  fixupPhase = ''
    patchShebangs $out/bin
  '';

  meta = {
    description = "Next generation frontend tooling.";
    homepage = "https://vite.dev/";
    license = lib.licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = lib.platforms.linux;
  };
}
