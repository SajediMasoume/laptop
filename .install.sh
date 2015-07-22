sudo rm -f /etc/nixos/configuration.nix
sudo rm -f /etc/nixos/hardware-configuration.nix
sudo rm -f /etc/wpa_supplicant.conf
sudo ln -s  ~/.nix/configuration.nix /etc/nixos/configuration.nix
sudo ln -s ~/.nix/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo ln -s ~/.wifi/wpa_supplicant.conf /etc/wpa_supplicant.conf