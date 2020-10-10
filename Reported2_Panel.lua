Panel = {}

local panelBase, playerNameText, channelText, reportButton, reportButtonTitle, skipButton, skipButtonTitle

function CreatePanelBase()
  panelBase = CreateFrame("Frame", "REPORTED2_PANEL_BASE", UIParent, BackdropTemplateMixin and "BackdropTemplate")
  panelBase:SetPoint("CENTER")
  panelBase:SetSize(PANEL_WIDTH, PANEL_HEIGHT)
  panelBase:SetBackdrop(
    {
      bgFile = FLAT_BG_TEXTURE,
      edgeFile = EDGE_TEXTURE,
      edgeSize = 1
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
  local headerTextLeft =
    Palette.START ..
    Palette.BLUE .. "Reported" .. Palette.END .. Palette.START .. Palette.PALE_BLUE .. "!" .. Palette.END
  local panelHeaderTextLeft = panelBase:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  panelHeaderTextLeft:SetPoint("TOPLEFT", PADDING, -PADDING)
  panelHeaderTextLeft:SetText(headerTextLeft)
end

function CreatePanelHeaderTextRight()
  local headerTextRight = Palette.START .. Palette.RICH_YELLOW .. "Waiting Room" .. Palette.END
  local panelHeaderTextRight =
    panelBase:CreateFontString("REPORTED2_PANEL_HEADER_TEXT_RIGHT", "OVERLAY", "GameFontNormal")
  panelHeaderTextRight:SetPoint("TOPRIGHT", -PADDING, -PADDING)
  panelHeaderTextRight:SetText(headerTextRight)
end

function CreatePanelSeparator()
  panelSeparator =
    CreateFrame("Frame", "REPORTED2_PANEL_SEPARATOR", panelBase, BackdropTemplateMixin and "BackdropTemplate")
  panelSeparator:SetPoint("TOP", 0, -30)
  panelSeparator:SetSize(PANEL_WIDTH - (PADDING * 2), 1)
  panelSeparator:SetBackdrop(
    {
      bgFile = FLAT_BG_TEXTURE,
      edgeSize = 0
    }
  )
  panelSeparator:SetBackdropColor(0, 0, 0, 0.5)
end

function CreateSeats(numberOfSeats)
  local offset = -10
  for index = 1, numberOfSeats do
    CreateSeat(index, offset)
    offset = offset + -SEAT_HEIGHT + -(PADDING / 2)
  end
end

function CreateSeat(index, offset)
  local seat =
    CreateFrame("Frame", "REPORTED2_SEAT_" .. index, panelSeparator, BackdropTemplateMixin and "BackdropTemplate")

  seat:SetPoint("TOP", 0, offset)
  seat:SetSize(SEAT_WIDTH, SEAT_HEIGHT)
  seat:SetBackdrop(
    {
      bgFile = FLAT_BG_TEXTURE,
      edgeFile = EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  seat:SetBackdropColor(0, 0, 0, 0.15)
  seat:SetBackdropBorderColor(0, 0, 0, 0.15)

  playerNameText = seat:CreateFontString("REPORTED2_SEAT_" .. index .. "PLAYER_NAME", "OVERLAY", "GameFontNormal")
  playerNameText:SetPoint("TOPLEFT", PLAYER_X_OFFSET, -PADDING * 0.75)
  playerNameText:SetText(Palette.START .. Palette.GREY .. "Player" .. Palette.END)

  channelText = seat:CreateFontString("REPORTED2_SEAT_" .. index .. "CHANNEL", "OVERLAY", "GameFontNormal")
  channelText:SetPoint("TOPLEFT", CHANNEL_X_OFFSET, -PADDING * 0.75)
  channelText:SetText(Palette.START .. Palette.GREY .. "Channel" .. Palette.END)

  reportButton = CreateFrame("Button", "REPORTED2_SEAT_" .. index .. "REPORT_BUTTON", seat)
  reportButton:SetBackdrop(
    {
      bgFile = BUTTON_BG_TEXTURE,
      edgeFile = EDGE_TEXTURE,
      edgeSize = 1
    }
  )

  reportButton:SetSize(60, 20)
  reportButton:SetPoint("TOPLEFT", ACTIONS_X_OFFSET, -(PADDING / 2))
  reportButton:SetBackdropColor(Palette.RGB.GREY.r, Palette.RGB.GREY.g, Palette.RGB.GREY.b, 1)
  reportButton:SetBackdropBorderColor(Palette.RGB.DARK_GREY.r, Palette.RGB.DARK_GREY.g, Palette.RGB.DARK_GREY.b, 1)

  reportButtonTitle =
    reportButton:CreateFontString("REPORTED2_SEAT_" .. index .. "REPORT_BUTTON_TEXT", "OVERLAY", "GameFontNormal")
  reportButtonTitle:SetPoint("CENTER", reportButton, "CENTER")
  reportButtonTitle:SetText(Palette.START .. Palette.DARK_GREY .. "Report" .. Palette.END)

  skipButton = CreateFrame("Button", "REPORTED2_SEAT_" .. index .. "SKIP_BUTTON", seat)
  skipButton:SetBackdrop(
    {
      bgFile = BUTTON_BG_TEXTURE,
      edgeFile = EDGE_TEXTURE,
      edgeSize = 1
    }
  )

  skipButton:SetSize(20, 20)
  skipButton:SetPoint("TOPLEFT", ACTIONS_X_OFFSET + (PADDING / 2) + reportButton:GetWidth(), -(PADDING / 2))
  skipButton:SetBackdropColor(Palette.RGB.GREY.r, Palette.RGB.GREY.g, Palette.RGB.GREY.b, 1)
  skipButton:SetBackdropBorderColor(Palette.RGB.DARK_GREY.r, Palette.RGB.DARK_GREY.g, Palette.RGB.DARK_GREY.b, 1)

  skipButtonTitle =
    skipButton:CreateFontString("REPORTED2_SEAT_" .. index .. "SKIP_BUTTON_TEXT", "OVERLAY", "GameFontNormal")
  skipButtonTitle:SetPoint("CENTER", skipButton, "CENTER")
  skipButtonTitle:SetText(Palette.START .. Palette.DARK_GREY .. Language.Skip .. Palette.END)

  skipButton:Disable()
  reportButton:Disable()
end

function AddOffender(playerName, playerNameWithRealm, classColour, swear, message, channelName, channelNumber, event)
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
      messageTime = date("%I:%M %p")
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

function FlashHeaderTextRight()
  local flashTime = 0.150
  local headerTextRight = _G["REPORTED2_PANEL_HEADER_TEXT_RIGHT"]
  local normalText = Palette.START .. Palette.RICH_YELLOW .. "Waiting Room" .. Palette.END
  local flashedText = Palette.START .. Palette.BRIGHT_YELLOW .. "Waiting Room" .. Palette.END

  headerTextRight:SetText(flashedText)

  C_Timer.After(
    flashTime,
    function()
      headerTextRight:SetText(normalText)
    end
  )
end

Panel.CreatePanel = CreatePanel
Panel.AddOffender = AddOffender

Panel.ShowPanel = ShowPanel
Panel.HidePanel = HidePanel

Panel.SetWidgetText = SetWidgetText
Panel.DisableButton = DisableButton
Panel.EnableButton = EnableButton

Panel.FlashHeaderTextRight = FlashHeaderTextRight
