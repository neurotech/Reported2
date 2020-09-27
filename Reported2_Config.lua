function CreateConfigPanel()
  local padding = 10
  local checkboxWidth = 12
  local checkboxHeight = 12

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

  local titleLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  titleLabel:SetPoint("TOPLEFT", configFrame, "TOPLEFT", padding, -padding)
  titleLabel:SetText(
    colours.START ..
      colours.PALE_BLUE ..
        "Reported" ..
          colours.START .. colours.BLUE .. "!" .. colours.START .. colours.RICH_YELLOW .. " 2" .. colours.END
  )

  local versionLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
  versionLabel:SetPoint("BOTTOMLEFT", titleLabel, "BOTTOMRIGHT", padding, 0)
  versionLabel:SetText(colours.START .. colours.WHITE .. "v" .. GetAddOnMetadata("Reported2", "Version"))

  local contributorsLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
  contributorsLabel:SetPoint("TOPRIGHT", configFrame, "TOPRIGHT", -padding, -padding)
  contributorsLabel:SetText(
    colours.START ..
      colours.WHITE ..
        "Contributors: " .. colours.START .. colours.TEAL .. "weasel, Sneep, TrashEmoji, Bronzong, Krakyn, neurotech"
  )

  local separator =
    CreateFrame("Frame", "Reported2ConfigFrameSeparator", configFrame, BackdropTemplateMixin and "BackdropTemplate")
  separator:SetPoint("TOP", 0, -padding * 3.5)
  separator:SetSize(InterfaceOptionsFramePanelContainer:GetWidth() - (padding * 2), 1)
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
  separator:SetBackdropColor(0, 0, 0, 0.5)

  local generalOptionsLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  generalOptionsLabel:SetPoint("TOPLEFT", separator, "BOTTOMLEFT", 0, -padding)
  generalOptionsLabel:SetText("General Options")

  local showWaitingRoomCheckbox = CreateFrame("CheckButton", nil, configFrame, "InterfaceOptionsCheckButtonTemplate")
  showWaitingRoomCheckbox:SetSize(checkboxWidth, checkboxHeight)
  showWaitingRoomCheckbox:SetPoint("TOPLEFT", generalOptionsLabel, "BOTTOMLEFT", padding, -padding)
  showWaitingRoomCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL])

  -- -
  local checked = showWaitingRoomCheckbox:CreateTexture()
  checked:SetAllPoints()
  checked:SetBlendMode("ADD")
  checked:SetColorTexture(46 / 255, 230 / 255, 46 / 255, 1)

  local normal = showWaitingRoomCheckbox:CreateTexture()
  normal:SetAllPoints()
  normal:SetBlendMode("BLEND")
  normal:SetColorTexture(0, 0, 0, 0.4)

  showWaitingRoomCheckbox:SetNormalTexture(unchecked)
  showWaitingRoomCheckbox:SetCheckedTexture(checked)
  showWaitingRoomCheckbox:SetHighlightTexture(nil)
  showWaitingRoomCheckbox:SetPushedTexture(nil)
  -- -

  local showWaitingRoomLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  showWaitingRoomLabel:SetPoint("LEFT", showWaitingRoomCheckbox, "RIGHT", padding, 0)
  showWaitingRoomLabel:SetText("Show Waiting Room")

  local muteSoundsCheckbox = CreateFrame("CheckButton", nil, configFrame, "InterfaceOptionsCheckButtonTemplate")
  muteSoundsCheckbox:SetPoint("TOPLEFT", showWaitingRoomCheckbox, "BOTTOMLEFT", 0, 0)
  muteSoundsCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS])

  local muteSoundsLabel = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  muteSoundsLabel:SetPoint("LEFT", muteSoundsCheckbox, "RIGHT", 0, 0)
  muteSoundsLabel:SetText("Mute sounds")

  -- Form Actions

  -- On show
  configFrame:SetScript(
    "OnShow",
    function()
      showWaitingRoomCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL])
      muteSoundsCheckbox:SetChecked(REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS])
    end
  )

  -- Click Okay
  function configFrame.okay(arg1, arg2, arg3, ...)
    REPORTED2_PREFS[REPORTED2_PREFS_SHOW_PANEL] = showWaitingRoomCheckbox:GetChecked()
    REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS] = muteSoundsCheckbox:GetChecked()
    RenderOffenders()
  end
end

CreateConfigPanel()
