{
  programs.wofi.style = ''
    @define-color normalText #7B88A1;
    @define-color selectText #ACB4C4;
    @define-color baseDarker #2e3440;
    @define-color baseDark   #3b4252; 
    @define-color baseMed    #434c5e;
    @define-color border     #4c566a;

    * {
      font-family: "Ubuntu Nerd Font";
      font-size: 12px;
    }

    window {
      background-color: transparent;
      border: none;
    }

    #outer-box {
      background-color: @baseDarker;
      border-radius: 20px;
      margin: 3px;
      padding: 10px;
    }
    
    #input {
      color: @normalText;
      caret-color: @normalText;
      background-color: @baseDark;
      border: none;
      border-radius: 10px;
    }
    
    #inner-box {
      background-color: transparent;
      border: none;
      border-radius: 10px;
    }
    
    #scroll {
      margin: 5px;
    }
    
    #text {
      padding: 4px;
      color: @normalText;
    }

    #entry {
      background-color: @baseDark;
      border: none;
      border-radius: 10px;
      margin: 2px;
    }
    
    #entry:selected {
      padding-left: 25px;
      background-color: @baseMed;
      border: none;
      border-radius: 10px;
    }
    
    #text:selected {
      color: @selectText;
      background: transparent;
      border: none;
      border-radius: 10px;
      margin: 2px;
    }

    #input:focus { 
      box-shadow: none; 
      border: 2px solid @border;
    }

  '';
}
