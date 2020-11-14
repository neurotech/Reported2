local sortedModules = Reported2.Utilities.GetSortedModuleNames(Reported2.Modules)

for index, moduleName in ipairs(sortedModules) do
  table.insert(REPORTED2_DEFAULT_PREFS[REPORTED2_PREFS_ENABLED_MODULES], moduleName)
end

local function ResetSeat(index)
  local playerNameText = _G["REPORTED2_SEAT_" .. index .. "PLAYER_NAME"]
  local channelText = _G["REPORTED2_SEAT_" .. index .. "CHANNEL"]
  local reportButton = _G["REPORTED2_SEAT_" .. index .. "REPORT_BUTTON"]
  local reportButtonTitle = _G["REPORTED2_SEAT_" .. index .. "REPORT_BUTTON_TEXT"]
  local skipButton = _G["REPORTED2_SEAT_" .. index .. "SKIP_BUTTON"]
  local skipButtonTitle = _G["REPORTED2_SEAT_" .. index .. "SKIP_BUTTON_TEXT"]

  Reported2.Panel.SetWidgetText(
    playerNameText,
    Reported2.Palette.START .. Reported2.Palette.GREY .. "Player" .. Reported2.Palette.END
  )
  Reported2.Panel.SetWidgetText(
    channelText,
    Reported2.Palette.START .. Reported2.Palette.GREY .. "Channel" .. Reported2.Palette.END
  )

  Reported2.Panel.DisableButton(reportButton)
  Reported2.Panel.SetWidgetText(
    reportButtonTitle,
    Reported2.Palette.START .. Reported2.Palette.DARK_GREY .. "Report" .. Reported2.Palette.END
  )

  Reported2.Panel.DisableButton(skipButton)
  Reported2.Panel.SetWidgetText(
    skipButtonTitle,
    Reported2.Palette.START .. Reported2.Palette.DARK_GREY .. Reported2.Language.Skip .. Reported2.Palette.END
  )
end

local function ResetAllSeats()
  for index = 1, Reported2.SEAT_COUNT do
    ResetSeat(index)
  end
end

function RenderOffenders()
  ResetAllSeats()

  for index = 1, Reported2.SEAT_COUNT do
    table.sort(
      Reported2.OFFENDERS,
      function(a, b)
        return not a
      end
    )

    local seat = _G["REPORTED2_SEAT_" .. index]
    seat:SetBackdropColor(0, 0, 0, 0.15)
    seat:SetBackdropBorderColor(0, 0, 0, 0.15)

    local record = Reported2.OFFENDERS[index]

    if record then
      local channel

      seat:SetBackdropColor(
        Reported2.Events.DarkColours.RGB[record.event].r,
        Reported2.Events.DarkColours.RGB[record.event].g,
        Reported2.Events.DarkColours.RGB[record.event].b,
        0.24
      )
      seat:SetBackdropBorderColor(
        Reported2.Events.DarkColours.RGB[record.event].r,
        Reported2.Events.DarkColours.RGB[record.event].g,
        Reported2.Events.DarkColours.RGB[record.event].b,
        0.75
      )

      local playerNameText = _G["REPORTED2_SEAT_" .. index .. "PLAYER_NAME"]
      Reported2.Panel.SetWidgetText(
        playerNameText,
        Reported2.Palette.START_NO_ALPHA .. record.classColour.colorStr .. record.playerName .. Reported2.Palette.END
      )

      if record.channelName == "" then
        channel = Reported2.Events.Readable[record.event]
      else
        channel = record.channelName:gsub(" .*", "")
      end

      local channelColour = Reported2.Events.Colours[record.event]
      local channelText = _G["REPORTED2_SEAT_" .. index .. "CHANNEL"]
      Reported2.Panel.SetWidgetText(
        channelText,
        Reported2.Palette.START .. channelColour .. channel .. Reported2.Palette.END
      )

      local reportButton = _G["REPORTED2_SEAT_" .. index .. "REPORT_BUTTON"]
      reportButton:SetScript(
        "OnClick",
        function()
          local channelNumber
          local reportedMessage, randomModule = Reported2.Utilities.GetRandomReportedMessage(record.playerName)

          print(
            Reported2.Utilities.CreateReportNotification(record.playerName, randomModule, record.classColour.colorStr)
          )

          if Reported2.Events.Readable[record.event] == "Whisper" then
            channelNumber = record.playerNameWithRealm
          else
            channelNumber = record.channelNumber
          end

          SendChatMessage(reportedMessage, Reported2.Events.Readable[record.event], nil, channelNumber)
          table.remove(Reported2.OFFENDERS, index)
          Reported2.Sounds.PlayReportMadeSound()

          RenderOffenders()
        end
      )

      reportButton:SetScript(
        "OnEnter",
        function(button)
          button:SetBackdropColor(
            Reported2.Events.DarkColours.RGB[record.event].r,
            Reported2.Events.DarkColours.RGB[record.event].g,
            Reported2.Events.DarkColours.RGB[record.event].b,
            0.33
          )
          button:SetBackdropBorderColor(
            Reported2.Events.Colours.RGB[record.event].r,
            Reported2.Events.Colours.RGB[record.event].g,
            Reported2.Events.Colours.RGB[record.event].b,
            0.5
          )
        end
      )

      reportButton:SetScript(
        "OnLeave",
        function(button)
          button:SetBackdropColor(
            Reported2.Palette.RGB.GREY.r,
            Reported2.Palette.RGB.GREY.g,
            Reported2.Palette.RGB.GREY.b,
            1
          )
          button:SetBackdropBorderColor(0, 0, 0, 1)
        end
      )

      local reportButtonTitle = _G["REPORTED2_SEAT_" .. index .. "REPORT_BUTTON_TEXT"]

      Reported2.Panel.SetWidgetText(
        reportButtonTitle,
        Reported2.Palette.START .. Reported2.Events.Colours[record.event] .. "Report" .. Reported2.Palette.END
      )
      Reported2.Panel.EnableButton(reportButton)

      local skipButton = _G["REPORTED2_SEAT_" .. index .. "SKIP_BUTTON"]
      skipButton:SetScript(
        "OnClick",
        function()
          table.remove(Reported2.OFFENDERS, index)
          Reported2.Sounds.PlaySkipSound()
          RenderOffenders()
        end
      )

      skipButton:SetScript(
        "OnEnter",
        function(button)
          button:SetBackdropBorderColor(
            Reported2.Events.Colours.RGB[record.event].r,
            Reported2.Events.Colours.RGB[record.event].g,
            Reported2.Events.Colours.RGB[record.event].b,
            0.33
          )
        end
      )

      skipButton:SetScript(
        "OnLeave",
        function(button)
          skipButton:SetBackdropBorderColor(
            Reported2.Palette.RGB.DARK_GREY.r,
            Reported2.Palette.RGB.DARK_GREY.g,
            Reported2.Palette.RGB.DARK_GREY.b,
            1
          )
        end
      )

      local skipButtonTitle = _G["REPORTED2_SEAT_" .. index .. "SKIP_BUTTON_TEXT"]
      Reported2.Panel.SetWidgetText(
        skipButtonTitle,
        Reported2.Palette.START .. Reported2.Palette.GREY .. Reported2.Language.Skip .. Reported2.Palette.END
      )
      Reported2.Panel.EnableButton(skipButton)
    end
  end

  if REPORTED2_PREFS[REPORTED2_PREFS_HIDE_WHEN_EMPTY] then
    if #Reported2.OFFENDERS == 0 then
      Reported2.Panel.HidePanel()
    end
  end
end

local function InitialiseReported2()
  local chatListener = CreateFrame("Frame")

  for _, event in ipairs(Reported2.Events.Raw) do
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

        local isSelf = playerName == currentPlayer

        -- DEBUG:
        -- isSelf = false

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

        for _, swearString in ipairs(Reported2.Dictionary) do
          detectedWord = paddedMessage:match(swearString)
          lastWord = swearString

          if detectedWord then
            detectedWord = detectedWord:gsub("^%s+", ""):gsub("%s+$", "")
            hasSwear = true
            break
          end
        end

        if hasSwear and not isSelf then
          local delay = Reported2.rand(Reported2.DELAY_MIN, Reported2.DELAY_MAX)

          C_Timer.After(
            delay,
            function()
              if #Reported2.OFFENDERS >= Reported2.SEAT_COUNT then
                local bracketPrefix = Reported2.Palette.START .. Reported2.Palette.WHITE
                local leftBracket = bracketPrefix .. "["
                local reportedPrefix = Reported2.Palette.START .. Reported2.Palette.TEAL .. "Reported! 2"
                local rightBracket = bracketPrefix .. "]"
                print(leftBracket .. reportedPrefix .. rightBracket .. " The waiting room is full!")
              else
                Reported2.Sounds.PlaySwearDetectedSound()
                Reported2.Panel.FlashHeaderTextRight()

                Reported2.Panel.AddOffender(
                  playerName,
                  sender,
                  classColour,
                  detectedWord,
                  message,
                  channelName,
                  channelIndex,
                  event
                )

                RenderOffenders()

                if REPORTED2_PREFS[REPORTED2_PREFS_SHOW_ON_DETECTION] then
                  if InCombatLockdown() then
                    if not REPORTED2_PREFS[REPORTED2_PREFS_HIDE_IN_COMBAT] then
                      Reported2.Panel.ShowPanel()
                    end
                  else
                    Reported2.Panel.ShowPanel()
                  end
                else
                  if InCombatLockdown() then
                    if not REPORTED2_PREFS[REPORTED2_PREFS_HIDE_IN_COMBAT] then
                      Reported2.Panel.ShowPanel()
                    end
                  end
                end
              end
            end
          )
        end
      end
    end
  )
end

local function SetPanelVisibility(visible)
  if visible then
    Reported2.Panel.ShowPanel()
  else
    Reported2.Panel.HidePanel()
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
        -- Seed preferences with defaults
        REPORTED2_PREFS = {}
        for key, value in pairs(REPORTED2_DEFAULT_PREFS) do
          REPORTED2_PREFS[key] = value
        end
      else
        -- Update prefs with any missing keys
        for key, value in pairs(REPORTED2_DEFAULT_PREFS) do
          if REPORTED2_PREFS[key] == nil then
            REPORTED2_PREFS[key] = value
          end
        end
      end

      InitialiseReported2()
      Reported2.Panel.CreatePanel()
      Reported2.Config.CreatePanel()
      RenderOffenders()
      SetPanelVisibility(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL])

      addonLoaded:UnregisterEvent("ADDON_LOADED")
    elseif event == "PLAYER_LOGOUT" then
    -- --
    end
  end
)

local combatListener = CreateFrame("Frame")
combatListener:RegisterEvent("PLAYER_REGEN_DISABLED")
combatListener:RegisterEvent("PLAYER_REGEN_ENABLED")
combatListener:SetScript(
  "OnEvent",
  function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
      if REPORTED2_PREFS[REPORTED2_PREFS_HIDE_IN_COMBAT] then
        Reported2.Panel.HidePanel()
      end
    end

    if event == "PLAYER_REGEN_ENABLED" then
      if REPORTED2_PREFS[REPORTED2_PREFS_HIDE_IN_COMBAT] and REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] then
        Reported2.Panel.ShowPanel()
      end
    end
  end
)

function SlashCommandHandler(msg, editbox)
  if msg == "show" then
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = true
    SetPanelVisibility(true)
  elseif msg == "hide" then
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = false
    SetPanelVisibility(false)
  else
    Reported2.Config.OpenConfigMenu()
  end
end

SlashCmdList["REPORTEDTWO"] = SlashCommandHandler

Reported2.RenderOffenders = RenderOffenders
