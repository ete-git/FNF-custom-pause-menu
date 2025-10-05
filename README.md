# Custom Pause Menu for Psych Engine

I made a custom pause menu for Psych Engine using Lua scripting as a personal hobby.
You can also apply this to your own FNF mod.



## Features
- Fully Lua-based custom pause menu   
- Cursor-based option navigation  
- UI remains visible during pause  

### Preview
![Pause Menu Preview](preview.png)

## Installation
1. Copy the following folders into your Psych Engine mod directory:
```
mods/
└── your_mod_folder/
    ├── images/
    │   └── pausemenu/
    │       ├── pause_exit.png
    │       ├── pause_restart.png
    │       └── pause_resume.png
    └── scripts/
        └──CustomPausemenu.lua
```
2. Make sure the folder structure looks exactly like the example above.  
3. Launch Psych Engine and test it in your mod!

## How to Use
You can edit `CustomPauseMenu.lua` to:
- Add or remove options  
- Change fonts, colors, or layout  
- Customize pause sounds or transitions  
- Replace the images inside `images/pausemenu/` with your own designs  
  (Make sure to keep the same file names, e.g. `pause_resume.png`)

## Notes
- Tested on **Psych Engine 1.0.4h** — at least it works on this version.  
- Compatibility with older versions is unknown.

