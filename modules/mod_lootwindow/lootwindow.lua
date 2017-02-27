local itemID = nil
local itemID2 = nil
local itemID3 = nil
local itemID4 = nil
local itemID5 = nil
local itemID6 = nil
local itemID7 = nil
local itemID8 = nil
local itemID9 = nil
local itemID10 = nil
local itemID11 = nil
local count1 = nil
local count2 = nil
local count3 = nil
local count4 = nil
local count5 = nil
local count6 = nil
local count7 = nil
local count8 = nil
local count9 = nil
local count10 = nil
local count11 = nil
local viraPhantom = nil
local desaparecendo = nil

function init()
  connect(g_game, { onGameEnd = onGameEnd })
  

  lootWindow = g_ui.displayUI('lootwindow')
  lootWindow:hide()
  lootWindow:addAnchor(AnchorTop, 'topMenu', AnchorBottom)
  lootWindow:setImageSource('/images/ui/loot.png')
  lootWindow:setParent(modules.game_interface.getMapPanel())
  lootWindow:setHeight(36)
  ProtocolGame.registerExtendedOpcode(60, function(protocol, opcode, buffer)
  local strings = string.explode(buffer, '-')  

  show(strings[1], strings[2], strings[3], strings[4], strings[5], strings[6], strings[7], strings[8], strings[9], strings[10], strings[11], strings[12], strings[13], strings[14], strings[15], strings[16], strings[17], strings[18], strings[19], strings[20], strings[21], strings[22]) 
  end)
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(60)

  lootWindow:destroy()
end

function onGameEnd()
  if lootWindow:isVisible() then
    lootWindow:hide()
  end
end

function show(itemID, count1, itemID2, count2, itemID3, count3, itemID4, count4, itemID5, count5, itemID6, count6, itemID7, count7, itemID8, count8, itemID9, count9, itemID10, count10, itemID11, count11)
  lootWindow:setWidth(modules.game_interface.getMapPanel():getWidth())
    addEvent(function() g_effects.fadeIn(lootWindow, 250) end)
  lootWindow:setPhantom(false)
  lootWindow:show()
  lootWindow:raise()
  lootWindow:focus()
  lootWindow:getChildById('loot1'):setItemId(tonumber(itemID))
  if count1 ~= nil and tonumber(count1) > 1 then
  lootWindow:getChildById('count1'):setText(tonumber(count1))
  else
  lootWindow:getChildById('count1'):setText('')
  end
  lootWindow:getChildById('loot2'):setItemId(tonumber(itemID2))
  if count2 ~= nil and tonumber(count2) > 1 then
  lootWindow:getChildById('count2'):setText(tonumber(count2))
  else
  lootWindow:getChildById('count2'):setText('')
  end
  lootWindow:getChildById('loot3'):setItemId(tonumber(itemID3))
  if count3 ~= nil and tonumber(count3) > 1 then
  lootWindow:getChildById('count3'):setText(tonumber(count3))
  else
  lootWindow:getChildById('count3'):setText('')
  end
  lootWindow:getChildById('loot4'):setItemId(tonumber(itemID4))
  if count4 ~= nil and tonumber(count4) > 1 then
  lootWindow:getChildById('count4'):setText(tonumber(count4))
  else
  lootWindow:getChildById('count4'):setText('')
  end
  lootWindow:getChildById('loot5'):setItemId(tonumber(itemID5))
  if count5 ~= nil and tonumber(count5) > 1 then 
  lootWindow:getChildById('count5'):setText(tonumber(count5))
  else
  lootWindow:getChildById('count5'):setText('')
  end
  lootWindow:getChildById('loot6'):setItemId(tonumber(itemID6))
  if count6 ~= nil and tonumber(count6) > 1 then 
  lootWindow:getChildById('count6'):setText(tonumber(count6))
  else
  lootWindow:getChildById('count6'):setText('')
  end
  lootWindow:getChildById('loot7'):setItemId(tonumber(itemID7))
  if count7 ~= nil and tonumber(count7) > 1 then 
  lootWindow:getChildById('count7'):setText(tonumber(count7))
  else
  lootWindow:getChildById('count7'):setText('')
  end
  lootWindow:getChildById('loot8'):setItemId(tonumber(itemID8))
  if count8 ~= nil and tonumber(count8) > 1 then 
  lootWindow:getChildById('count8'):setText(tonumber(count8))
  else
  lootWindow:getChildById('count8'):setText('')
  end
  lootWindow:getChildById('loot9'):setItemId(tonumber(itemID9))
  if count9 ~= nil and tonumber(count9) > 1 then 
  lootWindow:getChildById('count9'):setText(tonumber(count9))
  else
  lootWindow:getChildById('count9'):setText('')
  end
  lootWindow:getChildById('loot10'):setItemId(tonumber(itemID10))
  if count10 ~= nil and tonumber(count10) > 1 then 
  lootWindow:getChildById('count10'):setText(tonumber(count10))
  else
  lootWindow:getChildById('count10'):setText('')
  end
  lootWindow:getChildById('loot11'):setItemId(tonumber(itemID11))
  if count11 ~= nil and tonumber(count11) > 1 then 
  lootWindow:getChildById('count11'):setText(tonumber(count11))
  else
  lootWindow:getChildById('count11'):setText('')
  end
  if itemID11 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*11)
  lootWindow:getChildById('count1'):setMarginRight(16*11)
  elseif itemID10 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*10)
  lootWindow:getChildById('count1'):setMarginRight(16*10)
  elseif itemID9 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*9)
  lootWindow:getChildById('count1'):setMarginRight(16*9)
  elseif itemID8 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*8)
  lootWindow:getChildById('count1'):setMarginRight(16*8)
  elseif itemID7 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*7)
  lootWindow:getChildById('count1'):setMarginRight(16*7)
  elseif itemID6 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*6)
  lootWindow:getChildById('count1'):setMarginRight(16*6)
  elseif itemID5 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*5)
  lootWindow:getChildById('count1'):setMarginRight(16*5)
  elseif itemID4 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*4)
  lootWindow:getChildById('count1'):setMarginRight(16*4)
  elseif itemID3 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*3)
  lootWindow:getChildById('count1'):setMarginRight(16*3)
  elseif itemID2 ~= nil then
  lootWindow:getChildById('loot1'):setMarginRight(16*2)
  lootWindow:getChildById('count1'):setMarginRight(16*2)
  else
  lootWindow:getChildById('loot1'):setMarginRight(16)
  lootWindow:getChildById('count1'):setMarginRight(16)
  end

  if viraPhantom ~= nil then
  removeEvent(viraPhantom)
  end
  if desaparecendo ~= nil then
  removeEvent(desaparecendo)
  end
  
  desaparecendo = scheduleEvent(function() 
  g_effects.fadeOut(lootWindow, 2900) 
  desaparecendo = nil
  end, 3000)
  
  viraPhantom = scheduleEvent(function() 
  lootWindow:setPhantom(true) 
  viraPhantom = nil
  end, 6000)
  scheduleEvent(function() 
  if lootWindow:isPhantom() then 
  lootWindow:hide() 
  end
  end, 6000)
end

function hide()
  addEvent(function() g_effects.fadeOut(lootWindow, 250) end)
  scheduleEvent(function() lootWindow:hide() end, 250)
end
