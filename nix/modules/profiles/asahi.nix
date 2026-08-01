{
  inputs,
  self,
  ...
}:
{
  flake = {
    homeModules.asahi = { lib, ... }: {
      programs.fish.functions = {
        hyprbattery = ''
          set realCharge (cat /sys/class/power_supply/macsmc-battery/capacity)
          set charge (math "10 * round($realCharge / 10)")
          set state (cat /sys/class/power_supply/macsmc-battery/status)
          set iconKey "$state$charge"
          echo "{
            \"charge\": \"$realCharge\",
            \"state\": \"$state\",
            \"alt\": \"$iconKey\"
           }"
        '';
        ifdischarging = ''
           set state (cat /sys/class/power_supply/macsmc-battery/status)
           if test "$state" = "Discharging"
            eval $argv
          end
        '';
      };
      services.easyeffects.enable = lib.mkForce false;
    };
    nixosModules.asahi =
      {
        lib,
        pkgs,
        ...
      }:
      {
        imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];
        boot = {
          kernelPatches = [
            {
              name = "asahi-trim-fat";
              patch = null;
              structuredExtraConfig = lib.mapAttrs (_: lib.mkForce) (
                with lib.kernel;
                {
                  "9P_FS" = no;
                  AFS_FS = no;
                  # unused/errored because their parent above already removes them —
                  # tell generate-config.pl to just skip these entirely
                  AIC7XXX_DEBUG_ENABLE = unset;
                  BT_HCIBTUSB_MTK = no;
                  CEPH_FS = no;
                  CEPH_FSCACHE = unset;
                  CEPH_FS_POSIX_ACL = unset;
                  DRM_AMDGPU = no;
                  DRM_AMDGPU_CIK = unset;
                  DRM_AMDGPU_SI = unset;
                  DRM_AMDGPU_USERPTR = unset;
                  DRM_AMD_ACP = unset;
                  DRM_AMD_DC_FP = unset;
                  DRM_AMD_DC_SI = unset;
                  DRM_AMD_ISP = unset;
                  DRM_AMD_SECURE_DISPLAY = unset;
                  DRM_NOUVEAU = no;
                  DRM_NOUVEAU_SVM = unset;
                  DRM_RADEON = no;
                  DRM_VMWGFX = no;
                  GFS2_FS = no;
                  HSA_AMD = unset;
                  HSA_AMD_P2P = unset;
                  NET_VENDOR_MEDIATEK = no;
                  OCFS2_FS = no;
                  ORANGEFS_FS = no;
                  ROCKCHIP_DW_HDMI_QP = no;
                  ROCKCHIP_DW_MIPI_DSI2 = no;
                  SCSI_AIC7XXX = no;
                  SCSI_LPFC = no;
                  SCSI_QLA_FC = no;
                  SND_SOC_QCOM = no;
                  SND_SOC_SAMSUNG = no;
                  SND_SOC_TEGRA = no;
                  USB_XHCI_TEGRA = no;
                }
              );
            }
          ];
          kexec.enable = false;
          loader.efi.canTouchEfiVariables = lib.mkForce false;
        };
        environment.systemPackages = with pkgs; [
          asahi-bless
          muvm
        ];
        hardware.asahi.enable = true;
        home-manager.sharedModules = [
          self.homeModules.asahi
        ];
        services.logind.settings.Login.HandleLidSwitch = lib.mkForce "ignore";
      };
  };
}
