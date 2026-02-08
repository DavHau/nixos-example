{lib, config, pkgs, ...}: {

  imports = [
    ./basic-hardware-configuration.nix
    ./nvidia.nix
    ./sway.nix
    ./output-formats.nix
  ];

  system.stateVersion = "25.11";

  hardware.enableAllHardware = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.users.v = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    initialPassword = "v";
  };
  users.users.root.initialPassword = "root";

  services.ollama.enable = true;

  environment.systemPackages = with pkgs; [
    bat
    curl
    fd
    git
    htop
    ripgrep
    vim
    wget
    firefox
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  image.modules.iso.isoImage.squashfsCompression = "zstd -Xcompression-level 5";
}
