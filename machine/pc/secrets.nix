{ ... }:
{
  age = {
    identityPaths = [ "/home/cole/.ssh/id_ed25519" ];

    secrets = {
      restic.file = ../../secrets/restic.age;
    };
  };
}
