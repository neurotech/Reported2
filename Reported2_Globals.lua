Reported2 = {}

Reported2.OFFENDERS = {}
Reported2.Events = {}
Reported2.Language = {}
Reported2.Config = {}
Reported2.Panel = {}

CHAT_MSG_CHANNEL = "CHAT_MSG_CHANNEL"
CHAT_MSG_GUILD = "CHAT_MSG_GUILD"
CHAT_MSG_INSTANCE_CHAT = "CHAT_MSG_INSTANCE_CHAT"
CHAT_MSG_INSTANCE_CHAT_LEADER = "CHAT_MSG_INSTANCE_CHAT_LEADER"
CHAT_MSG_OFFICER = "CHAT_MSG_OFFICER"
CHAT_MSG_PARTY = "CHAT_MSG_PARTY"
CHAT_MSG_PARTY_LEADER = "CHAT_MSG_PARTY_LEADER"
CHAT_MSG_RAID = "CHAT_MSG_RAID"
CHAT_MSG_RAID_LEADER = "CHAT_MSG_RAID_LEADER"
CHAT_MSG_SAY = "CHAT_MSG_SAY"
CHAT_MSG_WHISPER = "CHAT_MSG_WHISPER"
CHAT_MSG_YELL = "CHAT_MSG_YELL"

Reported2.Events.Raw = {
  CHAT_MSG_CHANNEL,
  CHAT_MSG_GUILD,
  CHAT_MSG_INSTANCE_CHAT,
  CHAT_MSG_INSTANCE_CHAT_LEADER,
  CHAT_MSG_OFFICER,
  CHAT_MSG_PARTY_LEADER,
  CHAT_MSG_PARTY,
  CHAT_MSG_RAID_LEADER,
  CHAT_MSG_RAID,
  CHAT_MSG_SAY,
  CHAT_MSG_WHISPER,
  CHAT_MSG_YELL
}

Reported2.Events.Readable = {
  [CHAT_MSG_CHANNEL] = "Channel",
  [CHAT_MSG_GUILD] = "Guild",
  [CHAT_MSG_INSTANCE_CHAT] = "Instance",
  [CHAT_MSG_INSTANCE_CHAT_LEADER] = "Instance",
  [CHAT_MSG_OFFICER] = "Officer",
  [CHAT_MSG_PARTY_LEADER] = "Party",
  [CHAT_MSG_PARTY] = "Party",
  [CHAT_MSG_RAID_LEADER] = "Raid",
  [CHAT_MSG_RAID] = "Raid",
  [CHAT_MSG_SAY] = "Say",
  [CHAT_MSG_WHISPER] = "Whisper",
  [CHAT_MSG_YELL] = "Yell"
}

Reported2.Events.Colours = {
  [CHAT_MSG_CHANNEL] = "E8E079",
  [CHAT_MSG_GUILD] = "40FB40",
  [CHAT_MSG_INSTANCE_CHAT] = "FF7F00",
  [CHAT_MSG_INSTANCE_CHAT_LEADER] = "FF4809",
  [CHAT_MSG_OFFICER] = "40BD40",
  [CHAT_MSG_PARTY_LEADER] = "76C5FF",
  [CHAT_MSG_PARTY] = "AAA7FF",
  [CHAT_MSG_RAID_LEADER] = "FF4709",
  [CHAT_MSG_RAID] = "FF7D00",
  [CHAT_MSG_SAY] = "FFFFFF",
  [CHAT_MSG_WHISPER] = "FF7EFF",
  [CHAT_MSG_YELL] = "FF3F40"
}

Reported2.Events.Colours.RGB = {
  [CHAT_MSG_CHANNEL] = {r = 232 / 255, g = 224 / 255, b = 121 / 255},
  [CHAT_MSG_GUILD] = {r = 64 / 255, g = 251 / 255, b = 64 / 255},
  [CHAT_MSG_INSTANCE_CHAT] = {r = 255, g = 127 / 255, b = 0 / 255},
  [CHAT_MSG_INSTANCE_CHAT_LEADER] = {r = 255, g = 72 / 255, b = 9 / 255},
  [CHAT_MSG_OFFICER] = {r = 64 / 255, g = 189 / 255, b = 64 / 255},
  [CHAT_MSG_PARTY_LEADER] = {r = 118 / 255, g = 197 / 255, b = 255 / 255},
  [CHAT_MSG_PARTY] = {r = 170 / 255, g = 167 / 255, b = 255 / 255},
  [CHAT_MSG_RAID_LEADER] = {r = 255 / 255, g = 71 / 255, b = 9 / 255},
  [CHAT_MSG_RAID] = {r = 255 / 255, g = 125 / 255, b = 0 / 255},
  [CHAT_MSG_SAY] = {r = 255 / 255, g = 255 / 255, b = 255 / 255},
  [CHAT_MSG_WHISPER] = {r = 255 / 255, g = 126 / 255, b = 255 / 255},
  [CHAT_MSG_YELL] = {r = 255 / 255, g = 63 / 255, b = 64 / 255}
}

Reported2.Events.DarkColours = {
  [CHAT_MSG_CHANNEL] = "464324",
  [CHAT_MSG_GUILD] = "134B13",
  [CHAT_MSG_INSTANCE_CHAT] = "4D2600",
  [CHAT_MSG_INSTANCE_CHAT_LEADER] = "4D1603",
  [CHAT_MSG_OFFICER] = "133913",
  [CHAT_MSG_PARTY_LEADER] = "233B4D",
  [CHAT_MSG_PARTY] = "33324D",
  [CHAT_MSG_RAID_LEADER] = "4D1503",
  [CHAT_MSG_RAID] = "4D2600",
  [CHAT_MSG_SAY] = "4D4D4D",
  [CHAT_MSG_WHISPER] = "4D264D",
  [CHAT_MSG_YELL] = "4D1313"
}

Reported2.Events.DarkColours.RGB = {
  [CHAT_MSG_CHANNEL] = {r = 70 / 255, g = 67 / 255, b = 36 / 255},
  [CHAT_MSG_GUILD] = {r = 19 / 255, g = 75 / 255, b = 19 / 255},
  [CHAT_MSG_INSTANCE_CHAT] = {r = 77 / 255, g = 38 / 255, b = 0 / 255},
  [CHAT_MSG_INSTANCE_CHAT_LEADER] = {r = 77 / 255, g = 22 / 255, b = 3 / 255},
  [CHAT_MSG_OFFICER] = {r = 19 / 255, g = 57 / 255, b = 19 / 255},
  [CHAT_MSG_PARTY_LEADER] = {r = 35 / 255, g = 59 / 255, b = 77 / 255},
  [CHAT_MSG_PARTY] = {r = 51 / 255, g = 50 / 255, b = 77 / 255},
  [CHAT_MSG_RAID_LEADER] = {r = 77 / 255, g = 21 / 255, b = 3 / 255},
  [CHAT_MSG_RAID] = {r = 77 / 255, g = 38 / 255, b = 0 / 255},
  [CHAT_MSG_SAY] = {r = 77 / 255, g = 77 / 255, b = 77 / 255},
  [CHAT_MSG_WHISPER] = {r = 77 / 255, g = 38 / 255, b = 77 / 255},
  [CHAT_MSG_YELL] = {r = 77 / 255, g = 19 / 255, b = 19 / 255}
}

Reported2.Palette = {}
Reported2.Palette.RGB = {}

Reported2.Language.Skip = "x"

Reported2.SEAT_COUNT = 5
Reported2.PADDING = 10
Reported2.SEAT_HEIGHT = Reported2.PADDING * 3
Reported2.PANEL_WIDTH = 335
Reported2.PANEL_HEIGHT =
  45 + (Reported2.SEAT_COUNT * Reported2.SEAT_HEIGHT) + (Reported2.SEAT_COUNT * (Reported2.PADDING / 2))
Reported2.SEAT_WIDTH = Reported2.PANEL_WIDTH - (Reported2.PADDING * 2)
Reported2.PLAYER_X_OFFSET = 0 + (Reported2.PADDING / 2)
Reported2.CHANNEL_X_OFFSET = Reported2.PLAYER_X_OFFSET + 100
Reported2.ACTIONS_X_OFFSET = Reported2.CHANNEL_X_OFFSET + 120
Reported2.DELAY_MIN = 1
Reported2.DELAY_MAX = 3

Reported2.rand = math.random

Reported2.Palette.START = "|cff"
Reported2.Palette.START_NO_ALPHA = "|c"
Reported2.Palette.END = "|r"

-- ↓ #6B8BF5 ↓ --
Reported2.Palette.BLUE = "6B8BF5"

-- ↓ #FFF569 ↓ --
Reported2.Palette.BRIGHT_YELLOW = "FFF569"

-- ↓ #32333e ↓ --
Reported2.Palette.DARK_GREY = "32333e"

-- ↓ #4D4E5F ↓ --
Reported2.Palette.GREY = "4D4E5F"

-- ↓ #8A8CA8 ↓ --
Reported2.Palette.LIGHT_GREY = "8A8CA8"

-- ↓ #B8C8F9 ↓ --
Reported2.Palette.PALE_BLUE = "B8C8F9"

-- ↓ #FF66BA ↓ --
Reported2.Palette.PINK = "FF66BA"

-- ↓ #9560FF ↓ --
Reported2.Palette.PURPLE = "9560FF"

-- ↓ #FA1459 ↓ --
Reported2.Palette.RED = "FA1459"

-- ↓ #FFB83C ↓ --
Reported2.Palette.RICH_YELLOW = "FFB83C"

-- ↓ #00FF96 ↓ --
Reported2.Palette.TEAL = "00FF96"

-- ↓ #ffffff ↓ --
Reported2.Palette.WHITE = "ffffff"

Reported2.Palette.RGB.BLACK = {r = 0, g = 0, b = 0}
Reported2.Palette.RGB.RED = {r = 250 / 255, g = 20 / 255, b = 89 / 255}
Reported2.Palette.RGB.TEAL = {r = 0 / 255, g = 1, b = 150 / 255}
Reported2.Palette.RGB.WHITE = {r = 1, g = 1, b = 1}

Reported2.Palette.RGB.DARK_GREY = {r = 7 / 255, g = 7 / 255, b = 7 / 255}
Reported2.Palette.RGB.GREY = {r = 18 / 255, g = 18 / 255, b = 18 / 255}
Reported2.Palette.RGB.LIGHT_GREY = {r = 51 / 255, g = 51 / 255, b = 51 / 255}

SLASH_REPORTEDTWO1 = "/r2"
SLASH_REPORTEDTWO2 = "/reported2"

Reported2.BUTTON_BG_TEXTURE = [[Interface\Addons\Reported2\KMT56]]
Reported2.FLAT_BG_TEXTURE = [[Interface\Buttons\WHITE8X8]]
Reported2.EDGE_TEXTURE = [[Interface\Buttons\WHITE8X8]]

REPORTED2_PREFS_SHOW_PANEL = "REPORTED2_SHOW_PANEL"
REPORTED2_PREFS_HIDE_IN_COMBAT = "REPORTED2_HIDE_IN_COMBAT"
REPORTED2_PREFS_SHOW_ON_DETECTION = "REPORTED2_SHOW_ON_DETECTION"
REPORTED2_PREFS_MUTE_SOUNDS = "REPORTED2_MUTE_SOUNDS"
REPORTED2_PREFS_ENABLED_MODULES = "REPORTED2_PREFS_ENABLED_MODULES"
REPORTED2_PREFS_DISABLED_MODULES = "REPORTED2_PREFS_DISABLED_MODULES"

REPORTED2_DEFAULT_PREFS = {
  [REPORTED2_PREFS_SHOW_PANEL] = true,
  [REPORTED2_PREFS_HIDE_IN_COMBAT] = false,
  [REPORTED2_PREFS_SHOW_ON_DETECTION] = false,
  [REPORTED2_PREFS_MUTE_SOUNDS] = false,
  [REPORTED2_PREFS_ENABLED_MODULES] = {},
  [REPORTED2_PREFS_DISABLED_MODULES] = {},
  [CHAT_MSG_CHANNEL] = true,
  [CHAT_MSG_GUILD] = false,
  [CHAT_MSG_INSTANCE_CHAT] = true,
  [CHAT_MSG_INSTANCE_CHAT_LEADER] = true,
  [CHAT_MSG_OFFICER] = false,
  [CHAT_MSG_PARTY] = true,
  [CHAT_MSG_PARTY_LEADER] = true,
  [CHAT_MSG_RAID] = false,
  [CHAT_MSG_RAID_LEADER] = false,
  [CHAT_MSG_SAY] = true,
  [CHAT_MSG_WHISPER] = true,
  [CHAT_MSG_YELL] = true
}
