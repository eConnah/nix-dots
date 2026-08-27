{
  inputs,
  self,
  ...
}:
{
  flake = {
    hjemModules.asahi = {
      rum.programs.fish.functions = {
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
                  "8139TOO_8129" = unset;
                  "8139TOO_PIO" = unset;
                  "9P_FS" = no;
                  AFS_FS = no;
                  AIC7XXX_DEBUG_ENABLE = unset;
                  BT_HCIBTUSB_MTK = no;
                  CEPH_FS = no;
                  CEPH_FSCACHE = unset;
                  CEPH_FS_POSIX_ACL = unset;
                  COMEDI = no;
                  DM_CRYPT = module;
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
                  GPIB = no;
                  HSA_AMD = unset;
                  HSA_AMD_P2P = unset;
                  MEDIA_PCI_SUPPORT = no;
                  MMC_BLOCK = module;
                  NET_VENDOR_BROCADE = no;
                  NET_VENDOR_HISILICON = no;
                  NET_VENDOR_HUAWEI = no;
                  NET_VENDOR_INTEL = no;
                  NET_VENDOR_MARVELL = no;
                  NET_VENDOR_MEDIATEK = no;
                  NET_VENDOR_MICROSEMI = no;
                  NET_VENDOR_MYRI = no;
                  NET_VENDOR_NATSEMI = no;
                  NET_VENDOR_NVIDIA = no;
                  NET_VENDOR_QUALCOMM = no;
                  NET_VENDOR_REALTEK = no;
                  NET_VENDOR_SILAN = no;
                  NET_VENDOR_SIS = no;
                  NET_VENDOR_SMSC = no;
                  NET_VENDOR_SOLARFLARE = no;
                  NET_VENDOR_SUN = no;
                  NET_VENDOR_VIA = no;
                  NET_VENDOR_WANGXUN = no;
                  NET_VENDOR_XILINX = no;
                  OCFS2_FS = no;
                  ORANGEFS_FS = no;
                  ROCKCHIP_DW_HDMI_QP = no;
                  ROCKCHIP_DW_MIPI_DSI2 = no;
                  SCSI_AIC7XXX = no;
                  SCSI_LPFC = no;
                  SND_PCI = no;
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
        services.fwupd.enable = lib.mkForce false;
        services.logind.settings.Login.HandleLidSwitch = lib.mkForce "ignore";
      };
  };
}
