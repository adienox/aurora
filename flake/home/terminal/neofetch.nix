{ pkgs, ... }: {
  home.packages = with pkgs; [ neofetch imagemagick ];
  home.file.".config/neofetch/config.conf".text = ''
    print_info() {
      info title
      prin _____________________
      info "" distro
      info "" kernel
      info "" memory
      info "" de
      info "" term
      info "Local IP" local_ip
      info "" uptime
      prin "$(mypad) $(color 1)▂▂ $(color 2)▂▂ $(color 3)▂▂ $(color 4)▂▂ $(color 5)▂▂ $(color 6)▂▂ $(color 7)▂▂ "
      prin _____________________
    }

    title_fqdn="off"
    kernel_shorthand="off"
    distro_shorthand="on"
    os_arch="off"
    uptime_shorthand="on"
    memory_percent="off"
    memory_unit="mib"

    package_managers="on"
    shell_path="off"
    shell_version="on"
    speed_type="bios_limit"
    speed_shorthand="off"
    cpu_brand="off"
    cpu_speed="on"
    cpu_cores="logical"
    cpu_temp="off"
    gpu_brand="on"
    gpu_type="all"
    refresh_rate="off"
    gtk_shorthand="off"
    gtk2="on"
    gtk3="on"
    public_ip_host="http://ident.me"
    public_ip_timeout=2
    de_version="on"
    disk_show=('/')
    disk_subtitle="mount"
    disk_percent="on"
    music_player="auto"
    song_format="%artist% - %album% - %title%"
    song_shorthand="off"
    mpc_args=()
    colors=(distro)
    bold="on"
    underline_enabled="on"
    underline_char="-"
    separator=""
    block_range=(0 15)
    color_blocks="on"
    block_width=3
    block_height=1
    col_offset="auto"
    bar_char_elapsed="-"
    bar_char_total="="
    bar_border="on"
    bar_length=15
    bar_color_elapsed="distro"
    bar_color_total="distro"
    cpu_display="off"
    memory_display="off"
    battery_display="off"
    disk_display="off"
    image_backend="kitty"
    image_source="$HOME/Pictures/backgrounds/neofetch-backgrounds/sakura.png"
    ascii_distro="auto"
    ascii_colors=(distro)
    ascii_bold="on"
    crop_mode="normal"
    crop_offset="center"
    image_size="250px"
    gap=2
    yoffset=0
    xoffset=0
    background_color=
    stdout="off"
  '';
}
