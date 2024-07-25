{
  pkgs,
  inputs,
  default,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    vesktop
    #NOTE: you need to lauch unmodified discord first before launching with vencord else things break!
    # (pkgs.discord.override {
    #   nss = pkgs.nss_latest;
    #   withVencord = true;
    # })
  ];

  xdg.configFile."vesktop/themes/custom.css".text = ''
    /**
     * @name midnight (catppuccin)
     * @author refact0r
     * @version 1.6.2
     * @source https://github.com/refact0r/midnight-discord
    */

    @import url("https://mwittrien.github.io/BetterDiscordAddons/Themes/EmojiReplace/base/Apple.css"); /* Apple emoji */
    @import url("https://refact0r.github.io/midnight-discord/midnight.css");

    /* customize things here */
    :root {
      /* font, change to 'gg sans' for default discord font*/
      --font: "figtree";

      /* top left corner text */
      --corner-text: "Catppuccin";

      /* color of status indicators and window controls */
      --online-indicator: ${default.xcolors.base0B}; /* change to #23a55a for default green */
      --dnd-indicator: ${default.xcolors.base08}; /* change to #f13f43 for default red */
      --idle-indicator: ${default.xcolors.base0A}; /* change to #f0b232 for default yellow */

      /* accent colors */
      --accent-1: hsl(${default.colors.accenthue}, 84%, 81%); /* links */
      --accent-2: hsl(${default.colors.accenthue}, 84%, 81%); /* general unread/mention elements */
      --accent-3: hsl(${default.colors.accenthue}, 84%, 81%); /* accent buttons */
      --accent-4: hsl(${default.colors.accenthue}, 70%, 73%); /* accent buttons when hovered */
      --accent-5: hsl(${default.colors.accenthue}, 55%, 65%); /* accent buttons when clicked */
      --mention: hsla(${default.colors.accenthue}, 70%, 71%, 0.1); /* mentions & mention messages */
      --mention-hover: hsla(
        ${default.colors.accenthue},
        70%,
        71%,
        0.05
      ); /* mentions & mention messages when hovered */

      /* text colors */
      --text-0: var(--bg-4); /* text on colored elements */
      --text-1: hsl(220, 40%, 95%); /* bright text on colored elements */
      --text-2: hsl(226, 64%, 88%); /* headings and important text */
      --text-3: hsl(228, 24%, 72%); /* normal text */
      --text-4: hsl(230, 13%, 55%); /* icon buttons and channels */
      --text-5: hsl(233, 12%, 39%); /* muted channels/chats and timestamps */

      /* background and dark colors */
      --bg-1: ${default.xcolors.base01}; /* dark buttons when clicked */
      --bg-2: ${default.xcolors.base02}; /* dark buttons */
      --bg-3: ${default.xcolors.base01}; /* spacing, secondary elements */
      --bg-4: ${default.xcolors.base00}; /* main background color */
      --hover: hsla(237, 18%, 53%, 0.1); /* channels and buttons when hovered */
      --active: hsla(
        235,
        15%,
        53%,
        0.2
      ); /* channels and buttons when clicked or selected */
      --message-hover: hsla(240, 0%, 0%, 0.1); /* messages when hovered */

      /* amount of spacing and padding */
      --spacing: 8px;

      /* animations */
      --hover-push: 0.15s ease; /* channels/members when hovered */

      /* corner roundness (border-radius) */
      --roundness-xl: 18px; /* roundness of big panel outer corners */
      --roundness-l: 16px; /* popout panels */
      --roundness-m: 14px; /* smaller panels, images, embeds */
      --roundness-s: 12px; /* members, settings inputs */
      --roundness-xs: 10px; /* channels, buttons */
      --roundness-xxs: 8px; /* searchbar, small elements */

      /* direct messages moon icon */
      /* change to block to show, none to hide */
      --discord-icon: block; /* discord icon */
      --moon-icon: none; /* moon icon */
      --moon-icon-url: none; /* custom icon url */
      --moon-icon-size: auto;

      /* filter uncolorable elements to fit theme */
      /* (just set to none, they're too much work to configure) */
      --login-bg-filter: none; /* login background artwork */
      --green-to-accent-3-filter: none; /* add friend page explore icon */
      --blurple-to-accent-3-filter: none; /* add friend page school icon */
    }
  '';
}
