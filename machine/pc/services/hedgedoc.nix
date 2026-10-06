{ ... }:
{
  services.hedgedoc = {
    enable = true;
    settings = {
      host = "127.0.0.1";
      port = 3002;
      domain = "hedgedoc.colepng.com";
      protocolUseSSL = true;
      allowOrigin = [ "hedgedoc.colepng.com" ];
      useCDN = false;

      email = true;
      allowEmailRegister = false;
      allowAnonymous = false;
    };
  };
}
