{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8"
 ];
    defaultGateway = "209.38.64.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="209.38.73.18"; prefixLength=20; }
{ address="10.48.0.5"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="fe80::b0b7:d4ff:feda:2799"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "209.38.64.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 128; } ];
      };
            eth1 = {
        ipv4.addresses = [
          { address="10.124.0.2"; prefixLength=20; }
        ];
        ipv6.addresses = [
          { address="fe80::9c45:f5ff:fefc:b24c"; prefixLength=64; }
        ];
        };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="b2:b7:d4:da:27:99", NAME="eth0"
    ATTR{address}=="9e:45:f5:fc:b2:4c", NAME="eth1"
  '';
}
