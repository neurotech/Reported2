function ResetSeat(index)
  local playerNameText = _G["SEAT_" .. index .. "PLAYER_NAME"]
  local channelText = _G["SEAT_" .. index .. "CHANNEL"]
  local reportButton = _G["SEAT_" .. index .. "REPORT_BUTTON"]
  local reportButtonTitle = _G["SEAT_" .. index .. "REPORT_BUTTON_TEXT"]
  local skipButton = _G["SEAT_" .. index .. "SKIP_BUTTON"]
  local skipButtonTitle = _G["SEAT_" .. index .. "SKIP_BUTTON_TEXT"]

  Panel.SetWidgetText(playerNameText, Palette.START .. Palette.GREY .. "Player" .. Palette.END)
  Panel.SetWidgetText(channelText, Palette.START .. Palette.GREY .. "Channel" .. Palette.END)

  Panel.DisableButton(reportButton)
  Panel.SetWidgetText(reportButtonTitle, Palette.START .. Palette.DARK_GREY .. "Report" .. Palette.END)

  Panel.DisableButton(skipButton)
  Panel.SetWidgetText(skipButtonTitle, Palette.START .. Palette.DARK_GREY .. Language.Skip .. Palette.END)
end

function ResetAllSeats()
  for index = 1, SEAT_COUNT do
    ResetSeat(index)
  end
end

function RenderOffenders()
  if REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] then
    ResetAllSeats()

    for index = 1, SEAT_COUNT do
      table.sort(
        OFFENDERS,
        function(a, b)
          return not a
        end
      )

      local seat = _G["SEAT_" .. index]
      seat:SetBackdropColor(0, 0, 0, 0.15)
      seat:SetBackdropBorderColor(0, 0, 0, 0.15)

      local record = OFFENDERS[index]

      if record then
        local channel

        seat:SetBackdropColor(
          Events.DarkColours.RGB[record.event].r,
          Events.DarkColours.RGB[record.event].g,
          Events.DarkColours.RGB[record.event].b,
          0.24
        )
        seat:SetBackdropBorderColor(
          Events.DarkColours.RGB[record.event].r,
          Events.DarkColours.RGB[record.event].g,
          Events.DarkColours.RGB[record.event].b,
          0.75
        )

        local playerNameText = _G["SEAT_" .. index .. "PLAYER_NAME"]
        Panel.SetWidgetText(
          playerNameText,
          Palette.START_NO_ALPHA .. record.classColour.colorStr .. record.playerName .. Palette.END
        )

        if record.channelName == "" then
          channel = Events.Readable[record.event]
        else
          channel = record.channelName:gsub(" .*", "")
        end

        local channelColour = Events.Colours[record.event]
        local channelText = _G["SEAT_" .. index .. "CHANNEL"]
        Panel.SetWidgetText(channelText, Palette.START .. channelColour .. channel .. Palette.END)

        local reportButton = _G["SEAT_" .. index .. "REPORT_BUTTON"]
        reportButton:SetScript(
          "OnClick",
          function()
            local channelNumber
            local reportedMessage, randomModule = Utilities.GetRandomReportedMessage(record.playerName)

            print(Utilities.CreateReportNotification(record.playerName, randomModule, record.classColour.colorStr))

            if Events.Readable[record.event] == "Whisper" then
              channelNumber = record.playerNameWithRealm
            else
              channelNumber = record.channelNumber
            end

            SendChatMessage(reportedMessage, Events.Readable[record.event], nil, channelNumber)
            table.remove(OFFENDERS, index)
            Sounds.PlayReportMadeSound()

            RenderOffenders()
          end
        )

        reportButton:SetScript(
          "OnEnter",
          function(button)
            button:SetBackdropColor(
              Events.DarkColours.RGB[record.event].r,
              Events.DarkColours.RGB[record.event].g,
              Events.DarkColours.RGB[record.event].b,
              0.33
            )
            button:SetBackdropBorderColor(
              Events.Colours.RGB[record.event].r,
              Events.Colours.RGB[record.event].g,
              Events.Colours.RGB[record.event].b,
              0.5
            )
          end
        )

        reportButton:SetScript(
          "OnLeave",
          function(button)
            button:SetBackdropColor(Palette.RGB.GREY.r, Palette.RGB.GREY.g, Palette.RGB.GREY.b, 1)
            button:SetBackdropBorderColor(0, 0, 0, 1)
          end
        )

        local reportButtonTitle = _G["SEAT_" .. index .. "REPORT_BUTTON_TEXT"]
        local delay = rand(DELAY_MIN, DELAY_MAX)

        if record.locked then
          Panel.SetWidgetText(reportButtonTitle, Palette.START .. Palette.DARK_GREY .. "Wait" .. Palette.END)

          C_Timer.After(
            delay,
            function()
              record.locked = false
              Panel.EnableButton(reportButton)
              Panel.SetWidgetText(
                reportButtonTitle,
                Palette.START .. Events.Colours[record.event] .. "Report" .. Palette.END
              )
            end
          )
        else
          Panel.SetWidgetText(
            reportButtonTitle,
            Palette.START .. Events.Colours[record.event] .. "Report" .. Palette.END
          )
          Panel.EnableButton(reportButton)
        end

        local skipButton = _G["SEAT_" .. index .. "SKIP_BUTTON"]
        skipButton:SetScript(
          "OnClick",
          function()
            table.remove(OFFENDERS, index)
            Sounds.PlaySkipSound()
            RenderOffenders()
          end
        )

        skipButton:SetScript(
          "OnEnter",
          function(button)
            button:SetBackdropBorderColor(
              Events.Colours.RGB[record.event].r,
              Events.Colours.RGB[record.event].g,
              Events.Colours.RGB[record.event].b,
              0.33
            )
          end
        )

        skipButton:SetScript(
          "OnLeave",
          function(button)
            skipButton:SetBackdropBorderColor(
              Palette.RGB.DARK_GREY.r,
              Palette.RGB.DARK_GREY.g,
              Palette.RGB.DARK_GREY.b,
              1
            )
          end
        )

        local skipButtonTitle = _G["SEAT_" .. index .. "SKIP_BUTTON_TEXT"]

        if record.locked then
          Panel.SetWidgetText(skipButtonTitle, Palette.START .. Palette.DARK_GREY .. "-" .. Palette.END)

          C_Timer.After(
            delay,
            function()
              record.locked = false
              skipButton:Enable()
              Panel.SetWidgetText(skipButtonTitle, Palette.START .. Palette.GREY .. Language.Skip .. Palette.END)
            end
          )
        else
          Panel.SetWidgetText(skipButtonTitle, Palette.START .. Palette.GREY .. Language.Skip .. Palette.END)
          Panel.EnableButton(skipButton)
        end
      end
    end
  end

  SetPanelVisibility(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL])
end

function Initialise()
  local chatListener = CreateFrame("Frame")

  for _, event in ipairs(Events.Raw) do
    if REPORTED2_PREFS[event] then
      chatListener:RegisterEvent(event)
    end
  end

  chatListener:SetScript(
    "OnEvent",
    function(self, event, ...)
      if REPORTED2_PREFS[event] then
        local currentPlayer = UnitName("player")
        local channelName = select(9, ...)
        local message = select(1, ...)
        local sender = select(2, ...)
        local playerName = sender:gsub("%-.+", "")
        local channelIndex = select(8, ...)
        local guid = select(12, ...)

        -- local isSelf = playerName == currentPlayer
        local isSelf = false

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

        for _, swearString in ipairs(Dictionary) do
          detectedWord = paddedMessage:match(swearString)
          lastWord = swearString

          if detectedWord then
            detectedWord = detectedWord:gsub("^%s+", ""):gsub("%s+$", "")
            hasSwear = true
            break
          end
        end

        if hasSwear and not isSelf then
          Sounds.PlaySwearDetectedSound()
          Panel.FlashHeaderTextRight()

          if #OFFENDERS >= SEAT_COUNT then
            print("Waiting room is full!")
          else
            local locked = true
            AddOffender(
              playerName,
              sender,
              classColour,
              detectedWord,
              message,
              channelName,
              channelIndex,
              event,
              locked
            )
            RenderOffenders()
          end
        end
      end
    end
  )
end

function SetPanelVisibility(visible)
  if visible then
    Panel.ShowPanel()
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = true
  else
    Panel.HidePanel()
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = false
  end
end

local addonLoaded = CreateFrame("Frame")
addonLoaded:RegisterEvent("ADDON_LOADED")
addonLoaded:RegisterEvent("PLAYER_LOGOUT")
addonLoaded:SetScript(
  "OnEvent",
  function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "Reported2" then
      if REPORTED2_PREFS == nil then
        REPORTED2_PREFS = {}
        for key, value in pairs(REPORTED2_DEFAULT_PREFS) do
          REPORTED2_PREFS[key] = value
        end
      else
        -- ?
      end

      Initialise()
      Panel.CreatePanel()
      RenderOffenders()
      SetPanelVisibility(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL])

      addonLoaded:UnregisterEvent("ADDON_LOADED")
    elseif event == "PLAYER_LOGOUT" then
    -- ?
    end
  end
)

Config.CreatePanel()

function SlashCommandHandler(msg, editbox)
  if msg == "show" then
    SetPanelVisibility(true)
  elseif msg == "hide" then
    SetPanelVisibility(false)
  else
    Config.OpenConfigMenu()
  end
end

SlashCmdList["REPORTEDTWO"] = SlashCommandHandler
