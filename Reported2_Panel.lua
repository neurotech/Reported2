Panel = {}

local panelBase,
panelTitleBar,
listeningFontString,
placeHolderSeat,
channelFontString,
reportButton,
reportButtonTitle,
skipButton,
skipButtonTitle

local function CreatePanelBase()
  local alignmentFrame = CreateFrame("Frame", "REPORTED2_PANEL_ALIGNMENT", UIParent,
    BackdropTemplateMixin and "BackdropTemplate")
  Reported2.Utilities.SetPixelScaling(alignmentFrame)
  alignmentFrame:SetPoint("TOP")
  alignmentFrame:SetSize(
    Reported2.PANEL_WIDTH,
    (Reported2.TITLE_BAR_HEIGHT + (Reported2.SEAT_HEIGHT * Reported2.SEAT_COUNT) + (Reported2.SEAT_COUNT))
  )

  panelBase = CreateFrame("Frame", "REPORTED2_PANEL_BASE", alignmentFrame, BackdropTemplateMixin and "BackdropTemplate")

  Reported2.Utilities.SetPixelScaling(panelBase)
  panelBase:SetPoint("TOP")
  panelBase:SetSize(Reported2.PANEL_WIDTH, Reported2.PANEL_HEIGHT)
  panelBase:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  panelBase:SetBackdropColor(unpack(Reported2.Palette.RGB.GREY))
  panelBase:SetBackdropBorderColor(unpack(Reported2.Palette.RGB.DARK_GREY))

  alignmentFrame:SetClampedToScreen(true)
  alignmentFrame:SetMovable(true)
  alignmentFrame:EnableMouse(true)
  alignmentFrame:RegisterForDrag("LeftButton")
  alignmentFrame:SetScript("OnDragStart", alignmentFrame.StartMoving)
  alignmentFrame:SetScript("OnDragStop", alignmentFrame.StopMovingOrSizing)
end

local function CreatePanelTitleBar()
  panelTitleBar = CreateFrame("Frame", "REPORTED2_PANEL_BASE", panelBase, BackdropTemplateMixin and "BackdropTemplate")
  Reported2.Utilities.SetPixelScaling(panelTitleBar)
  panelTitleBar:SetPoint("TOP")
  panelTitleBar:SetSize(Reported2.PANEL_WIDTH, Reported2.TITLE_BAR_HEIGHT)
  panelTitleBar:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  panelTitleBar:SetBackdropColor(unpack(Reported2.Palette.RGB.DARK_GREY))
  panelTitleBar:SetBackdropBorderColor(unpack(Reported2.Palette.RGB.BLACK))

  local headerText = Reported2.Palette.START ..
      Reported2.Palette.RICH_YELLOW ..
      "Reported" ..
      Reported2.Palette.END ..
      Reported2.Palette.START .. Reported2.Palette.BRIGHT_YELLOW .. "!" .. Reported2.Palette.END
  Reported2.UI.CreatePixelText("HEADER_TEXT", panelTitleBar, headerText, nil, nil, "LEFT", nil
    , 0)

  local closeButton =
  Reported2.UI.CreatePixelButton(
    panelTitleBar,
    "CLOSE_BUTTON",
    Reported2.Language.Skip,
    Reported2.SQUARE_BUTTON_SIZE,
    Reported2.SQUARE_BUTTON_SIZE,
    Reported2.Palette.RGB.WHITE,
    0,
    1,
    Reported2.Palette.RGB.LIGHT_GREY,
    Reported2.Palette.RGB.GREY,
    "RIGHT",
    -(Reported2.PADDING),
    0,
    24
  )

  local clearButton =
  Reported2.UI.CreatePixelButton(
    closeButton,
    "CLEAR_BUTTON",
    "!",
    Reported2.SQUARE_BUTTON_SIZE,
    Reported2.SQUARE_BUTTON_SIZE,
    Reported2.Palette.RGB.WHITE,
    0,
    0,
    Reported2.Palette.RGB.LIGHT_GREY,
    Reported2.Palette.RGB.GREY,
    "RIGHT",
    -(closeButton:GetWidth() + Reported2.PADDING),
    0
  )

  closeButton:SetScript(
    "OnClick",
    function()
      REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = false
      Reported2.Panel.HidePanel()
      closeButton:SetBackdropColor(unpack(Reported2.Palette.RGB.GREY))
    end
  )

  clearButton:SetScript(
    "OnClick",
    function()
      for index = 1, #Reported2.OFFENDERS do
        local seat = _G["REPORTED2_SEAT_" .. index]
        seat:Hide()
      end
      Reported2.OFFENDERS = {}
      placeHolderSeat:Show()
      panelBase:SetSize(Reported2.PANEL_WIDTH, Reported2.PANEL_HEIGHT)
      clearButton:SetBackdropColor(unpack(Reported2.Palette.RGB.GREY))
      Reported2.Sounds.PlaySkipSound()
    end
  )
end

local function AddPlaceHolderSeat()
  placeHolderSeat =
  CreateFrame("Frame", "REPORTED2_SEAT_PLACEHOLDER", panelTitleBar, BackdropTemplateMixin and "BackdropTemplate")
  Reported2.Utilities.SetPixelScaling(placeHolderSeat)

  placeHolderSeat:SetPoint("TOPLEFT", panelTitleBar, 1, -Reported2.TITLE_BAR_HEIGHT)
  placeHolderSeat:SetSize(Reported2.SEAT_WIDTH, Reported2.SEAT_HEIGHT)
  placeHolderSeat:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  placeHolderSeat:SetBackdropColor(unpack(Reported2.Palette.RGB.GREY))
  placeHolderSeat:SetBackdropBorderColor(unpack(Reported2.Palette.RGB.LIGHT_GREY))

  local listeningText = "Listening..."
  Reported2.UI.CreatePixelText(
    "LISTENING_TEXT",
    placeHolderSeat,
    listeningText,
    Reported2.Palette.RGB.LIGHT_GREY,
    Reported2.Palette.RGB.DARK_GREY,
    "LEFT",
    Reported2.SeatOffsets.LISTENING
  )

  placeHolderSeat:Hide()
end

function Reported2.Panel.ShowPlaceHolderSeat()
  placeHolderSeat:Show()
end

function Reported2.Panel.UpsertSeat(index, offender)
  local seat,
  anchor,
  offset,
  channel,
  channelColour,
  shouldUpdate,
  offenderFontString,
  playerNameFontString,
  channelFontString,
  swearFontString,
  skipButton,
  reportButton

  placeHolderSeat:Hide()
  panelBase:SetSize(Reported2.PANEL_WIDTH, Reported2.TITLE_BAR_HEIGHT + (Reported2.SEAT_HEIGHT * index) + index)

  if _G["REPORTED2_SEAT_" .. index - 1] then
    anchor = _G["REPORTED2_SEAT_" .. index - 1]
  else
    anchor = panelTitleBar
  end

  if index == 1 then
    offset = Reported2.SEAT_HEIGHT
  else
    offset = Reported2.SEAT_HEIGHT + 1
  end

  if _G["REPORTED2_SEAT_" .. index] then
    shouldUpdate = true
    seat = _G["REPORTED2_SEAT_" .. index]
  else
    shouldUpdate = false
    seat = CreateFrame("Frame", "REPORTED2_SEAT_" .. index, anchor, BackdropTemplateMixin and "BackdropTemplate")
  end

  Reported2.Utilities.SetPixelScaling(seat)
  seat:SetPoint("BOTTOM", anchor, 0, -offset)
  seat:SetSize(Reported2.SEAT_WIDTH, Reported2.SEAT_HEIGHT)
  seat:Show()
  seat:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )

  seat:SetBackdropColor(unpack(Reported2.Events.DarkColours.RGB[offender.event]))
  seat:SetBackdropBorderColor(unpack(Reported2.Events.Colours.RGB[offender.event]))

  local offenderText = Reported2.Utilities.GenerateOffenderText(offender)

  if shouldUpdate then
    offenderFontString = _G["REPORTED2_OFFENDER_TEXT_" .. index]
    offenderFontString:SetText(offenderText)
  else
    offenderFontString =
    Reported2.UI.CreatePixelText(
      "REPORTED2_OFFENDER_TEXT_" .. index,
      seat,
      offenderText,
      nil,
      Reported2.Palette.RGB.BLACK,
      "LEFT",
      Reported2.PADDING * 2,
      nil,
      9
    )
  end

  if shouldUpdate then
    skipButton = _G["REPORTED2_SKIP_BUTTON" .. index]
  else
    skipButton =
    Reported2.UI.CreatePixelButton(
      seat,
      "REPORTED2_SKIP_BUTTON" .. index,
      "×",
      Reported2.SQUARE_BUTTON_SIZE,
      Reported2.SQUARE_BUTTON_SIZE,
      Reported2.Palette.RGB.SKIP_TEXT,
      0,
      1,
      Reported2.Palette.RGB.SKIP_BORDER,
      Reported2.Palette.RGB.SKIP_BG,
      "RIGHT",
      -Reported2.PADDING,
      0,
      24
    )
  end

  skipButton:SetScript(
    "OnClick",
    function()
      local seatToHide = _G["REPORTED2_SEAT_" .. index]
      seatToHide:Hide()
      table.remove(Reported2.OFFENDERS, index)
      Reported2.Sounds.PlaySkipSound()
      Reported2.Panel.RenderOffenders()

      skipButton:SetBackdropColor(unpack(Reported2.Palette.RGB.SKIP_BG))
    end
  )

  if shouldUpdate then
    reportButton = _G["REPORTED2_REPORT_BUTTON" .. index]
  else
    reportButton =
    Reported2.UI.CreatePixelButton(
      skipButton,
      "REPORTED2_REPORT_BUTTON" .. index,
      Reported2.Language.Report,
      Reported2.SQUARE_BUTTON_SIZE,
      Reported2.SQUARE_BUTTON_SIZE,
      Reported2.Palette.RGB.REPORT_TEXT,
      0,
      1,
      Reported2.Palette.RGB.REPORT_BORDER,
      Reported2.Palette.RGB.REPORT_BG,
      "RIGHT",
      -(skipButton:GetWidth() + Reported2.PADDING + 1),
      0,
      18
    )
  end


  reportButton:SetScript(
    "OnClick",
    function()
      local channelNumber
      local reportedMessage, randomModule = Reported2.Utilities.GetRandomReportedMessage(offender.playerName)

      print(
        Reported2.Utilities.CreateReportNotification(
          offender.playerName,
          randomModule,
          offender.classColour.colorStr,
          offender.swear
        )
      )

      if Reported2.Events.Readable[offender.event] == "Whisper" then
        channelNumber = offender.playerNameWithRealm
      else
        channelNumber = offender.channelNumber
      end

      SendChatMessage(reportedMessage, Reported2.Events.ChatTypes[offender.event], nil, channelNumber)
      Reported2.Sounds.PlayReportMadeSound()

      local seatToHide = _G["REPORTED2_SEAT_" .. index]
      seatToHide:Hide()

      table.remove(Reported2.OFFENDERS, index)

      Reported2.Panel.RenderOffenders()

      reportButton:SetBackdropColor(unpack(Reported2.Palette.RGB.REPORT_BG))
    end
  )
end

function Reported2.Panel.RenderOffenders()
  if #Reported2.OFFENDERS == 0 then
    Reported2.Panel.ShowPlaceHolderSeat()
  else
    -- Hide all seats first
    for index = 1, Reported2.SEAT_COUNT do
      local seatToHide = _G["REPORTED2_SEAT_" .. index]
      if seatToHide then
        seatToHide:Hide()
      end
    end

    -- Upsert accordingly
    for index = 1, #Reported2.OFFENDERS do
      Reported2.Panel.UpsertSeat(index, Reported2.OFFENDERS[index])
    end
  end

  if REPORTED2_PREFS[REPORTED2_PREFS_HIDE_WHEN_EMPTY] then
    if #Reported2.OFFENDERS == 0 then
      Reported2.Panel.HidePanel()
    end
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
  event,
  seatIndex)
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
      messageTime = date("%I:%M %p"),
      rawTime = time(),
      seatIndex = seatIndex
    }
  )
end

function Reported2.Panel.CreatePanel()
  CreatePanelBase()
  CreatePanelTitleBar()
  AddPlaceHolderSeat()

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
