local panelBase, panelSeparator
local rand = math.random
local seatCount = 5
local padding = 10
local panelWidth = 430
local seatWidth = panelWidth - (padding * 2)
local seatHeight = padding * 3
local panelHeight = 40 + (seatCount * seatHeight) + (seatCount * padding)
local playerXOffset = 0 + padding
local channelXOffset = playerXOffset + 100
local swearXOffset = channelXOffset + 110
local actionsXOffset = swearXOffset + 70

local DelayMin = 2
local DelayMax = 6

offenders = {}

if REPORTED2_PREFS == nil then
  REPORTED2_PREFS = {}
end

for key, value in pairs(REPORTED2_DEFAULT_PREFS) do
  if REPORTED2_PREFS[key] == nil or REPORTED2_PREFS[key] == "" then
    REPORTED2_PREFS[key] = value
  end
end

function CreatePanel()
  panelBase = CreateFrame("Frame", "PANEL_BASE", UIParent, BackdropTemplateMixin and "BackdropTemplate")
  panelBase:SetPoint("CENTER", 128, 0)
  panelBase:SetSize(panelWidth, panelHeight)
  panelBase:SetBackdrop(
    {
      bgFile = "bgFile",
      edgeFile = "edgeFile",
      tile = false,
      tileEdge = false,
      tileSize = 0,
      edgeSize = 0,
      insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
  )
  panelBase:SetBackdropColor(0, 0, 0, 0.63)
  panelBase:SetBackdropBorderColor(0, 0, 0, 1)

  panelBase:SetClampedToScreen(true)
  panelBase:SetMovable(true)
  panelBase:EnableMouse(true)
  panelBase:RegisterForDrag("LeftButton")
  panelBase:SetScript("OnDragStart", panelBase.StartMoving)
  panelBase:SetScript("OnDragStop", panelBase.StopMovingOrSizing)
end

function CreatePanelHeaderTextLeft()
  local headerTextLeft = "|cff" .. "b8c8f9" .. "Reported" .. "|r" .. "|cff" .. "6b8bf5" .. "!" .. "|r"
  local panelHeaderTextLeft = panelBase:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  panelHeaderTextLeft:SetPoint("TOPLEFT", padding, -padding)
  panelHeaderTextLeft:SetText(headerTextLeft)
end

function CreatePanelHeaderTextRight()
  local headerTextRight = "|cff" .. "ffb83c" .. "Waiting Room" .. "|r"
  local panelHeaderTextRight = panelBase:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  panelHeaderTextRight:SetPoint("TOPRIGHT", -padding, -padding)
  panelHeaderTextRight:SetText(headerTextRight)
end

function CreatePanelSeparator()
  panelSeparator = CreateFrame("Frame", "PANEL_SEPARATOR", panelBase, BackdropTemplateMixin and "BackdropTemplate")
  panelSeparator:SetPoint("TOP", 0, -30)
  panelSeparator:SetSize(panelWidth - (padding * 2), 1)
  panelSeparator:SetBackdrop(
    {
      bgFile = "bgFile",
      tile = false,
      tileEdge = false,
      tileSize = 0,
      edgeSize = 0,
      insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
  )
  panelSeparator:SetBackdropColor(0, 0, 0, 0.5)
end

function CreateSeats(numberOfSeats)
  local offset = -10
  for index = 1, numberOfSeats do
    CreateSeat(index, offset)
    offset = offset + -seatHeight + -padding
  end
end

function CreateSeat(index, offset)
  local seat = CreateFrame("Frame", "SEAT_" .. index, panelSeparator, BackdropTemplateMixin and "BackdropTemplate")
  seat:SetPoint("TOP", 0, offset)
  seat:SetSize(seatWidth, seatHeight)
  seat:SetBackdrop(
    {
      bgFile = "bgFile",
      tile = false,
      tileEdge = false,
      tileSize = 0,
      edgeSize = 0,
      insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
  )
  seat:SetBackdropColor(0, 0, 0, 0.2)

  local playerNameText = seat:CreateFontString("SEAT_" .. index .. "PLAYER_NAME", "OVERLAY", "GameFontNormal")
  playerNameText:SetPoint("TOPLEFT", playerXOffset, -padding * 0.75)
  playerNameText:SetText("|cff" .. "4d4e5f" .. "Player" .. "|r")

  local channelText = seat:CreateFontString("SEAT_" .. index .. "CHANNEL", "OVERLAY", "GameFontNormal")
  channelText:SetPoint("TOPLEFT", channelXOffset, -padding * 0.75)
  channelText:SetText("|cff" .. "4d4e5f" .. "Channel" .. "|r")

  local swearText = seat:CreateFontString("SEAT_" .. index .. "SWEAR", "OVERLAY", "GameFontNormal")
  swearText:SetPoint("TOPLEFT", swearXOffset, -padding * 0.75)
  swearText:SetText("|cff" .. "4d4e5f" .. "Swear" .. "|r")

  local reportButton = CreateFrame("Button", "SEAT_" .. index .. "REPORT_BUTTON", seat)
  reportButton:SetTemplate(nil, true)
  reportButton:SetSize(60, 20)
  reportButton:SetPoint("TOPLEFT", actionsXOffset, -(padding / 2))
  reportButton:SetBackdropColor(0, 0, 0, 0.3)
  reportButton:SetBackdropBorderColor(0, 0, 0, 1)

  local reportButtonTitle =
    reportButton:CreateFontString("SEAT_" .. index .. "REPORT_BUTTON_TEXT", "OVERLAY", "GameFontNormal")
  reportButtonTitle:SetPoint("CENTER", reportButton, "CENTER")
  reportButtonTitle:SetText("|cff" .. "32333e" .. "Report" .. "|r")

  local skipButton = CreateFrame("Button", "SEAT_" .. index .. "SKIP_BUTTON", seat)
  skipButton:SetTemplate(nil, true)
  skipButton:SetSize(40, 20)
  skipButton:SetPoint("TOPLEFT", actionsXOffset + padding + reportButton:GetWidth(), -(padding / 2))
  skipButton:SetBackdropColor(0, 0, 0, 0.3)
  skipButton:SetBackdropBorderColor(0, 0, 0, 1)

  local skipButtonTitle =
    skipButton:CreateFontString("SEAT_" .. index .. "SKIP_BUTTON_TEXT", "OVERLAY", "GameFontNormal")
  skipButtonTitle:SetPoint("CENTER", skipButton, "CENTER")
  skipButtonTitle:SetText("|cff" .. "32333e" .. "Skip" .. "|r")

  skipButton:Disable()
  reportButton:Disable()
end

function AddOffender(playerName, classColour, swear, message, channelName, channelNumber, event, locked)
  table.insert(
    offenders,
    {
      playerName = playerName,
      classColour = classColour,
      swear = swear,
      message = message,
      channelName = channelName,
      channelNumber = channelNumber,
      event = event,
      locked = locked
    }
  )
end

function getTableKeys(tab)
  local keyset = {}

  for k, v in pairs(tab) do
    keyset[#keyset + 1] = k
  end

  return keyset
end

function GetReportedMessage(playerName)
  local moduleKeys = getTableKeys(modules)
  local randomModule = moduleKeys[rand(1, #moduleKeys)]
  local line = rand(1, #modules[randomModule])
  local text = modules[randomModule][line]
  text = text:gsub("%%Pl", playerName)
  text = text:gsub("%%PL", strupper(playerName))
  text = text:gsub("%%pl", strlower(playerName))

  return text, randomModule
end

function ResetSeat(index)
  local playerNameText = _G["SEAT_" .. index .. "PLAYER_NAME"]
  local channelText = _G["SEAT_" .. index .. "CHANNEL"]
  local swearText = _G["SEAT_" .. index .. "SWEAR"]
  local reportButton = _G["SEAT_" .. index .. "REPORT_BUTTON"]
  local reportButtonTitle = _G["SEAT_" .. index .. "REPORT_BUTTON_TEXT"]
  local skipButton = _G["SEAT_" .. index .. "SKIP_BUTTON"]
  local skipButtonTitle = _G["SEAT_" .. index .. "SKIP_BUTTON_TEXT"]

  playerNameText:SetText("|cff" .. "4d4e5f" .. "Player" .. "|r")
  channelText:SetText("|cff" .. "4d4e5f" .. "Channel" .. "|r")
  swearText:SetText("|cff" .. "4d4e5f" .. "Swear" .. "|r")

  reportButton:Disable()
  reportButtonTitle:SetText("|cff" .. "32333e" .. "Report" .. "|r")

  skipButton:Disable()
  skipButtonTitle:SetText("|cff" .. "32333e" .. "Skip" .. "|r")
end

function RenderOffenders()
  if REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] then
    for index = 1, seatCount do
      ResetSeat(index)
      table.sort(
        offenders,
        function(a, b)
          return not a
        end
      )
      local seat = _G["SEAT_" .. index]
      local record = offenders[index]
      if record then
        local channel
        local playerNameText = _G["SEAT_" .. index .. "PLAYER_NAME"]
        playerNameText:SetTextColor(record.classColour.r, record.classColour.g, record.classColour.b, 1)
        playerNameText:SetText(record.playerName)

        if record.channelName == "" then
          channel = events[record.event]
        else
          channel = record.channelName:gsub(" .*", "")
        end

        local channelColour = eventColours[record.event]
        local channelText = _G["SEAT_" .. index .. "CHANNEL"]
        channelText:SetTextColor(255, 255, 255, 1)
        channelText:SetText("|cff" .. channelColour .. channel .. "|r")

        local swearText = _G["SEAT_" .. index .. "SWEAR"]
        swearText:SetText("|cff" .. "fa1459" .. record.swear .. "|r")

        local seat = _G["SEAT_" .. index]

        local reportButton = _G["SEAT_" .. index .. "REPORT_BUTTON"]
        reportButton:SetScript(
          "OnClick",
          function()
            local reportedMessage, randomModule = GetReportedMessage(record.playerName)

            print(utilities.CreateReportNotification(record.playerName, randomModule, record.classColour.colorStr))
            SendChatMessage(reportedMessage, events[record.event], nil, record.channelNumber)
            table.remove(offenders, index)

            RenderOffenders()
          end
        )

        reportButton:SetScript(
          "OnEnter",
          function(button)
            button:SetBackdropBorderColor(0.31372549019, 0.46, 0.95294117647, 1)
          end
        )

        reportButton:SetScript(
          "OnLeave",
          function(button)
            button:SetBackdropBorderColor(0, 0, 0, 1)
          end
        )

        local reportButtonTitle = _G["SEAT_" .. index .. "REPORT_BUTTON_TEXT"]
        local delay = rand(DelayMin, DelayMax)

        if record.locked then
          reportButtonTitle:SetText("|cff" .. "32333e" .. "Wait" .. "|r")

          C_Timer.After(
            delay,
            function()
              record.locked = false
              reportButton:Enable()
              reportButtonTitle:SetText("|cff" .. "5077f3" .. "Report" .. "|r")
            end
          )
        else
          reportButtonTitle:SetText("|cff" .. "5077f3" .. "Report" .. "|r")
          reportButton:Enable()
        end

        local skipButton = _G["SEAT_" .. index .. "SKIP_BUTTON"]
        skipButton:SetScript(
          "OnClick",
          function()
            table.remove(offenders, index)
            RenderOffenders()
          end
        )

        skipButton:SetScript(
          "OnEnter",
          function(button)
            button:SetBackdropBorderColor(0.30196078431, 0.30588235294, 0.3725490196, 1)
          end
        )

        skipButton:SetScript(
          "OnLeave",
          function(button)
            button:SetBackdropBorderColor(0, 0, 0, 1)
          end
        )

        local skipButtonTitle = _G["SEAT_" .. index .. "SKIP_BUTTON_TEXT"]

        if record.locked then
          skipButtonTitle:SetText("|cff" .. "32333e" .. "Wait" .. "|r")

          C_Timer.After(
            delay,
            function()
              record.locked = false
              skipButton:Enable()
              skipButtonTitle:SetText("|cff" .. "4d4e5f" .. "Skip" .. "|r")
            end
          )
        else
          skipButtonTitle:SetText("|cff" .. "4d4e5f" .. "Skip" .. "|r")
          skipButton:Enable()
        end
      end
    end
    panelBase:Show()
  else
    panelBase:Hide()
  end
end

function Initialise()
  local chatListener = CreateFrame("Frame", "chatListener")

  chatListener:RegisterEvent("CHAT_MSG_SAY")
  chatListener:RegisterEvent("CHAT_MSG_YELL")
  chatListener:RegisterEvent("CHAT_MSG_RAID")
  chatListener:RegisterEvent("CHAT_MSG_PARTY")
  chatListener:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")
  chatListener:RegisterEvent("CHAT_MSG_CHANNEL")
  chatListener:RegisterEvent("CHAT_MSG_GUILD")

  CreatePanel()
  CreatePanelHeaderTextLeft()
  CreatePanelHeaderTextRight()
  CreatePanelSeparator()
  CreateSeats(seatCount)

  chatListener:SetScript(
    "OnEvent",
    function(self, event, ...)
      local channelName = select(9, ...)
      local message = select(1, ...)
      local sender = select(2, ...)
      local playerName = sender:gsub("%-.+", "")
      local channelIndex = select(8, ...)
      local guid = select(12, ...)

      local class
      if not guid or guid == "" then
        class = "PRIEST"
      else
        class = select(2, GetPlayerInfoByGUID(guid))
      end

      local classColour = RAID_CLASS_COLORS[class]

      local hasSwear = false
      local detectedWord
      local lastWord

      local paddedMessage = " " .. strlower(message) .. " "

      for _, swearString in ipairs(dictionary) do
        detectedWord = paddedMessage:match(swearString)
        lastWord = swearString

        if detectedWord then
          detectedWord = detectedWord:gsub("^%s+", ""):gsub("%s+$", "")
          hasSwear = true
          break
        end
      end

      if hasSwear then
        sounds.PlaySwearDetectedSound()
        if #offenders >= seatCount then
          print("Waiting room is full!")
        else
          local locked = true
          AddOffender(playerName, classColour, detectedWord, message, channelName, channelIndex, event, locked)
          RenderOffenders()
        end
      end
    end
  )
end

Initialise()

if REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] then
  panelBase:Show()
else
  panelBase:Hide()
end

function SetPanelVisibility(visible)
  if visible then
    panelBase:Show()
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = true
  else
    panelBase:Hide()
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = false
  end
end

function SlashCommandHandler(msg, editbox)
  if msg == "show" then
    SetPanelVisibility(true)
  end

  if msg == "hide" then
    SetPanelVisibility(false)
  end
end

SlashCmdList["REPORTEDTWO"] = SlashCommandHandler
