Icons = {}
Icons[128] = { path = '/images/game/pokemon/logout_block', id = 'condition_logout_block' }
Icons[16384] = { path = '/images/game/pokemon/protection_zone', id = 'condition_protection_zone' }

InventorySlotStyles = {
  [InventorySlotHead] = "HeadSlot",
  [InventorySlotNeck] = "NeckSlot",
  [InventorySlotBack] = "BackSlot",
  [InventorySlotBody] = "BodySlot",
  [InventorySlotRight] = "RightSlot",
  [InventorySlotLeft] = "LeftSlot",
  [InventorySlotLeg] = "LegSlot",
  [InventorySlotFeet] = "FeetSlot",
  [InventorySlotFinger] = "FingerSlot",
  [InventorySlotAmmo] = "AmmoSlot"
}

pokemonWindow = nil
healthBar = nil
pokeHealthBar = nil
pokeballs = {}

fightOffensiveBox = nil
fightBalancedBox = nil
fightDefensiveBox = nil
fightModeRadioGroup = nil
pvpModeRadioGroup = nil

function init()
  connect(LocalPlayer, { onHealthChange = onHealthChange,
                         onFreeCapacityChange = onPokeballsChange,
                         onStatesChange = onStatesChange,
                         onInventoryChange = onInventoryChange })

  connect(g_game, { onGameStart = refresh,
                    onGameEnd = offline,
                    onFightModeChange = update })

   connect(g_game, 'onTextMessage', onPokeHealthChange)

  g_keyboard.bindKeyDown('Ctrl+P', toggle)
  pokemonButton = modules.client_topmenu.addRightGameToggleButton('pokemonButton', tr('Pokemon') .. ' (Ctrl+P)', '/images/topbuttons/pokemon', toggle)
  pokemonButton:setWidth(25)
  pokemonButton:setOn(true)

  pokemonWindow = g_ui.loadUI('pokemon', modules.game_interface.getRightPanel())
  pokemonWindow:disableResize()
  healthBar = pokemonWindow:recursiveGetChildById('healthBar')
  pokeHealthBar = pokemonWindow:recursiveGetChildById('pokeHealthBar')
  pokeballBar = pokemonWindow:recursiveGetChildById('pokeballBar')

  fightOffensiveBox = pokemonWindow:recursiveGetChildById('fightOffensiveBox')
  fightBalancedBox = pokemonWindow:recursiveGetChildById('fightBalancedBox')
  fightDefensiveBox = pokemonWindow:recursiveGetChildById('fightDefensiveBox')

  fightModeRadioGroup = UIRadioGroup.create()
  fightModeRadioGroup:addWidget(fightOffensiveBox)
  fightModeRadioGroup:addWidget(fightBalancedBox)
  fightModeRadioGroup:addWidget(fightDefensiveBox)

  connect(fightModeRadioGroup, { onSelectionChange = onSetFightMode })

  -- load condition icons
  for k,v in pairs(Icons) do
    g_textures.preload(v.path)
  end

  refresh()
  pokemonWindow:setup()
end

function terminate()
  disconnect(LocalPlayer, { onHealthChange = onHealthChange,
                            onFreeCapacityChange = onPokeballsChange,
                            onStatesChange = onStatesChange,
                            onInventoryChange = onInventoryChange })

  disconnect(g_game, { onGameStart = refresh,
                       onGameEnd = offline,
                       onFightModeChange = update })

  ProtocolGame.unregisterExtendedOpcode(104)

  g_keyboard.unbindKeyDown('Ctrl+P', toggle)
  pokemonWindow:destroy()
  pokemonButton:destroy()
  fightModeRadioGroup:destroy()
end

function refresh()
  local player = g_game.getLocalPlayer()
  if g_game.isOnline() then
    onHealthChange(player, player:getHealth(), player:getMaxHealth())
    g_game.getProtocolGame():sendExtendedOpcode(104, 'refresh')
    onPokeballsChange(player, player:getFreeCapacity())
    onStatesChange(player, player:getStates(), 0)
  end

  for i = InventorySlotFirst, InventorySlotLast do
    if g_game.isOnline() then
      onInventoryChange(player, i, player:getInventoryItem(i))
    else
      onInventoryChange(player, i, nil)
    end
  end

  if player then
    local char = g_game.getCharacterName()

    local lastCombatControls = g_settings.getNode('LastCombatControls')

    if not table.empty(lastCombatControls) then
      if lastCombatControls[char] then
        g_game.setFightMode(lastCombatControls[char].fightMode)
      end
    end
  end

  update()
end

function update()
  local fightMode = g_game.getFightMode()
  if fightMode == FightOffensive then
    fightModeRadioGroup:selectWidget(fightOffensiveBox)
  elseif fightMode == FightBalanced then
    fightModeRadioGroup:selectWidget(fightBalancedBox)
  else
    fightModeRadioGroup:selectWidget(fightDefensiveBox)
  end
end

function toggle()
  if pokemonButton:isOn() then
    pokemonWindow:close()
    pokemonButton:setOn(false)
  else
    pokemonWindow:open()
    pokemonButton:setOn(true)
  end
end

function toggleIcon(bitChanged)
  local content = pokemonWindow:recursiveGetChildById('conditionPanel')

  local icon = content:getChildById(Icons[bitChanged].id)
  if icon then
    icon:destroy()
  else
    icon = loadIcon(bitChanged)
    icon:setParent(content)
  end
end

function loadIcon(bitChanged)
  local icon = g_ui.createWidget('ConditionWidget', content)
  icon:setId(Icons[bitChanged].id)
  icon:setImageSource(Icons[bitChanged].path)
  return icon
end

function offline()
  pokemonWindow:recursiveGetChildById('conditionPanel'):destroyChildren()

  local lastCombatControls = g_settings.getNode('LastCombatControls')
  if not lastCombatControls then
    lastCombatControls = {}
  end

  local player = g_game.getLocalPlayer()
  if player then
    local char = g_game.getCharacterName()
    lastCombatControls[char] = {
      fightMode = g_game.getFightMode(),
      chaseMode = g_game.getChaseMode(),
      safeFight = g_game.isSafeFight()
    }

    -- save last combat control settings
    g_settings.setNode('LastCombatControls', lastCombatControls)
  end
end

-- hooked events
function onMiniWindowClose()
  pokemonButton:setOn(false)
end

function onSkillButtonClick(button)
  local percentBar = button:getChildById('percent')
  if percentBar then
    percentBar:setVisible(not percentBar:isVisible())
    if percentBar:isVisible() then
      button:setHeight(21)
      pokemonWindow:setHeight(pokemonWindow:getHeight() + 6)
    else
      button:setHeight(21 - 6)
      pokemonWindow:setHeight(pokemonWindow:getHeight() - 6)
    end
  end
end

function onHealthChange(localPlayer, health, maxHealth)
  healthBar:setText(health .. ' / ' .. maxHealth)
  healthBar:setValue(health, 0, maxHealth)
end

function onPokeHealthChange(mode, text)
if not g_game.isOnline() then return end
   if mode == MessageModes.Failure then 
      if string.find(text, '#ph#,') then
         local t = text:explode(',')
         local hp, maxHp = tonumber(t[2]), tonumber(t[3])
         pokeHealthBar:setText(hp .. ' / ' .. maxHp)
         --barWindow:recursiveGetChildById("pokeHealthIcon"):setTooltip(tr(pokeHealthTooltip, hp, maxHp))
         pokeHealthBar:setValue(hp, 0, maxHp)
      end
   end
end 

function onPokeballsChange(player, freeCapacity)
  if freeCapacity > 7 then return end
  pokeballBar:setImageSource('/images/game/pokemon/pokeball' .. 7 - (freeCapacity ~= -1 and freeCapacity or 7))
end

function onStatesChange(localPlayer, now, old)
  if now == old then return end

  local bitsChanged = bit32.bxor(now, old)
  for i = 1, 32 do
    local pow = math.pow(2, i-1)
    if pow > bitsChanged then break end
    local bitChanged = bit32.band(bitsChanged, pow)
    if bitChanged ~= 0 then
      toggleIcon(bitChanged)
    end
  end
end

function onInventoryChange(player, slot, item, oldItem)
  if slot > InventorySlotPurse then return end

  local itemWidget = pokemonWindow:recursiveGetChildById('slot' .. slot)
  if item then
    itemWidget:setItem(item)
  else
    itemWidget:setItem(nil)
  end
end

function onSetFightMode(self, selectedFightButton)
  if selectedFightButton == nil then return end
  local buttonId = selectedFightButton:getId()
  local fightMode = 1
  if buttonId == 'fightOffensiveBox' then
    fightMode = 1
  elseif buttonId == 'fightBalancedBox' then
    fightMode = 2
  else
    fightMode = 3
  end
	g_game.setFightMode(fightMode)
end
