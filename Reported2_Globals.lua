Reported2 = {}

Reported2.OFFENDERS = {}
Reported2.Events = {}
Reported2.Language = {}
Reported2.Config = {}
Reported2.Panel = {}

REPORTED2_CHAT_MSG_CHANNEL = "CHAT_MSG_CHANNEL"
REPORTED2_CHAT_MSG_GUILD = "CHAT_MSG_GUILD"
REPORTED2_CHAT_MSG_INSTANCE_CHAT = "CHAT_MSG_INSTANCE_CHAT"
REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER = "CHAT_MSG_INSTANCE_CHAT_LEADER"
REPORTED2_CHAT_MSG_OFFICER = "CHAT_MSG_OFFICER"
REPORTED2_CHAT_MSG_PARTY = "CHAT_MSG_PARTY"
REPORTED2_CHAT_MSG_PARTY_LEADER = "CHAT_MSG_PARTY_LEADER"
REPORTED2_CHAT_MSG_RAID = "CHAT_MSG_RAID"
REPORTED2_CHAT_MSG_RAID_LEADER = "CHAT_MSG_RAID_LEADER"
REPORTED2_CHAT_MSG_SAY = "CHAT_MSG_SAY"
REPORTED2_CHAT_MSG_WHISPER = "CHAT_MSG_WHISPER"
REPORTED2_CHAT_MSG_YELL = "CHAT_MSG_YELL"

Reported2.Events.Raw = {
  REPORTED2_CHAT_MSG_CHANNEL,
  REPORTED2_CHAT_MSG_GUILD,
  REPORTED2_CHAT_MSG_INSTANCE_CHAT,
  REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER,
  REPORTED2_CHAT_MSG_OFFICER,
  REPORTED2_CHAT_MSG_PARTY_LEADER,
  REPORTED2_CHAT_MSG_PARTY,
  REPORTED2_CHAT_MSG_RAID_LEADER,
  REPORTED2_CHAT_MSG_RAID,
  REPORTED2_CHAT_MSG_SAY,
  REPORTED2_CHAT_MSG_WHISPER,
  REPORTED2_CHAT_MSG_YELL
}

Reported2.Events.Readable = {
  [REPORTED2_CHAT_MSG_CHANNEL] = "Channel",
  [REPORTED2_CHAT_MSG_GUILD] = "Guild",
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT] = "Instance",
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] = "Instance",
  [REPORTED2_CHAT_MSG_OFFICER] = "Officer",
  [REPORTED2_CHAT_MSG_PARTY_LEADER] = "Party",
  [REPORTED2_CHAT_MSG_PARTY] = "Party",
  [REPORTED2_CHAT_MSG_RAID_LEADER] = "Raid",
  [REPORTED2_CHAT_MSG_RAID] = "Raid",
  [REPORTED2_CHAT_MSG_SAY] = "Say",
  [REPORTED2_CHAT_MSG_WHISPER] = "Whisper",
  [REPORTED2_CHAT_MSG_YELL] = "Yell"
}

Reported2.Events.ChatTypes = {
  [REPORTED2_CHAT_MSG_CHANNEL] = "CHANNEL",
  [REPORTED2_CHAT_MSG_GUILD] = "GUILD",
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT] = "INSTANCE_CHAT",
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] = "INSTANCE_CHAT",
  [REPORTED2_CHAT_MSG_OFFICER] = "GUILD",
  [REPORTED2_CHAT_MSG_PARTY_LEADER] = "PARTY",
  [REPORTED2_CHAT_MSG_PARTY] = "PARTY",
  [REPORTED2_CHAT_MSG_RAID_LEADER] = "RAID",
  [REPORTED2_CHAT_MSG_RAID] = "RAID",
  [REPORTED2_CHAT_MSG_SAY] = "SAY",
  [REPORTED2_CHAT_MSG_WHISPER] = "WHISPER",
  [REPORTED2_CHAT_MSG_YELL] = "YELL"
}

Reported2.Events.Colours = {
  [REPORTED2_CHAT_MSG_CHANNEL] = "E8E079",
  [REPORTED2_CHAT_MSG_GUILD] = "40FB40",
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT] = "FF7F00",
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] = "FF4809",
  [REPORTED2_CHAT_MSG_OFFICER] = "40BD40",
  [REPORTED2_CHAT_MSG_PARTY_LEADER] = "76C5FF",
  [REPORTED2_CHAT_MSG_PARTY] = "AAA7FF",
  [REPORTED2_CHAT_MSG_RAID_LEADER] = "FF4709",
  [REPORTED2_CHAT_MSG_RAID] = "FF7D00",
  [REPORTED2_CHAT_MSG_SAY] = "FFFFFF",
  [REPORTED2_CHAT_MSG_WHISPER] = "FF7EFF",
  [REPORTED2_CHAT_MSG_YELL] = "FF3F40"
}

Reported2.Events.Colours.RGB = {
  [REPORTED2_CHAT_MSG_CHANNEL] = {232 / 255, 224 / 255, 121 / 255},
  [REPORTED2_CHAT_MSG_GUILD] = {64 / 255, 251 / 255, 64 / 255},
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT] = {255 / 255, 127 / 255, 0 / 255},
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] = {255 / 255, 72 / 255, 9 / 255},
  [REPORTED2_CHAT_MSG_OFFICER] = {64 / 255, 189 / 255, 64 / 255},
  [REPORTED2_CHAT_MSG_PARTY_LEADER] = {118 / 255, 197 / 255, 255 / 255},
  [REPORTED2_CHAT_MSG_PARTY] = {170 / 255, 167 / 255, 255 / 255},
  [REPORTED2_CHAT_MSG_RAID_LEADER] = {255 / 255, 71 / 255, 9 / 255},
  [REPORTED2_CHAT_MSG_RAID] = {255 / 255, 125 / 255, 0 / 255},
  [REPORTED2_CHAT_MSG_SAY] = {255 / 255, 255 / 255, 255 / 255},
  [REPORTED2_CHAT_MSG_WHISPER] = {255 / 255, 126 / 255, 255 / 255},
  [REPORTED2_CHAT_MSG_YELL] = {255 / 255, 63 / 255, 64 / 255}
}

Reported2.Events.DarkColours = {
  [REPORTED2_CHAT_MSG_CHANNEL] = "464324",
  [REPORTED2_CHAT_MSG_GUILD] = "134B13",
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT] = "4D2600",
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] = "4D1603",
  [REPORTED2_CHAT_MSG_OFFICER] = "133913",
  [REPORTED2_CHAT_MSG_PARTY_LEADER] = "233B4D",
  [REPORTED2_CHAT_MSG_PARTY] = "33324D",
  [REPORTED2_CHAT_MSG_RAID_LEADER] = "4D1503",
  [REPORTED2_CHAT_MSG_RAID] = "4D2600",
  [REPORTED2_CHAT_MSG_SAY] = "4D4D4D",
  [REPORTED2_CHAT_MSG_WHISPER] = "4D264D",
  [REPORTED2_CHAT_MSG_YELL] = "4D1313"
}

Reported2.Events.DarkColours.RGB = {
  [REPORTED2_CHAT_MSG_CHANNEL] = {70 / 255, 67 / 255, 36 / 255},
  [REPORTED2_CHAT_MSG_GUILD] = {19 / 255, 75 / 255, 19 / 255},
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT] = {77 / 255, 38 / 255, 0 / 255},
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] = {77 / 255, 22 / 255, 3 / 255},
  [REPORTED2_CHAT_MSG_OFFICER] = {19 / 255, 57 / 255, 19 / 255},
  [REPORTED2_CHAT_MSG_PARTY_LEADER] = {35 / 255, 59 / 255, 77 / 255},
  [REPORTED2_CHAT_MSG_PARTY] = {51 / 255, 50 / 255, 77 / 255},
  [REPORTED2_CHAT_MSG_RAID_LEADER] = {77 / 255, 21 / 255, 3 / 255},
  [REPORTED2_CHAT_MSG_RAID] = {77 / 255, 38 / 255, 0 / 255},
  [REPORTED2_CHAT_MSG_SAY] = {77 / 255, 77 / 255, 77 / 255},
  [REPORTED2_CHAT_MSG_WHISPER] = {77 / 255, 38 / 255, 77 / 255},
  [REPORTED2_CHAT_MSG_YELL] = {77 / 255, 19 / 255, 19 / 255}
}

Reported2.Palette = {}
Reported2.Palette.RGB = {}

Reported2.Language.Report = ">"
Reported2.Language.Skip = "x"

Reported2.SEAT_COUNT = 5
Reported2.PADDING = 4
Reported2.PANEL_WIDTH = 200
Reported2.PANEL_HEIGHT = 37
Reported2.TITLE_BAR_HEIGHT = 18
Reported2.SEAT_WIDTH = 198
Reported2.SEAT_HEIGHT = 18
Reported2.DELAY_MIN = 1
Reported2.DELAY_MAX = 3

Reported2.SeatOffsets = {
  LISTENING = 4,
  PLAYER = 4,
  CHANNEL = 58,
  SWEAR = 92,
  REPORT = 130,
  SKIP = 144
}

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

Reported2.Palette.RGB.TITLEBAR_BG = {20 / 255, 21 / 255, 26 / 255}
Reported2.Palette.RGB.TITLEBAR_BORDER = {11 / 255, 11 / 255, 14 / 255}
Reported2.Palette.RGB.TITLEBAR_BUTTON_BG = {60 / 255, 63 / 255, 78 / 255}
Reported2.Palette.RGB.TITLEBAR_BUTTON_BORDER = {124 / 255, 130 / 255, 161 / 255}

Reported2.Palette.RGB.PANEL_BG = {14 / 255, 15 / 255, 18 / 255}
Reported2.Palette.RGB.PANEL_BORDER = {14 / 255, 15 / 255, 18 / 255}

Reported2.Palette.RGB.SEAT_BG = {35 / 255, 36 / 255, 46 / 255}
Reported2.Palette.RGB.SEAT_BORDER = {57 / 255, 58 / 255, 73 / 255}
Reported2.Palette.RGB.SEAT_TEXT = {87 / 255, 88 / 255, 111 / 255}
Reported2.Palette.RGB.SEAT_TEXT_SHADOW = {20 / 255, 21 / 255, 26 / 255}

Reported2.Palette.RGB.REPORT_BG = {15 / 255, 91 / 255, 65 / 255}
Reported2.Palette.RGB.REPORT_BORDER = {28 / 255, 173 / 255, 123 / 255}
Reported2.Palette.RGB.REPORT_TEXT = {42 / 255, 255 / 255, 182 / 255}

Reported2.Palette.RGB.SKIP_BG = {62 / 255, 6 / 255, 22 / 255}
Reported2.Palette.RGB.SKIP_BORDER = {127 / 255, 11 / 255, 44 / 255}
Reported2.Palette.RGB.SKIP_TEXT = {255 / 255, 0 / 255, 96 / 255}

SLASH_REPORTEDTWO1 = "/r2"
SLASH_REPORTEDTWO2 = "/reported2"

Reported2.BUTTON_BG_TEXTURE = [[Interface\Addons\Reported2\KMT56]]
Reported2.FLAT_BG_TEXTURE = [[Interface\Buttons\WHITE8X8]]
Reported2.EDGE_TEXTURE = [[Interface\Buttons\WHITE8X8]]

REPORTED2_PREFS_SHOW_PANEL = "REPORTED2_SHOW_PANEL"
REPORTED2_PREFS_HIDE_IN_COMBAT = "REPORTED2_HIDE_IN_COMBAT"
REPORTED2_PREFS_HIDE_WHEN_EMPTY = "REPORTED2_HIDE_WHEN_EMPTY"
REPORTED2_PREFS_SHOW_ON_DETECTION = "REPORTED2_SHOW_ON_DETECTION"
REPORTED2_PREFS_MUTE_SOUNDS = "REPORTED2_MUTE_SOUNDS"
REPORTED2_PREFS_ENABLED_MODULES = "REPORTED2_PREFS_ENABLED_MODULES"
REPORTED2_PREFS_DISABLED_MODULES = "REPORTED2_PREFS_DISABLED_MODULES"

REPORTED2_DEFAULT_PREFS = {
  [REPORTED2_PREFS_SHOW_PANEL] = true,
  [REPORTED2_PREFS_HIDE_IN_COMBAT] = false,
  [REPORTED2_PREFS_HIDE_WHEN_EMPTY] = false,
  [REPORTED2_PREFS_SHOW_ON_DETECTION] = false,
  [REPORTED2_PREFS_MUTE_SOUNDS] = false,
  [REPORTED2_PREFS_ENABLED_MODULES] = {},
  [REPORTED2_PREFS_DISABLED_MODULES] = {},
  [REPORTED2_CHAT_MSG_CHANNEL] = true,
  [REPORTED2_CHAT_MSG_GUILD] = false,
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT] = true,
  [REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] = true,
  [REPORTED2_CHAT_MSG_OFFICER] = false,
  [REPORTED2_CHAT_MSG_PARTY] = true,
  [REPORTED2_CHAT_MSG_PARTY_LEADER] = true,
  [REPORTED2_CHAT_MSG_RAID] = false,
  [REPORTED2_CHAT_MSG_RAID_LEADER] = false,
  [REPORTED2_CHAT_MSG_SAY] = true,
  [REPORTED2_CHAT_MSG_WHISPER] = true,
  [REPORTED2_CHAT_MSG_YELL] = true
}
