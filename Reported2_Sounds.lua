sounds = {}

function PlaySwearDetectedSound()
  if not REPORTED2_PREFS[REPORTED2_PREFS_MUTE_SOUNDS] then
    PlaySoundFile([[Interface\Addons\Reported2\swear-detected.mp3]])
  end
end

sounds.PlaySwearDetectedSound = PlaySwearDetectedSound
