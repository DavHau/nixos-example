{lib, config, pkgs, ...}: {

  imports = [
    ./nvidia.nix
    ./sway.nix
  ];

  system.stateVersion = "25.11";

  boot.loader.grub.enable = true;

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
