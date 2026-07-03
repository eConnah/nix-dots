{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "robius-packaging-commands";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "project-robius";
    repo = "robius-packaging-commands";
    tag = "v${version}";
    hash = "sha256-RqMjSu9R63J2Xyn01Yc6NNMID3Vz16fc37vytFz8a0I=";
  };

  cargoHash = "sha256-Cam3j8t8+mGnN8CuEIHv4ovkwJepFjhxNUJVWCd76+c=";

  meta = {
    description = "Companion tool to help package Rust apps with cargo-packager";
    homepage = "https://github.com/project-robius/robius-packaging-commands";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ eConnah ];
    mainProgram = "robius-packaging-commands";
  };
}
