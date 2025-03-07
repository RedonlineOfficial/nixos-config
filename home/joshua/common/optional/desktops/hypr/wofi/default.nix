{
  imports = [ ./style.nix ];
  programs.wofi = {
    enable = true;

    settings = {
      show = "drun";
      prompt = "Start typing to search...";
      matching = "contains";
      insensitive = true;
      dynamic_lines = true;
      no_actions = true;
      allow_images = true;
      image_size = 12;
      lines = 10;
    };
  };
}
