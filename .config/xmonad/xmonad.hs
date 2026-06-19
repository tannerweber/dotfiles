import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Spacing
import XMonad.Prompt.ConfirmPrompt
import XMonad.Util.EZConfig (additionalKeysP)
import System.Exit
import qualified XMonad.StackSet as W

myLayoutHook = spacingWithEdge 10 $ layoutHook def

myKeys :: [(String, X ())]
myKeys =
  [ ("M-<Return>", spawn "wezterm"),
    ("M-r", spawn "rofi -show drun"),
    ("M-d", spawn "rofi -show drun"),
    ("M-<Space>", spawn "rofi -show drun"),
    ("M-S-r", spawn "xmonad --recompile" >> spawn "xmonad --restart"),
    ("M-m", io exitSuccess),
    ("M-t", withFocused $ windows . W.sink),
    ("M-q", kill)
  ]

main :: IO ()
main =
  xmonad $
    def
      { modMask = mod4Mask,
        terminal = "wezterm",
        borderWidth = 2,
        normalBorderColor = "#444b6a",
        focusedBorderColor = "#ad8ee6",
        layoutHook = myLayoutHook
      }
      `additionalKeysP` myKeys
