# Nix os module that contains all configuartion rust toolings
{ config, pkgs, ... }:

{
  services = {
    thermald.enable = false;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;

        # Optional helps save long term battery health
        # START_CHARGE_THRESH_BAT1 = 40; # 40 and bellow it starts to charge
        # STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging

        MEM_SLEEP_ON_AC = "s2idle";
        MEM_SLEEP_ON_BAT = "s2idle";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;
      };
    };

    upower.enable = true;

    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandlePowerKeyLongPress = "poweroff";
      HandlePowerKey = "suspend-then-hibernate";
    };
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-gmmlib
        intel-media-driver
        intel-ocl
        libvdpau-va-gl
        vulkan-tools
        intel-vaapi-driver
        libva-vdpau-driver
        mesa
      ];
    };
  };

  environment.systemPackages = [ pkgs.fw-fanctrl ];
}
