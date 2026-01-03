assert(SMODS.load_file('src/atlas.lua'))()
assert(SMODS.load_file('src/jokers.lua'))()
assert(SMODS.load_file('src/cons.lua'))()
assert(SMODS.load_file('src/stickers.lua'))()
assert(SMODS.load_file('src/vouchers.lua'))()
assert(SMODS.load_file('src/sounds.lua'))()
assert(SMODS.load_file('src/vouchers.lua'))()
assert(SMODS.load_file('src/seals.lua'))()
assert(SMODS.load_file('src/stake.lua'))()
assert(SMODS.load_file('src/tags.lua'))()
assert(SMODS.load_file('src/boosters.lua'))()
assert(SMODS.load_file('src/ranks.lua'))()
assert(SMODS.load_file('src/bigboys.lua'))()
assert(SMODS.load_file('src/challenge.lua'))()
assert(SMODS.load_file('src/backs.lua'))()
assert(SMODS.load_file('src/mainmenu.lua'))()
assert(SMODS.load_file('src/cardsleeves.lua'))()
assert(SMODS.load_file('src/timers.lua'))()
-- assert(SMODS.load_file('src/achievements.lua'))()


title_variant = title_variant or 1
title_screen_randomized = false
timer_active = false

trigger_global_chip_decrease = function()
	if G and G.E_MANAGER and G.GAME then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 2,
			func = function()
				G.GAME.chips = (G.GAME.chips or 0) - 2
				return true
			end
		}))
	end
end
get_total_joker_sell_value = function(exclude_card)
    local total_sell = 0
    if G and G.jokers and G.jokers.cards then
        for _, j in ipairs(G.jokers.cards) do
            if j ~= exclude_card and j.sell_cost then
                local sell = type(j.sell_cost) == "function" and j:sell_cost() or j.sell_cost
                total_sell = total_sell + (tonumber(sell) or 0)
            end
        end
    end
    return total_sell
end
can_add_jokers = function(num)
    local owned = (G and G.jokers and G.jokers.cards) and #G.jokers.cards or 0
    local max = (G and G.GAME and G.GAME.starting_params and G.GAME.starting_params.joker_slots) or 0
    return (owned + num) <= max, owned, max
end

currentprobability = function()
	return G.GAME.probabilities.normal
end

hasplayedthisround = function(hand_type)
    local hands = G.GAME.current_round and G.GAME.current_round.hands
    if not hands then return false end
    local hand = hands[hand_type]
    if hand and hand.played_this_round then
        return hand.played_this_round > 0
    end
    return false
end


sine = function(intensity, speed, offset)
   local t = (love and love.timer and love.timer.getTime and love.timer.getTime()) or os.clock() + (offset or 0)
    return math.sin(t * (speed or 1)) * (intensity or 1)
end

cosine = function(intensity, speed, offset)
    local t = (love and love.timer and love.timer.getTime and love.timer.getTime()) or os.clock() + (offset or 0)
    return math.cos(t * (speed or 1)) * (intensity or 1)
end

addCardsRandom = function(count, edition)
    local suits = {"H", "S", "D", "C"}
        local num_to_add = count
        for i = 1, num_to_add do
			G.E_MANAGER:add_event(Event({
				trigger = "immediate",
				func = function()
					local suit = suits[math.random(#suits)]
					local suit = suits[math.random(#suits)]
					local rank = math.random(1, 13)
					local front = suit .. "_" .. tostring(rank)
					SMODS.add_card{
						set = "Base",
						suit = suit,
						rank = rank,
						front = front,
						edition = "e_" .. edition,
						area = G.deck
					}
					return true
				end
			}))
		end
	end

amountselected = function()
    local selected = {}
    for i, card in ipairs(G.hand.cards) do
         if card.highlighted then
            table.insert(selected, card)
        end
    end
    return #selected
end

getJokerEdition = function(joker)
    if joker and joker.edition then
        return joker.edition
    elseif joker and joker.ability and joker.ability.edition then
        return joker.ability.edition
    end
    return nil
end

getHighlighted = function(num)
    local selected = {}
    for i, card in ipairs(G.hand.cards) do
         if card.highlighted then
            table.insert(selected, card)
        end
    end
    return selected[num]
end

juice_up_all_cards = function()
     if G.hand and G.hand.cards then
        for _, card in ipairs(G.hand.cards) do
            if card.juice_up then card:juice_up() end
        end
    end
     if G.play and G.play.cards then
        for _, card in ipairs(G.play.cards) do
            if card.juice_up then card:juice_up() end
        end
    end
     if G.jokers and G.jokers.cards then
        for _, card in ipairs(G.jokers.cards) do
            if card.juice_up then card:juice_up() end
        end
    end
 	if G.consumeables and G.consumeables.cards then
        for _, card in ipairs(G.consumeables.cards) do
            if card.juice_up then card:juice_up() end
        end
    end
	SMODS.juice_up_blind()
end

getLowestCardInHand = function()
    if not G.hand or not G.hand.cards or #G.hand.cards == 0 then return nil end
    local lowest = G.hand.cards[1]
    for _, card in ipairs(G.hand.cards) do
        if card.base and lowest.base and card.base.value and lowest.base.value then
             local v1 = card.base.value == "Ace" and 14 or tonumber(card.base.value) or 0
            local v2 = lowest.base.value == "Ace" and 14 or tonumber(lowest.base.value) or 0
            if v1 < v2 then
                lowest = card
            end
        end
    end
    return lowest
end

SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = 'Credits',
            tab_definition_function = function()
                local joker_list = {"c_fams_LeafiC", "c_fams_AlexC", "c_fams_JynxC", "c_fams_PikoC", "c_fams_credA", "c_fams_EarlC", "c_fams_YogiC", "c_fams_BearC"}
                local joker_cards = {}
                for i, joker_key in ipairs(joker_list) do
                    local center = G.P_CENTERS[joker_key] or G.P_CENTERS.j_joker
                    if center then
                        local card = Card(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
                        if card then table.insert(joker_cards, card) end
                    end
                end

                return {
                    n = G.UIT.ROOT,
                    config = {align = "cm", r = 0.1, minw = 12, minh = 8, padding = 1, colour = G.C.BLACK},
                    nodes = {
                         {
                            n = G.UIT.R,
                            config = {align = "cm", minw = 12, minh = 1, padding = 0.15},
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {text = "Credits", colour = G.C.UI.TEXT_LIGHT, scale = 1.2, padding = 0.1}
                                }
                            }
                        },
						{
                            n = G.UIT.R,
                            config = {align = "cm", minw = 12, minh = 1, padding = 0},
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {text = "Thanks to these wonderful fellas for their contributions to this silly ass project", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}
                                }
                            }
                        },
                         {
                            n = G.UIT.R,
                            config = {align = "cm", minw = 12, minh = 2, padding = 0.1},
                            nodes = (function()
                                local card_nodes = {}
                                for _, card in ipairs(joker_cards) do
                                    table.insert(card_nodes, {
                                        n = G.UIT.O,
                                        config = {object = card, padding = 0.1, minw = 2, minh = 2}
                                    })
                                end
                                return card_nodes
                            end)()
                        }
                    }
                }
            end,
        },
    }
end


GetMoney = function()
	return G.GAME.dollars or 0
end

handsLeft = function()
	return G.GAME.current_round.hands_left
end

SetMoney = function(num)
	G.GAME.dollars = num
end

isPlayingBlind = function()
	return G and G.GAME and G.GAME.facing_blind
end

isChallenge = function(key)
	return G.GAME.challenge == "c_" .. "fams_" .. key
end

isAnte = function(num)
	return G.GAME.round_resets.ante == num
end

getAnte = function()
	return G.GAME.round_resets.ante
end

setAnte = function(index)
	G.GAME.round_resets.ante = index
end

isBoss = function()
	return G and G.GAME and G.GAME.blind and G.GAME.blind.boss == true
end

getcurrentBlind = function()
	if (G.GAME.blind) then
		return G.GAME.blind.name
	end
end

SetWinningAnte = function(num)
	G.GAME.win_ante = num
end

GetWinningAnte = function()
	return G.GAME.win_ante or nil
end

GetStake = function()
	return G.GAME.stake or nil
end

isEternal = function(card)
	return card.ability.eternal
end

setEternal = function(card, bool)
	card.ability.eternal = bool
end

getRoundNumber = function()
    return G.GAME.round or nil
end

getBlindRequirement = function()
	return G.GAME.blind.chipsr
end

isMainMenu = function()
	return G.STATE == 11
end

hasWon = function()
	return G.STATE == 7
end

hasLost = function()
	return G.STATE == 4
end

hasSeal = function(card, key)
	return card and card.seal and card.seal == key
end

setseal = function(card, key)
	card:set_seal("fams_"..key, nil, true)
end

createtag = function(key)
add_tag(Tag(key, false, 'Small'))
end

setseal_all_selected = function(seal_key)
    for _, card in ipairs(G.hand.cards) do
        if card.highlighted then
            card:set_seal("fams_" .. seal_key, nil, true)
        end
    end
end

mostPlayedHand = function()
	if not G.GAME or not G.GAME.hands then return "High Card" end
	
	local most_played_count = 0
	local most_played_name = "High Card"
	
	for hand_name, hand_data in pairs(G.GAME.hands) do
		if hand_data.played and hand_data.played > most_played_count then
			most_played_count = hand_data.played
			most_played_name = hand_name
		end
	end
	
	return most_played_name
end

currentDeck = function()
    if G and G.GAME and G.GAME.selected_back 
        and G.GAME.selected_back.effect 
        and G.GAME.selected_back.effect.center 
        and G.GAME.selected_back.effect.center.key then
        return G.GAME.selected_back.effect.center.key
    end
    return nil
end

ForceLoss = function()
	if G.STATE ~= G.STATES.GAME_OVER then
	G.STATE = G.STATES.GAME_OVER
	G.STATE_COMPLETE = false
	end
end

destroycard = function(card)
	card:remove(true)
end

hasJoker = function(key)
	if G and G.jokers and G.jokers.cards then
		for _, joker in ipairs(G.jokers.cards) do
			if joker.label == key then
				return true
			end
		end
	end
	return false
end

getJokers = function()
	local jokerList = {}
	if G and G.jokers and G.jokers.cards then
		for _, joker in ipairs(G.jokers.cards) do
			table.insert(jokerList, joker.label)
		end
	end
	return jokerList

end

removeCards = function(amount)
				local removed = 0
			   local sources = {G.deck, G.hand, G.discard}
			   for _, area in ipairs(sources) do
					   if area and area.cards then

							   for i = #area.cards, 1, -1 do
									   local c = area.cards[i]

									   if c then
											   table.remove(area.cards, i)
											   c:remove(true)
											   removed = removed + 1
											   if removed >= amount then break end
									   end
							   end
					   end
					   if removed >= amount then break end
			   end
end
 setMenuBG = function(colour1, colour2, colour3, contrast, spin_amount)
	if G and G.SPLASH_BACK and G.SPLASH_BACK.draw_steps then
		for _, step in ipairs(G.SPLASH_BACK.draw_steps) do
			if step.shader == 'splash' and step.send then
				for _, entry in ipairs(step.send) do
					if entry.name == 'colour_1' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = colour1
					elseif entry.name == 'colour_2' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = colour2
					elseif entry.name == 'colour_3' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = colour3
					elseif entry.name == 'contrast' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = contrast
					elseif entry.name == 'spin_amount' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = spin_amount
					end
				end
			end
		end
	end
end

setrunBG = function(col1, col2, vort_speed)
	if (G.SPLASH_BACK) then
    G.SANDBOX = G.SANDBOX or {}
    G.SANDBOX.vort_time = love.timer.getTime()
    G.SANDBOX.col1 = col1 or {0.2, 0.4, 0.8, 1}
    G.SANDBOX.col2 = col2 or {0.8, 0.2, 0.4, 1}
    G.SANDBOX.mid_flash = mid_flash or 0.5

    G.SPLASH_BACK:define_draw_steps({
        {
            shader = 'splash',
            send = {
                {name = 'time', ref_table = G.SANDBOX, ref_value = 'vort_time'},
                {name = 'vort_speed', val = vort_speed or 0.4},
                {name = 'colour_1', ref_table = G.SANDBOX, ref_value = 'col1'},
                {name = 'colour_2', ref_table = G.SANDBOX, ref_value = 'col2'},
            }
        }
    })
end
end


resetrunBG = function()
	if (G.SPLASH_BACK) then
    G.SANDBOX = G.SANDBOX or {}
    G.SANDBOX.vort_time = love.timer.getTime()
    G.SANDBOX.col1 = {0.494, 0.839, 0.404, 1}
    G.SANDBOX.col2 = {0.394, 0.539, 0.304, 1}

    G.SPLASH_BACK:define_draw_steps({
        {
            shader = 'splash',
            send = {
                {name = 'time', ref_table = G.SANDBOX, ref_value = 'vort_time'},
                {name = 'vort_speed', val = 0.4},
                {name = 'colour_1', ref_table = G.SANDBOX, ref_value = 'col1'},
                {name = 'colour_2', ref_table = G.SANDBOX, ref_value = 'col2'},
            }
        }
    })
end
end

extinctcards = function(rank)
  	local sources = {G.deck, G.discard, G.hand}
	for _, area in ipairs(sources) do
		if area and area.cards then
			for i = #area.cards, 1, -1 do
				local c = area.cards[i]
				if rank then
					if c and c.base and c.base.value == rank then
 						if c.dissolve and type(c.dissolve) == "function" then
 							pcall(function() c:dissolve({G.C.WHITE, G.C.WHITE}, true, 3, true) end)
						elseif c.start_dissolve and type(c.start_dissolve) == "function" then
							play_sound("tarot2", 1, 1)
							pcall(function() c:start_dissolve({G.C.WHITE, G.C.WHITE}, true, 3, true) end)
						else
 							pcall(function() c:remove(true) end)
						end
					end
				end
			end
		end
	end
end

targetdisplay = "nothing"
random = math.random(0,1)
random2 = math.random(0,1)
random3 = math.random(0,1)
random4 = math.random(0,1)
random5 = math.random(0,1)
random6 = math.random(0,1)
tick = false
tick_once = false
 local DEFAULT_BPMMAX = 4
 getBPMMax = function()
	if G and G.GAME then
 		if G.GAME.bpmmax == nil then
			G.GAME.bpmmax = DEFAULT_BPMMAX
		end
		return G.GAME.bpmmax
	end
	return DEFAULT_BPMMAX
end

BPM_tick_start_time = love and love.timer and love.timer.getTime and love.timer.getTime() or os.clock()
prev_BPM_tick_time = BPM_tick_start_time

do
	local prev_beat = 0
	getBPMTick = function()
		local now = (love and love.timer and love.timer.getTime and love.timer.getTime() or os.clock())
		local t = now - BPM_tick_start_time
		local beats_per_second = BPM / 60
		local beat = math.floor(t * beats_per_second)
		local mod_beat = (beat % getBPMMax()) + 1

		tick_once = false
		if beat ~= prev_beat then
			tick_once = true
		end
		prev_beat = beat
		return mod_beat, tick_once
	end
end
timeradd = false
BPM = 117
drums = 0
triggeronce = false

setBPM = function(num)
	BPM = num
end

triggeronce = function()
	triggeronce = false
end

check_wyr_joker_on_run = function()
	if G and G.GAME and G.jokers and G.jokers.cards then
		for _, joker in ipairs(G.jokers.cards) do
			if joker.key == 'wouldyourather' then
				G.GAME.menu_answered = G.GAME.menu_answered or false
				if not G.GAME.menu_answered then
					wyr()
				end
				break
			end
		end
	end
end

timer = 60.0
timeropened = false
timerdisplay = timer
local superease = 1
wyrnames = {}
wyreffects = {}

addWYR = function(name, effect_func)
	table.insert(wyrnames, name)
	table.insert(wyreffects, effect_func)
end

G.customtext = G.customtext or {}
showFloatingText = function(text, colour, scale, offset, id)
	G.customtext = G.customtext or {}
	id = id or "newnode"
	if G.customtext[id] and not G.customtext[id].removed then
		G.customtext[id]:remove()
	end
	local node = {
		n = G.UIT.T,
		config = {
			text = text or "",
			scale = scale or 1,
			colour = colour or G.C.WHITE,
			offset = offset or {x = 0, y = 0}
		}
	}
	G.customtext[id] = UIBox {
		definition = node,
		config = { align = "tm", offset = offset or {x = 0, y = 0}, major = G.ROOM_ATTACH, bond = "Weak" }
	}
	G.customtext[id]:align_to_major()
end

local timer_text_node = nil
showUItimer = function(newtime)
	if G and G.GAME and timer_active and type(G.GAME.bomb_timer) == "number" and G.GAME.bomb_timer > 0 then
		timer = G.GAME.bomb_timer
	else
		timer = newtime
	end
	if G.TIMER_OVERLAY and not G.TIMER_OVERLAY.removed then
		G.TIMER_OVERLAY:remove()
	end
	timer_text_node = {n = G.UIT.T, config = {text = tostring(timerdisplay):sub(1, 5), scale = 0.8, colour = G.C.RED}}
	local menu_def = {
		n = G.UIT.ROOT,
		config = {align = "tm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minw = 0.5, minh = 2},
		nodes = {
			{
				n = G.UIT.R,
				config = {align = "cm", padding = 0.05},
				nodes = {
					{
						n = G.UIT.T,
						config = {text = "Time Left", scale = 0.8, colour = G.C.RED}
					}
				}
			},
			{
				n = G.UIT.R,
				config = {align = "cm", padding = 0.05},
				nodes = {
					{
						n = G.UIT.R,
						config = {align = "cm"},
						nodes = {
							timer_text_node
						}
					}
				}
			}
		}
	}
	G.TIMER_OVERLAY = UIBox {
		definition = menu_def,
		config = { align = "cm", offset = { x = 9.5, y = 0 }, major = G.ROOM_ATTACH, bond = "Weak" }
	}
	G.TIMER_OVERLAY:align_to_major()
	timeropened = true
end

update_timer_text = function()
	if timer_text_node then
		timer_text_node.config.text = tostring(math.floor(timer)) .. " Seconds"
	end
	if G and G.GAME and (G.GAME.challenge == "c_fams_bomb" or GetStake() == 9) then
		G.GAME.bomb_timer = timer
		if G.GAME.challenge == "c_fams_bomb" then
		if isPlayingBlind() then
		setrunBG({1, 0, 0, 1}, {0, 0, 0, 1}, 1.5)
		else
		setrunBG({0, 1, 0, 1}, {0, 1, 0, 1}, 1)
		end
		end
 	end
	if timer < 0 and G.STATE ~= G.STATES.GAME_OVER then
		G.STATE = G.STATES.GAME_OVER
		G.STATE_COMPLETE = false
	end
end

update_blind_select_UI = function()
    if G.blind_select and G.blind_select.children then
        for _, blind_card in ipairs(G.blind_select.children) do
            if blind_card and blind_card.config and blind_card.config.blind then
                local blind = blind_card.config.blind
                 blind.base_chips = blind.base_chips or blind.chips
                blind.chips = math.floor((blind.base_chips or blind.chips) * 2)
                blind.chip_text = tostring(blind.chips)
                 if blind_card.children and blind_card.children.chip_text then
                    blind_card.children.chip_text.config.text = blind.chip_text
                    blind_card.children.chip_text.config.colour = G.C.RED
                end
            end
        end
    end
end


musicpower = 1
musicPower = function(new)
	musicpower = new
end



SMODS.Keybind{
    key_pressed = "g", -- The key to trigger the action (e.g., "k" for the K key)
    action = function(self)
    end,
}

SMODS.Keybind{
    key_pressed = "s",
    action = function(self)
        
    end,
}

SMODS.Keybind{
    key_pressed = "j", -- The key to trigger the action (e.g., "k" for the K key)
    action = function(self)
        SMODS.create_card{
        set = "Joker",
        legendary = false,
        rarity = math.random(0.01, 1.00),
        skip_materialize = false,
        enhanced_poll = 0.5
        }
    end,
}

addtime = function(amount)
	timer = timer + (amount or 0)
	update_timer_text()
end

addJokersByRarity = function(rarity, amount)
	local count = 0
	for _, joker in ipairs(SMODS.Jokers) do
		if joker.rarity == rarity then
			G.jokers:add_to_deck(joker)
			count = count + 1
			if count >= amount then break end
		end
	end
end

updateBlindChips = function()
	if G and G.GAME.blind and G.GAME.blind.chip_text then
		G.GAME.blind.chip_text = G.GAME.blind.chips
	end
end

removeUItimer = function()
if G.TIMER_OVERLAY and not G.TIMER_OVERLAY.removed then
	G.TIMER_OVERLAY:remove()
end

end

addWYR("Set Discards to 0", function()
	G.GAME.current_round.discards_left = 0
end)

addWYR("Set Hands to 1", function()
	G.GAME.current_round.hands_left = 0
end)

addWYR("remove 20 cards", function()
	removeCards(20)
end)

addWYR("remove 10 cards", function()
	removeCards(10)
end)

addWYR("Decrease winning ante by 1", function()
	SetWinningAnte(GetWinningAnte() - 1)
end)

addWYR("Increase winning ante by 1", function()
	SetWinningAnte(GetWinningAnte() + 1)
end)

addWYR("start with 100 chips", function()
	G.GAME.chips = G.GAME.chips + 100
end)

addWYR("Lose the run", function()
	ForceLoss()
end)

addWYR("Set ante to random", function()
	G.GAME.round_resets.ante = math.random(1, GetWinningAnte())
end)

addWYR("Set winning ante to dollars", function()
	SetWinningAnte(GetMoney())
end)

addWYR("Set dollars to 0", function()
	SetMoney(0)
end)

addWYR("Go back in time", function()
	G.GAME.round_resets.ante = 1
end)

addWYR("start with half required chips", function()
	G.GAME.chips = G.GAME.blind.chips / 2
end)

addWYR("Gain 5 polychrome cards", function()
	addCardsRandom(5, "polychrome")
end)

addWYR("Gain 10 holographic cards", function()
	addCardsRandom(10, "holo")
end)

addWYR("Gain 30 foil cards", function()
	addCardsRandom(30, "foil")
end)

addWYR("Double your money!", function()
	SetMoney(GetMoney() * 2)
end)

addWYR("Triple your money!", function()
	SetMoney(GetMoney() * 3)
end)

addWYR("0 - money", function()
	SetMoney(0 - GetMoney())
end)

addWYR("Money^2", function()
	SetMoney(GetMoney()^2)
end)

addWYR("Money^4", function()
	SetMoney(GetMoney()^4)
end)

addWYR("Random Money", function()
	SetMoney(math.random(1, 10000))
end)

addWYR("Decrease Shop Prices by 3", function()
	G.GAME.inflation = G.GAME.inflation - 3
end)

addWYR("Increase Shop Prices by 3", function()
	G.GAME.inflation = G.GAME.inflation + 3
end)

addWYR("Gain 5 skips", function()
	G.GAME.skips = G.GAME.skips + 5
end)

addWYR("Lose One Random Joker", function()
 	if G and G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
		local count = #G.jokers.cards
		local idx = math.random(1, count)
		local victim = G.jokers.cards[idx]
		if victim then
 			if victim.juice_up then pcall(victim.juice_up, victim) end
 			pcall(function()
				victim:remove(true)
			end)
 			for i, j in ipairs(G.jokers.cards) do
				if j == victim then
					table.remove(G.jokers.cards, i)
					break
				end
			end
		end
	end
end)

addWYR("Lose ALL jokers", function()
 	if G and G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
 		local copy = {}
		for i, j in ipairs(G.jokers.cards) do copy[i] = j end
		for _, victim in ipairs(copy) do
			if victim then
 				if victim.juice_up then pcall(victim.juice_up, victim) end
 				pcall(function() victim:remove(true) end)
			end
		end
 		if G.jokers then G.jokers.cards = {} end
	end
end)

addWYR("Increase bankrupt threshold by 10 dollars", function()
    if not (G and G.GAME) then return end
    G.GAME.bankrupt_at = (G.GAME.bankrupt_at or 0) + 10
end)

addWYR("Decrease bankrupt threshold by 10 dollars", function()
    if not (G and G.GAME) then return end
    G.GAME.bankrupt_at = (G.GAME.bankrupt_at or 0) - 10
end)

addWYR("Gain 1 extra joker shop slot", function()
    if not (G and G.GAME) then return end
    G.GAME.shop.joker_max = G.GAME.shop.joker_max + 1
end)

addWYR("Lose 1 extra joker shop slot", function()
    if not (G and G.GAME) then return end
    G.GAME.shop.joker_max = G.GAME.shop.joker_max - 1
end)

addWYR("Increase Spectral Rate by 15", function()
    if not (G and G.GAME) then return end
    G.GAME.spectral_rate = G.GAME.spectral_rate + 15
end)

addWYR("Decrease Spectral Rate by 15", function()
    if not (G and G.GAME) then return end
    G.GAME.spectral_rate = G.GAME.spectral_rate + -15
end)

addWYR("Increase Planet Rate by 15", function()
    if not (G and G.GAME) then return end
    G.GAME.planet_rate = G.GAME.planet_rate + 15
end)

addWYR("Decrease Planet Rate by 15", function()
    if not (G and G.GAME) then return end
    G.GAME.planet_rate = G.GAME.planet_rate + -15
end)

addWYR("Increase Tarot Rate by 15", function()
    if not (G and G.GAME) then return end
    G.GAME.tarot_rate = G.GAME.tarot_rate + 15
end)

addWYR("Decrease Tarot Rate by 15", function()
    if not (G and G.GAME) then return end
    G.GAME.tarot_rate = G.GAME.tarot_rate + -15
end)


addWYR("Gain a completely randomized card", function()
	local params = {}
	local possible_sets = {"Joker", "Tarot", "Spectral", "Planet", "mini-joker", "Consumable"}
	params.set = possible_sets[math.random(#possible_sets)]

	params.legendary = (math.random() < 0.05) -- small chance legendary
	params.rarity = params.legendary and 1 or math.random(1, 4)

	if G and G.P_CENTERS and next(G.P_CENTERS) then
		local keys = {}
		for k, _ in pairs(G.P_CENTERS) do table.insert(keys, k) end
		params.key = keys[math.random(#keys)]
	end

	if G and G.jokers and G.jokers.cards then
		params.area = G.jokers
	end

	if SMODS and SMODS.add_card then
		pcall(function()
			SMODS.add_card(params)
		end)
	end
end)

addWYR("Create an entirely random joker deck", function()
	local max_slots = (G and G.GAME and G.GAME.starting_params and G.GAME.starting_params.joker_slots) or 5
	local owned = (G and G.jokers and G.jokers.cards) and #G.jokers.cards or 0
	local slots = math.max(0, max_slots - owned)
	if slots <= 0 then return end

	for i = 1, slots do
		local params = {}
		local possible_sets = {"Joker", "Tarot", "Spectral", "Planet", "mini-joker", "Consumable"}
		params.set = possible_sets[math.random(#possible_sets)]
		params.legendary = (math.random() < 0.05)
		params.rarity = params.legendary and 1 or math.random(0, 4)
		params.skip_materialize = (math.random() < 0.2)
		params.enhanced_poll = math.random()
		if G and G.P_CENTERS and next(G.P_CENTERS) then
			local keys = {}
			for k, _ in pairs(G.P_CENTERS) do table.insert(keys, k) end
			params.key = keys[math.random(#keys)]
		end
		if G and G.jokers and G.jokers.cards then
			params.area = G.jokers
		end
		if math.random() < 0.05 then params.no_edition = true end
		if SMODS and SMODS.add_card then
			pcall(function() SMODS.add_card(params) end)
		end
	end
end)
 



local original_card_click = Card.click
function Card:click()
  if self.config and self.config.center and self.config.center.key == "j_fams_radiation" and
     self.area and self.area == G.jokers then

    play_sound('fams_dogbark', 1, 1)
  end
  if self.config and self.config.center and self.config.center.key == "j_fams_radiationevil" and
     self.area and self.area == G.jokers then

    play_sound('fams_dogbarkevil', 1, 1)
  end
   if self.config and self.config.center and self.config.center.key == "j_fams_spawn" and
     self.area and self.area == G.jokers then
    
    if self.start_dissolve then
		play_sound("fams_death", 1, 1)
        self:start_dissolve({G.C.RED, G.C.RED},true, 1, true)
    else
         self:remove(true)
    end
    return 
  end
  if self.config and self.config.center and self.config.center.key == "j_fams_gayster" and
     self.area and self.area == G.jokers then
    

		play_sound("fams_gasterleave", 1, 1)
		self:start_dissolve({G.C.BLACK, G.C.WHITE},true, 1, true)
		SMODS.add_card{
        			set = "Joker",                
        			legendary = false,            
					key = "j_egg",
        			skip_materialize = false,     
    	}
		
    return 
  end
  
  if original_card_click then
    return original_card_click(self)
  end
end



clearCustomTextAfterDraw = function()
    if G.customtext then
        for id, box in pairs(G.customtext) do
            if box and not box.removed then
                box:remove()
            end
        end
        G.customtext = {}
    end
end


blind_timer_bonus_given = blind_timer_bonus_given or false

create_single_image_ui_node = function(image_path, w, h, scale)
     local atlas = {
        px = w or 32,
        py = h or 32,
        image = love.graphics.newImage(image_path)
    }
     local sprite = Sprite(0, 0, atlas.px, atlas.py, atlas, {x = 0, y = 0})
    if scale then sprite:set_scale(scale) end
    return { n = G.UIT.O, config = { object = sprite } }
end

updateHandAndDiscardsUI = function()
    if G and G.hand_text_area then
         if G.hand_text_area.handname and G.GAME and G.GAME.current_round and G.GAME.current_round.hands_left then
            G.hand_text_area.handname.config.text = "Hands: " .. tostring(G.GAME.current_round.hands_left)
        end
         if G.hand_text_area.discards and G.GAME and G.GAME.current_round and G.GAME.current_round.discards_left then
            G.hand_text_area.discards.config.text = "Discards: " .. tostring(G.GAME.current_round.discards_left)
        end
    end
end

trigger_next_frame = function(func)
    G.E_MANAGER:add_event(Event({
        func = function()
            func()
            return true
        end
    }))
end

 

triggered_antes_music_update2 = triggered_antes_music_update2 or {}
dogtrials_jokers = {
	[2] = "j_fams_earl",
	[4] = "j_fams_yogi",
	[6] = "j_fams_bear",
	[8] = "j_fams_butterdog",
	[10] = "j_fams_radiation"
 }
auto_add_card_timer = auto_add_card_timer or (love.timer.getTime and love.timer.getTime() or os.clock())



flip_all_cards = function(cards)
	if G and G.hand and G.hand.cards then
    for _, card in ipairs(G.hand.cards) do
    if card.flip then
        card:flip()
    end
	end
end
end



current_wyr_idx1 = nil
current_wyr_idx2 = nil
active_wyr_menu = nil

apply_wyr_entry = function(idx)
	local entry = wyrnames[idx]
	if type(entry) == "function" then
		entry()
	end
end

apply_wyr_effect = function(idx)
	local effect = wyreffects[idx]
	if type(effect) == "function" then
		effect()
	end
end

G.FUNCS.print_hello = function(e)
	apply_wyr_effect(current_wyr_idx1)
	if active_wyr_menu and not active_wyr_menu.removed then
		active_wyr_menu:remove()
		active_wyr_menu = nil
	end
end

G.FUNCS.print_world = function(e)
	apply_wyr_effect(current_wyr_idx2)
	if active_wyr_menu and not active_wyr_menu.removed then
		active_wyr_menu:remove()
		active_wyr_menu = nil
	end
end


my_menu_function = function()
	play_sound('cancel', 1, 1)
	local name1 = current_wyr_idx1 and (type(wyrnames[current_wyr_idx1]) == "string" and wyrnames[current_wyr_idx1] or "Option 1") or "Option 1"
	local name2 = current_wyr_idx2 and (type(wyrnames[current_wyr_idx2]) == "string" and wyrnames[current_wyr_idx2] or "Option 2") or "Option 2"
	return {
		n = G.UIT.ROOT,
		config = {align = "cm", r = 1, minw = 40, minh = 20, padding = 1, colour = glass, emboss = 0.05, hover = true, shadow = true, juice = true},
		nodes = {

			{n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
				{n = G.UIT.T, config = {text = "Would You Rather", colour = G.C.UI.TEXT_LIGHT, scale = 2}}
			}},
			{n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
				{n = G.UIT.T, config = {text = "selected option is applied to this blind", colour = G.C.attention, scale = 0.5}}
			}},

			{n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {

				{n = G.UIT.C, config = {button = "print_hello", shadow = true, colour = {1, 0.2, 0.2, 1}, r = 1.55, padding = 1, minw = 4, maxw = 4, emboss = 0.6}, nodes = {
					{n = G.UIT.T, config = {text = name1, colour = G.C.UI.TEXT_LIGHT, scale = 0.7}}
				}},

				{n = G.UIT.C, config = {button = "print_world", shadow = true, colour = {0.2, 0.2, 1, 1}, r = 1.55, padding = 1, minw = 4, maxw = 4, emboss = 0.6}, nodes = {
					{n = G.UIT.T, config = {text = name2, colour = G.C.UI.TEXT_LIGHT, scale = 0.7}}
				}}
			}}
		}
	}
end

wyr = function()
	local n = #wyrnames
	if n < 2 then return end
	local idx1 = math.random(1, n)
	local idx2 = idx1
	while idx2 == idx1 do
		idx2 = math.random(1, n)
	end
	current_wyr_idx1 = idx1
	current_wyr_idx2 = idx2
	if active_wyr_menu and not active_wyr_menu.removed then
		active_wyr_menu:remove()
	end
	active_wyr_menu = UIBox({
		definition = my_menu_function(),
		config = {
			align = "cm",
			offset = {x = 0, y = 0},
			major = G.ROOM_ATTACH,
			bond = "Weak",
			instance_type = "ALERT"
		}
	})
	active_wyr_menu:align_to_major()
end


local card_overlay = nil

showUICardOverlay = function(card_table)
     if G.CARD_OVERLAY and not G.CARD_OVERLAY.removed then
        G.CARD_OVERLAY:remove()
    end
     local card_nodes = {}
    for i = 1, 3 do
        local card = card_table[i]
        table.insert(card_nodes, {
            n = G.UIT.O,
            config = {
                object = card,
                padding = 0.1,
                scale = 1.2
            }
        })
    end

    local menu_def = {
        n = G.UIT.ROOT,
        config = {align = "tm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minw = 2, minh = 2.5},
        nodes = {
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.05},
                nodes = {
                    {n = G.UIT.T, config = {text = "Your Cards", scale = 0.8, colour = G.C.WHITE}}
                }
            },
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0.05},
                nodes = card_nodes
            }
        }
    }

    G.CARD_OVERLAY = UIBox {
        definition = menu_def,
        config = { align = "cm", offset = { x = 9.5, y = 0 }, major = G.ROOM_ATTACH, bond = "Weak" }
    }
    G.CARD_OVERLAY:align_to_major()
end





add_joker_by_key = function(joker_key, bool)
    G.E_MANAGER:add_event(Event({
        func = function()
				SMODS.add_card{
                area = G.jokers,
                key = joker_key,
				no_edition = bool
				}
            return true
        end
    }))
end

currentmult = function()
return G.GAME.current_round.current_hand.mult
end

GiftBox = function()
	local events = {
		function()
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_swashbuckler",
        	skip_materialize = false,     -- Skip animation
    		}
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_egg",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_egg",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_blueprint",
        	skip_materialize = false,     -- Skip animation
    		}
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_burglar",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_blueprint",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_hologram",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_blueprint",
        	skip_materialize = false,     -- Skip animation
    		}
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_hologram",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "spectral",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "c_ectoplasm",
        	skip_materialize = false,     -- Skip animation
    		}
			SMODS.add_card{
        	set = "spectral",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "c_ectoplasm",
        	skip_materialize = false,     -- Skip animation
    		}
			SMODS.add_card{
        	set = "spectral",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "c_ectoplasm",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_marble",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_marble",
        	skip_materialize = false,     -- Skip animation
    		}
			SMODS.add_card{
        	set = "joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_stone",
        	skip_materialize = false,     -- Skip animation
    		}
		end,
		function()
			SMODS.add_card{
        	set = "joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_bootstraps",
        	skip_materialize = false,     -- Skip animation
    		}
			SMODS.add_card{
        	set = "joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = false,            -- Legendary rarity (true/false)
			key = "j_golden",
        	skip_materialize = false,     -- Skip animation
    		}
		end
	}
	local idx = math.random(1, #events)
    events[idx]()
end


startingHand = 4
labelset = "???"

is_word_new = function(word, found_words)
	for _, found_word in ipairs(found_words) do
		if found_word == word then
			return false
		end
	end
	return true
end
