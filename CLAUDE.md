# Dendritic NixOS Configuration

This project is my NixOS configuration. It is based on the Dendritic Layout. 

## Build Philosophy

Pure flake-enable NixOS, when managing multiple machine configurations and 
sharing modules across those configurations, because exponentially more complex. 
The Dendritic Pattern solves this complexity by exposing each module to the 
top-level configuration.  Each module can be simply imported into other modules 
or configurations.  This allows the directory structure itself to manage 
organization.  The file locations are arbitrary to the NixOS configuration 
therefore, the actual layout is not important to the building of the NixOS 
configuration. 

Home-manager is used to manage the user specific configurations (think 
dotfiles). There are a few ways to set this up. Official documentations show it 
can be installed standalone, or as a NixOS module.  However, it is possible to 
install this in a third way: a hybrid approach.  Home-Manager will run primarly 
as a standalone module, but will expose itself to NixOS.  This allows the entire 
NixOS configuration, including home-manager, to be rebuilt using nixos-rebuild 
switch. However, when making small dotfile changes, there is no need to rebuild 
the entire system, so this also allows the use of home-manager switch as these 
rebuilds are much quicker.

## Design

### Inputs
#### Core nixos inputs

**nixpkgs** - Exposes the configuration to nixpkgs. Uses unstable by default
**nixpkgs-stable** - Stable packages fallback. Use the latest stable release
**nix-hardware** - NixOS modules that covers hardware specific quirks

#### Dendritic Tools
**flake-parts** - Provides the core framework the Dendritic Pattern uses
- Source:           https://github.com/hercules-ci/flake-parts
- Documentation:    https://flake.parts/

**flake-file** - Generates flake.nix from NixOS modules.
- Source:           https://github.com/denful/flake-file
- Documentation:    https://flake-file.denful.dev/

**import-tree** - Recursively imports all nix modules under a specified directory
- Source:           https://github.com/denful/import-tree
- Documentation:    https://import-tree.denful.dev/

#### Other Utilities
**home-manager** - Declarative user configuration
- Source:           https://github.com/nix-community/home-manager
- Documentation:    https://nix-community.github.io/home-manager/

**nvf** - Declarative neovim configuration
Source:         https://github.com/NotAShelf/nvf
Documentation:  https://nvf.notashelf.dev/

### Directory Structure

```
nixos-config/
 ├── modules/
 │    ├── hosts/
 │    │    ├── common/
 │    │    │   ├── workstation/
 │    │    │   ├── server/
 │    │    │   └── base.nix
 │    │    └── <hostname>/
 │    │        ├── configuration.nix 
 │    │        └── _hardware-configuration.nix
 │    │
 │    ├── users/
 │    │   └── <username>.nix
 │    │           
 │    ├── features/
 │    │   └── <category>/
 │    │        ├── <moduleDir>/
 │    │        └── <module>.nix
 │    │
 │    ├── suites/
 │    │   └── <suiteName>.nix
 │    │
 │    └── disks/
 │        └── <diskLayout>.nix
 ├── flake.nix
 └── flake.lock
```

### Directory Explanation

**nixos-config** - Project and Flake root directory

**modules/** - import-tree target; all modules within get automatically exposed
to the top-level configuration 

**hosts/** - shared and host specific configurations

**common/** - configurations shared between multiple machines

**workstation/** - workstation specific configurations; desktop.nix is specific 
to desktops, while laptop.nix is specific to laptops

**server/** - configurations for specific servers based on what the host is 
running on; bareMetal.nix for non-virtualized systems, virtualMachine.nix and 
container.nix for virtualized systems

**<hostName>/** - these configurations define options that are specific to one 
host; contains configuration.nix which defines the nixosConfiguration and the 
corresponding nixosModule.<hostname>Config module. _hardware-configuration.nix is 
the raw hardware-configuration that was generated during install; the '_' prefix 
tells import-tree to ignore this file.

**users/** - user specific configurations

**<userName>.nix** - monolithic user configuration containing both the 
nixosModule.<username> and homeModule.<username>

**features/** - home for all other configurations not defined in hosts/ or 
users/; each feature gets a <feature>.nix or, if <feature>/ if the feature will 
have submodules.  Example of a feature with submodules: zsh (zsh.nix: parent, 
imports the submodules, zshAliases.nix: zsh aliases, zshFunctions.nix: functions 
for zsh, zshOptions.nix: zsh options)

**suites/** - group of related modules for easy imports to hosts. One such 
example is a hyprland desktop suite (suiteHyprland.nix) which imports hyprland, 
hyprpaper, hypridle, hyprlock, waybar, mako, and rofi modules). These feature 
groups are typically always used together.

**disks/** - disko layout configurations; these are generic and may require 
specific overrides, thus the config/option module declaration is used for those 
options (such as disk device name). The file names indicate what kind of layout 
they are, for example: efiSingleLuksExt4.nix is a efi partition layout with a 
single LUKS encrypted ext4 partition.

**flake.nix** - autogenerated using flake-file. Inputs are colocated with their 
respective modules

**flake.lock** - autogenerated lock file

## Important Commands

### Testing (Ensure configuration works without switching to it)

`nix eval /path/to/flake#nixosConfigurations.<hostname>.config.system.build.toplevel`
 - evaluates the full NixOS module system and returns the derivation path. Great 
for catching evaluation errors instantly. No build, very fast.

`nixos-rebuild build --flake /path/to/flake#<hostname>`
- fully evaluates nix expressions and catches any syntax/type errors
- download and build all required packages
- produces a complete system closure at ./result
- does not touch the running system or bootloader at all

`nixos-rebuild dry-activate --flake /path/to/flake#<hostname>`
- simulates the activation script and prints what services would be 
started/stopped/restarted, without touching live system 

`nix flake check /path/to/flake`
- catches flake schema issues and runs any defined checks, doesn't build the 
full system

### flake-file
`nix run ".#write-flake"`
- uses flake-file to generate the flake.nix file based on nixos modules
