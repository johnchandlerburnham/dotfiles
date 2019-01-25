import           XMonad

import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops  (ewmh)
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers

import           XMonad.Layout.Fullscreen
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Reflect
import           XMonad.Layout.Spacing
import           XMonad.Layout.ThreeColumns

import           XMonad.Util.EZConfig

import           XMonad.Actions.Volume

import           Control.Monad

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


myModMask = mod4Mask

myLayoutHook = smartBorders myLayouts ||| noBorders (fullscreenFloat Full)

myLayouts = avoidStruts $ spacingWithEdge 15 $
  ThreeCol 1 (3/100) (3/5)
  ||| ThreeColMid 1 (3/100) (3/5)
  ||| reflectHoriz (ThreeCol 1 (3/100) (3/5))
  ||| Tall 1 (3/100) (3/5)
  ||| reflectHoriz (Tall 1 (3/100) (3/5))

myStartupHook = do
   spawn "feh --bg-fill --no-fehbg ~/background.png"
   spawn "taffybar &"

myManageHook = composeAll
  [ manageDocks
  , fullscreenManageHook
  , manageHook def
  ]

myKeys =
  [ ("M-p",                           spawn "rofi -show run"   )
  , ("M-S-p",                         spawn "rofi -show window")
  , ("M-b",                           spawn "qutebrowser")
  , ("M-S-b",                         spawn "firefox")
  , ("<XF86AudioLowerVolume>",        void $ lowerVolume 5)
  , ("<XF86AudioMute>",               void toggleMute)
  , ("<XF86AudioRaiseVolume>",        void $ raiseVolume 5)
  ]

myConfig = def
    { modMask = myModMask
    , borderWidth = 4
    , terminal = "urxvt"
    , focusedBorderColor = magenta
    , startupHook = myStartupHook
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , handleEventHook = handleEventHook def
    } `additionalKeysP` myKeys

main = xmonad . docks . ewmh $ myConfig

