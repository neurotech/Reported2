utilities = {}
colours = {}

colours.START = "|cff"
colours.START_NO_ALPHA = "|c"
colours.END = "|r"

colours.PALE_BLUE = "B8C8F9"
colours.BLUE = "6B8BF5"
colours.BRIGHT_YELLOW = "FFF569"
colours.RICH_YELLOW = "FFB83C"
colours.RED = "FA1459"
colours.TEAL = "00FF96"
colours.WHITE = "ffffff"

function CreateReportNotification(playerName, moduleName, classColour)
  local leftBracket = colours.START .. colours.WHITE .. "["
  local reportedPrefix = colours.START .. colours.TEAL .. "Reported! 2"
  local rightBracket = colours.START .. colours.WHITE .. "]"
  local reportedPlayer = " Reported player '"
  local playerClassColoured = colours.START_NO_ALPHA .. classColour .. playerName .. colours.END
  local usingTheModule =
    "' using the " .. colours.START .. colours.TEAL .. moduleName .. colours.END .. " module." .. colours.END

  return leftBracket .. reportedPrefix .. rightBracket .. reportedPlayer .. playerClassColoured .. usingTheModule
end

utilities.CreateReportNotification = CreateReportNotification
