DISK="$1"

echo "start partition"
parted "$DISK" -- mklabel gpt
parted "$DISK" -- mkpart root ext4 512MB -8GB
parted "$DISK" -- mkpart swap linux-swap -8GB 100%
parted "$DISK" -- mkpart ESP fat32 1MB 512MB
parted "$DISK" -- set 3 esp on

if echo "$DISK" | grep -q nvme; then
  PART_1="${DISK}p1"
  PART_2="${DISK}p2"
  PART_3="${DISK}p3"
fi

mkfs.ext4 -L nixos "$PART_1"
mkswap -L swap "$PART_2"
swapon "$PART_2"
mkfs.fat -F 32 -n boot "$PART_3"
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
nixos-generate-config --root /mnt

echo "partition finished"
echo "edit /mnt/etc/nixos/configuration.nix"
echo "then run nixos-install and reboot"
