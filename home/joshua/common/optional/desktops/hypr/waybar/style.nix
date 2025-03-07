{
  programs.waybar.style = ''
    * {
      opacity: 1.0;
      font-family: "Ubuntu Nerd Font";
      font-size: 14px;
      text-shadow: none;
      padding: 0;
      min-height: 0;
      border: none;
      border-radius: 0px;
      color: #7B88A1;
    }
    
    window#waybar {
      background: transparent;
    }
    
    tooltip {
      border: 1px dotted #4c566a;
      border-radius: 10px;
      background: #2e3440;
      padding: 2px;
      opacity: 1.0;
    }
    
    #custom-seperator {
      color: #4c566a;
    }
    
    /* LEFT MODULES */
    .modules-left {
      background: transparent;
    }
    #workspaces {
      border-radius: 20px;
      background: #2e3440;
      padding: 1px 7px 0px 7px;
      border: 1px solid #4c566a;
    }
    
    #submap {
      color: #2e3440;
      background: #ebcb8b;
      border-radius: 20px;
      padding: 1px 7px 1px 7px;
      border: 1px solid #4c566a;
    }
    
    
    /* CENTER MODULES */
    .modules-center {
      background: #2e3440;
      border-radius: 20px;
      padding: 1px 7px 0px 7px;
      border: 1px solid #4c566a;
      margin: 0;
    }
    
    
    /* RIGHT MODULES */
    .modules-right {
      border-radius: 20px;
      background: #2e3440;
      padding: 1px 7px 0px 7px;
      border: 1px solid #4c566a;
    }
    
    /* Battery */
    #battery.critical,
    #battery.plugged.critical {
      color: #bf616a;
    }
    #battery.warning,
    #battery.plugged.warning {
      color: #ebcb8b;
    }
    
    #battery.medium,
    #battery.plugged.medium,
    #battery.high,
    #battery.plugged.high {
      color: #a3be8c;
    }
    
    /* Network */
    #network.disconnected {
      border-radius: 15px;
      padding: 0px 7px;
      background: #bf616a;
      color: #eceff4;
      font-weight: bold;
    }
  '';
}
