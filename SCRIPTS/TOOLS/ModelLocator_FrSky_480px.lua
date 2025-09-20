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
  -- FrSky S.Port has RSSI value from 0 to 100
  -- TX16S screen size: 480x272
  local rssi = getValue("RSSI")
  local rxbt = getValue("RxBt")
  
  -- lcd.setColor(TEXT_COLOR, BLACK)
  -- lcd.drawText(4,4,"FrSky RX Finder(D8/D16)", MIDSIZE)
  -- lcd.drawNumber(180, 30, rssi, XXLSIZE)

  lcd.drawText(2,2,"FrSky RX Finder(S.Port)", MIDSIZE)
  -- lcd.drawNumber(20, 20, rssi, XXLSIZE)
  -- lcd.drawNumber(70, 20, rxbt, XXLSIZE)
  -- add color to RSSI text
  lcd.drawText(10, 22, string.format("RSSI: %d", rssi), XXLSIZE)
  -- left border of the rssi bar
  lcd.drawFilledRectangle(10,80,1,8, 0)
  -- upper border of the rssi bar
  lcd.drawFilledRectangle(11,80,200,1, 0)
  -- lower border of the rssi bar
  lcd.drawFilledRectangle(11,87,200,1, 0)
  -- right border of the rssi bar
  lcd.drawFilledRectangle(211,80,1,8,0)
  -- rssi bar itself (max 100)
  lcd.drawFilledRectangle(11,81,rssi*2,6, 0)
  -- receiver RxBt voltage
  lcd.drawText(10, 92, string.format("RxBt: %.2f V", rxbt), MIDSIZE)

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
