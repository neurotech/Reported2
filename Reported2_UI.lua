Reported2.UI = {}
Reported2.UI.Config = {}
Reported2.UI.Sizes = {}

Reported2.UI.Sizes.Padding = 10
Reported2.UI.Sizes.CheckboxWidth = 16
Reported2.UI.Sizes.CheckboxHeight = 16

local function SetTextureInside(parent, texture)
  local xOffset = 1
  local yOffset = 1
  texture:SetPoint("TOPLEFT", parent, "TOPLEFT", xOffset, -yOffset)
  texture:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -xOffset, yOffset)
end

local function ApplyCheckedTexture(checkbox)
  local checkboxCheckedTexture = checkbox:GetCheckedTexture()
  checkboxCheckedTexture:SetVertexColor(unpack(Reported2.Palette.RGB.TEAL))
  SetTextureInside(checkbox, checkboxCheckedTexture)
end

local function ApplyNormalTexture(checkbox)
  local checkBoxNormalTexture = checkbox:GetNormalTexture()

  checkBoxNormalTexture:SetVertexColor(
    Reported2.Palette.RGB.WHITE[1],
    Reported2.Palette.RGB.WHITE[2],
    Reported2.Palette.RGB.WHITE[3],
    0.1
  )
  SetTextureInside(checkbox, checkBoxNormalTexture)
end

function Reported2.UI.Config.CreateCheckbox(labelText, parent, anchorPoint, relativePoint)
  local checkbox = CreateFrame("CheckButton", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
  Reported2.Utilities.SetPixelScaling(checkbox)
  local label = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

  if relativePoint == nil then
    relativePoint = "BOTTOMLEFT"
  end

  checkbox:SetSize(Reported2.UI.Sizes.CheckboxWidth, Reported2.UI.Sizes.CheckboxHeight)
  checkbox:SetPoint("TOPLEFT", anchorPoint, relativePoint, 0, -Reported2.UI.Sizes.Padding)
  checkbox:SetBackdrop(
    {
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  checkbox:SetBackdropBorderColor(unpack(Reported2.Palette.RGB.BLACK))
  checkbox:SetCheckedTexture(Reported2.BUTTON_BG_TEXTURE)
  checkbox:SetNormalTexture(Reported2.BUTTON_BG_TEXTURE)
  checkbox:SetHighlightTexture(nil)
  checkbox:SetPushedTexture(nil)
  checkbox:SetDisabledTexture(nil)

  ApplyNormalTexture(checkbox)
  ApplyCheckedTexture(checkbox)

  label:SetPoint("LEFT", checkbox, "RIGHT", Reported2.UI.Sizes.Padding, 0)
  label:SetText(labelText)

  return checkbox, label
end

function Reported2.UI.Config.CreateModuleCheckboxAndLabel(
  moduleName,
  moduleCredit,
  moduleDescription,
  parent,
  vOffset,
  isLastModule)
  local moduleCheckboxAndLabelFrame =
  CreateFrame(
    "Frame",
    "REPORTED2_MODULE_FRAME_" .. string.upper(moduleName),
    parent,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  Reported2.Utilities.SetPixelScaling(moduleCheckboxAndLabelFrame)
  moduleCheckboxAndLabelFrame:SetPoint("TOPLEFT", 0, -vOffset)

  local checkbox =
  CreateFrame(
    "CheckButton",
    "REPORTED2_MODULE_CHECKBOX_" .. string.upper(moduleName),
    moduleCheckboxAndLabelFrame,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  Reported2.Utilities.SetPixelScaling(checkbox)
  local nameAndCreditLabel = moduleCheckboxAndLabelFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  local descriptionLabel = moduleCheckboxAndLabelFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")

  local nameAndCreditText = Reported2.Palette.START .. Reported2.Palette.PURPLE .. moduleName .. Reported2.Palette.END

  if (moduleCredit) then
    nameAndCreditText =
    nameAndCreditText ..
        Reported2.Palette.START ..
        Reported2.Palette.LIGHT_GREY ..
        " by " .. Reported2.Palette.START .. Reported2.Palette.BRIGHT_YELLOW .. moduleCredit .. Reported2.Palette.END
  end

  local descriptionText =
  Reported2.Palette.START .. Reported2.Palette.WHITE .. moduleDescription .. Reported2.Palette.END

  checkbox:SetSize(Reported2.UI.Sizes.CheckboxWidth, Reported2.UI.Sizes.CheckboxHeight)
  checkbox:SetPoint("TOPLEFT", Reported2.UI.Sizes.Padding, 0)
  checkbox:SetBackdrop(
    {
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1
    }
  )
  checkbox:SetBackdropBorderColor(unpack(Reported2.Palette.RGB.BLACK))

  checkbox:SetCheckedTexture(Reported2.BUTTON_BG_TEXTURE)
  checkbox:SetNormalTexture(Reported2.BUTTON_BG_TEXTURE)
  checkbox:SetHighlightTexture(nil)
  checkbox:SetPushedTexture(nil)
  checkbox:SetDisabledTexture(nil)

  ApplyNormalTexture(checkbox)
  ApplyCheckedTexture(checkbox)

  nameAndCreditLabel:SetWordWrap(true)
  nameAndCreditLabel:SetPoint("LEFT", checkbox, "RIGHT", Reported2.UI.Sizes.Padding, 0)
  nameAndCreditLabel:SetText(nameAndCreditText)
  nameAndCreditLabel:SetWidth(parent:GetWidth())
  nameAndCreditLabel:SetJustifyH("LEFT")

  descriptionLabel:SetPoint("LEFT", checkbox, "RIGHT", Reported2.UI.Sizes.Padding, -Reported2.UI.Sizes.Padding * 2)
  descriptionLabel:SetText(descriptionText)
  descriptionLabel:SetWidth(parent:GetWidth() - 100)
  descriptionLabel:SetWordWrap(true)
  descriptionLabel:SetJustifyH("LEFT")

  moduleCheckboxAndLabelFrame:SetSize(parent:GetWidth(), checkbox:GetHeight() + (Reported2.UI.Sizes.Padding * 2))

  if isLastModule then
    descriptionLabel:SetHeight(descriptionLabel:GetHeight() + Reported2.UI.Sizes.Padding * 2)
  end

  return moduleCheckboxAndLabelFrame, checkbox, nameLabel, offset
end

function Reported2.UI.Config.CreateConfigFrame()
  local configFrame =
  CreateFrame(
    "Frame",
    "Reported2ConfigFrame",
    InterfaceOptionsFramePanelContainer,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  Reported2.Utilities.SetPixelScaling(configFrame)

  configFrame:Hide()
  configFrame.name = "Reported! 2"
  InterfaceOptions_AddCategory(configFrame)

  return configFrame
end

function Reported2.UI.Config.CreateTitleLabel(configFrame)
  local titleLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

  titleLabel:SetPoint("TOPLEFT", configFrame, "TOPLEFT", Reported2.UI.Sizes.Padding, -Reported2.UI.Sizes.Padding)
  titleLabel:SetText(
    Reported2.Palette.START ..
    Reported2.Palette.PALE_BLUE ..
    "Reported" ..
    Reported2.Palette.START ..
    Reported2.Palette.BLUE ..
    "!" .. Reported2.Palette.START .. Reported2.Palette.RICH_YELLOW .. " 2" .. Reported2.Palette.END
  )

  return titleLabel
end

function Reported2.UI.Config.CreateVersionLabel(configFrame, titleLabel)
  local versionLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")

  versionLabel:SetPoint("BOTTOMLEFT", titleLabel, "BOTTOMRIGHT", Reported2.UI.Sizes.Padding, 0)
  versionLabel:SetText(
    Reported2.Palette.START .. Reported2.Palette.WHITE .. "v" .. GetAddOnMetadata("Reported2", "Version")
  )

  return versionLabel
end

function Reported2.UI.Config.CreateContributorsLabel(configFrame)
  local contributorsLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")

  contributorsLabel:SetPoint(
    "TOPRIGHT",
    configFrame,
    "TOPRIGHT",
    -Reported2.UI.Sizes.Padding,
    -Reported2.UI.Sizes.Padding
  )
  contributorsLabel:SetText(Reported2.Utilities.GenerateContributorsString())

  return contributorsLabel
end

function Reported2.UI.Config.CreateSeparator(configFrame)
  local separator =
  CreateFrame("Frame", "Reported2ConfigFrameSeparator", configFrame, BackdropTemplateMixin and "BackdropTemplate")
  Reported2.Utilities.SetPixelScaling(separator)

  separator:SetPoint("TOP", 0, -Reported2.UI.Sizes.Padding * 3.5)
  separator:SetSize(InterfaceOptionsFramePanelContainer:GetWidth() - (Reported2.UI.Sizes.Padding * 2), 1)
  separator:SetBackdrop(
    {
      bgFile = Reported2.FLAT_BG_TEXTURE
    }
  )
  separator:SetBackdropColor(
    Reported2.Palette.RGB.BLACK[1],
    Reported2.Palette.RGB.BLACK[2],
    Reported2.Palette.RGB.BLACK[3],
    0.5
  )

  return separator
end

function Reported2.UI.Config.CreateOptionsLabel(labelText, parent, anchorPoint, yPadding)
  local optionsLabel = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

  if yPadding == nil then
    yPadding = Reported2.UI.Sizes.Padding
  end

  optionsLabel:SetPoint("TOPLEFT", anchorPoint, "BOTTOMLEFT", 0, -yPadding)
  optionsLabel:SetText(labelText)

  return optionsLabel
end

function Reported2.UI.Config.CreateOptionsSubLabel(labelText, parent, anchorPoint)
  local optionsSubLabel = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")

  optionsSubLabel:SetPoint("TOPLEFT", anchorPoint, "BOTTOMLEFT", 0, -Reported2.UI.Sizes.Padding)
  optionsSubLabel:SetText(Reported2.Palette.START .. Reported2.Palette.LIGHT_GREY .. labelText .. Reported2.Palette.END)

  return optionsSubLabel
end

function Reported2.UI.Config.CreateChannelCheckboxes(configFrame)
  local relativePoint = "TOPLEFT"

  -- Left Column
  local leftChannelColumn =
  CreateFrame(
    "Frame",
    "Reported2ConfigFrameChannelsColumnLeft",
    configFrame,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  Reported2.Utilities.SetPixelScaling(leftChannelColumn)
  leftChannelColumn:SetPoint("TOPLEFT", Reported2.UI.Sizes.Padding, -270)
  leftChannelColumn:SetSize(200, 200)

  local globalChannelsText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_CHANNEL] .. "Global channels" .. Reported2.Palette.END
  globalChannelsCheckbox, globalChannelsLabel =
  Reported2.UI.Config.CreateCheckbox(globalChannelsText, configFrame, leftChannelColumn, relativePoint)

  local guildChannelText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_GUILD] .. "Guild chat" .. Reported2.Palette.END
  guildChannelCheckbox, guildChannelLabel =
  Reported2.UI.Config.CreateCheckbox(guildChannelText, configFrame, globalChannelsCheckbox)

  local officerChannelText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_OFFICER] .. "Officer chat" .. Reported2.Palette.END
  officerChannelCheckbox, officerChannelLabel =
  Reported2.UI.Config.CreateCheckbox(officerChannelText, configFrame, guildChannelCheckbox)

  local partyLeaderChannelText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_PARTY_LEADER] .. "Party leader" .. Reported2.Palette.END
  partyLeaderChannelCheckbox, partyLeaderChannelLabel =
  Reported2.UI.Config.CreateCheckbox(partyLeaderChannelText, configFrame, officerChannelCheckbox)

  local partyChannelText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_PARTY] .. "Party chat" .. Reported2.Palette.END
  partyChannelCheckbox, partyChannelLabel =
  Reported2.UI.Config.CreateCheckbox(partyChannelText, configFrame, partyLeaderChannelCheckbox)

  local yellChannelText =
  Reported2.Palette.START .. Reported2.Events.Colours[REPORTED2_CHAT_MSG_YELL] .. "Yell" .. Reported2.Palette.END
  yellChannelCheckbox, yellChannelLabel =
  Reported2.UI.Config.CreateCheckbox(yellChannelText, configFrame, partyChannelCheckbox)

  -- Right Column
  local rightChannelColumn =
  CreateFrame(
    "Frame",
    "Reported2ConfigFrameChannelsColumnRight",
    configFrame,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  Reported2.Utilities.SetPixelScaling(rightChannelColumn)
  rightChannelColumn:SetPoint("TOPLEFT", Reported2.UI.Sizes.Padding + leftChannelColumn:GetWidth(), -270)
  rightChannelColumn:SetSize(200, 200)

  local raidLeaderChannelText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_RAID_LEADER] .. "Raid leader" .. Reported2.Palette.END
  raidLeaderChannelCheckbox, raidLeaderChannelLabel =
  Reported2.UI.Config.CreateCheckbox(raidLeaderChannelText, configFrame, rightChannelColumn, relativePoint)

  local raidChannelText =
  Reported2.Palette.START .. Reported2.Events.Colours[REPORTED2_CHAT_MSG_RAID] .. "Raid chat" .. Reported2.Palette.END
  raidChannelCheckbox, raidChannelLabel =
  Reported2.UI.Config.CreateCheckbox(raidChannelText, configFrame, raidLeaderChannelCheckbox)

  local sayChannelText =
  Reported2.Palette.START .. Reported2.Events.Colours[REPORTED2_CHAT_MSG_SAY] .. "Say" .. Reported2.Palette.END
  sayChannelCheckbox, sayChannelLabel =
  Reported2.UI.Config.CreateCheckbox(sayChannelText, configFrame, raidChannelCheckbox)

  local instanceLeaderChannelText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_INSTANCE_CHAT_LEADER] .. "Instance leader" .. Reported2.Palette.END
  instanceLeaderChannelCheckbox, instanceLeaderChannelLabel =
  Reported2.UI.Config.CreateCheckbox(instanceLeaderChannelText, configFrame, sayChannelCheckbox)

  local instanceChannelText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_INSTANCE_CHAT] .. "Instance chat" .. Reported2.Palette.END
  instanceChannelCheckbox, instanceChannelLabel =
  Reported2.UI.Config.CreateCheckbox(instanceChannelText, configFrame, instanceLeaderChannelCheckbox)

  local whisperChannelText =
  Reported2.Palette.START ..
      Reported2.Events.Colours[REPORTED2_CHAT_MSG_WHISPER] .. "Whispers" .. Reported2.Palette.END
  whisperChannelCheckbox, whisperChannelLabel =
  Reported2.UI.Config.CreateCheckbox(whisperChannelText, configFrame, instanceChannelCheckbox)

  return globalChannelsCheckbox, guildChannelCheckbox, officerChannelCheckbox, partyLeaderChannelCheckbox,
      partyChannelCheckbox, sayChannelCheckbox, yellChannelCheckbox, raidLeaderChannelCheckbox, raidChannelCheckbox,
      instanceLeaderChannelCheckbox, instanceChannelCheckbox, whisperChannelCheckbox
end

function Reported2.UI.Config.CreateModulesFrame(configFrame)
  local modulesFrame =
  CreateFrame(
    "Frame",
    "Reported2ConfigFrame_Modules",
    InterfaceOptionsFramePanelContainer,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  Reported2.Utilities.SetPixelScaling(modulesFrame)

  modulesFrame.name = "Modules"
  modulesFrame.parent = configFrame.name
  InterfaceOptions_AddCategory(modulesFrame)

  return modulesFrame
end

function Reported2.UI.CreatePixelText(name, frame, text, textColour, shadowColour, point, offsetx, offsety, textSize)
  point = point or "TOPLEFT"
  offsetx = offsetx or 4
  offsety = offsety or 0
  shadowColour = shadowColour or { 0, 0, 0 }
  textSize = textSize or 9

  local pixelText = frame:CreateFontString(name, "OVERLAY", nil)
  pixelText:SetIgnoreParentScale(true)
  pixelText:SetPoint(point, offsetx, offsety)
  pixelText:SetFont("Interface\\AddOns\\Reported2\\Fonts\\cabin-bold.ttf", textSize)

  if (textColour) then
    pixelText:SetTextColor(unpack(textColour))
  end

  pixelText:SetShadowColor(unpack(shadowColour))
  pixelText:SetShadowOffset(1, -1)
  pixelText:SetText(text)

  return pixelText
end

function Reported2.UI.CreatePixelButton(
  frame,
  name,
  text,
  width,
  height,
  textColour,
  textOffsetx,
  textOffsety,
  borderColour,
  backgroundColour,
  point,
  offsetx,
  offsety,
  textSize)
  width = width or 60
  height = height or 20
  point = point or "TOPLEFT"
  textColour = textColour or { 1, 1, 1 }
  textOffsetx = textOffsetx or 0
  textOffsety = textOffsety or 0
  borderColour = borderColour or { 1, 1, 1 }
  backgroundColour = backgroundColour or { 0, 0, 0 }
  offsetx = offsetx or 0
  offsety = offsety or 0
  textSize = textSize or 10

  local pixelButton = CreateFrame("Button", name, frame, BackdropTemplateMixin and "BackdropTemplate")
  Reported2.Utilities.SetPixelScaling(pixelButton)
  pixelButton:SetPoint(point, offsetx, offsety)
  pixelButton:SetSize(width, height)
  pixelButton:SetBackdrop(
    {
      bgFile = Reported2.BUTTON_BG_TEXTURE,
      edgeFile = Reported2.EDGE_TEXTURE,
      edgeSize = 1,
      insets = { left = 1, right = 1, top = 1, bottom = 1 }
    }
  )

  pixelButton:SetBackdropColor(unpack(backgroundColour))
  pixelButton:SetBackdropBorderColor(unpack(borderColour))

  pixelButton:HookScript("OnEnter", function(self, motion)
    if not motion then return end
    -- pixelButton:SetBackdropBorderColor(unpack(Elements.Palette.RGB.WHITE))
    pixelButton:SetBackdropColor(unpack(Reported2.Utilities.LightenColour(backgroundColour)))
  end)

  pixelButton:HookScript("OnLeave", function(self, motion)
    if not motion then return end
    -- pixelButton:SetBackdropBorderColor(unpack(borderColour))
    pixelButton:SetBackdropColor(unpack(backgroundColour))
  end)

  Reported2.UI.CreatePixelText(
    name .. "_TEXT",
    pixelButton,
    text,
    textColour,
    backgroundColour,
    "CENTER",
    textOffsetx,
    textOffsety,
    textSize
  )

  return pixelButton
end
