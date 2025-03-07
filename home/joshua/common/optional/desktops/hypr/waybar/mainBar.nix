{
  programs.waybar.style = ./style.css;
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      margin = "0px";
      margin-top = 5;
      margin-left = 5;
      margin-right = 5;
      height = 15;
      spacing = 4;
      reload_style_on_change = true;

      modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
      modules-center = [ "clock#calendar" "custom/seperator" "clock" "custom/seperator" "custom/weather"];
      modules-right = [ "network" "custom/seperator" "bluetooth" "custom/seperator" "battery" ];
      # Global Modules
      "custom/seperator" = {
      	format = " | ";
      };

      ### Left Modules 
      # Workspaces
      "hyprland/workspaces" = {
      	format = "{icon}";
      	format-icons = {
      	  active = "<span font-size='150%'></span>";
      	  default = "<span font-size='150%'></span>";
      	  empty = "<span font-size='150%'></span>";
      	};
      	persistent-workspaces = {
      	  "*" = [ 1 2 3 4 5 ];
	};
      };

      "hyprland/submap" = {
	format = "{}";
	tooltip = true;
      };

      ### Center Modules
      # Clock
      clock = {
       	format = "󰥔  {:%H:%M}";
       	tooltip = false;
      };

      # Date
      "clock#calendar" = {
      	format = "󰃭  {:%A, %B %d, %Y}";
      	tooltip = false;
      };

      # Weather
      "custom/weather" = {
	exec = "curl wttr.in/Phoenix?format='%c%C,+%w,+%t'";
      	interval = 600;
      };

      ### Right Modules
      # Battery
      battery = {
	bat = "BAT0";
	interval = 60;
	states = {
	  critical = 10;
	  warning = 25;
	  medium = 75;
	  high = 100;
	};

	format-critical = "󰂎 {capacity}% 󰀨 ";
	format-warning = "󱊡 {capacity}% 󰀦 ";
	format-medium= "󱊢 {capacity}%";
	format-high = "󱊣 {capacity}%";
	format-plugged-critical = "󰢟  {capacity}%";
	format-plugged-warning = "󱊤  {capacity}%";
	format-plugged-medium= "󱊥  {capacity}%";
	format-plugged-high = "󱊦  {capacity}%";

	tooltip = true;
	tooltip-format = "{timeTo}\rMax Capacity: {health}%\rCharge Cycles: {cycles}";
      };

      # Bluetooth
      bluetooth = {
      	format-connected = "󰂱  Connected";
      	format-on = "󰂯 No Devices";
      	format-off = "󰂲 Bluetooth Off";
      	tooltip-format = "Bluetooth is {status}\n{device_enumerate}";
      	tooltip-format-enumerate-connected = "{device_alias}";
      };

      # Network
      network = {
	interval = 10;
      	family = "ipv4";
      	format-ethernet = "󰈀 Ethernet";
      	format-wifi = "{icon} {essid} ({signalStrength}%)";
      	format-disconnected = "  No Internet</span>";

      	tooltip-format = "IP: {ipaddr}/{cidr}\nGW: {gwaddr}\nUp: {bandwidthUpBits}\nDown: {bandwidthDownBits}";
      	tooltip-format-wifi = "IP: {ipaddr}/{cidr}\nGW: {gwaddr}\nUp: {bandwidthUpBits}\nDown: {bandwidthDownBits}\nSignal dBm: {signaldBm}";

      	format-icons = [ "<span color='#bf616a'>󰢿 </span>" "<span color='#d08770'>󰢼 </span>" "<span color='#ebcb8b'>󰢽 </span>" "<span color='#a3be8c'>󰢾 </span>" ];
      };
    };
  };
}
