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
  panelBase:SetBackdropColor(Reported2.Palette.RGB.PANEL_BG)
  panelBase:SetBackdropBorderColor(Reported2.Palette.RGB.PANEL_BORDER)

  panelBase:SetClampedToScreen(true)
  panelBase:SetMovable(true)
  panelBase:EnableMouse(true)
  panelBase:RegisterForDrag("LeftButton")
  panelBase:SetScript("OnDragStart", panelBase.StartMoving)
  panelBase:SetScript("OnDragStop", panelBase.StopMovingOrSizing)
end

local function CreatePanelTitleBar()
  panelTitleBar = CreateFrame("Frame", "REPORTED2_PANEL_BASE", panelBase, BackdropTemplateMixin and "BackdropTemplate")
  panelTitleBar:SetPoint("TOP")
  panelTitleBar:SetSize(Reported2.PANEL_WIDTH, Reported2.TITLE_BAR_HEIGHT)
  panelTitleBar:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  panelTitleBar:SetBackdropColor(unpack(Reported2.Palette.RGB.TITLEBAR_BG))
  panelTitleBar:SetBackdropBorderColor(unpack(Reported2.Palette.RGB.TITLEBAR_BORDER))

  local headerText =
    Reported2.Palette.START ..
    Reported2.Palette.BLUE ..
      "Reported" ..
        Reported2.Palette.END .. Reported2.Palette.START .. Reported2.Palette.PALE_BLUE .. "!" .. Reported2.Palette.END
  Reported2.UI.CreatePixelText("HEADER_TEXT", panelTitleBar, headerText)

  local closeButton =
    Reported2.UI.CreatePixelButton(
    panelTitleBar,
    "CLOSE_BUTTON",
    Reported2.Language.Skip,
    12,
    12,
    {1, 1, 1},
    1,
    1,
    Reported2.Palette.RGB.TITLEBAR_BUTTON_BORDER,
    Reported2.Palette.RGB.TITLEBAR_BUTTON_BG,
    "RIGHT",
    -3,
    0
  )

  local clearButton =
    Reported2.UI.CreatePixelButton(
    closeButton,
    "CLEAR_BUTTON",
    "!",
    12,
    12,
    {1, 1, 1},
    0,
    0,
    Reported2.Palette.RGB.TITLEBAR_BUTTON_BORDER,
    Reported2.Palette.RGB.TITLEBAR_BUTTON_BG,
    "LEFT",
    -14,
    0
  )

  closeButton:SetScript(
    "OnClick",
    function()
      REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = false
      Reported2.Panel.HidePanel()
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
    end
  )
end

local function AddPlaceHolderSeat(chatType)
  placeHolderSeat =
    CreateFrame("Frame", "REPORTED2_SEAT_PLACEHOLDER", panelTitleBar, BackdropTemplateMixin and "BackdropTemplate")
  placeHolderSeat:SetPoint("TOP", panelTitleBar, 0, -Reported2.SEAT_HEIGHT)
  placeHolderSeat:SetSize(Reported2.SEAT_WIDTH, Reported2.SEAT_HEIGHT)
  placeHolderSeat:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  placeHolderSeat:SetBackdropColor(unpack(Reported2.Palette.RGB.SEAT_BG))
  placeHolderSeat:SetBackdropBorderColor(unpack(Reported2.Palette.RGB.SEAT_BORDER))

  local listeningText = "Listening..."
  listeningFontString =
    Reported2.UI.CreatePixelText(
    "LISTENING_TEXT",
    placeHolderSeat,
    listeningText,
    Reported2.Palette.RGB.SEAT_TEXT,
    Reported2.Palette.RGB.SEAT_TEXT_SHADOW,
    "LEFT",
    Reported2.SeatOffsets.LISTENING,
    1
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

  seat:Show()
  seat:SetPoint("BOTTOM", anchor, 0, -offset)
  seat:SetSize(Reported2.SEAT_WIDTH, Reported2.SEAT_HEIGHT)
  seat:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )

  seat:SetBackdropColor(unpack(Reported2.Events.DarkColours.RGB[offender.event]))
  seat:SetBackdropBorderColor(unpack(Reported2.Events.Colours.RGB[offender.event]))

  local playerNameText =
    Reported2.Palette.START_NO_ALPHA .. offender.classColour.colorStr .. offender.playerName .. Reported2.Palette.END

  if shouldUpdate then
    playerNameFontString = _G["REPORTED2_PLAYER_NAME_TEXT_" .. index]
    playerNameFontString:SetText(playerNameText)
  else
    playerNameFontString =
      Reported2.UI.CreatePixelText(
      "REPORTED2_PLAYER_NAME_TEXT_" .. index,
      seat,
      playerNameText,
      nil,
      Reported2.Palette.RGB.BLACK,
      "LEFT",
      Reported2.SeatOffsets.PLAYER,
      1
    )
  end

  if offender.channelName == "" then
    channel = Reported2.Events.Readable[offender.event]
  else
    channel = offender.channelName:gsub(" .*", "")
    channel = "CH: " .. channel:gsub("[^A-Z]", "")
  end

  channelColour = Reported2.Events.Colours[offender.event]

  local channelText = Reported2.Palette.START .. channelColour .. channel .. Reported2.Palette.END

  if shouldUpdate then
    channelFontString = _G["REPORTED2_CHANNEL_TEXT_" .. index]
    channelFontString:SetText(channelText)
  else
    channelFontString =
      Reported2.UI.CreatePixelText(
      "REPORTED2_CHANNEL_TEXT_" .. index,
      seat,
      channelText,
      nil,
      Reported2.Palette.RGB.BLACK,
      "LEFT",
      Reported2.SeatOffsets.CHANNEL,
      1
    )
  end

  local swearText =
    Reported2.Palette.START .. Reported2.Palette.WHITE .. "'" .. offender.swear .. "'" .. Reported2.Palette.END

  if shouldUpdate then
    swearFontString = _G["REPORTED2_SWEAR_TEXT_" .. index]
    swearFontString:SetText(swearText)
  else
    swearFontString =
      Reported2.UI.CreatePixelText(
      "REPORTED2_SWEAR_TEXT_" .. index,
      seat,
      swearText,
      nil,
      Reported2.Palette.RGB.BLACK,
      "LEFT",
      Reported2.SeatOffsets.SWEAR,
      1
    )
  end

  if shouldUpdate then
    skipButton = _G["REPORTED2_SKIP_BUTTON" .. index]
  else
    skipButton =
      Reported2.UI.CreatePixelButton(
      seat,
      "REPORTED2_SKIP_BUTTON" .. index,
      "x",
      12,
      12,
      Reported2.Palette.RGB.SKIP_TEXT,
      1,
      1,
      Reported2.Palette.RGB.SKIP_BORDER,
      Reported2.Palette.RGB.SKIP_BG,
      "RIGHT",
      -2,
      0
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
      12,
      12,
      Reported2.Palette.RGB.REPORT_TEXT,
      0,
      0,
      Reported2.Palette.RGB.REPORT_BORDER,
      Reported2.Palette.RGB.REPORT_BG,
      "LEFT",
      -14,
      0
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
  CreatePanelTitleBar()
  AddPlaceHolderSeat("PLACEHOLDER", 1, nil)

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
