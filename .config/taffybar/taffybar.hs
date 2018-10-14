import           System.Taffybar

import           System.Taffybar.FreedesktopNotifications
import           System.Taffybar.MPRIS
import           System.Taffybar.NetMonitor
import           System.Taffybar.SimpleClock
import           System.Taffybar.Systray
import           System.Taffybar.TaffyPager
import           System.Taffybar.Weather

import           System.Taffybar.Weather
import           System.Taffybar.Widgets.PollingBar
import           System.Taffybar.Widgets.PollingGraph

import           System.Information.CPU
import           System.Information.CPU2
import           System.Information.Memory
import           System.Information.Network

import           Text.StringTemplate

-- Solarized Colors
base03  = 0x002b36
base02  = 0x073642
base01  = 0x586e75
base00  = 0x657b83
base0   = 0x839496
base1   = 0x93a1a1
base2   = 0xeee8d5
base3   = 0xfdf6e3
yellow  = 0xb58900
orange  = 0xcb4b16
red     = 0xdc322f
magenta = 0xd33682
violet  = 0x6c71c4
blue    = 0x268bd2
cyan    = 0x2aa198
green   = 0x859900

-- convert a number into a color triple
color3 :: Int -> (Double, Double, Double)
color3 n = (r, g, b)
  where
    percent n = (fromIntegral n) / 256
    r = percent $ n `div` 0x10000
    g = percent $ n `mod` 0x10000 `div` 0x100
    b = percent $ n `mod` 0x100

-- color3 plus Transparency
color3T :: Int -> Double -> (Double, Double, Double, Double)
color3T n t = let (r, g, b) = color3 n in (r, g, b, t)

-- Graphs

cpuGraphConfig = defaultGraphConfig
  { graphPadding = 1
  , graphBackgroundColor = (color3 base02)
  , graphBorderColor = (color3 base02)
  , graphBorderWidth = 2
  , graphDataColors = [(color3T green 1)]
  , graphLabel = Just "cpu"
  , graphWidth = 40
  , graphDirection = RIGHT_TO_LEFT
  }

memGraphConfig = defaultGraphConfig
  { graphPadding = 1
  , graphBackgroundColor = (color3 base02)
  , graphBorderColor = (color3 base02)
  , graphBorderWidth = 2
  , graphDataColors = [(color3T magenta 1)]
  , graphLabel = Just "mem"
  , graphWidth = 40
  , graphDirection = RIGHT_TO_LEFT
  }

hotGraphConfig = defaultGraphConfig
  { graphPadding = 1
  , graphBackgroundColor = (color3 base02)
  , graphBorderColor = (color3 base02)
  , graphBorderWidth = 2
  , graphDataColors = [(color3T red 1)]
  , graphLabel = Just "hot"
  , graphWidth = 40
  , graphDirection = RIGHT_TO_LEFT
  }

-- Weather
{-
myWeatherURL = "http://tgftp.nws.noaa.gov/data/observations/metar/decoded"

myWeatherConfig = WeatherConfig
  { weatherStation = "KBOS"
  , weatherTemplate = "$tempF$°F @ $humidity$ & $pressure$ $stationPlace$,$stationState$"
  , weatherFormatter = myWeatherFormatter
  }

myWeatherFormatter :: WeatherInfo -> String

myWeatherNew :: WeatherConfig -> Double -> IO Widget
weatherNew cfg delayMinutes = do
  let url = printf "%s/%s.TXT" myWeatherURL (weatherStation cfg)
      getter = getWeather (weatherProxy cfg) url
  weatherCustomNew getter (weatherTemplate cfg) (weatherTemplateTooltip cfg)
    (weatherFormatter cfg) delayMinutes
-}


memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

hotCallback = do
  cpuTemp <- getCPUTemp ["cpu0"]
  return $ fromIntegral <$> cpuTemp

main = do
  let memCfg = defaultGraphConfig
        { graphDataColors = [(color3T red 1)]
        , graphLabel = Just "mem"
        }
  let clock = textClockNew Nothing
                "<span fgcolor='orange'>%a %b %_d %H:%M</span>" 1
      pager = taffyPagerNew defaultPagerConfig
      note = notifyAreaNew defaultNotificationConfig
      wea = weatherNew (defaultWeatherConfig "KBOS") 10
      mpris = mprisNew defaultMPRISConfig
      mem = pollingGraphNew memGraphConfig 0.5 memCallback
      cpu = pollingGraphNew cpuGraphConfig 0.5 cpuCallback
      net = netMonitorNewWith 0.5 "wlp5s0" 3 "▼ $inMB$ Mb/s ▲ $outMB$ Mb/s"

      -- hot = pollingGraphNew hotGraphConfig 0.5 hotCallback
      tray = systrayNew
  defaultTaffybar defaultTaffybarConfig
    { startWidgets = [ pager, note, tray ]
    , endWidgets = [ clock, mem, cpu, net, mpris]
    }
