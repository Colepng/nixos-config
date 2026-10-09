{ ... }:
{
  age = {
    identityPaths = [ "/home/cole/.ssh/id_ed25519" ];

    secrets = {
      beszel.file = ../../secrets/beszel.age;
    };
  };
}
