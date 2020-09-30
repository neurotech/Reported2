Config = {}

local configFrame,
  titleLabel,
  versionLabel,
  contributorsLabel,
  separator,
  generalOptionsLabel,
  showWaitingRoomCheckbox,
  showWaitingRoomLabel,
  muteSoundsCheckbox,
  muteSoundsLabel

function UpdateConfigFrameValues()
  showWaitingRoomCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL])
  muteSoundsCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS])

  globalChannelsCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_CHANNEL])
  guildChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_GUILD])
  officerChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_OFFICER])
  partyLeaderChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_PARTY])
  partyChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_PARTY_LEADER])
  raidLeaderChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_RAID])
  raidChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_RAID_LEADER])
  sayChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_SAY])
  whisperChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_WHISPER])
  yellChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_YELL])
end

function CreatePanel()
  configFrame = UI.Config.CreateConfigFrame()
  titleLabel = UI.Config.CreateTitleLabel(configFrame)
  versionLabel = UI.Config.CreateVersionLabel(configFrame, titleLabel)
  contributorsLabel = UI.Config.CreateContributorsLabel(configFrame)
  separator = UI.Config.CreateSeparator(configFrame)

  -- General Options
  generalOptionsLabel = UI.Config.CreateOptionsLabel("General Options", configFrame, separator)

  local showWaitingRoomText = "Show Waiting Room"
  local showWaitingRoomShortcutText = Palette.START .. Palette.GREY .. " — Shortcut: /r2 show & /r2 hide" .. Palette.END

  showWaitingRoomCheckbox, showWaitingRoomLabel =
    UI.Config.CreateCheckbox(showWaitingRoomText .. showWaitingRoomShortcutText, configFrame, generalOptionsLabel)

  muteSoundsCheckbox, muteSoundsLabel = UI.Config.CreateCheckbox("Mute sounds", configFrame, showWaitingRoomCheckbox)

  -- Channel Options
  channelOptionsLabel =
    UI.Config.CreateOptionsLabel("Channel Options", configFrame, muteSoundsCheckbox, UI.Sizes.Padding * 2)
  channelOptionsSubLabel =
    UI.Config.CreateOptionsSubLabel("Select which channels to monitor:", configFrame, channelOptionsLabel)

  -- Channels
  UI.Config.CreateChannelCheckboxes(configFrame)

  -- Config Frame - Form actions
  configFrame:SetScript("OnShow", UpdateConfigFrameValues)

  function configFrame.okay()
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = showWaitingRoomCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS] = muteSoundsCheckbox:GetChecked()

    REPORTED2_PREFS[CHAT_MSG_CHANNEL] = globalChannelsCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_GUILD] = guildChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_OFFICER] = officerChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_PARTY] = partyLeaderChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_PARTY_LEADER] = partyChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_RAID] = raidLeaderChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_RAID_LEADER] = raidChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_SAY] = sayChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_WHISPER] = whisperChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_YELL] = yellChannelCheckbox:GetChecked()

    RenderOffenders()
  end
end

function OpenConfigMenu()
  -- https://wowwiki.fandom.com/wiki/Using_the_Interface_Options_Addons_panel
  -- ------------------------------------------------------------------------
  -- Note: Call this function twice (in a row), there is a bug in Blizzard's code which makes the first call
  -- (after login or /reload) fail. It opens interface options but not on the addon's interface options;
  -- instead it opens the default interface options.
  -- If you call it twice in a row, it works as intended.

  InterfaceOptionsFrame_OpenToCategory(configFrame.name)
  InterfaceOptionsFrame_OpenToCategory(configFrame.name)
end

Config.CreatePanel = CreatePanel
Config.OpenConfigMenu = OpenConfigMenu
