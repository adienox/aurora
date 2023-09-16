{ pkgs, ... }: {
  home.packages = with pkgs; [ swaynotificationcenter ];
  
  xdg.configFile."swaync/config.json.bak".source =
    (pkgs.formats.json { }).generate "config.json.bak" {
	    notification-margin-top =  12;
    };
}
