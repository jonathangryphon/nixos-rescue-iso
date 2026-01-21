# YEET!
{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  # Enable SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  # Root SSH access (live ISO logs in as root)
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEa1Ib/PDdAwh3BcgRM4XEF28OtMwpkpyTkdmE7GK0rW nixos-rescue"
  ];

  # Automatically get networking
  networking.useDHCP = true;

  # Optional but recommended: show IP on console
  services.getty.helpLine = ''
    Rescue system ready.
    SSH enabled. Check IP with: ip a
  '';

  # Make boot faster and quieter
  boot.kernelParams = [ "quiet" ];

  # Allow remote troubleshooting tools
  environment.systemPackages = with pkgs; [
    git
    tmux
    htop
    curl
    wget
    rsync
    vim
  ];
}

