{ ... }:
{
  sops = {
    defaultSopsFile = ./secrets/secrets.sops.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/nox/.config/sops/age/keys.txt";
    secrets."api_keys/openai" = { };
    secrets."pass/protonmail-bridge" = { };
  };
}
