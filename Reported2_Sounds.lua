Reported2.Sounds = {}

local function PlaySoundFileForEvent(path)
  if not REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS] then
    PlaySoundFile(path)
  end
end

function Reported2.Sounds.PlaySwearDetectedSound()
  PlaySoundFileForEvent([[Interface\Addons\Reported2\swear-detected.mp3]])
end

function Reported2.Sounds.PlayReportMadeSound()
  PlaySoundFileForEvent([[Interface\Addons\Reported2\report-made.mp3]])
end

function Reported2.Sounds.PlaySkipSound()
  PlaySoundFileForEvent([[Interface\Addons\Reported2\skip.mp3]])
end
