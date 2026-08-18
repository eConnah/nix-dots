{
  flake.hjemModules.remote-assets =
    {
      lib,
      pkgs,
      ...
    }:
    {
      _module.args.remoteAssets = {
        profile-pics = {
          "connor.png" = pkgs.fetchurl {
            hash = "sha256-tn+hVdAxKIpkLOw3SsqrCSV37PIKdYROZ0wjn2Hx7cA=";
            url = "https://assets.econnah.uk/profile-pics/connor.png";
          };
          "leo.png" = pkgs.fetchurl {
            hash = "sha256-w9cHmg3SyIAXv1j14sNvl2JAY2CwOarJXVs2Ym4eYmE=";
            url = "https://assets.econnah.uk/profile-pics/leo.png";
          };
        };
        wallpapers = {
          "86-01.png" = pkgs.fetchurl {
            hash = "sha256-mV1clUbd3m11VXJPLCNV4D3UE+SAekaKTWA/zuAwX/w=";
            url = "https://assets.econnah.uk/wallpapers/86-01.png";
          };
          "86-02.png" = pkgs.fetchurl {
            hash = "sha256-xptg1+4yx52PkJqosfQmqsKSghWVR/sRo/sK17GCdkM=";
            url = "https://assets.econnah.uk/wallpapers/86-02.png";
          };
          "frieren-01.png" = pkgs.fetchurl {
            hash = "sha256-hO9frS8rKtoQ2wdEYTbc3bWg8cOJdlyQ9Hof6PdgRcQ=";
            url = "https://assets.econnah.uk/wallpapers/frieren-01.png";
          };
          "frieren-02.png" = pkgs.fetchurl {
            hash = "sha256-kem0UYXhZJGBgyMYEpYOdqOaGZ08ac10MMjU4Nkam+8=";
            url = "https://assets.econnah.uk/wallpapers/frieren-02.png";
          };
          "frieren-03.png" = pkgs.fetchurl {
            hash = "sha256-PAR+lDkmVteqqQ1Sap62VQ6s2Ie19QNGylcvz0kLCp0=";
            url = "https://assets.econnah.uk/wallpapers/frieren-03.png";
          };
          "frieren-04.png" = pkgs.fetchurl {
            hash = "sha256-BGm9o2j1kjJkPtE0Q8WZJoWOfDn60j9WTNH+G/2x884=";
            url = "https://assets.econnah.uk/wallpapers/frieren-04.png";
          };
          "mountains-01.jpg" = pkgs.fetchurl {
            hash = "sha256-HiLEDE5fifOxYTExMSuisExVdAf/c+iBc7/vXxsW4Gs=";
            url = "https://assets.econnah.uk/wallpapers/mountains-01.jpg";
          };
          "ultrakill-01.png" = pkgs.fetchurl {
            hash = "sha256-OtPvmv3X9pqj1JtFOWjwPqTbzK1kzCXXFI54zsxIyw8=";
            url = "https://assets.econnah.uk/wallpapers/ultrakill-01.png";
          };
        };
      };
    };
}
