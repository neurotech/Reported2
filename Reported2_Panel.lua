Panel = {}

local panelBase, playerNameText, channelText, reportButton, reportButtonTitle, skipButton, skipButtonTitle

local function CreatePanelBase()
  panelBase = CreateFrame("Frame", "REPORTED2_PANEL_BASE", UIParent, BackdropTemplateMixin and "BackdropTemplate")
  panelBase:SetPoint("CENTER")
  panelBase:SetSize(Reported2.PANEL_WIDTH, Reported2.PANEL_HEIGHT)
  panelBase:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
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

local function CreatePanelHeaderTextLeft()
  local headerTextLeft =
    Reported2.Palette.START ..
    Reported2.Palette.BLUE ..
      "Reported" ..
        Reported2.Palette.END .. Reported2.Palette.START .. Reported2.Palette.PALE_BLUE .. "!" .. Reported2.Palette.END
  local panelHeaderTextLeft = panelBase:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  panelHeaderTextLeft:SetPoint("TOPLEFT", Reported2.PADDING, -Reported2.PADDING)
  panelHeaderTextLeft:SetText(headerTextLeft)
end

local function CreatePanelHeaderTextRight()
  local headerTextRight =
    Reported2.Palette.START .. Reported2.Palette.RICH_YELLOW .. "Waiting Room" .. Reported2.Palette.END
  local panelHeaderTextRight =
    panelBase:CreateFontString("REPORTED2_PANEL_HEADER_TEXT_RIGHT", "OVERLAY", "GameFontNormal")
  panelHeaderTextRight:SetPoint("TOPRIGHT", -Reported2.PADDING, -Reported2.PADDING)
  panelHeaderTextRight:SetText(headerTextRight)
end

local function CreatePanelSeparator()
  panelSeparator =
    CreateFrame("Frame", "REPORTED2_PANEL_SEPARATOR", panelBase, BackdropTemplateMixin and "BackdropTemplate")
  panelSeparator:SetPoint("TOP", 0, -30)
  panelSeparator:SetSize(Reported2.PANEL_WIDTH - (Reported2.PADDING * 2), 1)
  panelSeparator:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeSize = 0
    }
  )
  panelSeparator:SetBackdropColor(0, 0, 0, 0.5)
end

local function CreateSeat(index, offset)
  local seat =
    CreateFrame("Frame", "REPORTED2_SEAT_" .. index, panelSeparator, BackdropTemplateMixin and "BackdropTemplate")

  seat:SetPoint("TOP", 0, offset)
  seat:SetSize(Reported2.SEAT_WIDTH, Reported2.SEAT_HEIGHT)
  seat:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  seat:SetBackdropColor(0, 0, 0, 0.15)
  seat:SetBackdropBorderColor(0, 0, 0, 0.15)

  playerNameText = seat:CreateFontString("REPORTED2_SEAT_" .. index .. "PLAYER_NAME", "OVERLAY", "GameFontNormal")
  playerNameText:SetPoint("TOPLEFT", Reported2.PLAYER_X_OFFSET, -Reported2.PADDING * 0.75)
  playerNameText:SetText(Reported2.Palette.START .. Reported2.Palette.GREY .. "Player" .. Reported2.Palette.END)

  channelText = seat:CreateFontString("REPORTED2_SEAT_" .. index .. "CHANNEL", "OVERLAY", "GameFontNormal")
  channelText:SetPoint("TOPLEFT", Reported2.CHANNEL_X_OFFSET, -Reported2.PADDING * 0.75)
  channelText:SetText(Reported2.Palette.START .. Reported2.Palette.GREY .. "Channel" .. Reported2.Palette.END)

  reportButton =
    CreateFrame(
    "Button",
    "REPORTED2_SEAT_" .. index .. "REPORT_BUTTON",
    seat,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  reportButton:SetBackdrop(
    {
      bgFile = Reported2.BUTTON_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )

  reportButton:SetSize(60, 20)
  reportButton:SetPoint("TOPLEFT", Reported2.ACTIONS_X_OFFSET, -(Reported2.PADDING / 2))
  reportButton:SetBackdropColor(
    Reported2.Palette.RGB.GREY.r,
    Reported2.Palette.RGB.GREY.g,
    Reported2.Palette.RGB.GREY.b,
    1
  )
  reportButton:SetBackdropBorderColor(
    Reported2.Palette.RGB.DARK_GREY.r,
    Reported2.Palette.RGB.DARK_GREY.g,
    Reported2.Palette.RGB.DARK_GREY.b,
    1
  )

  reportButtonTitle =
    reportButton:CreateFontString("REPORTED2_SEAT_" .. index .. "REPORT_BUTTON_TEXT", "OVERLAY", "GameFontNormal")
  reportButtonTitle:SetPoint("CENTER", reportButton, "CENTER")
  reportButtonTitle:SetText(Reported2.Palette.START .. Reported2.Palette.DARK_GREY .. "Report" .. Reported2.Palette.END)

  skipButton =
    CreateFrame(
    "Button",
    "REPORTED2_SEAT_" .. index .. "SKIP_BUTTON",
    seat,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  skipButton:SetBackdrop(
    {
      bgFile = Reported2.BUTTON_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )

  skipButton:SetSize(20, 20)
  skipButton:SetPoint(
    "TOPLEFT",
    Reported2.ACTIONS_X_OFFSET + (Reported2.PADDING / 2) + reportButton:GetWidth(),
    -(Reported2.PADDING / 2)
  )
  skipButton:SetBackdropColor(
    Reported2.Palette.RGB.GREY.r,
    Reported2.Palette.RGB.GREY.g,
    Reported2.Palette.RGB.GREY.b,
    1
  )
  skipButton:SetBackdropBorderColor(
    Reported2.Palette.RGB.DARK_GREY.r,
    Reported2.Palette.RGB.DARK_GREY.g,
    Reported2.Palette.RGB.DARK_GREY.b,
    1
  )

  skipButtonTitle =
    skipButton:CreateFontString("REPORTED2_SEAT_" .. index .. "SKIP_BUTTON_TEXT", "OVERLAY", "GameFontNormal")
  skipButtonTitle:SetPoint("CENTER", skipButton, "CENTER")
  skipButtonTitle:SetText(
    Reported2.Palette.START .. Reported2.Palette.DARK_GREY .. Reported2.Language.Skip .. Reported2.Palette.END
  )

  skipButton:Disable()
  reportButton:Disable()
end

local function CreateSeats(numberOfSeats)
  local offset = -10
  for index = 1, numberOfSeats do
    CreateSeat(index, offset)
    offset = offset + -Reported2.SEAT_HEIGHT + -(Reported2.PADDING / 2)
  end
end

function Reported2.Panel.AddOffender(
  playerName,
  playerNameWithRealm,
  classColour,
  swear,
  message,
  channelName,
  channelNumber,
  event)
  table.insert(
    Reported2.OFFENDERS,
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

function Reported2.Panel.CreatePanel()
  CreatePanelBase()
  CreatePanelHeaderTextLeft()
  CreatePanelHeaderTextRight()
  CreatePanelSeparator()
  CreateSeats(Reported2.SEAT_COUNT)

  panelBase:Hide()
end

function Reported2.Panel.ShowPanel()
  if panelBase == nil then
    CreatePanel()
    panelBase:Show()
  else
    panelBase:Show()
  end
end

function Reported2.Panel.HidePanel()
  panelBase:Hide()
end

function Reported2.Panel.SetWidgetText(widget, text)
  widget:SetText(text)
end

function Reported2.Panel.DisableButton(button)
  button:Disable()
end

function Reported2.Panel.EnableButton(button)
  button:Enable()
end

function Reported2.Panel.FlashHeaderTextRight()
  local flashTime = 0.150
  local headerTextRight = _G["REPORTED2_PANEL_HEADER_TEXT_RIGHT"]
  local normalText = Reported2.Palette.START .. Reported2.Palette.RICH_YELLOW .. "Waiting Room" .. Reported2.Palette.END
  local flashedText =
    Reported2.Palette.START .. Reported2.Palette.BRIGHT_YELLOW .. "Waiting Room" .. Reported2.Palette.END

  headerTextRight:SetText(flashedText)

  C_Timer.After(
    flashTime,
    function()
      headerTextRight:SetText(normalText)
    end
  )
end
