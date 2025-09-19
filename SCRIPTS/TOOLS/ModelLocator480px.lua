local delayDecMillis = 5
local nextPlayTime = getTime()

local function init()
  return 0
end

local function bg()
  return 0
end

local function main(event)

  lcd.clear()
  -- FrSky X9D+ has RSSI value from 0 to 100
  local rssi = getValue("RSSI")
  
  lcd.setColor(TEXT_COLOR, BLACK)
  lcd.drawNumber(180, 30, rssi, XXLSIZE)

  -- beep
  if rssi ~= 0 then
	  if getTime() >= nextPlayTime then
		playFile("/SCRIPTS/TOOLS/ModelLocator.wav")
		nextPlayTime = getTime() + delayDecMillis + (100 - math.abs(rssi))
	  end
  end

  return 0
end

return {init = init,run = main,background = bg}

