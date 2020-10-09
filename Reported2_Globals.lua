OFFENDERS = {}

Palette = {}
Palette.RGB = {}

Language = {}

Language.Skip = "x"

SEAT_COUNT = 5
PADDING = 10
SEAT_HEIGHT = PADDING * 3
PANEL_WIDTH = 335
PANEL_HEIGHT = 45 + (SEAT_COUNT * SEAT_HEIGHT) + (SEAT_COUNT * (PADDING / 2))
SEAT_WIDTH = PANEL_WIDTH - (PADDING * 2)
PLAYER_X_OFFSET = 0 + (PADDING / 2)
CHANNEL_X_OFFSET = PLAYER_X_OFFSET + 100
ACTIONS_X_OFFSET = CHANNEL_X_OFFSET + 120
DELAY_MIN = 1
DELAY_MAX = 3

rand = math.random

Palette.START = "|cff"
Palette.START_NO_ALPHA = "|c"
Palette.END = "|r"

-- ↓ #6B8BF5 ↓ --
Palette.BLUE = "6B8BF5"

-- ↓ #FFF569 ↓ --
Palette.BRIGHT_YELLOW = "FFF569"

-- ↓ #32333e ↓ --
Palette.DARK_GREY = "32333e"

-- ↓ #4D4E5F ↓ --
Palette.GREY = "4D4E5F"

-- ↓ #8A8CA8 ↓ --
Palette.LIGHT_GREY = "8A8CA8"

-- ↓ #B8C8F9 ↓ --
Palette.PALE_BLUE = "B8C8F9"

-- ↓ #FF66BA ↓ --
Palette.PINK = "FF66BA"

-- ↓ #9560FF ↓ --
Palette.PURPLE = "9560FF"

-- ↓ #FA1459 ↓ --
Palette.RED = "FA1459"

-- ↓ #FFB83C ↓ --
Palette.RICH_YELLOW = "FFB83C"

-- ↓ #00FF96 ↓ --
Palette.TEAL = "00FF96"

-- ↓ #ffffff ↓ --
Palette.WHITE = "ffffff"

Palette.RGB.BLACK = {r = 0, g = 0, b = 0}
Palette.RGB.RED = {r = 250 / 255, g = 20 / 255, b = 89 / 255}
Palette.RGB.TEAL = {r = 0 / 255, g = 1, b = 150 / 255}
Palette.RGB.WHITE = {r = 1, g = 1, b = 1}

Palette.RGB.DARK_GREY = {r = 7 / 255, g = 7 / 255, b = 7 / 255}
Palette.RGB.GREY = {r = 18 / 255, g = 18 / 255, b = 18 / 255}
Palette.RGB.LIGHT_GREY = {r = 51 / 255, g = 51 / 255, b = 51 / 255}

SLASH_REPORTEDTWO1 = "/r2"
SLASH_REPORTEDTWO2 = "/reported2"

BUTTON_BG_TEXTURE = [[Interface\Addons\Reported2\KMT56]]
FLAT_BG_TEXTURE = [[Interface\Buttons\WHITE8X8]]
EDGE_TEXTURE = [[Interface\Buttons\WHITE8X8]]

REPORTED2_PREFS_SHOW_PANEL = "REPORTED2_SHOW_PANEL"
REPORTED2_PREFS_HIDE_IN_COMBAT = "REPORTED2_HIDE_IN_COMBAT"
REPORTED2_PREFS_MUTE_SOUNDS = "REPORTED2_MUTE_SOUNDS"
REPORTED2_PREFS_ENABLED_MODULES = "REPORTED2_PREFS_ENABLED_MODULES"
REPORTED2_PREFS_DISABLED_MODULES = "REPORTED2_PREFS_DISABLED_MODULES"

REPORTED2_DEFAULT_PREFS = {
  [REPORTED2_PREFS_SHOW_PANEL] = true,
  [REPORTED2_PREFS_HIDE_IN_COMBAT] = false,
  [REPORTED2_PREFS_MUTE_SOUNDS] = false,
  [REPORTED2_PREFS_ENABLED_MODULES] = {},
  [REPORTED2_PREFS_DISABLED_MODULES] = {},
  [CHAT_MSG_CHANNEL] = true,
  [CHAT_MSG_GUILD] = false,
  [CHAT_MSG_OFFICER] = false,
  [CHAT_MSG_PARTY] = true,
  [CHAT_MSG_PARTY_LEADER] = true,
  [CHAT_MSG_RAID] = false,
  [CHAT_MSG_RAID_LEADER] = false,
  [CHAT_MSG_SAY] = true,
  [CHAT_MSG_WHISPER] = true,
  [CHAT_MSG_YELL] = true
}

local sortedModules = Utilities.GetSortedModuleNames(Modules)

for index, moduleName in ipairs(sortedModules) do
  table.insert(REPORTED2_DEFAULT_PREFS[REPORTED2_PREFS_ENABLED_MODULES], moduleName)
end
