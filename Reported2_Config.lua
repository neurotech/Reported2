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
  muteSoundsLabel,
  modulesFrame

function UpdateConfigFrameValues()
  showWaitingRoomCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL])
  muteSoundsCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS])
  globalChannelsCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_CHANNEL])
  guildChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_GUILD])
  instanceChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_INSTANCE_CHAT])
  instanceLeaderChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_INSTANCE_CHAT_LEADER])
  officerChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_OFFICER])
  partyLeaderChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_PARTY])
  partyChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_PARTY_LEADER])
  raidLeaderChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_RAID])
  raidChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_RAID_LEADER])
  sayChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_SAY])
  whisperChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_WHISPER])
  yellChannelCheckbox:SetChecked(REPORTED2_PREFS[CHAT_MSG_YELL])
end

function CreateModulesPanel()
  modulesFrame = UI.Config.CreateModulesFrame(configFrame)
  UI.Config.CreateTitleLabel(modulesFrame)
  UI.Config.CreateVersionLabel(modulesFrame, titleLabel)
  UI.Config.CreateContributorsLabel(modulesFrame)
  local separator = UI.Config.CreateSeparator(modulesFrame)
  local modulesLabel = UI.Config.CreateOptionsLabel("Modules", modulesFrame, separator)

  local scrollFrame =
    CreateFrame("ScrollFrame", "InGameTest", modulesFrame, BackdropTemplateMixin and "BackdropTemplate")
  scrollFrame:SetPoint("TOPLEFT", modulesLabel, 0, -modulesLabel:GetHeight() * 1.5)
  scrollFrame:SetSize(
    InterfaceOptionsFramePanelContainer:GetWidth() - UI.Sizes.Padding * 2,
    InterfaceOptionsFramePanelContainer:GetHeight() - UI.Sizes.Padding * 12
  )
  scrollFrame:SetBackdrop(
    {
      bgFile = FLAT_BG_TEXTURE,
      edgeFile = EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  scrollFrame:SetBackdropColor(0, 0, 0, 0.3)
  scrollFrame:SetBackdropBorderColor(0, 0, 0, 1)

  scrollFrame:EnableMouseWheel(true)
  scrollFrame:SetScript(
    "OnMouseWheel",
    function(self, delta)
      local newValue = self:GetVerticalScroll() - (delta * 20)

      if (newValue < 0) then
        newValue = 0
      elseif (newValue > self:GetVerticalScrollRange()) then
        newValue = self:GetVerticalScrollRange()
      end

      self:SetVerticalScroll(newValue)
    end
  )

  local scrollChild = CreateFrame("Frame", nil, scrollFrame)
  scrollChild:SetPoint("TOPLEFT")
  scrollChild:SetSize(scrollFrame:GetWidth(), 480)

  scrollFrame:SetScrollChild(scrollChild)

  local offset = UI.Sizes.Padding
  local sortedModules = Utilities.GetSortedModuleNames(Modules)

  for i, moduleName in ipairs(sortedModules) do
    local moduleContent = Modules[moduleName]
    local moduleNameText = moduleName
    local moduleCreditText = moduleContent["Credit"]
    local moduleDescriptionText = moduleContent["Description"]
    local isLastModule = i == #sortedModules

    local moduleCheckboxAndLabelFrame, moduleCheckbox, moduleLabel =
      UI.Config.CreateModuleCheckboxAndLabel(
      moduleNameText,
      moduleCreditText,
      moduleDescriptionText,
      scrollChild,
      offset,
      isLastModule
    )

    offset = offset + moduleCheckboxAndLabelFrame:GetHeight() + UI.Sizes.Padding * 1.5
  end
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

  CreateModulesPanel()

  -- Config Frame - Form actions
  configFrame:SetScript("OnShow", UpdateConfigFrameValues)

  function configFrame.okay()
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = showWaitingRoomCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS] = muteSoundsCheckbox:GetChecked()

    REPORTED2_PREFS[CHAT_MSG_CHANNEL] = globalChannelsCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_GUILD] = guildChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_INSTANCE_CHAT] = instanceChannelCheckbox:GetChecked()
    REPORTED2_PREFS[CHAT_MSG_INSTANCE_CHAT_LEADER] = instanceLeaderChannelCheckbox:GetChecked()
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
