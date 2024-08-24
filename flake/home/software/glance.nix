{...}: {
  services.glance = {
    enable = true;
    settings = {
      pages = [
        {
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "calendar";
                }
                {
                  type = "rss";
                  feeds = [
                    {
                      url = "https://ciechanow.ski/atom.xml";
                    }
                    {
                      url = "https://www.joshwcomeau.com/rss.xml";
                      title = "Josh Comeau";
                    }
                  ];
                }
                {
                  type = "twitch-channels";
                  channels = [
                    "theprimeagen"
                    "christitustech"
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "hacker-news";
                }
                {
                  type = "videos";
                  style = "grid-cards";
                  collapse-after-rows = 2;
                  channels = [
                    "UCR-DXc1voovS8nhAvccRZhg" # Jeff Geerling
                    "UCXuqSBlHAE6Xw-yeJA0Tunw" #LTT
                    "UCJ0-OtVpF0wOKEqT2Z1HEtA" # Electro Boom
                    "UCODHrzPMGbNv67e84WDZhQQ" # Fern
                    "UCoZd78hRUdxxsuGiABuHF_A" # Historically
                  ];
                }
                {
                  type = "reddit";
                  subreddit = "selfhosted";
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "weather";
                  location = "Kathmandu, Nepal";
                }
                {
                  type = "bookmarks";
                  groups = [
                    {
                      links = [
                        {
                          title = "Mail";
                          url = "https://mail.proton.me/u/0/inbox";
                        }
                        {
                          title = "Github";
                          url = "https://github.com";
                        }
                        {
                          title = "Home Manager";
                          url = "https://nix-community.github.io/home-manager/options.xhtml";
                        }
                        {
                          title = "Wikipedia";
                          url = "https://en.wikipedia.org/";
                        }
                        {
                          title = "Selfh.st";
                          url = "https://https://selfh.st/";
                        }
                      ];
                    }
                    {
                      title = "Entertainment";
                      color = "10 70 50";
                      links = [
                        {
                          title = "Youtube";
                          url = "https://www.youtube.com";
                        }
                        {
                          title = "Movies";
                          url = "https://mov2day.to";
                        }
                      ];
                    }
                    {
                      title = "Social";
                      color = "200 50 50";
                      links = [
                        {
                          title = "Reddit";
                          url = "https://www.reddit.com";
                        }
                        {
                          title = "Twitter";
                          url = "https://twitter.com";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
          ];
          name = "Home";
        }
      ];
      theme = {
        background-color = "0 0 0";
        contrast-multiplier = 1.2;
        primary-color = "23 92 75";
        positive-color = "115 54 76";
        negative-color = "347 70 65";
      };
      server = {
        port = 8080;
      };
    };
  };
}
