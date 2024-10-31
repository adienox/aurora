{inputs, ...}: {
  imports = [inputs.xremap-flake.homeManagerModules.default];

  services.xremap = {
    withWlroots = true;
    watch = true;
    yamlConfig = ''
      modmap:
        - name: main remaps
          remap:
            CapsLock:
              held: leftctrl
              alone: esc
              alone_timeout_millis: 350
            CONTROL_L:
              held: leftctrl
              alone: esc
              alone_timeout_millis: 350
            SHIFT_L:
              held: SHIFT_L
              alone: KEY_KPLEFTPAREN
              alone_timeout_millis: 350
      keymap:
        - name: obsidian
          application:
            only: obsidian
          remap:
            M-j: down
            M-k: up
        - name: browser
          application:
            only: firefox
          remap:
            C-j: down
            C-k: up
    '';
  };
}
