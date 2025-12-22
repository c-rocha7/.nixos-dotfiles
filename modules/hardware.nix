{ pkgs, ... }:

{
  # ========================================
  # Firmware e Microcode
  # ========================================
  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  # ========================================
  # Gráficos e Drivers (AMD)
  # ========================================
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
      rocmPackages.clr.icd
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # ========================================
  # Otimizações de Kernel e Boot
  # ========================================
  boot.kernelParams = [
    "amd_pstate=disable"
    "kernel.split_lock_mitigate=0"
  ];

  boot.kernelModules = [ "kvm-amd" ];
}
