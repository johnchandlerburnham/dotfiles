import           XMonad

import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops        (ewmh)
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers

import           XMonad.Layout.Fullscreen
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Reflect
import           XMonad.Layout.Spacing
import           XMonad.Layout.ThreeColumns

import           System.Taffybar.Hooks.PagerHints

-- Solarized Colors
base03  ="#002b36"
base02  ="#073642"
base01  ="#586e75"
base00  ="#657b83"
base0   ="#839496"
base1   ="#93a1a1"
base2   ="#eee8d5"
base3   ="#fdf6e3"
yellow  ="#b58900"
orange  ="#cb4b16"
red     ="#dc322f"
magenta ="#d33682"
violet  ="#6c71c4"
blue    ="#268bd2"
cyan    ="#2aa198"
green   ="#859900"


myLayoutHook = smartBorders $
  myLayouts ||| (fullscreenFloat Full)

myLayouts = avoidStruts $ spacingWithEdge 15 $
  ThreeCol 1 (3/100) (3/5)
  ||| ThreeColMid 1 (3/100) (3/5)
  ||| (reflectHoriz $ ThreeCol 1 (3/100) (3/5))
  ||| Tall 1 (3/100) (3/5)
  ||| (reflectHoriz $ Tall 1 (3/100) (3/5))

myStartupHook = do
   spawn "~/.fehbg"
   spawn "taffybar &"

myManageHook = composeAll
  [ manageDocks
  , fullscreenManageHook
  , manageHook def
  ]

myConfig = def
    { modMask = mod4Mask
    , borderWidth = 3
    , terminal = "urxvt"
    , focusedBorderColor = cyan
    , startupHook = myStartupHook
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , handleEventHook = handleEventHook def <+> fullscreenEventHook
    }

main = xmonad . docks . pagerHints . ewmh . fullscreenSupport $ myConfig
