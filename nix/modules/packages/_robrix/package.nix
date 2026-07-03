{
  lib,
  stdenv,
  rustPlatform,
  pkg-config,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
  callPackage,
  alsa-lib,
  fetchFromGitHub,
  fontconfig,
  libGL,
  libglvnd,
  libpulseaudio,
  libx11,
  libxcursor,
  libxkbcommon,
  openssl,
  wayland,
  robius-packaging-commands ? callPackage ../_robius-packaging-commands/package.nix { },
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "robrix";
  version = "unstable-2026-07-03";
  src = fetchFromGitHub {
    owner = "project-robius";
    repo = "robrix";
    rev = "8c79e1dece370d4cbe0cb050ce0ba2a4017acea0";
    hash = "sha256-DbmFhp7m6c9f0LhWJ7+bMf7DslfORTl/y1ago7dRVQo=";
  };
  cargoHash = "sha256-XhZvG1im3yHSPEdfzTA6T4IVX543y6HyXo2y4egaduk=";
  MAKEPAD_PACKAGE_DIR = "${placeholder "out"}/share/robrix/resources";

  nativeBuildInputs = [
    pkg-config
    makeWrapper
    copyDesktopItems
    robius-packaging-commands
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "robrix";
      exec = "robrix";
      icon = "robrix";
      desktopName = "Robrix";
      genericName = "Matrix Chat Client";
      comment = "A multi-platform Matrix chat client written in Rust";
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
      startupWMClass = "robrix";
    })
  ];

  buildInputs = [
    openssl
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    alsa-lib
    fontconfig
    libGL
    libglvnd
    libpulseaudio
    libx11
    libxcursor
    libxkbcommon
    wayland
  ];

  postInstall = ''
    CARGO_PACKAGER_FORMAT=${if stdenv.hostPlatform.isDarwin then "app" else "appimage"} \
      robius-packaging-commands before-each-package \
        --binary-name robrix \
        --path-to-binary target/${stdenv.hostPlatform.rust.rustcTarget}/release/robrix

    mkdir -p "$out/share/robrix/resources"
    cp -r dist/resources/* "$out/share/robrix/resources/"
  ''
  + lib.optionalString stdenv.hostPlatform.isLinux ''
    for size in 32 48 64 128 256 512 1024; do
      iconDir="$out/share/icons/hicolor/''${size}x''${size}/apps"
      iconSrc="$out/share/robrix/resources/robrix/resources/icon_''${size}.png"
      if [ -f "$iconSrc" ]; then
        mkdir -p "$iconDir"
        install -Dm444 "$iconSrc" "$iconDir/robrix.png"
      fi
    done
  '';

  postFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    wrapProgram $out/bin/robrix \
      --prefix LD_LIBRARY_PATH : "${
        lib.makeLibraryPath [
          fontconfig
          libGL
          libglvnd
          libx11
          libxcursor
          libxkbcommon
          wayland
        ]
      }"
  '';

  meta = {
    description = "A multi-platform Matrix chat client written in Rust.";
    homepage = "https://github.com/project-robius/robrix";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ eConnah ];
    platforms = lib.platforms.unix;
    mainProgram = "robrix";
  };
})
