Reported2.Utilities = {}

function CreateReportNotification(playerName, moduleName, classColour)
  local leftBracket = Reported2.Palette.START .. Reported2.Palette.WHITE .. "["
  local reportedPrefix = Reported2.Palette.START .. Reported2.Palette.TEAL .. "Reported! 2"
  local rightBracket = Reported2.Palette.START .. Reported2.Palette.WHITE .. "]"
  local reportedPlayer = " Reported player '"
  local playerClassColoured = Reported2.Palette.START_NO_ALPHA .. classColour .. playerName .. Reported2.Palette.END
  local usingTheModule =
    "' using the " ..
    Reported2.Palette.START ..
      Reported2.Palette.TEAL .. moduleName .. Reported2.Palette.END .. " module." .. Reported2.Palette.END

  return leftBracket .. reportedPrefix .. rightBracket .. reportedPlayer .. playerClassColoured .. usingTheModule
end

function GenerateContributorsString()
  local contributors = {"weasel", "Sneep", "TrashEmoji", "Bronzong", "Krakyn", "neurotech"}
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

function GetTableKeys(tab)
  local keyset = {}

  for k, v in pairs(tab) do
    keyset[#keyset + 1] = k
  end

  return keyset
end

function GetRandomReportedMessage(playerName)
  local enabledModules = REPORTED2_PREFS[REPORTED2_PREFS_ENABLED_MODULES]
  local randomModule = enabledModules[Reported2.rand(1, #enabledModules)]
  local line = Reported2.rand(1, #Reported2.Modules[randomModule])
  local text = Reported2.Modules[randomModule][line]
  text = text:gsub("%%Pl", playerName)
  text = text:gsub("%%PL", strupper(playerName))
  text = text:gsub("%%pl", strlower(playerName))

  return text, randomModule
end

function GetSortedModuleNames(modulesList)
  local sortedModuleNames = {}

  for moduleName in pairs(modulesList) do
    table.insert(sortedModuleNames, moduleName)
  end

  table.sort(sortedModuleNames)

  return sortedModuleNames
end

Reported2.Utilities.CreateReportNotification = CreateReportNotification
Reported2.Utilities.GenerateContributorsString = GenerateContributorsString
Reported2.Utilities.GetTableKeys = GetTableKeys
Reported2.Utilities.GetRandomReportedMessage = GetRandomReportedMessage
Reported2.Utilities.GetSortedModuleNames = GetSortedModuleNames
