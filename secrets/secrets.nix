let
  pc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBotTIkimcU+7Kt0ZavDzt6dH1PsTb38zjbcN5TFc39a";

  framework = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAb4sxQtDQK3a5rIYNFIep6XwzjXIqqVzXRnBM6hRm07";
in
{
  "restic.age".publicKeys = [ pc ];
}
