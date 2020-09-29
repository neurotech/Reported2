Panel = {}

local panelBase, playerNameText, channelText, swearText, reportButton, reportButtonTitle, skipButton, skipButtonTitle

function CreatePanelBase()
  panelBase = CreateFrame("Frame", "PANEL_BASE", UIParent, BackdropTemplateMixin and "BackdropTemplate")
  panelBase:SetPoint("CENTER", 128, 0)
  panelBase:SetSize(PANEL_WIDTH, PANEL_HEIGHT)
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
  panelHeaderTextLeft:SetPoint("TOPLEFT", PADDING, -PADDING)
  panelHeaderTextLeft:SetText(headerTextLeft)
end

function CreatePanelHeaderTextRight()
  local headerTextRight = "|cff" .. "ffb83c" .. "Waiting Room" .. "|r"
  local panelHeaderTextRight = panelBase:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  panelHeaderTextRight:SetPoint("TOPRIGHT", -PADDING, -PADDING)
  panelHeaderTextRight:SetText(headerTextRight)
end

function CreatePanelSeparator()
  panelSeparator = CreateFrame("Frame", "PANEL_SEPARATOR", panelBase, BackdropTemplateMixin and "BackdropTemplate")
  panelSeparator:SetPoint("TOP", 0, -30)
  panelSeparator:SetSize(PANEL_WIDTH - (PADDING * 2), 1)
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
    offset = offset + -SEAT_HEIGHT + -PADDING
  end
end

function CreateSeat(index, offset)
  local seat = CreateFrame("Frame", "SEAT_" .. index, panelSeparator, BackdropTemplateMixin and "BackdropTemplate")
  seat:SetPoint("TOP", 0, offset)
  seat:SetSize(SEAT_WIDTH, SEAT_HEIGHT)
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

  playerNameText = seat:CreateFontString("SEAT_" .. index .. "PLAYER_NAME", "OVERLAY", "GameFontNormal")
  playerNameText:SetPoint("TOPLEFT", PLAYER_X_OFFSET, -PADDING * 0.75)
  playerNameText:SetText("|cff" .. "4d4e5f" .. "Player" .. "|r")

  channelText = seat:CreateFontString("SEAT_" .. index .. "CHANNEL", "OVERLAY", "GameFontNormal")
  channelText:SetPoint("TOPLEFT", CHANNEL_X_OFFSET, -PADDING * 0.75)
  channelText:SetText("|cff" .. "4d4e5f" .. "Channel" .. "|r")

  swearText = seat:CreateFontString("SEAT_" .. index .. "SWEAR", "OVERLAY", "GameFontNormal")
  swearText:SetPoint("TOPLEFT", SWEAR_X_OFFSET, -PADDING * 0.75)
  swearText:SetText("|cff" .. "4d4e5f" .. "Swear" .. "|r")

  reportButton = CreateFrame("Button", "SEAT_" .. index .. "REPORT_BUTTON", seat)
  --reportButton:SetTemplate(nil, true)
  reportButton:SetSize(60, 20)
  reportButton:SetPoint("TOPLEFT", ACTIONS_X_OFFSET, -(PADDING / 2))
  reportButton:SetBackdropColor(0, 0, 0, 0.3)
  reportButton:SetBackdropBorderColor(0, 0, 0, 1)

  reportButtonTitle =
    reportButton:CreateFontString("SEAT_" .. index .. "REPORT_BUTTON_TEXT", "OVERLAY", "GameFontNormal")
  reportButtonTitle:SetPoint("CENTER", reportButton, "CENTER")
  reportButtonTitle:SetText("|cff" .. "32333e" .. "Report" .. "|r")

  skipButton = CreateFrame("Button", "SEAT_" .. index .. "SKIP_BUTTON", seat)
  --skipButton:SetTemplate(nil, true)
  skipButton:SetSize(40, 20)
  skipButton:SetPoint("TOPLEFT", ACTIONS_X_OFFSET + PADDING + reportButton:GetWidth(), -(PADDING / 2))
  skipButton:SetBackdropColor(0, 0, 0, 0.3)
  skipButton:SetBackdropBorderColor(0, 0, 0, 1)

  skipButtonTitle = skipButton:CreateFontString("SEAT_" .. index .. "SKIP_BUTTON_TEXT", "OVERLAY", "GameFontNormal")
  skipButtonTitle:SetPoint("CENTER", skipButton, "CENTER")
  skipButtonTitle:SetText("|cff" .. "32333e" .. "Skip" .. "|r")

  skipButton:Disable()
  reportButton:Disable()
end

function AddOffender(
  playerName,
  playerNameWithRealm,
  classColour,
  swear,
  message,
  channelName,
  channelNumber,
  event,
  locked)
  table.insert(
    OFFENDERS,
    {
      playerName = playerName,
      playerNameWithRealm = playerNameWithRealm,
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

function CreatePanel()
  CreatePanelBase()
  CreatePanelHeaderTextLeft()
  CreatePanelHeaderTextRight()
  CreatePanelSeparator()
  CreateSeats(SEAT_COUNT)

  panelBase:Hide()
end

function ShowPanel()
  panelBase:Show()
end

function HidePanel()
  panelBase:Hide()
end

function SetWidgetText(widget, text)
  widget:SetText(text)
end

function DisableButton(button)
  button:Disable()
end

function EnableButton(button)
  button:Enable()
end

Panel.CreatePanel = CreatePanel
Panel.AddOffender = AddOffender

Panel.ShowPanel = ShowPanel
Panel.HidePanel = HidePanel

Panel.SetWidgetText = SetWidgetText
Panel.DisableButton = DisableButton
Panel.EnableButton = EnableButton
