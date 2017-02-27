--Design
pokedexWindow = nil

--functions
Painel = {
	pokedex = {
		['pnlDescricao'] = "",
		['pnlAtaques'] = "",
		['pnlHabilidades'] = "",		
	}
}
openedDex = {}
dexMax = 0

function init()
	connect(g_game, { onEditText = showPokemonDescription, onGameEnd = hide } )
end

function showPokedex()
	if pokedexWindow then
		pokedexWindow:destroy()
	end
	pokedexWindow = g_ui.displayUI('game_pokedex')
end

function terminate()
	disconnect(g_game, { onEditText = showPokemonDescription, onGameEnd = hide } )
end

function hide()
	pokedexWindow:destroy()
end

function Painel.show(childName, id)	
	pokedexWindow:getChildById('pnlDescricao'):getChildById('lblConteudo'):setText(Painel.pokedex['pnlDescricao'])
	pokedexWindow:getChildById('pnlDescricao'):setVisible(false)
	pokedexWindow:getChildById('scrDescricao'):setVisible(false)
	pokedexWindow:getChildById('portrait1'):setItemId(tonumber(id))
	
	pokedexWindow:getChildById(childName):setVisible(true)
	pokedexWindow:getChildById('scr'..childName:sub(4,#childName)):setVisible(true)
	
end



function showPokemonDescription(id, itemId, maxLength, texto, writter, time)
	if not g_game.isOnline() then return end	--Se nao estiver online 
	local name = texto:match('Name: (.-)\n')
	local type = texto:match('Type: (.-)\n')
	local std = string.explode(texto, '|')  
	--Se for chamada de pokedex
	-- print(std[1]) 
	if name and type then
						-- local itemIDWidget = pokedexWindow:getChildById("portrait1")
							  -- itemIDWidget:setItemId(tonumber(std[1]))
		showPokedex()
		Painel.pokedex["pnlDescricao"] = std[2]
		Painel.show('pnlDescricao', std[1])
	end
end