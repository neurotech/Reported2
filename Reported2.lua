local sortedModules = Reported2.Utilities.GetSortedModuleNames(Reported2.Modules)

for index, moduleName in ipairs(sortedModules) do
  table.insert(REPORTED2_DEFAULT_PREFS[REPORTED2_PREFS_ENABLED_MODULES], moduleName)
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
        isSelf = false

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
              Reported2.Sounds.PlaySwearDetectedSound()

              if #Reported2.OFFENDERS >= Reported2.SEAT_COUNT then
                -- Remove seat one
                local seatToHide = _G["REPORTED2_SEAT_" .. 1]
                seatToHide:Hide()
                table.remove(Reported2.OFFENDERS, 1)
              end

              Reported2.Panel.AddOffender(
                playerName,
                sender,
                classColour,
                detectedWord,
                message,
                channelName,
                channelIndex,
                event,
                #Reported2.OFFENDERS + 1
              )

              Reported2.Panel.RenderOffenders()

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
      Reported2.Panel.RenderOffenders()
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
