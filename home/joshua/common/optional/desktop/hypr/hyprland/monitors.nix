{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # name,resolution,position,scale,action,arg
      "desc:Sceptre Tech Inc Sceptre K27 0x00000001,1920x1080@240, 0x0, 1" # Primary Monitor
      "desc:AU Optronics 0xC693, 3840x2400@60, 180x1080, 2.5" # Laptop Monitor
      "desc:Sceptre Tech Inc Sceptre F27, 1920x1080@75, 1920x-225, 1, transform, 3" # Vertical Monitor
      ", preferred, auto , 1" # Catch all
    ];

    workspace = [
      "1, monitor:desc:desc:Sceptre Tech Inc Sceptre K27 0x00000001, default:true"
      "2, monitor:desc:Sceptre Tech Inc Sceptre F27, default:true"
      "3, monitor:desc:AU Optronics 0xC693, default:true"
    ];
  };
}

