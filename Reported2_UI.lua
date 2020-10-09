UI = {}
UI.Config = {}
UI.Sizes = {}

UI.Sizes.Padding = 10
UI.Sizes.CheckboxWidth = 16
UI.Sizes.CheckboxHeight = 16

function SetTextureInside(parent, texture)
  local xOffset = 1
  local yOffset = 1
  texture:SetPoint("TOPLEFT", parent, "TOPLEFT", xOffset, -yOffset)
  texture:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -xOffset, yOffset)
end

function ApplyCheckedTexture(checkbox)
  local checkboxCheckedTexture = checkbox:GetCheckedTexture()

  checkboxCheckedTexture:SetVertexColor(Palette.RGB.TEAL.r, Palette.RGB.TEAL.g, Palette.RGB.TEAL.b, 1)
  SetTextureInside(checkbox, checkboxCheckedTexture)
end

function ApplyNormalTexture(checkbox)
  local checkBoxNormalTexture = checkbox:GetNormalTexture()

  checkBoxNormalTexture:SetVertexColor(Palette.RGB.WHITE.r, Palette.RGB.WHITE.g, Palette.RGB.WHITE.b, 0.1)
  SetTextureInside(checkbox, checkBoxNormalTexture)
end

function CreateCheckbox(labelText, parent, anchorPoint, relativePoint)
  local checkbox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
  local label = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

  if relativePoint == nil then
    relativePoint = "BOTTOMLEFT"
  end

  checkbox:SetSize(UI.Sizes.CheckboxWidth, UI.Sizes.CheckboxHeight)
  checkbox:SetPoint("TOPLEFT", anchorPoint, relativePoint, 0, -UI.Sizes.Padding)
  checkbox:SetBackdrop(
    {
      edgeFile = EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  checkbox:SetBackdropBorderColor(Palette.RGB.BLACK.r, Palette.RGB.BLACK.g, Palette.RGB.BLACK.b, 1)

  checkbox:SetCheckedTexture(BUTTON_BG_TEXTURE)
  checkbox:SetNormalTexture(BUTTON_BG_TEXTURE)
  checkbox:SetHighlightTexture(nil)
  checkbox:SetPushedTexture(nil)
  checkbox:SetDisabledTexture(nil)

  ApplyNormalTexture(checkbox)
  ApplyCheckedTexture(checkbox)

  label:SetPoint("LEFT", checkbox, "RIGHT", UI.Sizes.Padding, 0)
  label:SetText(labelText)

  return checkbox, label
end

function CreateModuleCheckboxAndLabel(moduleName, moduleCredit, moduleDescription, parent, vOffset, isLastModule)
  local moduleCheckboxAndLabelFrame =
    CreateFrame(
    "Frame",
    "MODULE_FRAME_" .. string.upper(moduleName),
    parent,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  moduleCheckboxAndLabelFrame:SetPoint("TOPLEFT", 0, -vOffset)

  local checkbox =
    CreateFrame(
    "CheckButton",
    "MODULE_CHECKBOX_" .. string.upper(moduleName),
    moduleCheckboxAndLabelFrame,
    "InterfaceOptionsCheckButtonTemplate"
  )
  local nameAndCreditLabel = moduleCheckboxAndLabelFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  local descriptionLabel = moduleCheckboxAndLabelFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")

  local nameAndCreditText = Palette.START .. Palette.PURPLE .. moduleName .. Palette.END

  if (moduleCredit) then
    nameAndCreditText =
      nameAndCreditText ..
      Palette.START ..
        Palette.LIGHT_GREY .. " by " .. Palette.START .. Palette.BRIGHT_YELLOW .. moduleCredit .. Palette.END
  end

  local descriptionText = Palette.START .. Palette.WHITE .. moduleDescription .. Palette.END

  checkbox:SetSize(UI.Sizes.CheckboxWidth, UI.Sizes.CheckboxHeight)
  checkbox:SetPoint("TOPLEFT", UI.Sizes.Padding, 0)
  checkbox:SetBackdrop(
    {
      edgeFile = EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  checkbox:SetBackdropBorderColor(Palette.RGB.BLACK.r, Palette.RGB.BLACK.g, Palette.RGB.BLACK.b, 1)

  checkbox:SetCheckedTexture(BUTTON_BG_TEXTURE)
  checkbox:SetNormalTexture(BUTTON_BG_TEXTURE)
  checkbox:SetHighlightTexture(nil)
  checkbox:SetPushedTexture(nil)
  checkbox:SetDisabledTexture(nil)

  ApplyNormalTexture(checkbox)
  ApplyCheckedTexture(checkbox)

  nameAndCreditLabel:SetWordWrap(true)
  nameAndCreditLabel:SetPoint("LEFT", checkbox, "RIGHT", UI.Sizes.Padding, 0)
  nameAndCreditLabel:SetText(nameAndCreditText)
  nameAndCreditLabel:SetWidth(parent:GetWidth())
  nameAndCreditLabel:SetJustifyH("LEFT")

  descriptionLabel:SetPoint("LEFT", checkbox, "RIGHT", UI.Sizes.Padding, -UI.Sizes.Padding * 2)
  descriptionLabel:SetText(descriptionText)
  descriptionLabel:SetWidth(parent:GetWidth() - 100)
  descriptionLabel:SetWordWrap(true)
  descriptionLabel:SetJustifyH("LEFT")

  moduleCheckboxAndLabelFrame:SetSize(parent:GetWidth(), checkbox:GetHeight() + (UI.Sizes.Padding * 2))

  if isLastModule then
    descriptionLabel:SetHeight(descriptionLabel:GetHeight() + UI.Sizes.Padding * 2)
  end

  return moduleCheckboxAndLabelFrame, checkbox, nameLabel, offset
end

function CreateConfigFrame()
  local configFrame =
    CreateFrame(
    "Frame",
    "Reported2ConfigFrame",
    InterfaceOptionsFramePanelContainer,
    BackdropTemplateMixin and "BackdropTemplate"
  )

  configFrame:Hide()
  configFrame.name = "Reported! 2"
  InterfaceOptions_AddCategory(configFrame)

  return configFrame
end

function CreateTitleLabel(configFrame)
  local titleLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

  titleLabel:SetPoint("TOPLEFT", configFrame, "TOPLEFT", UI.Sizes.Padding, -UI.Sizes.Padding)
  titleLabel:SetText(
    Palette.START ..
      Palette.PALE_BLUE ..
        "Reported" ..
          Palette.START .. Palette.BLUE .. "!" .. Palette.START .. Palette.RICH_YELLOW .. " 2" .. Palette.END
  )

  return titleLabel
end

function CreateVersionLabel(configFrame, titleLabel)
  local versionLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")

  versionLabel:SetPoint("BOTTOMLEFT", titleLabel, "BOTTOMRIGHT", UI.Sizes.Padding, 0)
  versionLabel:SetText(Palette.START .. Palette.WHITE .. "v" .. GetAddOnMetadata("Reported2", "Version"))

  return versionLabel
end

function CreateContributorsLabel(configFrame)
  local contributorsLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")

  contributorsLabel:SetPoint("TOPRIGHT", configFrame, "TOPRIGHT", -UI.Sizes.Padding, -UI.Sizes.Padding)
  contributorsLabel:SetText(Utilities.GenerateContributorsString())

  return contributorsLabel
end

function CreateSeparator(configFrame)
  local separator =
    CreateFrame("Frame", "Reported2ConfigFrameSeparator", configFrame, BackdropTemplateMixin and "BackdropTemplate")

  separator:SetPoint("TOP", 0, -UI.Sizes.Padding * 3.5)
  separator:SetSize(InterfaceOptionsFramePanelContainer:GetWidth() - (UI.Sizes.Padding * 2), 1)
  separator:SetBackdrop(
    {
      bgFile = "bgFile",
      tile = false,
      tileEdge = false,
      tileSize = 0,
      edgeSize = 0,
      insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
  )
  separator:SetBackdropColor(Palette.RGB.BLACK.r, Palette.RGB.BLACK.g, Palette.RGB.BLACK.b, 0.5)

  return separator
end

function CreateOptionsLabel(labelText, parent, anchorPoint, yPadding)
  local optionsLabel = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

  if yPadding == nil then
    yPadding = UI.Sizes.Padding
  end

  optionsLabel:SetPoint("TOPLEFT", anchorPoint, "BOTTOMLEFT", 0, -yPadding)
  optionsLabel:SetText(labelText)

  return optionsLabel
end

function CreateOptionsSubLabel(labelText, parent, anchorPoint)
  local optionsSubLabel = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")

  optionsSubLabel:SetPoint("TOPLEFT", anchorPoint, "BOTTOMLEFT", 0, -UI.Sizes.Padding)
  optionsSubLabel:SetText(Palette.START .. Palette.LIGHT_GREY .. labelText .. Palette.END)

  return optionsSubLabel
end

function CreateChannelCheckboxes(configFrame)
  local relativePoint = "TOPLEFT"

  -- Left Column
  local leftChannelColumn =
    CreateFrame(
    "Frame",
    "Reported2ConfigFrameChannelsColumnLeft",
    configFrame,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  leftChannelColumn:SetPoint("TOPLEFT", UI.Sizes.Padding, -200)
  leftChannelColumn:SetSize(200, 200)

  local globalChannelsText = Palette.START .. Events.Colours[CHAT_MSG_CHANNEL] .. "Global channels" .. Palette.END
  globalChannelsCheckbox, globalChannelsLabel =
    CreateCheckbox(globalChannelsText, configFrame, leftChannelColumn, relativePoint)

  local guildChannelText = Palette.START .. Events.Colours[CHAT_MSG_GUILD] .. "Guild chat" .. Palette.END
  guildChannelCheckbox, guildChannelLabel = CreateCheckbox(guildChannelText, configFrame, globalChannelsCheckbox)

  local officerChannelText = Palette.START .. Events.Colours[CHAT_MSG_OFFICER] .. "Officer chat" .. Palette.END
  officerChannelCheckbox, officerChannelLabel = CreateCheckbox(officerChannelText, configFrame, guildChannelCheckbox)

  local partyLeaderChannelText = Palette.START .. Events.Colours[CHAT_MSG_PARTY_LEADER] .. "Party leader" .. Palette.END
  partyLeaderChannelCheckbox, partyLeaderChannelLabel =
    CreateCheckbox(partyLeaderChannelText, configFrame, officerChannelCheckbox)

  local partyChannelText = Palette.START .. Events.Colours[CHAT_MSG_PARTY] .. "Party chat" .. Palette.END
  partyChannelCheckbox, partyChannelLabel = CreateCheckbox(partyChannelText, configFrame, partyLeaderChannelCheckbox)

  local yellChannelText = Palette.START .. Events.Colours[CHAT_MSG_YELL] .. "Yell" .. Palette.END
  yellChannelCheckbox, yellChannelLabel = CreateCheckbox(yellChannelText, configFrame, partyChannelCheckbox)

  -- Right Column
  local rightChannelColumn =
    CreateFrame(
    "Frame",
    "Reported2ConfigFrameChannelsColumnRight",
    configFrame,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  rightChannelColumn:SetPoint("TOPLEFT", UI.Sizes.Padding + leftChannelColumn:GetWidth(), -200)
  rightChannelColumn:SetSize(200, 200)

  local raidLeaderChannelText = Palette.START .. Events.Colours[CHAT_MSG_RAID_LEADER] .. "Raid leader" .. Palette.END
  raidLeaderChannelCheckbox, raidLeaderChannelLabel =
    CreateCheckbox(raidLeaderChannelText, configFrame, rightChannelColumn, relativePoint)

  local raidChannelText = Palette.START .. Events.Colours[CHAT_MSG_RAID] .. "Raid chat" .. Palette.END
  raidChannelCheckbox, raidChannelLabel = CreateCheckbox(raidChannelText, configFrame, raidLeaderChannelCheckbox)

  local sayChannelText = Palette.START .. Events.Colours[CHAT_MSG_SAY] .. "Say" .. Palette.END
  sayChannelCheckbox, sayChannelLabel = CreateCheckbox(sayChannelText, configFrame, raidChannelCheckbox)

  local instanceLeaderChannelText =
    Palette.START .. Events.Colours[CHAT_MSG_INSTANCE_CHAT_LEADER] .. "Instance leader" .. Palette.END
  instanceLeaderChannelCheckbox, instanceLeaderChannelLabel =
    CreateCheckbox(instanceLeaderChannelText, configFrame, sayChannelCheckbox)

  local instanceChannelText = Palette.START .. Events.Colours[CHAT_MSG_INSTANCE_CHAT] .. "Instance chat" .. Palette.END
  instanceChannelCheckbox, instanceChannelLabel =
    CreateCheckbox(instanceChannelText, configFrame, instanceLeaderChannelCheckbox)

  local whisperChannelText = Palette.START .. Events.Colours[CHAT_MSG_WHISPER] .. "Whispers" .. Palette.END
  whisperChannelCheckbox, whisperChannelLabel = CreateCheckbox(whisperChannelText, configFrame, instanceChannelCheckbox)

  return globalChannelsCheckbox, guildChannelCheckbox, officerChannelCheckbox, partyLeaderChannelCheckbox, partyChannelCheckbox, sayChannelCheckbox, yellChannelCheckbox, raidLeaderChannelCheckbox, raidChannelCheckbox, instanceLeaderChannelCheckbox, instanceChannelCheckbox, whisperChannelCheckbox
end

function CreateModulesFrame(configFrame)
  local modulesFrame =
    CreateFrame(
    "Frame",
    "Reported2ConfigFrame_Modules",
    InterfaceOptionsFramePanelContainer,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  modulesFrame.name = "Modules"
  modulesFrame.parent = configFrame.name
  InterfaceOptions_AddCategory(modulesFrame)

  return modulesFrame
end

UI.Config.CreateCheckbox = CreateCheckbox
UI.Config.CreateModuleCheckboxAndLabel = CreateModuleCheckboxAndLabel

UI.Config.CreateConfigFrame = CreateConfigFrame
UI.Config.CreateTitleLabel = CreateTitleLabel
UI.Config.CreateVersionLabel = CreateVersionLabel
UI.Config.CreateContributorsLabel = CreateContributorsLabel
UI.Config.CreateSeparator = CreateSeparator
UI.Config.CreateOptionsLabel = CreateOptionsLabel
UI.Config.CreateOptionsSubLabel = CreateOptionsSubLabel
UI.Config.CreateChannelCheckboxes = CreateChannelCheckboxes
UI.Config.CreateModulesFrame = CreateModulesFrame
