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
  -- For FrSky X8R and etc. RSSI is in range 0-100. 100 is strongest.
  -- FrSky X9D Plus screen size: 212x64
  local rssi = getValue("RSSI")
  local rxbt = getValue("RxBt")
  
  lcd.drawText(2,2,"FrSky RX Finder(D8/D16)", MIDSIZE)
  -- lcd.drawNumber(20, 20, rssi, XXLSIZE)
  -- lcd.drawNumber(70, 20, rxbt, XXLSIZE)
  lcd.drawText(10, 18, string.format("RSSI: %d", rssi), DBLSIZE)
  -- left border of the rssi bar
  lcd.drawFilledRectangle(10,40,1,8, 0)
  -- upper border of the rssi bar
  lcd.drawFilledRectangle(11,40,100,1, 0)
  -- lower border of the rssi bar
  lcd.drawFilledRectangle(11,47,100,1, 0)
  -- rssi bar itself (max 100)
  lcd.drawFilledRectangle(11,41,rssi,6, 0)
  -- right border of the rssi bar
  lcd.drawFilledRectangle(111,40,1,8,0)
  -- receiver RxBt voltage
  lcd.drawText(10, 52, string.format("RxBt: %.2f V", rxbt), MIDSIZE)



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
