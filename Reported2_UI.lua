UI = {}
UI.Config = {}
UI.Sizes = {}

UI.Sizes.Padding = 10
UI.Sizes.CheckboxWidth = 20
UI.Sizes.CheckboxHeight = 20

local normalTex = [[Interface\Addons\Reported2\KMT56]]
local edgeTex = [[Interface\Buttons\WHITE8X8]]

function ApplyCheckedTexture(checkbox)
  local checkedTexture = checkbox:GetCheckedTexture()

  checkedTexture:SetVertexColor(Palette.RGB.TEAL.r, Palette.RGB.TEAL.g, Palette.RGB.TEAL.b, 1)
  checkedTexture:SetInside()
end

function ApplyNormalTexture(checkbox)
  local normalTexture = checkbox:GetNormalTexture()

  normalTexture:SetVertexColor(Palette.RGB.WHITE.r, Palette.RGB.WHITE.g, Palette.RGB.WHITE.b, 0.1)
  normalTexture:SetInside()
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
      edgeFile = edgeTex,
      edgeSize = 1
    }
  )
  checkbox:SetBackdropBorderColor(Palette.RGB.BLACK.r, Palette.RGB.BLACK.g, Palette.RGB.BLACK.b, 1)

  checkbox:SetCheckedTexture(normalTex)
  checkbox:SetNormalTexture(normalTex)
  checkbox:SetHighlightTexture(nil)
  checkbox:SetPushedTexture(nil)
  checkbox:SetDisabledTexture(nil)

  ApplyNormalTexture(checkbox)
  ApplyCheckedTexture(checkbox)

  label:SetPoint("LEFT", checkbox, "RIGHT", UI.Sizes.Padding, 0)
  label:SetText(labelText)

  return checkbox, label
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
  leftChannelColumn:SetPoint("TOPLEFT", UI.Sizes.Padding, -180)
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

  -- Right Column
  local rightChannelColumn =
    CreateFrame(
    "Frame",
    "Reported2ConfigFrameChannelsColumnRight",
    configFrame,
    BackdropTemplateMixin and "BackdropTemplate"
  )
  rightChannelColumn:SetPoint("TOPLEFT", UI.Sizes.Padding + leftChannelColumn:GetWidth(), -180)
  rightChannelColumn:SetSize(200, 200)

  local raidLeaderChannelText = Palette.START .. Events.Colours[CHAT_MSG_RAID_LEADER] .. "Raid leader" .. Palette.END
  raidLeaderChannelCheckbox, raidLeaderChannelLabel =
    CreateCheckbox(raidLeaderChannelText, configFrame, rightChannelColumn, relativePoint)

  local raidChannelText = Palette.START .. Events.Colours[CHAT_MSG_RAID] .. "Raid chat" .. Palette.END
  raidChannelCheckbox, raidChannelLabel = CreateCheckbox(raidChannelText, configFrame, raidLeaderChannelCheckbox)

  local sayChannelText = Palette.START .. Events.Colours[CHAT_MSG_SAY] .. "Say" .. Palette.END
  sayChannelCheckbox, sayChannelLabel = CreateCheckbox(sayChannelText, configFrame, raidChannelCheckbox)

  local whisperChannelText = Palette.START .. Events.Colours[CHAT_MSG_WHISPER] .. "Whispers" .. Palette.END
  whisperChannelCheckbox, whisperChannelLabel = CreateCheckbox(whisperChannelText, configFrame, sayChannelCheckbox)

  local yellChannelText = Palette.START .. Events.Colours[CHAT_MSG_YELL] .. "Yells" .. Palette.END
  yellChannelCheckbox, yellChannelLabel = CreateCheckbox(yellChannelText, configFrame, whisperChannelCheckbox)

  return globalChannelsCheckbox, guildChannelCheckbox, officerChannelCheckbox, partyLeaderChannelCheckbox, partyChannelCheckbox, raidLeaderChannelCheckbox, raidChannelCheckbox, sayChannelCheckbox, whisperChannelCheckbox, yellChannelCheckbox
end

UI.Config.CreateCheckbox = CreateCheckbox

UI.Config.CreateConfigFrame = CreateConfigFrame
UI.Config.CreateTitleLabel = CreateTitleLabel
UI.Config.CreateVersionLabel = CreateVersionLabel
UI.Config.CreateContributorsLabel = CreateContributorsLabel
UI.Config.CreateSeparator = CreateSeparator
UI.Config.CreateOptionsLabel = CreateOptionsLabel
UI.Config.CreateOptionsSubLabel = CreateOptionsSubLabel
UI.Config.CreateChannelCheckboxes = CreateChannelCheckboxes
