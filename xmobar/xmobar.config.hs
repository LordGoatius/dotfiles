Config { 
         font = "xft:Fira Code-12"
         -- font = "xft:Ubuntu Mono-semibold-14"
       , additionalFonts = [ "xft:FiraCode Nerd Font Mono:pixelsize=13"
                           , "xft:Font Awesome 6 Free:pixelsize=13"
                           ]
       , borderColor = "black"
       , border = NoBorder
       , bgColor = "#202020"
       , fgColor = "#888888"
       -- , alpha = 190 
       , position = Static { xpos = 5 , ypos = 0, width = 1910, height = 26}
       -- , position = Top 
       , textOffset = 0
       , iconOffset = -1
       , lowerOnStart = False
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = 
         [ Run Weather "KSLE" ["-t","<tempF>°F",
                              "-L","18","-H","25"] 36000
         -- , Run Network "wlo1" ["-L","0","-H","32",
         --                      "--normal","green","--high","red"] 50
         -- , Run Network "enp44s0" ["-L","0","-H","32",
         --                      "--normal","gray","--high","gray",
         --                      "-t", "<rx>:<tx>"] 50
         , Run Cpu ["-L","3","-H","50",
                    "--normal","#32cd32","--high","red"] 10
         , Run Memory ["-t","Mem: <usedratio>%"] 10
         , Run Swap [] 10
         , Run Date "%a %b %d %Y %I:%M:%S %p" "date" 5
         , Run Com "/home/lordgoatius/.config/xmobar/gputemp.sh" [] "gpu" 300
         , Run Com "/home/lordgoatius/.config/xmobar/battery.sh" [] "battery" 60 
         , Run StdinReader 
         ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %cpu% | %gpu% | %memory% * %swap% }\
                    \%date%\
                    \{ %StdinReader% | Salem: %KSLE% | LordGoatius | %battery% "
       }
