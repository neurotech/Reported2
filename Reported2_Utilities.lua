Utilities = {}

function CreateReportNotification(playerName, moduleName, classColour)
  local leftBracket = Palette.START .. Palette.WHITE .. "["
  local reportedPrefix = Palette.START .. Palette.TEAL .. "Reported! 2"
  local rightBracket = Palette.START .. Palette.WHITE .. "]"
  local reportedPlayer = " Reported player '"
  local playerClassColoured = Palette.START_NO_ALPHA .. classColour .. playerName .. Palette.END
  local usingTheModule =
    "' using the " .. Palette.START .. Palette.TEAL .. moduleName .. Palette.END .. " module." .. Palette.END

  return leftBracket .. reportedPrefix .. rightBracket .. reportedPlayer .. playerClassColoured .. usingTheModule
end

function GenerateContributorsString()
  local contributors = {"weasel", "Sneep", "TrashEmoji", "Bronzong", "Krakyn", "neurotech"}
  local whiteColourString = Palette.START .. Palette.WHITE
  local pinkColourString = Palette.START .. Palette.PINK
  local contributorsPrefix = whiteColourString .. "Contributors: "
  local commaString = whiteColourString .. ", "

  local contributorsString = contributorsPrefix

  for index, contributor in pairs(contributors) do
    if index == #contributors then
      contributorsString = contributorsString .. pinkColourString .. contributor .. Palette.END
    else
      contributorsString = contributorsString .. pinkColourString .. contributor .. Palette.END .. commaString
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
  local moduleKeys = GetTableKeys(Modules)
  local randomModule = moduleKeys[rand(1, #moduleKeys)]
  local line = rand(1, #Modules[randomModule])
  local text = Modules[randomModule][line]
  text = text:gsub("%%Pl", playerName)
  text = text:gsub("%%PL", strupper(playerName))
  text = text:gsub("%%pl", strlower(playerName))

  return text, randomModule
end

Utilities.CreateReportNotification = CreateReportNotification
Utilities.GenerateContributorsString = GenerateContributorsString
Utilities.GetTableKeys = GetTableKeys
Utilities.GetRandomReportedMessage = GetRandomReportedMessage
