{ ... }:
{
  age.secrets = {
    restic.file = ../../secrets/restic.age;

    cloudflare.file = ../../secrets/cloudflare.age;
  };
}
