{lib, config, pkgs, ...}: {
  image.modules.iso.isoImage.squashfsCompression = "zstd -Xcompression-level 5";
}
