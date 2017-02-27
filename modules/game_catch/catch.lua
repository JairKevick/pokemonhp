function init()
  connect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.registerExtendedOpcode(105, function(protocol, opcode, buffer)
  local strings = string.explode(buffer, '-')  

  show(strings[1], strings[2], strings[3], strings[4], strings[5], strings[6], strings[7], strings[8], strings[9], strings[10], strings[11], strings[12], strings[13], strings[14], strings[15], strings[16], strings[17], strings[18], strings[19]) 
  end)

  catchWindow = g_ui.displayUI('catch')
  catchWindow:hide()
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(105)

  catchWindow:destroy()
end

function onGameEnd()
  if catchWindow:isVisible() then
    catchWindow:hide()
  end
end

function show(itemID, exp, pokemon, n, g, s, u)
  if not catchWindow:isVisible() then
    addEvent(function() g_effects.fadeIn(catchWindow, 250) end)
  end
  catchWindow:show()
  catchWindow:raise()
  catchWindow:focus()
  catchWindow:getChildById('portrait'):setItemId(tonumber(itemID))
  catchWindow:getChildById('pokeball'):setItemId(3282)
  catchWindow:getChildById('greatball'):setItemId(3279)
  catchWindow:getChildById('superball'):setItemId(3281)
  catchWindow:getChildById('ultraball'):setItemId(3280)		
  catchWindow:getChildById('hpball'):setItemId(11929)
  
  
  catchWindow:getChildById('text'):setText(tr('Congratulations, you caught a %s!\nXP: %s', doCorrectString(pokemon), exp))
  catchWindow:getChildById('pokeballsLabel'):setText(n)
  catchWindow:getChildById('greatballsLabel'):setText(g)
  catchWindow:getChildById('superballsLabel'):setText(s)
  catchWindow:getChildById('utraballsLabel'):setText(u)
 
end

function hide()
  addEvent(function() g_effects.fadeOut(catchWindow, 250) end)
  scheduleEvent(function() catchWindow:hide() end, 250)
end
