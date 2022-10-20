Reported2.Utilities = {}

function Reported2.Utilities.CreateReportNotification(playerName, moduleName, classColour, swearWord)
  local leftBracket = Reported2.Palette.START .. Reported2.Palette.WHITE .. "["
  local reportedPrefix = Reported2.Palette.START .. Reported2.Palette.TEAL .. "Reported! 2"
  local rightBracket = Reported2.Palette.START .. Reported2.Palette.WHITE .. "]"
  local reportedPlayer = " Reported player '"
  local playerClassColoured = Reported2.Palette.START_NO_ALPHA .. classColour .. playerName .. Reported2.Palette.END
  local forSayingTheWord = "' for saying the word '"
  local swearWordColoured = Reported2.Palette.START .. Reported2.Palette.RED .. swearWord .. Reported2.Palette.END
  local usingTheModule =
  "' - using the " ..
      Reported2.Palette.START ..
      Reported2.Palette.TEAL .. moduleName .. Reported2.Palette.END .. " module." .. Reported2.Palette.END

  return leftBracket ..
      reportedPrefix ..
      rightBracket .. reportedPlayer .. playerClassColoured .. forSayingTheWord .. swearWordColoured .. usingTheModule
end

function Reported2.Utilities.GenerateContributorsString()
  local contributors = { "weasel", "Sneep", "Xenoletum", "Krakyn", "neurotech", "slowjack" }
  local whiteColourString = Reported2.Palette.START .. Reported2.Palette.WHITE
  local pinkColourString = Reported2.Palette.START .. Reported2.Palette.PINK
  local contributorsPrefix = whiteColourString .. "Contributors: "
  local commaString = whiteColourString .. ", "

  local contributorsString = contributorsPrefix

  for index, contributor in pairs(contributors) do
    if index == #contributors then
      contributorsString = contributorsString .. pinkColourString .. contributor .. Reported2.Palette.END
    else
      contributorsString = contributorsString .. pinkColourString .. contributor .. Reported2.Palette.END .. commaString
    end
  end

  return contributorsString
end

function Reported2.Utilities.GetTableKeys(tab)
  local keyset = {}

  for k, v in pairs(tab) do
    keyset[#keyset + 1] = k
  end

  return keyset
end

function Reported2.Utilities.GetRandomReportedMessage(playerName)
  local enabledModules = REPORTED2_PREFS[REPORTED2_PREFS_ENABLED_MODULES]
  local randomModule = enabledModules[Reported2.rand(1, #enabledModules)]
  local line = Reported2.rand(1, #Reported2.Modules[randomModule])
  local text = Reported2.Modules[randomModule][line]
  text = text:gsub("%%Pl", playerName)
  text = text:gsub("%%PL", strupper(playerName))
  text = text:gsub("%%pl", strlower(playerName))

  return text, randomModule
end

function Reported2.Utilities.GetSortedModuleNames(modulesList)
  local sortedModuleNames = {}

  for moduleName in pairs(modulesList) do
    table.insert(sortedModuleNames, moduleName)
  end

  table.sort(sortedModuleNames)

  return sortedModuleNames
end

function Reported2.Utilities.GenerateOffenderText(offender)
  local messageTemplate = "%PlayerName at %Time for %SwearWord"

  local offenderText = messageTemplate

  local playerNameText =
  Reported2.Palette.START_NO_ALPHA .. offender.classColour.colorStr .. offender.playerName .. Reported2.Palette.END

  local timeText = Reported2.Palette.START ..
      Reported2.Palette.BRIGHT_YELLOW .. offender.messageTime .. Reported2.Palette.END

  local swearText =
  Reported2.Palette.START ..
      Reported2.Palette.WHITE ..
      "'" ..
      Reported2.Palette.START ..
      Reported2.Palette.RED ..
      offender.swear .. Reported2.Palette.START .. Reported2.Palette.WHITE .. "'" .. Reported2.Palette.END

  offenderText = offenderText:gsub("%%PlayerName", playerNameText)
  offenderText = offenderText:gsub("%%Time", timeText)
  offenderText = offenderText:gsub("%%SwearWord", swearText)

  return offenderText
end

function Reported2.Utilities.LightenColour(colour, percent)
  percent = percent or 0.25

  local lighter = {}

  for _, value in ipairs(colour) do
    local lightened = (percent * 1) + value

    if lightened > 1 then
      lightened = 1
    end

    table.insert(lighter, lightened)
  end

  return lighter
end

function Reported2.Utilities.SetPixelScaling(frame)
  frame:SetIgnoreParentScale(true)
  frame:SetScale(768 / (select(2, GetPhysicalScreenSize())))
end
