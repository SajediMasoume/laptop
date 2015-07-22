import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig 
import Graphics.X11.ExtraTypes.XF86
 
main = xmonad $ defaultConfig
  { startupHook = setWMName "LG3D" >> takeTopFocus
  , manageHook = composeOne 
    [ transience
    , isFullscreen -?> doFullFloat ]
  , logHook = setWMName "LG3D" >> takeTopFocus
  , borderWidth = 0
  } `additionalKeys`
  [ ((0, xF86XK_MonBrightnessDown ), spawn "xbacklight -10") 
  , ((0, xF86XK_MonBrightnessUp ), spawn "xbacklight +10") 
  , ((0, xF86XK_AudioMute ), spawn "amixer -q sset Master toggle")  
  , ((0, xF86XK_AudioLowerVolume ), spawn "amixer -q sset Master 5%-") 
  , ((0, xF86XK_AudioRaiseVolume ), spawn "amixer -q sset Master 5%+")
  {-
    xF86XK_AudioPlay
    xF86XK_AudioPrev
    xF86XK_AudioNext
  -}
  ]