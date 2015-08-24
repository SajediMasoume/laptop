export ZSH=/home/gui/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git sbt)
export PATH="/home/gui/bin:/var/setuid-wrappers:/home/gui/.nix-profile/bin:/home/gui/.nix-profile/sbin:/home/gui/.nix-profile/lib/kde4/libexec:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/nix/var/nix/profiles/default/lib/kde4/libexec:/run/current-system/sw/bin:/run/current-system/sw/sbin:/run/current-system/sw/lib/kde4/libexec"
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export EDITOR='sublime3 -n -w'
export SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"

