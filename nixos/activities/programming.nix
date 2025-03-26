{ config, lib, pkgs, ... }:

let
  query_model = (pkgs.writeShellScriptBin "query-ollama" ''
    #!/usr/bin/env bash
    jq -Rs --arg model "$1" '{model: $model, prompt: ., stream: false}' | curl -s -X POST http://localhost:11434/api/generate -H "Content-Type: application/json" -d @- | jq -r '.response'
  '');
  ai_generate_commit_msg = (pkgs.writeShellScriptBin "ai-gcm" ''
    #!/usr/bin/env bash
    { echo '=> git diff --staged'; git diff --staged; echo 'Generate a meaningful, and concise commit message for this changes.'; } | query-ollama "git-expert"
  '');
in
{
  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    cachix
    cargo
    gcc
    gh
    # haskell compiler (here for the interactive version "ghci")
    ghc
    git-credential-oauth
    vscode

    postman

    ldtk

    query_model
    ai_generate_commit_msg
  ];

  services.ollama = {
    enable = true;

    host = "127.0.0.1";
    port = 11434;

    acceleration = "cuda";
  };
}
