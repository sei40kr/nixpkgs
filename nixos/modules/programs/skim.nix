{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkPackageOption
    ;
  cfg = config.programs.skim;
in
{
  options = {
    programs.skim = {
      keybindings = mkEnableOption "skim keybindings";
      package = mkPackageOption pkgs "skim" { };
    };
  };

  config = mkIf cfg.keybindings {
    environment.systemPackages = [ cfg.package ];

    programs.bash.interactiveShellInit = ''
      source ${cfg.package}/share/skim/key-bindings.bash
    '';

    programs.zsh.interactiveShellInit = ''
      source ${cfg.package}/share/skim/key-bindings.zsh
    '';

    programs.fish.interactiveShellInit = ''
      source ${cfg.package}/share/skim/key-bindings.fish && skim_key_bindings
    '';
  };
}
