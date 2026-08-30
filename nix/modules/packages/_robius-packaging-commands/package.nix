{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  cargoHash = "sha256-Cam3j8t8+mGnN8CuEIHv4ovkwJepFjhxNUJVWCd76+c=";
  pname = "robius-packaging-commands";
  src = fetchFromGitHub {
    hash = "sha256-RqMjSu9R63J2Xyn01Yc6NNMID3Vz16fc37vytFz8a0I=";
    owner = "project-robius";
    repo = "robius-packaging-commands";
    tag = "v${version}";
  };
  version = "0.2.1";
  meta = {
    description = "Companion tool to help package Rust apps with cargo-packager";
    homepage = "https://github.com/project-robius/robius-packaging-commands";
    license = lib.licenses.mit;
    mainProgram = "robius-packaging-commands";
    maintainers = with lib.maintainers; [eConnah];
  };
}
