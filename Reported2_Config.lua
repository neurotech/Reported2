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

local function UpdateConfigFrameValues()
  showWaitingRoomCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL])
  hideInCombatCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_HIDE_IN_COMBAT])
  showOnDetectionCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_ON_DETECTION])
  muteSoundsCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS])
  globalChannelsCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_CHANNEL])
  guildChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_GUILD])
  instanceChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_INSTANCE_CHAT])
  instanceLeaderChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER])
  officerChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_OFFICER])
  partyLeaderChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_PARTY])
  partyChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_PARTY_LEADER])
  raidLeaderChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_RAID])
  raidChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_RAID_LEADER])
  sayChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_SAY])
  whisperChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_WHISPER])
  yellChannelCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_CHAT_MSG_YELL])

  for index, moduleName in ipairs(REPORTED2_PREFS[REPORTED2_PREFS_ENABLED_MODULES]) do
    local checkbox = _G["REPORTED2_MODULE_CHECKBOX_" .. string.upper(moduleName)]
    checkbox:SetChecked(true)
  end

  for index, moduleName in ipairs(REPORTED2_PREFS[REPORTED2_PREFS_DISABLED_MODULES]) do
    local checkbox = _G["REPORTED2_MODULE_CHECKBOX_" .. string.upper(moduleName)]
    checkbox:SetChecked(false)
  end
end

local function CreateModulesPanel()
  modulesFrame = Reported2.UI.Config.CreateModulesFrame(configFrame)
  Reported2.UI.Config.CreateTitleLabel(modulesFrame)
  Reported2.UI.Config.CreateVersionLabel(modulesFrame, titleLabel)
  Reported2.UI.Config.CreateContributorsLabel(modulesFrame)
  local separator = Reported2.UI.Config.CreateSeparator(modulesFrame)
  local modulesLabel = Reported2.UI.Config.CreateOptionsLabel("Modules", modulesFrame, separator)

  local scrollFrame =
    CreateFrame(
    "ScrollFrame",
    "REPORTED2_MODULES_SCROLL_FRAME",
    modulesFrame,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  scrollFrame:SetPoint("TOPLEFT", modulesLabel, 0, -modulesLabel:GetHeight() * 1.5)
  scrollFrame:SetSize(
    InterfaceOptionsFramePanelContainer:GetWidth() - Reported2.UI.Sizes.Padding * 2,
    InterfaceOptionsFramePanelContainer:GetHeight() - Reported2.UI.Sizes.Padding * 12
  )
  scrollFrame:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
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
      modulesFrame.scrollbar:SetValue(newValue)
    end
  )

  local scrollChild = CreateFrame("Frame", nil, scrollFrame)
  scrollChild:SetPoint("TOPLEFT")
  scrollChild:SetSize(scrollFrame:GetWidth(), 480)

  scrollFrame:SetScrollChild(scrollChild)

  local scrollBar = CreateFrame("Slider", nil, scrollFrame)
  scrollBar:SetFrameLevel(4)
  scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -(Reported2.UI.Sizes.Padding * 1.5), 0)
  scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", Reported2.UI.Sizes.Padding * 0.5, 0)
  scrollBar:SetMinMaxValues(1, InterfaceOptionsFramePanelContainer:GetHeight())
  scrollBar:SetValueStep(1)
  scrollBar.scrollStep = 1
  scrollBar:SetValue(0)
  scrollBar:SetWidth(Reported2.UI.Sizes.Padding * 1.5)
  scrollBar:SetScript(
    "OnValueChanged",
    function(self, value)
      self:GetParent():SetVerticalScroll(value)
    end
  )
  local scrollbg =
    CreateFrame("Frame", "MODULES_FRAME_SCROLLBAR_BG", scrollBar, BackdropTemplateMixin and "BackdropTemplate")
  scrollbg:SetFrameLevel(3)
  scrollbg:SetAllPoints(scrollBar)
  scrollbg:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  scrollbg:SetBackdropBorderColor(
    Reported2.Palette.RGB.BLACK.r,
    Reported2.Palette.RGB.BLACK.g,
    Reported2.Palette.RGB.BLACK.b,
    1
  )
  scrollbg:SetBackdropColor(0, 0, 0, 0.45)

  scrollBar:SetThumbTexture(Reported2.BUTTON_BG_TEXTURE)
  local thumbTexture = scrollBar:GetThumbTexture()
  thumbTexture:SetVertexColor(
    Reported2.Palette.RGB.TEAL.r,
    Reported2.Palette.RGB.TEAL.g,
    Reported2.Palette.RGB.TEAL.b,
    1
  )
  thumbTexture:SetWidth(scrollBar:GetWidth() - 2)
  thumbTexture:SetHeight(Reported2.UI.Sizes.Padding * 2)

  modulesFrame.scrollbar = scrollBar

  local offset = Reported2.UI.Sizes.Padding
  local sortedModules = Reported2.Utilities.GetSortedModuleNames(Reported2.Modules)

  for index, moduleName in ipairs(sortedModules) do
    local moduleContent = Reported2.Modules[moduleName]
    local moduleNameText = moduleName
    local moduleCreditText = moduleContent["Credit"]
    local moduleDescriptionText = moduleContent["Description"]
    local isLastModule = index == #sortedModules

    local moduleCheckboxAndLabelFrame, moduleCheckbox, moduleLabel =
      Reported2.UI.Config.CreateModuleCheckboxAndLabel(
      moduleNameText,
      moduleCreditText,
      moduleDescriptionText,
      scrollChild,
      offset,
      isLastModule
    )

    offset = offset + moduleCheckboxAndLabelFrame:GetHeight() + Reported2.UI.Sizes.Padding * 1.5
  end

  local enableAllButton = CreateFrame("BUTTON", nil, scrollFrame)
  enableAllButton:SetBackdrop(
    {
      bgFile = Reported2.BUTTON_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )

  enableAllButton:SetSize(80, 30)
  enableAllButton:SetPoint(
    "BOTTOMRIGHT",
    -(enableAllButton:GetWidth() + Reported2.UI.Sizes.Padding),
    -(enableAllButton:GetHeight() + Reported2.UI.Sizes.Padding)
  )
  enableAllButton:SetBackdropColor(
    Reported2.Palette.RGB.GREY.r,
    Reported2.Palette.RGB.GREY.g,
    Reported2.Palette.RGB.GREY.b,
    1
  )
  enableAllButton:SetBackdropBorderColor(
    Reported2.Palette.RGB.DARK_GREY.r,
    Reported2.Palette.RGB.DARK_GREY.g,
    Reported2.Palette.RGB.DARK_GREY.b,
    1
  )

  local enableAllButtonText = enableAllButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  enableAllButtonText:SetPoint("CENTER", enableAllButton, "CENTER")
  enableAllButtonText:SetText(
    Reported2.Palette.START .. Reported2.Palette.TEAL .. "Enable all" .. Reported2.Palette.END
  )

  local disableAllButton = CreateFrame("BUTTON", nil, scrollFrame)
  disableAllButton:SetBackdrop(
    {
      bgFile = Reported2.BUTTON_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )

  disableAllButton:SetSize(80, 30)
  disableAllButton:SetPoint("BOTTOMRIGHT", 0, -(disableAllButton:GetHeight() + Reported2.UI.Sizes.Padding))
  disableAllButton:SetBackdropColor(
    Reported2.Palette.RGB.GREY.r,
    Reported2.Palette.RGB.GREY.g,
    Reported2.Palette.RGB.GREY.b,
    1
  )
  disableAllButton:SetBackdropBorderColor(
    Reported2.Palette.RGB.DARK_GREY.r,
    Reported2.Palette.RGB.DARK_GREY.g,
    Reported2.Palette.RGB.DARK_GREY.b,
    1
  )

  local disableAllButtonText = disableAllButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  disableAllButtonText:SetPoint("CENTER", disableAllButton, "CENTER")
  disableAllButtonText:SetText(
    Reported2.Palette.START .. Reported2.Palette.RED .. "Disable all" .. Reported2.Palette.END
  )

  enableAllButton:SetScript(
    "OnClick",
    function()
      local sortedModules = Reported2.Utilities.GetSortedModuleNames(Reported2.Modules)
      for index, moduleName in ipairs(sortedModules) do
        local checkbox = _G["REPORTED2_MODULE_CHECKBOX_" .. string.upper(moduleName)]
        checkbox:SetChecked(true)
      end
    end
  )
  enableAllButton:SetScript(
    "OnEnter",
    function()
      enableAllButtonText:SetText(
        Reported2.Palette.START .. Reported2.Palette.WHITE .. "Enable all" .. Reported2.Palette.END
      )
      enableAllButton:SetBackdropBorderColor(
        Reported2.Palette.RGB.TEAL.r,
        Reported2.Palette.RGB.TEAL.g,
        Reported2.Palette.RGB.TEAL.b,
        1
      )
    end
  )
  enableAllButton:SetScript(
    "OnLeave",
    function()
      enableAllButtonText:SetText(
        Reported2.Palette.START .. Reported2.Palette.TEAL .. "Enable all" .. Reported2.Palette.END
      )
      enableAllButton:SetBackdropBorderColor(
        Reported2.Palette.RGB.DARK_GREY.r,
        Reported2.Palette.RGB.DARK_GREY.g,
        Reported2.Palette.RGB.DARK_GREY.b,
        1
      )
    end
  )

  disableAllButton:SetScript(
    "OnClick",
    function()
      local sortedModules = Reported2.Utilities.GetSortedModuleNames(Reported2.Modules)
      for index, moduleName in ipairs(sortedModules) do
        local checkbox = _G["REPORTED2_MODULE_CHECKBOX_" .. string.upper(moduleName)]
        checkbox:SetChecked(false)
      end
    end
  )
  disableAllButton:SetScript(
    "OnEnter",
    function()
      disableAllButtonText:SetText(
        Reported2.Palette.START .. Reported2.Palette.WHITE .. "Disable all" .. Reported2.Palette.END
      )
      disableAllButton:SetBackdropBorderColor(
        Reported2.Palette.RGB.RED.r,
        Reported2.Palette.RGB.RED.g,
        Reported2.Palette.RGB.RED.b,
        1
      )
    end
  )
  disableAllButton:SetScript(
    "OnLeave",
    function()
      disableAllButtonText:SetText(
        Reported2.Palette.START .. Reported2.Palette.RED .. "Disable all" .. Reported2.Palette.END
      )
      disableAllButton:SetBackdropBorderColor(
        Reported2.Palette.RGB.DARK_GREY.r,
        Reported2.Palette.RGB.DARK_GREY.g,
        Reported2.Palette.RGB.DARK_GREY.b,
        1
      )
    end
  )
end

function Reported2.Config.CreatePanel()
  configFrame = Reported2.UI.Config.CreateConfigFrame()
  titleLabel = Reported2.UI.Config.CreateTitleLabel(configFrame)
  versionLabel = Reported2.UI.Config.CreateVersionLabel(configFrame, titleLabel)
  contributorsLabel = Reported2.UI.Config.CreateContributorsLabel(configFrame)
  separator = Reported2.UI.Config.CreateSeparator(configFrame)

  -- General Options
  generalOptionsLabel = Reported2.UI.Config.CreateOptionsLabel("General Options", configFrame, separator)

  local showWaitingRoomText = "Show Waiting Room"
  local hideInCombatText = "Hide in combat"
  local showOnDetectionText = "Show on detection"
  local showWaitingRoomShortcutText =
    Reported2.Palette.START .. Reported2.Palette.GREY .. " — Shortcut: /r2 show & /r2 hide" .. Reported2.Palette.END

  showWaitingRoomCheckbox, showWaitingRoomLabel =
    Reported2.UI.Config.CreateCheckbox(
    showWaitingRoomText .. showWaitingRoomShortcutText,
    configFrame,
    generalOptionsLabel
  )

  hideInCombatCheckbox, hideInCombatLabel =
    Reported2.UI.Config.CreateCheckbox(hideInCombatText, configFrame, showWaitingRoomCheckbox)

  showOnDetectionCheckbox, showOnDetectionCheckboxLabel =
    Reported2.UI.Config.CreateCheckbox(showOnDetectionText, configFrame, hideInCombatCheckbox)

  muteSoundsCheckbox, muteSoundsLabel =
    Reported2.UI.Config.CreateCheckbox("Mute sounds", configFrame, showOnDetectionCheckbox)

  -- Channel Options
  channelOptionsLabel =
    Reported2.UI.Config.CreateOptionsLabel(
    "Channel Options",
    configFrame,
    muteSoundsCheckbox,
    Reported2.UI.Sizes.Padding * 3
  )
  channelOptionsSubLabel =
    Reported2.UI.Config.CreateOptionsSubLabel("Select which channels to monitor:", configFrame, channelOptionsLabel)

  -- Channels
  Reported2.UI.Config.CreateChannelCheckboxes(configFrame)

  CreateModulesPanel()

  -- Config Frame - Form actions
  configFrame:SetScript("OnShow", UpdateConfigFrameValues)

  function configFrame.okay()
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = showWaitingRoomCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_PREFS_HIDE_IN_COMBAT] = hideInCombatCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_ON_DETECTION] = showOnDetectionCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS] = muteSoundsCheckbox:GetChecked()

    REPORTED2_PREFS[REPORTED2_CHAT_MSG_CHANNEL] = globalChannelsCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_GUILD] = guildChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_INSTANCE_CHAT] = instanceChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] = instanceLeaderChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_OFFICER] = officerChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_PARTY] = partyLeaderChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_PARTY_LEADER] = partyChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_RAID] = raidLeaderChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_RAID_LEADER] = raidChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_SAY] = sayChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_WHISPER] = whisperChannelCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_CHAT_MSG_YELL] = yellChannelCheckbox:GetChecked()

    REPORTED2_PREFS[REPORTED2_PREFS_ENABLED_MODULES] = {}
    REPORTED2_PREFS[REPORTED2_PREFS_DISABLED_MODULES] = {}

    local sortedModules = Reported2.Utilities.GetSortedModuleNames(Reported2.Modules)

    for index, moduleName in ipairs(sortedModules) do
      local checkbox = _G["REPORTED2_MODULE_CHECKBOX_" .. string.upper(moduleName)]
      local isChecked = checkbox:GetChecked()

      if isChecked then
        table.insert(REPORTED2_PREFS[REPORTED2_PREFS_ENABLED_MODULES], moduleName)
      else
        table.insert(REPORTED2_PREFS[REPORTED2_PREFS_DISABLED_MODULES], moduleName)
      end
    end

    if #REPORTED2_PREFS[REPORTED2_PREFS_ENABLED_MODULES] == 0 then
      local indexOfDefaultModule
      for index, value in pairs(REPORTED2_PREFS[REPORTED2_PREFS_DISABLED_MODULES]) do
        if value == "Default" then
          indexOfDefaultModule = index
        end
      end

      table.remove(REPORTED2_PREFS[REPORTED2_PREFS_DISABLED_MODULES], indexOfDefaultModule)
      table.insert(REPORTED2_PREFS[REPORTED2_PREFS_ENABLED_MODULES], "Default")
    end

    if REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] then
      Reported2.RenderOffenders()
      Reported2.Panel.ShowPanel()
    else
      Reported2.Panel.HidePanel()
    end
  end
end

function Reported2.Config.OpenConfigMenu()
  -- https://wowwiki.fandom.com/wiki/Using_the_Interface_Options_Addons_panel
  -- ------------------------------------------------------------------------
  -- Note: Call this function twice (in a row), there is a bug in Blizzard's code which makes the first call
  -- (after login or /reload) fail. It opens interface options but not on the addon's interface options;
  -- instead it opens the default interface options.
  -- If you call it twice in a row, it works as intended.

  InterfaceOptionsFrame_OpenToCategory(configFrame.name)
  InterfaceOptionsFrame_OpenToCategory(configFrame.name)
end
