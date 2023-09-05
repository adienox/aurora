{ inputs, ... }: {
  imports = [ inputs.xremap-flake.homeManagerModules.default ];

  services.xremap = {
    withHypr = true;
    yamlConfig = ''
      modmap:
        - name: main remaps
          remap:
            CapsLock:
              held: leftctrl
              alone: esc
              alone_timeout_millis: 150
    '';
  };
}
