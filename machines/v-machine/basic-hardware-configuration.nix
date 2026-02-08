{lib, ...}: {
  boot.loader.systemd-boot.enable = true;

  fileSystems."/" = lib.mkDefault
    { device = "/dev/disk/by-uuid/f222513b-ded1-49fa-b591-20ce86a2fe7f";
      fsType = "ext4";
    };
}
