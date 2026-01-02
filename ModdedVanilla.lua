








munching1 = {0, 0, 0.2, 1 }
munching2 = {0.15, 0, 0.4, 1 }
munching3 = {0.4, 0, 0.6, 1 }
munching4 = {0.55, 0, 0.67, 1 }
munching5 = {0.65, 0, 0.86, 1 }
munching6 = {0.8, 0, 0.9, 1 }
munching7 = {0.9, 0, 1, 1 }
Cghost = {0.6, 0.6, 0.6, 0.6 }
glass = {0.6, 0.6, 0.6, 0.3 }
darkglass = {0, 0, 0, 0.3 }
timesignature = {0.902, 0.902, 0.980, 1.0 }

SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "bronze",
    path = "iconb.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "silver",
    path = "iconc.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "gold",
    path = "icon.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "balatro",
    path = "balatro.png",
    px = 450,
    py = 216,
    prefix_config = {
        key = { mod = false },   -- disables mod prefix for 'key'
        atlas = false            -- disables all prefixes for 'atlas'
    }
}

SMODS.Atlas {
    key = "balatro2",
    path = "balatro2.png",
    px = 450,
    py = 216,
    prefix_config = {
        key = { mod = false },   -- disables mod prefix for 'key'
        atlas = false            -- disables all prefixes for 'atlas'
    }
}

SMODS.Atlas {
    key = "balatro3",
    path = "balatro3.png",
    px = 450,
    py = 216,
    prefix_config = {
        key = { mod = false },   -- disables mod prefix for 'key'
        atlas = false            -- disables all prefixes for 'atlas'
    }
}

SMODS.Atlas {
    key = "balatro4",
    path = "balatro4.png",
    px = 450,
    py = 216,
    prefix_config = {
        key = { mod = false },   -- disables mod prefix for 'key'
        atlas = false            -- disables all prefixes for 'atlas'
    }
}

SMODS.Atlas {
    key = "balatro5",
    path = "balatro5.png",
    px = 450,
    py = 216,
    prefix_config = {
        key = { mod = false },   -- disables mod prefix for 'key'
        atlas = false            -- disables all prefixes for 'atlas'
    }
}

SMODS.Atlas {
    key = "balatro6",
    path = "balatro6.png",
    px = 450,
    py = 216,
    prefix_config = {
        key = { mod = false },   -- disables mod prefix for 'key'
        atlas = false            -- disables all prefixes for 'atlas'
    }
}

title_variant = title_variant or 1
title_screen_randomized = false

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

atlas = function(key, path, px, py, disx, disy)
SMODS.Atlas {
    key = key,
    path = path,
    px = px,
    py = py,
	display_size = { w = disx or 71, h = disy or 95 }
}
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
	return G.GAME.stake or 0
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
	if G and G.GAME and (G.GAME.challenge == "c_fams_bomb" or GetStake() == 9) and type(G.GAME.bomb_timer) == "number" and G.GAME.bomb_timer > 0 then
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

SMODS.Atlas {
	key = "quarter",
	path = "quarter.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "stressed",
	path = "stress.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "archive",
	path = "archive.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Atlas {
	key = "fuck",
	path = "fuck.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Atlas {
	key = "cat",
	path = "cat.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "cool",
	path = "cool.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "wyrdeck",
	path = "wyrdeck.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "sdeck",
	path = "sdeck.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "steve",
	path = "steve.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "bob",
	path = "bob.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "joe",
	path = "joe.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "tidywhitey",
	path = "tidywhitey.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "purple",
	path = "purple.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "littleshit",
	path = "littleshit.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "halo",
	path = "halo.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "headstart",
	path = "hs.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "earlybird",
	path = "eb.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "don",
	path = "don.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "katsu",
	path = "katsu.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "rev",
	path = "rev.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "pikoc",
	path = "pikoc.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "mega",
	path = "mega.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "dr",
	path = "dr.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "skullblind",
	path = "skullb.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Atlas {
	key = "pin",
	path = "pin.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Atlas {
	key = "theend",
	path = "theend.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Atlas {
	key = "wyrj",
	path = "wyr.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
    key = "blinddrum",
    path = "blindrhythm.png",
    atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1 
}

SMODS.Atlas {
    key = "greed",
    path = "greed.png",
    atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1 
}

SMODS.Atlas {
    key = "forceful",
    path = "forceful.png",
    atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1 
}

SMODS.Atlas {
    key = "picky",
    path = "picky.png",
    atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1 
}

SMODS.Atlas {
	key = "salmon",
	path = "salmon.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Atlas {
	key = "guesswho",
	path = "guesswho.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Atlas {
	key = "prison",
	path = "prison.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Atlas {
    key = "Dball",
    path = "Dball.png",
    px = 32, 
    py = 32,
}

SMODS.Atlas {
    key = "GB",
    path = "gift.png",
    px = 32, 
    py = 32,
}

SMODS.Atlas {
    key = "cheat",
    path = "cheat.png",
    px = 32, 
    py = 32,
}

SMODS.Atlas {
    key = "up",
    path = "up.png",
    px = 32, 
    py = 32,
}

SMODS.Atlas {
    key = "down",
    path = "down.png",
    px = 32, 
    py = 32,
}

SMODS.Atlas {
    key = "shapeshifter",
    path = "shapeshifter.png",
    px = 32, 
    py = 32,
}


SMODS.Atlas {
    key = "trap",
    path = "trap.png",
    px = 32, 
    py = 32,
}

SMODS.Atlas {
	key = "rank1",
	path = "rank1.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "basketball",
	path = "basketball.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "jenkins",
	path = "jenkins.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "bigboobs",
	path = "bigboobsthecat.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "coke",
	path = "othercola.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "hcrank1",
	path = "hcrank1.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "tobyradiationfox",
	path = "tobiasradiationbronx.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "tonybronxreal",
	path = "tonybronxreal.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "ritz",
	path = "ritz.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "othercola",
	path = "othercola.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "metro",
	path = "metro.png",
	px = 71,
	py = 95
}


SMODS.Sound {
  key = "music_gen",
  pitch = 1,
  path = "music_gennew.ogg",
  select_music_track = function(self)
	musicPower(1.3)
	setBPM(128)
	return 100
  end
}

SMODS.Sound {
  key = "music_spawn",
  pitch = 1,
  path = "music_spawn.ogg",
  select_music_track = function(self)
	if isChallenge("SPAWN") then
	musicPower(1.6)
	setBPM(135)
	return 999
	end
  end
}

SMODS.Sound {
  key = "death",
  pitch = 1,
  volume = 1,
  path = "death.ogg",
}

SMODS.Sound {
  key = "bang",
  pitch = 1,
  volume = 1,
  path = "bang.ogg",
}

SMODS.Sound {
  key = "earleat",
  pitch = 1,
  volume = 1,
  path = "earleatcard.ogg",
}

SMODS.Sound {
  key = "pikmin",
  pitch = 1,
  volume = 0.5,
  path = "pikmin.ogg",
}

SMODS.Sound {
  key = "idiotyellow",
  pitch = 1,
  volume = 0.5,
  path = "pktrip.ogg",
}

SMODS.Sound {
  key = "skull",
  pitch = 1,
  volume = 0.8,
  path = "skull.ogg",
}

SMODS.Sound {
  key = "music_ghost",
  pitch = 1,
  path = "music_dark.ogg",
  select_music_track = function(self)
	if isChallenge("ghost") then
	musicPower(1.3)
	setBPM(100)
	return 999
	end
  end
}

SMODS.Sound {
  key = "music_beat1",
  pitch = 1,
  path = "music_rhythm.ogg",
  select_music_track = function(self)
	if isChallenge("obo") then
	musicPower(1)
	setBPM(60)
	if G.GAME.bpmmax then
		G.GAME.bpmmax = 3
	end
	return 999
	end
  end
}

SMODS.Sound {
  key = "music_beat2",
  pitch = 1,
  path = "music_rhythm2.ogg",
  select_music_track = function(self)
	if isChallenge("tiar") then
	musicPower(1)
	setBPM(72)
	if G.GAME.bpmmax then
		G.GAME.bpmmax = 4
	end
	return 999
	end
  end
}

SMODS.Atlas {
	key = "coolj",
	path = "coolj.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "kitchengun",
	path = "kitchengun.png",
	px = 71,
	py = 95
}

SMODS.Rank {
  key = 'one',
  card_key = '1',
  lc_atlas = "rank1",
  hc_atlas = "hcrank1",
  pos = {x = 0},
  nominal = 1,
  loc_txt = {name = '1'},
  shorthand = '1',
  face = false,
  next = {"2", "Ace"},
  strength_effect = { fixed = 1 },
  straight_edge = true,
}

SMODS.Atlas {
	key = "timestake",
	path = "timestake.png",
	px = 29,
	py = 29
}

SMODS.Atlas {
	key = "nickel",
	path = "nickel.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "dime",
	path = "dime.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "doller",
	path = "dollar.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "penny",
	path = "penny.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "Earl",
	path = "Earl.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "leaf",
	path = "leaf.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "credA",
	path = "credA.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "alexc",
	path = "alexc.png",
	px = 71,
	py = 95
}

SMODS.Sound {
  key = "Don",
  path = "Don.ogg"
}

SMODS.Sound {
  key = "donderfulS",
  path = "donderfulS.ogg"
}

SMODS.Sound {
  key = "Katsu",
  path = "Katsu.ogg"
}

SMODS.Sound {
  key = "dogeat",
  path = "dogeat.ogg"
}

SMODS.Sound {
  key = "gasterleave",
  path = "gasterleave.ogg"
}
SMODS.Sound {
  key = "dogres",
  path = "snd_dogresidue.ogg"
}
SMODS.Sound {
  key = "dogresevil",
  path = "snd_dogresidueevil.ogg"
}
SMODS.Sound {
  key = "dogbark",
  path = "snd_pombark.ogg"
}
SMODS.Sound {
  key = "dogbarkevil",
  path = "snd_pombarkevil.ogg"
}

SMODS.Sound {
  key = "dogsteal",
  pitch = 1,
  volume = 0.5,
  path = "dogsteal.ogg"
}
SMODS.Sound {
  key = "tick1",
  pitch = 1,
  path = "tick.ogg"
}
SMODS.Sound {
  key = "tick2",
  pitch = 0.8,
  path = "tick.ogg"
}




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
 
SMODS.Consumable{
    key = "LeafiC",
    set = "credits", -- or "Planet", "Spectral", or a custom type key
    loc_txt = {
        name = "LeafiDev",
        text = {
            "Main developer of the mod",
            '{C:inactive}"This {C:chips}Lua{} {C:inactive}file is pissing me off"{}'
        },
    },
    atlas = "leaf",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}

SMODS.Consumable{
    key = "AlexC",
    set = "credits", -- or "Planet", "Spectral", or a custom type key
    loc_txt = {
        name = "ObviousAlexC",
        text = {
            "Helped me understand advanced lua code.",
			"{C:inactive}S l e e p y  f e l l a{}"
        }
    },
    atlas = "alexc",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}

atlas("credj", "credj.png", 276, 298)

SMODS.Consumable{
    key = "JynxC",
    set = "credits", -- or "Planet", "Spectral", or a custom type key
    loc_txt = {
        name = "jinkusu_spl",
        text = {
            "Gave the ideas for",
			"Steve, Bob, Joe, Tighty Whitey and Purple",
			"concept for taiko, then remixed into seals.",
            '{C:inactive}"i wonder how many bananas i can fit inside my ass"{}'
        }
    },
    atlas = "credj",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}

SMODS.Consumable{
    key = "PikoC",
    set = "credits", -- or "Planet", "Spectral", or a custom type key
    loc_txt = {
        name = "xpikolaix",
        text = {
            "Gave the ideas for",
			"Halo Rule, Ritz Box, big boobs's mechanic, Stressed Joker, smurf (what the fuck.)",
			"Drew the card for Stressed Joker",
			"also did bug testing {C:munching3}<3{}",
            '{C:inactive}"don\'t touch my man titties"{}'
        }
    },
    atlas = "pikoc",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}


SMODS.Consumable{
    key = "credA",
    set = "credits", -- or "Planet", "Spectral", or a custom type key
    loc_txt = {
        name = "WaffleJolt64",
        text = {
            'Made the Pootis blind',
			'{C:inactive}"Waffle is love, Waffle is life."{}'
        },
    },
    atlas = "credA",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}

SMODS.Consumable{
    key = "EarlC",
    set = "credits", -- or "Planet", "Spectral", or a custom type key
    loc_txt = {
        name = "Earl Joe",
        text = {
            "Was a good boy smiling for his joker sprite!"
        }
    },
    atlas = "Earl",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}

SMODS.Consumable{
    key = "YogiC",
    set = "credits", -- or "Planet", "Spectral", or a custom type key
    loc_txt = {
        name = "Yogi",
        text = {
            "Was ALSO a good boy posing with {C:attention}Bear{} for his joker sprit"
        }
    },
    atlas = "yogi",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}

SMODS.Consumable{
    key = "BearC",
    set = "credits", -- or "Planet", "Spectral", or a custom type key
    loc_txt = {
        name = "Bear",
        text = {
            "Was ALSO ALSO a good boy posing with {C:attention}Yogi{} for his joker sprite"
        }
    },
    atlas = "bear",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}


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
    return -- Don't call original click since we're removing the card
  end
  if self.config and self.config.center and self.config.center.key == "j_fams_gayster" and
     self.area and self.area == G.jokers then
    

		play_sound("fams_gasterleave", 1, 1)
		self:start_dissolve({G.C.BLACK, G.C.WHITE},true, 1, true)
		SMODS.add_card{
        			set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        			legendary = false,            -- Legendary rarity (true/false)
					key = "j_egg",
        			skip_materialize = false,     -- Skip animation
    	}
		
    return -- Don't call original click since we're removing the card
  end
  
  if original_card_click then
    return original_card_click(self)
  end
end

atlas("yogi", "yogi.png", 71, 95)

atlas("bear", "bear.png", 71, 95)

atlas("butterdog", "butterdog.png", 71, 95)



atlas("pedigree", "pedigree.png", 71, 95)



endcheck = false
ritz_round_chips = 0



SMODS.Sound {
  key = "music_jimb",
  pitch = 1,
  path = "music_jimb.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("jimboonly") then
		if not isAnte(8) then
		if not isBoss() then
		setBPM(75)
		return 9999
		end
		setBPM(75)
		return 9999
		end
	end
  end
}

SMODS.Sound {
  key = "music_trial",
  pitch = 1,
  path = "music_trial.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("Dogtrials") then
		setBPM(130)
		musicPower(2)
		return 9999
	end
  end
}

SMODS.Sound {
  key = "music_finale",
  pitch = 1,
  path = "music_finale.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("finale") then
		setBPM(82 * 2)
		musicPower(2)
			if getcurrentBlind() == "bl_fams_theend" then
				superease = superease + ((1 - superease) / 15)
				setrunBG({0.2, 1, 0.4, 1}, {0.1, 0.8, 0.2, 1}, superease)
			else
				 juice_up_all_cards()
			end
			return 9999999999
	end
  end
}

SMODS.Sound {
  key = "music_jimbfinal",
  pitch = 1,
  path = "music_nearend.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("jimboonly") then
		if isAnte(8) then
		if isBoss() then
		setBPM(108)
		return 100000
		end
		end
	end
  end
}

SMODS.Sound {
  key = "music_toomuch",
  pitch = 0.8,
  path = "music_geno.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("toomuch")then
		SetWinningAnte(99)
		musicPower(5)
		setBPM(144)
		return 999999
	end
  end
}

SMODS.Sound {
  key = "music_whatthefuck",
  pitch = 0.7,
  path = "music_wind.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("toomuch") and getAnte() > 8 then
		musicPower(1)
		setBPM(40)
		return 99999999
	end
  end
}

SMODS.Sound {
  key = "music_listen",
  pitch = 1,
  volume = 0.5,
  path = "music_wind.ogg",
  select_music_track = function(self)
	if getcurrentBlind() == "bl_fams_Drum" then
		musicPower(1)
		setBPM(60)
		return 99999999
end
	
	
end
}

SMODS.Sound {
  key = "music_bomb",
  pitch = 1,
  path = "music_bomb.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.facing_blind and isChallenge("bomb") then
		musicPower(2)
		setBPM(180)
		return 99999999
	end
  end
}

SMODS.Sound {
  key = "music_bomblow",
  pitch = 1,
  volume = 1,
  path = "music_bomblow.ogg",
  select_music_track = function(self)
	if G and G.GAME and not G.GAME.facing_blind and isChallenge("bomb") then
		musicPower(1.5)
		setBPM(180)
		return 99999999
	end
  end
}

jimadded = false

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

SMODS.Sound {
  key = "music_update",
  pitch = 0.1,
  volume = 0,
  path = "music_wind.ogg",
  select_music_track = function(self)
	clearCustomTextAfterDraw()
	if G.STATE == G.STATES.WIN then

		if isChallenge("bomb") and not blind_timer_bonus_given and G.GAME and G.GAME.current_round and type(G.GAME.current_round.hands_left) == "number" and G.GAME.current_round.hands_left > 0 then
			update_timer_text()
			blind_timer_bonus_given = true
		end
		removeUItimer()
	else
		blind_timer_bonus_given = false
		if G.STATE ~= G.STATES.MAIN_MENU and (isChallenge("bomb") or isChallenge("finale") or GetStake() == 9) then
			if isChallenge("bomb") then
				showUItimer(30)
			else
				if GetStake() == 9 then
					showUItimer(60)
				else
					showUItimer(600)
				end
				
			end

			if G.GAME and G.GAME.facing_blind and not G.OVERLAY_MENU and G.STATE ~= 4 then
				timer = timer - 0.015
				timeradd = true
			end
			update_timer_text()
		else
			removeUItimer()
		end
	end

	if (G.STATE == 4 or G.STATE == 7 or G.STATE == 1) and not isPlayingBlind() and G.GAME.current_round ~= 0 then
		
	end
	
	if not isPlayingBlind() and timeradd == true then
	if G.STATE ~= 0 and G.STATE ~= 2 and G.STATE ~= 3 then
		if G.GAME and G.GAME.current_round and G.GAME.current_round.hands_left and G.GAME.current_round ~= 0 then
 			if not isChallenge("finale") then
				if G.GAME.current_round.hands_left > 0 then
					addtime(10 * G.GAME.current_round.hands_left)
				else
					addtime(10)
				end
			end
		end
	end
	timeradd = false
end

if isPlayingBlind() then
	
else
	triggeronce = true
end

	if (isChallenge('cor')) and G.hand and G.hand_text_area and G.hand_text_area.ante and G.hand_text_area.ante.config then
		
	end
	
	if G.STATE == 11 then
		if title_variant == 1 then
		setMenuBG({0.85, 0.55, 0.25, 1}, {1, 0.9, 0.5, 1}, {1, 0.7, 0.3, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 2 then
		setMenuBG({0, 0.78, 0, 1}, {0, 0.39, 0, 1}, {1, 0.7, 0.3, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 3 then
		setMenuBG({0.9, 0.9, 0.9, 1}, {0.3, 0.3, 0.3, 1}, {1, 0.7, 0.3, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 4 then
		setMenuBG({2, 0, 0, 1}, {0, 0, 2, 1}, {1, 0.7, 0.3, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 5 then
		setMenuBG({1, 1, 1, 1}, {0, 0, 0, 1}, {1, 0, 0, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 6 then
		setMenuBG({0.8, 0, 0, 1}, {0.023, 0.086, 0.435, 1}, {1, 0, 0, 1}, 0, math.abs(sine(0.6, 1)))
		end
		
		showFloatingText("BPM: " .. tostring(BPM), G.C.WHITE, 0.29, {x = 999999, y = 3.1}, "bpmcounter")
		showFloatingText(tostring(math.ceil(getBPMTick())) .. "/".. getBPMMax(), G.C.WHITE, 999999, {x = 4.55, y = 2.85}, "bpmcounter2")
		showFloatingText("targetting "..targetdisplay.."'s this hand", G.C.WHITE, 0.29, {x = 9999999, y = 3.1}, "targettext")
	end

	if G.STATE < 9 and G.STATE ~= 11 then
		showFloatingText("BPM: " .. tostring(BPM), G.C.WHITE, 0.29, {x = 4.55, y = 3.1}, "bpmcounter")
		showFloatingText(tostring(math.ceil(getBPMTick())) .. "/".. getBPMMax(), G.C.WHITE, 0.29, {x = 4.55, y = 2.85}, "bpmcounter2")
	end

	if (isPlayingBlind() and isBoss() and getcurrentBlind() == "bl_fams_extinct") and G.STATE < 9 and G.STATE ~= 11 then
		if targetdisplay == "fams_one" then
		showFloatingText("targetting 1's this hand", G.C.WHITE, 0.29, {x = 0, y = 3.1}, "targettext")
		elseif  targetdisplay == "nothing" then
		showFloatingText("targetting nothing this hand", G.C.WHITE, 0.29, {x = 0, y = 3.1}, "targettext")
	else
		if (isPlayingBlind() and getcurrentBlind() == "bl_fams_extinct") then
		showFloatingText("targetting "..targetdisplay.."'s this hand", G.C.WHITE, 0.29, {x = 0, y = 3.1}, "targettext")
		else
		showFloatingText("targetting "..targetdisplay.."'s this hand", G.C.WHITE, 0.29, {x = 999999, y = 3.1}, "targettext")
		end
		end
	end

	timerdisplay = timerdisplay + ((timer - timerdisplay) / 10)

	if getcurrentBlind() == "bl_fams_Drum" and tick_once then
		flip_all_cards()
		if (getBPMTick() == 1) then
			play_sound('fams_tick1', 1, 1.1)
		else
			play_sound('fams_tick2', 1, 1)
		end
	end

	if isChallenge("finale") then
		SetWinningAnte(12)
	end

	if isChallenge("choice") and getRoundNumber() ~= 0 then
		SetMoney(0)
	end
	
	if G.jokers and G.jokers.cards then
	for _, joker in ipairs(G.jokers.cards) do
    if joker.label == "j_fams_mus" then
        if tick_once then
            joker:juice_up()
        end
    end
	end
	currentDeck()
	if G.GAME and G.GAME.blind and G.GAME.blind and G.GAME.blind.chips then
	updateBlindChips()
	update_blind_select_UI()
	updateHandAndDiscardsUI()
	end
end
end
}
 

triggered_antes_music_update2 = triggered_antes_music_update2 or {}
 local dogtrials_jokers = {
	[2] = "j_fams_earl",
	[4] = "j_fams_yogi",
	[6] = "j_fams_bear",
	[8] = "j_fams_butterdog",
	[10] = "j_fams_radiation"
 }
auto_add_card_timer = auto_add_card_timer or (love.timer.getTime and love.timer.getTime() or os.clock())

SMODS.Sound {
	key = "music_update2",
	pitch = 0.1,
	volume = 0,
	path = "music_wind.ogg",
	select_music_track = function(self)

		if isChallenge("smol") then
			SetWinningAnte(4)
		end

		if isChallenge("Dogtrials") then
			setrunBG({0.85, 0.55, 0.25, 1}, {1, 0.9, 0.5, 1}, 1)
			SetWinningAnte(10)
		end

		if isChallenge("ghost") then
			setrunBG({0.25, 0.25, 0.25, 1}, {0.45, 0.45, 0.45, 0.45}, 1)
		end

		if isChallenge("SPAWN") and G.STATE ~= 10 then
			setrunBG({0, 0, 0, 1}, {getAnte() / 8, 0, 0, 1}, 1)
		end

		if isChallenge("jimboonly") and G.STATE ~= 10 then
			setrunBG({0.6, 0.2, 0.8, 1}, {0.25, 0.05, 0.3, 1}, 1)
		end

		if isChallenge("court") and G.STATE ~= 10 then
			G.GAME.inflation = G.GAME.inflation + 5
		end

		if isChallenge("tiar") and G.STATE ~= 10 then
   			
		end

		if isChallenge("bstreet") and G.STATE ~= 10 then
			G.GAME.planet_rate = 0
			G.GAME.tarot_rate = 0
			G.GAME.spectral_rate = 0
		end

		if isChallenge("dogtrials") and getAnte() == GetWinningAnte() + 1 then
    if G and G.PROFILES and G.SETTINGS and G.SETTINGS.profile then
        local pr = G.PROFILES[G.SETTINGS.profile]
        if pr then
            pr.fams_dogtrials_completed = true
             if type(set_profile_progress) == "function" then
                pcall(set_profile_progress)
            end
             G.fams_dogtrials_complete = true
        end
    end
	end

		if G.STATE ~= 10 and not isMainMenu() then
			showFloatingText("Bankrupt at: " .. tostring(G.GAME.bankrupt_at), G.C.BLACK, 0.29, {x = -7.09, y = 9.26}, "bank1bg")
			showFloatingText("Bankrupt at: " .. tostring(G.GAME.bankrupt_at), G.C.MONEY, 0.29, {x = -7.09, y = 9.2}, "bank1")
		end

		if isChallenge("SPAWN") and G.STATE ~= 10 then
		local now = (love.timer.getTime and love.timer.getTime() or os.clock())
   		if now - auto_add_card_timer >= 4 / (getAnte() / 4) then
        SMODS.add_card{
            area = G.jokers,
            key = "j_fams_spawn",
            no_edition = true
        }
        auto_add_card_timer = now
    end
		end

		if hasWon() or hasLost() then
			cooked1 = 0
			cooked2 = 0
 			triggered_antes_music_update2 = {}
		end
 		last_checked_ante = last_checked_ante or 0
		local ante = getAnte and getAnte() or (G and G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante) or 0
		if isChallenge("Dogtrials") and ante > 0 and ante ~= last_checked_ante then
			if not triggered_antes_music_update2[ante] then
				local joker_key = dogtrials_jokers[ante]
 				if joker_key and type(joker_key) == "string" and joker_key ~= "" then
					SMODS.add_card{
						area = G.jokers,
						key = joker_key,
						no_edition = true,
					}
				else
 				end
				end
				triggered_antes_music_update2[ante] = true
			else
				
			end
			last_checked_ante = ante
		end
}

flip_all_cards = function(cards)
	if G and G.hand and G.hand.cards then
    for _, card in ipairs(G.hand.cards) do
    if card.flip then
        card:flip()
    end
	end
end
end

SMODS.Challenge {
  key = 'allsix',
  loc_txt = {
	name = "Oops! All 6's (Literally)",
	text = {''}
  },
  jokers = {{id = 'j_oops', eternal = true, negative = false, pinned = true}},
  deck = {
	type = 'Challenge Deck',
	cards = (function()
	  local suits = {'H', 'D', 'C', 'S'}
	  local cards = {}
	  for _, s in ipairs(suits) do
		for i = 1, 6 do
		  table.insert(cards, {r = 6, s = s})
		end
	  end
	  return cards
	end)()
  },
  button_colour = G.C.GREEN,
  rules = {
	custom = {},
	modifiers = {
	  {id = "joker_slots", value = 6},
	  {id = "consumable_slots", value = 6},
	  {id = "hand_size", value = 6},
	  {id = "discards", value = 6},
	  {id = "hands", value = 6},
	  {id = "dollars", value = 6},
	  {id = "reroll_cost", value = 6},
	  {id = "consumable_slots", value = 6},
	}
  },
  restrictions = {
		banned_cards = {
			
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'choose',
  loc_txt = {
	name = 'Joker! I choose you!',
	text = {
	  ''
	}
  },
  
  jokers = {
  },
  deck = {
	type = 'Challenge Deck',

  },
  rules = {
	custom = {
	{id = 'no_shop_jokers'}
	},
	modifiers = {
	}
  },
  button_colour = G.C.CHIPS,
  restrictions = {
	banned_cards = {{id = "p_buffoon_normal_1", type = "booster"}, {id = "p_buffoon_normal_2", type = "booster"}, {id = "p_buffoon_jumbo_1", type = "booster"}, {id = "p_buffoon_mega_1", type = "booster"}, {id = "c_judgement"}, {id = "c_soul"}, {id = "j_riff_raff"}, },
	banned_tags = {{id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {}
  },
  consumeables = {{ id = "c_fams_m-b"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'smol',
  loc_txt = {
	name = "Mini Round",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
		{id = "mini"},
		{id = "no_shop_jokers"}
	},
	modifiers = {
	{id = "joker_slots", value = 0},
	{id = "consumable_slots", value = 5},
	}
  },
  restrictions = {
	banned_cards = {{id = "p_buffoon_normal_1", type = "booster"}, {id = "p_buffoon_normal_2", type = "booster"}, {id = "p_buffoon_jumbo_1", type = "booster"}, {id = "p_buffoon_mega_1", type = "booster"}, {id = "c_judgement"}, {id = "c_soul"}, {id = "j_riff_raff"}, },
	banned_tags = {{id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}, {id = "j_tag_cts", "j_tag_GB"}},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'bigdawg',
  loc_txt = {
	name = 'Munching',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',

  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 20}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = munching1,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'squared',
  loc_txt = {
	name = 'Munching X2',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', eternal = true, edition = "negative"},
	{id = 'j_madness', eternal = true, edition = "negative"}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = munching2,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'cubed',
  loc_txt = {
	name = 'Munching X3',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = munching3,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'quartic',
  loc_txt = {
	name = 'Munching X4',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true},
	{id = 'j_fams_radiation', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40},
	  {id = "hands", value = 6},
	}
  },
  button_colour = munching4,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'sursolid',
  loc_txt = {
	name = 'Munching X5',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_fams_yogi', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true},
	{id = 'j_fams_radiation', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40},
	  {id = "hands", value = 6},
	}
  },
  button_colour = munching5,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'sixthpower',
  loc_txt = {
	name = 'Munching X6',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_fams_yogi', edition = "negative", eternal = true},
	{id = 'j_fams_bear', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true},
	{id = 'j_fams_radiation', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40},
	  {id = "hands", value = 6},
	}
  },
  button_colour = munching6,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'seventhpower',
  loc_txt = {
	name = 'Munching X7',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_fams_yogi', edition = "negative", eternal = true},
	{id = 'j_fams_bear', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true},
	{id = 'j_fams_radiation', edition = "negative", eternal = true},
	{id = 'j_fams_butterdog', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40},
	  {id = "hands", value = 6},
	}
  },
  button_colour = munching7,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'big_money',
  loc_txt = {
	name = 'Small Gains',
	text = {
	  'find dem coins'
	}
  },
  jokers = {
	{id = 'j_fams_doller', eternal = true}
  },
  deck = {
	type = 'Challenge Deck',

  },
  button_colour = G.C.GREEN,
  rules = {
	custom = {
	  {id = 'no_reward'},
	  {id = 'no_extra_hand_money'},
	  {id = 'no_interest'}
	},
	modifiers = {
	  {id = 'dollars', value = 10}
	}
  },
  restrictions = {
	banned_cards = {{id = "j_golden"}, {id = "j_rocket"}, {id = "j_cloud_9"}, {id = "j_ticket"}},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {{id = "v_clearance_sale"}, {id = "v_liquidation"}}
}

SMODS.Challenge {
  key = 'whoopscasino',
  loc_txt = {
	name = "You really suck at the slots don't you",
	text = {
	  'find dem coins'
	}
  },
  jokers = {
	{id = 'j_credit_card', eternal = true}
  },
  deck = {
	type = 'Challenge Deck',

  },
  button_colour = G.C.BLACK,
  rules = {
	custom = {
	  {id = "bruh"}
	},
	modifiers = {
	  {id = 'dollars', value = -50}
	}
  },
  restrictions = {
	banned_cards = {{id = "j_golden"}, {id = "j_rocket"}, {id = "j_cloud_9"}, {id = "j_ticket"}},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {{id = "v_clearance_sale"}, {id = "v_liquidation"}}
}

SMODS.Challenge {
  key = 'bstreet',
  loc_txt = {
	name = 'Balatro Street'
  },
  jokers = {
	
  },
  deck = {
	type = 'Challenge Deck',

  },
  button_colour = G.C.RED,
  rules = {
	custom = {
		{id = "no_tarot"},
		{id = "no_planet"},
		{id = "no_spectral"}
	},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {{ id = "p_arcana_normal_1", type = "booster" }, { id = "p_arcana_normal_2", type = "booster" }, { id = "p_arcana_normal_3", type = "booster" }, { id = "p_arcana_normal_4", type = "booster" },
			{ id = "p_arcana_jumbo_1", type = "booster" }, { id = "p_arcana_jumbo_2", type = "booster" }, { id = "p_arcana_mega_1", type = "booster" }, { id = "p_arcana_mega_2", type = "booster" },
			{ id = "p_celestial_normal_1", type = "booster" }, { id = "p_celestial_normal_2", type = "booster" }, { id = "p_celestial_normal_3", type = "booster" }, { id = "p_celestial_normal_4", type = "booster" },
			{ id = "p_celestial_jumbo_1", type = "booster" }, { id = "p_celestial_jumbo_2", type = "booster" }, { id = "p_celestial_mega_1", type = "booster" }, { id = "p_celestial_mega_2", type = "booster" },
			{ id = "p_spectral_normal_1", type = "booster" }, { id = "p_spectral_normal_2", type = "booster" }, { id = "p_spectral_jumbo_1", type = "booster" }, { id = "p_spectral_mega_1", type = "booster" },},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'HK',
  loc_txt = {
	name = "Hell's Kitchen",
	text = {''}
  },
  jokers = {
	{id = "j_fams_ramsay", eternal = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {
	},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}


SMODS.Challenge {
  key = 'wyrC',
  loc_txt = {
	name = "Red Or Blue?",
	text = {''}
  },
  jokers = {{id = 'j_fams_wouldyourather', edition = "negative", eternal = true},},
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'ghost',
  loc_txt = {
	name = "G-G-G-Ghosts!!!",
	text = {''}
  },
  jokers = {{id = "j_oops", edition = "negative", eternal = true}, {id = "j_oops", edition = "negative", eternal = true}},
  deck = {
	type = 'Challenge Deck',
  },
  button_colour = Cghost,
  rules = {
	custom = {
		
	},
	modifiers = {
	  {id = "joker_slots", value = 1},
	  {id = "consumable_slots", value = 3},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {{ id = "c_fams_m-g"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'bomb',
  loc_txt = {
	name = 'In a Hurry!',
	text = { '' }
  },
  rules = {
	custom = {
		{id = 'timer'},
		{id = 'recspeed'}
	},
	modifiers = {}
},
deck = {
	type = 'Challenge Deck',
  },
  restrictions = {
	banned_cards = {

	},
	banned_tags = {

	},
	banned_other = {

	}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'hpk',
  loc_txt = {
	name = 'Hey! Pikmin',
	text = {
	  'find dem coins'
	}
  },
  jokers = {
	{id = 'j_fams_steve', eternal = true, edition = "negative"},
	{id = 'j_fams_bob', eternal = true, edition = "negative"},
	{id = 'j_fams_joe'},
	{id = 'j_fams_tidywhitey', eternal = true, edition = "negative"},
	{id = 'j_fams_purple', eternal = true, edition = "negative"}
  },
  deck = {
	type = 'Challenge Deck',

  },
  rules = {
	custom = {
	  
	},
	modifiers = {
	
	}
  },
  button_colour = G.C.GREEN,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'BF',
  loc_txt = {
	name = "Black Friday Sale",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {
		{id = "BF1"}
	},
	modifiers = {
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'sh',
  loc_txt = {
	name = "Study Hall",
	text = {''}
  },
  jokers = {{id = "j_fams_pencil", eternal = false}, {id = "j_fams_webster", eternal = false}},
  deck = {
	type = 'Challenge Deck',
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {
		
	},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}


SMODS.Challenge {
  key = 'exam',
  loc_txt = {
	name = "Exam Day",
	text = {''}
  },
  jokers = {{id = "j_fams_pencil", eternal = true}},
  deck = {
	type = 'Challenge Deck',
  },
  button_colour = G.C.RED,
  rules = {
	custom = {
		
	},
	modifiers = {
		{id = "joker_slots", value = 0}
	}
  },
  restrictions = {
	banned_cards = {{id = "c_ectoplasm"}, {id = "v_antimatter"}},
	banned_tags = {{id = "tag_negative"}, {id = "tag_fams_GB"}, {id = "tag_fams_cts"}, {id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {{id = 'bl_final_heart', type = 'blind'}, {id = 'bl_final_leaf', type = 'blind'}}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'Mini-Corp',
  loc_txt = {
	name = "Mini Corp",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
	{id = 'no_reward'},
	{id = 'no_extra_hand_money'},
	{id = 'no_interest'}
	},
	modifiers = {
	  {id = "hands", value = 1},
	  {id = "discards", value = 6},
	  {id = "consumable_slots", value = 6}
	}
  },
  button_colour = G.C.YELLOW,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {{id = "c_fams_m-m"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'taxseason',
  loc_txt = {
	name = 'Tax Season',
	text = { '' }
  },
  deck = {
	type = 'Challenge Deck',
  },
  rules = {
	custom = {
		{id = "tax1"},
		{id = "tax2"},
		{id = "tax3"}
	},
	modifiers = {
		{id = "dollars", value = 20},
	}
},
button_colour = G.C.CHIPS,
  restrictions = {
	banned_cards = {

	},
	banned_tags = {

	},
	banned_other = {

	}
  },
  jokers = {{ id = "j_golden"}},
  consumeables = {{ id = "c_fams_g-tax"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'SPAWN',
  loc_txt = {
	name = "SPAWN",
	text = {''}
  },
  button_colour = G.C.BLACK,
  jokers = {},
  deck = {
	
  },
  rules = {
	custom = {{id = "ohno"}, {id = "ohno3"}, {id = "ohno2"}},
	modifiers = {
	  	{id = "joker_slots", value = 10},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'court',
  loc_txt = {
	name = "Court Room",
	text = {''}
  },
  jokers = {{id = "j_even_steven", eternal = true}, {id = "j_fams_divorce"}, {id = "j_odd_todd", eternal = true}},
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
	
	},
	modifiers = {
	}
  },
  button_colour = G.C.FILTER,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {{ id = "c_fams_g-tax"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'obo',
  loc_txt = {
	name = "One By One",
	text = {''}
  },
  jokers = {
	{id = "j_fams_mus", eternal = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.RED,
  rules = {
	custom = {
		{id = "beat1"}
	},
	modifiers = {
		{id = "joker_slots", value = 3}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'tiar',
  loc_txt = {
	name = "Three in a Row",
	text = {''}
  },
  jokers = {
	{id = "j_fams_mus", eternal = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.RED,
  rules = {
	custom = {
	},
	modifiers = {
		{id = "joker_slots", value = 2}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'edge',
  loc_txt = {
	name = 'Cliff Edge',
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck',
  cards = (function()
	local cards = {}
	table.insert(cards, {r = 2, s = 'S'})
	table.insert(cards, {r = 3, s = 'S'})
	table.insert(cards, {r = 4, s = 'S'})
	table.insert(cards, {r = 5, s = 'S'})
	table.insert(cards, {r = 6, s = 'S'})
	table.insert(cards, {r = 7, s = 'S'})
	table.insert(cards, {r = 8, s = 'S'})
	table.insert(cards, {r = 9, s = 'S'})
	table.insert(cards, {r = "T", s = 'S'})
	table.insert(cards, {r = "J", s = 'S'})
	table.insert(cards, {r = "K", s = 'S'})
	table.insert(cards, {r = "Q", s = 'S'})
	table.insert(cards, {r = "A", s = 'S'})
	return cards
  end)()
  },
  rules = {
	custom = {},
	modifiers = {{id = "hand_size", value = 7},}
  },
  button_colour = G.C.BLACK,
  restrictions = {
	banned_cards = {{id = "p_standard_normal_1", type = "booster"}, {id = "p_standard_normal_2", type = "booster"}, {id = "p_standard_normal_3", type = "booster"}, {id = "p_standard_normal_4", type = "booster"}, {id = "p_standard_jumbo_1", type = "booster"}, {id = "p_standard_jumbo_2", type = "booster"}, {id = "p_standard_mega_1", type = "booster"}, {id = "p_standard_mega_2", type = "booster"}, {id = "v_magic_trick"}, {id = "v_illusion"}, {id = "c_familiar"}, {id = "c_grim"}, {id = "c_incantation"}, {id = "c_familiar"}, {id = "c_cryptid"}, {id = "j_marble"}, {id = "j_certificate"}},
	banned_tags = {
		{id = "tag_standard"}, {id = "tag_fams_CH"},
	},
	banned_other = {
	  {id = "bl_pillar", type = "blind"}
	}
  },
  consumeables = {},
  vouchers = {}
}


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


local picky_hand_types = {
    "Pair", "Two Pair", "Three of a Kind", "Straight", "Flush",
    "Full House", "Four of a Kind", "Straight Flush", "Five of a Kind", "Flush House"
}

SMODS.Blind {
    key = "the_picky",
	atlas = "picky",
    loc_txt = {
        name = "The Picky",
        text = {"play a specified hand type"}
    },
	boss = ({ min = 5 }),
    dollars = 3,
    mult = 1,
	boss_colour = HEX('66005B'),
    set_blind = function(self)
         self.picky_type = picky_hand_types[math.random(#picky_hand_types)]
    end,
    debuff_hand = function(self, cards, hand, handname, check)
         if not self.picky_type then return false end
        return handname ~= self.picky_type
    end,
    get_loc_debuff_text = function(self)
        return "Only "..(self.picky_type).." is allowed!"
    end
}

local picky_suits = {"Hearts", "Diamonds", "Clubs", "Spades"}

SMODS.Blind {
    key = "the_greedy",
	atlas = "greed",
    loc_txt = {
        name = "The Greedy",
        text = {"play a specified suit"}
    },
   boss = ({ min = 4 }),
    dollars = 2,
    mult = 1,
    boss_colour = HEX('B8860B'), 
    set_blind = function(self)

        self.greedy_suit = picky_suits[math.random(#picky_suits)]
    end,
    debuff_hand = function(self, cards, hand, handname, check)
    if not self.greedy_suit then return false end
    for _, card in ipairs(cards) do
        if card.base.suit ~= self.greedy_suit then
            return true 
        end
    end
    return false 
end,
    get_loc_debuff_text = function(self)
        return "Only "..(self.greedy_suit).." cards are allowed!"
    end
}

SMODS.Blind {
    key = "the_forceful",
    atlas = "forceful",
    loc_txt = {
        name = "The Forceful",
        text = {"All cards are debuffed."}
    },
    boss = ({ min = 6 }),
    dollars = 2,
    mult = 0.25,
    boss_colour = HEX('ff6508'),
    recalc_debuff = function(self, card, from_blind)
         if card.config.center.set == "Joker" then
            return false
        end
        return true
    end
}



SMODS.Blind {
    key = "gh",
	atlas = "guesswho",
    loc_txt = {
        name = "Guess Who",
        text = {"all cards and jokers are flipped"}
    },
   boss = ({ min = 7 }),
    dollars = 2,
    mult = 2,
    boss_colour = HEX('c6ff7c'),
	stay_flipped = function(self, area, card)
		return true
	end
}


SMODS.Blind {
    key = "fish2",
	atlas = "salmon",
    loc_txt = {
        name = "The Salmon",
        text = {"all enchanced and sealed cards are debuffed"}
    },
   boss = ({ min = 4 }),
    dollars = 2,
    mult = 1,
    boss_colour = HEX('efb98a'),
	recalc_debuff = function(self, card, from_blind)
		local enhancement = (card.ability.effect ~= "Base" or card.seal) and not (card.config and card.config.center and card.config.center.set == "Joker")
		if enhancement then
    		return true -- Debuff all playing cards, including all enhancements
		end
			return false

    end
}

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

local selcardsuit = {"H", "D", "C", "S"}
local selcardrank = {"fams_one", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"}
SMODS.Blind {
    key = "extinct",
	atlas = "skullblind",
    loc_txt = {
        name = "Extinction",
        text = {"At the end of first hand",
	"destroy targetted rank cards"}
    },
   	boss = { min = 8, showdown = true },
    dollars = 10,
    mult = 2,
    boss_colour = HEX('FFFFFF'), 
    set_blind = function(self)
		self.descard2 = -1000000000
		targetdisplay = "nothing"
    end,
	press_play = function(self)
		extinctcards(self.descard2)
		self.descard2 = selcardrank[math.random(#selcardrank)]
		targetdisplay = self.descard2
	end,
	in_pool = function(self)
		return not isChallenge("Dogtrials")
	end
}

SMODS.Blind {
    key = "needle2",
	atlas = "pin",
    loc_txt = {
        name = "The Pin(head)",
        text = {"Play Only One Hand, 3 Discards"}
    },
   	boss = { showdown = true },
    dollars = 10,
    mult = 1,
    boss_colour = HEX('0c7300'), 
    set_blind = function(self)
		G.GAME.current_round.hands_left = 1
		G.GAME.current_round.discards_left = 3
    end,
	press_play = function(self)
		
	end,
	in_pool = function(self)
		return not isChallenge("Dogtrials")
	end
}

SMODS.Blind {
    key = "bad",
	atlas = "fuck",
    loc_txt = {
        name = "The Fuck You Blind",
        text = {"What a shame for your final boss blind."}
    },
   	boss = { min = 8, showdown = true },
    dollars = 10,
    mult = 69.420,
    boss_colour = HEX('4f6367'), 
    set_blind = function(self)
		
    end,
	press_play = function(self)
		
	end,
	in_pool = function(self)
		return not isChallenge("Dogtrials")
	end
}

SMODS.Voucher {
    key = "headstartv",
    loc_txt = {
        name = "Head Start",
        text = {
            "Every blind starts with {C:blue}+500{} chips."
        }
    },
    atlas = "headstart", -- Use any atlas key you have, or replace with your own
    pos = {x = 0, y = 0},
    cost = 5,
	calculate = function(self, card, context)
		if context.setting_blind and G and G.GAME and G.GAME.chips then
			G.E_MANAGER:add_event(Event({
    		trigger = "ease",
    		delay = 1,
    		ref_table = G.GAME,
    		ref_value = "chips",
    		ease_to = G.GAME.chips + 500,
		}))
		end
	end,
}

SMODS.Voucher {
    key = "earlybirdv",
    loc_txt = {
        name = "Early Bird",
        text = {
            "Every blind starts with {C:blue}+1000{} chips."
        }
    },
    atlas = "earlybird", -- Use any atlas key you have, or replace with your own
    pos = {x = 0, y = 0},
    cost = 5,
	requires = {"v_fams_headstartv"},
	calculate = function(self, card, context)
		if context.setting_blind and G and G.GAME and G.GAME.chips then
			G.E_MANAGER:add_event(Event({
    		trigger = "ease",
    		delay = 1,
    		ref_table = G.GAME,
    		ref_value = "chips",
    		ease_to = 1000,
		}))
		end
	end,
}

SMODS.Voucher {
    key = "rev",
    loc_txt = {
        name = "Revive",
        text = {
            "Running out of hands gives you {C:attention}one extra chance{}",
			"{C:inactive}Works once every round{}"
        }
    },
    atlas = "rev", -- Use any atlas key you have, or replace with your own
    pos = {x = 0, y = 0},
    cost = 50,
	calculate = function(self, card, context)
		if context.setting_blind and G and G.GAME and G.GAME.chips then
			self.triggered = false
		end
		if context.final_scoring_step and handsLeft() < 1 and self.triggered == false then
			self.triggered = true
			G.E_MANAGER:add_event(Event({
    		trigger = "ease",
    		delay = 0.1,
    		ref_table = G.GAME.current_round,
    		ref_value = "hands_left",
    		ease_to = 1,
		}))
		end
	end,
}

SMODS.Voucher {
    key = "dr",
    loc_txt = {
        name = "Dead Ringer",
        text = {
            "Running out of hands gives you {C:attention}4 hands back{}",
			"{C:inactive}Works once every round{}"
        }
    },
    atlas = "dr", -- Use any atlas key you have, or replace with your own
    pos = {x = 0, y = 0},
    cost = 200,
	requires = {"v_fams_rev"},
	calculate = function(self, card, context)
		if context.setting_blind and G and G.GAME and G.GAME.chips then
			self.triggered = false
		end
		if context.final_scoring_step and handsLeft() < 1 and self.triggered == false then
			self.triggered = true
			G.E_MANAGER:add_event(Event({
    		trigger = "ease",
    		delay = 1,
    		ref_table = G.GAME.current_round,
    		ref_value = "hands_left",
    		ease_to = 2,
		}))
		end
	end,
}

atlas("fl", "fl.png", 71, 95)

SMODS.Voucher {
    key = "fl",
    loc_txt = {
        name = "FL STUDIO",
        text = {
            "Increases time signature maximum to 8"
        }
    },
    atlas = "fl", -- Use any atlas key you have, or replace with your own
    pos = {x = 0, y = 0},
    cost = 10,
	redeem = function(self, card)
		G.GAME.bpmmax = 8
	end
}

atlas("piano", "piano.png", 71, 95)

SMODS.Voucher {
    key = "piano",
	requires = {"v_fams_fl"},
    loc_txt = {
        name = "It's just an track for playing poker, No need for it to go hard.",
        text = {
            "Increases time signature maximum to 16"
        }
    },
    atlas = "piano", -- Use any atlas key you have, or replace with your own
    pos = {x = 0, y = 0},
    cost = 20,
	redeem = function(self, card)
		G.GAME.bpmmax = 16
	end
}


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


SMODS.Back {
    key = "wyrdeck",
    loc_txt = {
        name = "Decisive Deck",
        text = {
            "Start each run with",
			"{C:red}Would{} You {C:blue}Rather{}",
			"Joker"
        }
    },
    atlas = "wyrdeck",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    if G and G.GAME then
        G.GAME.dollars = 4
        local jokers = {"j_fams_wouldyourather"}
        for i = 1, #jokers do
            add_joker_by_key(jokers[i], false)
        end
    end
end
}

SMODS.Back {
    key = "sdeck",
    loc_txt = {
        name = "Stressed Deck",
        text = {
            "Start each run with",
            "Stressed Joker"
        }
    },
    atlas = "sdeck",
    pos = {x = 0, y = 0},
    apply = function(self, back)
        if G and G.GAME then
            G.GAME.dollars = 4
             if G.GAME.round_resets then
                G.GAME.round_resets.hands = 3
            end
            local jokers = {"j_fams_stressed"}
            for i = 1, #jokers do
                add_joker_by_key(jokers[i], false)
            end
        end
    end
}

atlas("modeck", "modeck.png", 71, 95)

SMODS.Back {
    key = "modeck",
    loc_txt = {
        name = "Poor as fuck Deck",
        text = {
            "You lost the game of life.",
			"Take this dollar for your struggles."
        }
    },
    atlas = "modeck",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    if G and G.GAME then
        local jokers = {"j_fams_doller"}
        for i = 1, #jokers do
            add_joker_by_key(jokers[i], false)
        end
		G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    G.GAME.inflation = G.GAME.inflation - 4
        			G.GAME.dollars = 0
                    return true
                end
            }))
    end
end
}

atlas("paper", "paper.png", 71, 95)

SMODS.Back {
    key = "paper",
    loc_txt = {
        name = "Paper Deck",
        text = {
            "{C:red}OOOO MATH HOMEWORK!{}"
        }
    },
    atlas = "paper",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    if G and G.GAME then
        local jokers = {"j_fams_ritz", "j_fams_pencil"}
        for i = 1, #jokers do
            add_joker_by_key(jokers[i], false)
        end
		G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    
                    return true
                end
            }))
    end
end
}

atlas("edeck", "edeck.png", 71, 95)

SMODS.Back {
    key = "dogdeck",
    loc_txt = {
        name = "Earl Deck",
        text = {
			"start with {C:attention}20${}",
			"and {C:attention}Earl Joe{}"
        }
    },
    atlas = "edeck",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    if G and G.GAME then
        local jokers = {"j_fams_earl"}
        for i = 1, #jokers do
            add_joker_by_key(jokers[i], false)
        end
		
		G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    SetMoney(20)
                    return true
                end
            }))
		
    end
end
}

SMODS.Stake {
	key = 'timestake',
	prefix_config = {
	applied_stakes = false
    },
	applied_stakes = {
        "stake_white",
        "stake_red",
        "stake_green",
        "stake_black",
        "stake_blue",
        "stake_purple",
        "stake_orange",
        "stake_gold"
    },
	loc_txt = {
		name = 'Time Stake',
		text = {
			'A timer is applied, Starting from 60 seconds',
			'Timer runs during a {C:attention}blind.{}',
			'{C:inactive,S:0.6}Time is restored end of round (15 * hands left).{}'
		},
		sticker = {
			name = 'Time Stake Winner',
			text = {'Win a run with the Time Stake active.'}
		}
	},
	atlas = 'timestake',
	pos = { x = 0, y = 0 },
	sticker_pos = { x = 0, y = 0 },
	unlocked = false,
	colour = {0.69, 0.61, 0.60, 1}, 
	above_stake = 4, 
	modifiers = function(self)

	end
}

atlas("walmart", "walmart.png", 29, 29)

SMODS.Stake {
	key = 'walmert',
	prefix_config = {
	applied_stakes = false
    },
	applied_stakes = {
        "stake_white",
        "stake_red",
        "stake_green",
        "stake_black",
        "stake_blue",
        "stake_purple",
        "stake_orange",
        "stake_gold",
    },
	loc_txt = {
		name = 'Walmart Stake',
		text = {
			"{C:attention}Jokers{} can be {C:money}On Sale{}",
			"{C:inactive}1 in 5 chance to sell automatically{}",
			"{s:0.8,C:inactive}Time Stake not included{}"
		},
		sticker = {
			name = 'Walmart Employee',
			text = {'Haha'}
		}
	},
	atlas = 'walmart',
	pos = { x = 0, y = 0 },
	sticker_pos = { x = 0, y = 0 },
	unlocked = false,
	colour = {0.69, 0.61, 0.60, 1}, 
	above_stake = 4, 
	modifiers = function(self)
	end
}

atlas("poorstake", "poorstake.png", 29, 29)

SMODS.Stake {
	key = 'poor',
	prefix_config = {
	applied_stakes = false
    },
	applied_stakes = {
        "stake_white",
        "stake_red",
        "stake_green",
        "stake_black",
        "stake_blue",
        "stake_purple",
        "stake_orange",
        "stake_gold",
		"stake_fams_walmert"
    },
	loc_txt = {
		name = 'U.S. Economy in 2022',
		text = {
			"So essentially it's just higher {C:attention}Inflation{}",
			"{C:money}-10 Dollars{}",
			"{s:0.8,C:inactive}Time Stake not included{}"
		},
		sticker = {
			name = 'Broke Master',
			text = {'Win a run with U.S. Economy in 2022'}
		}
	},
	atlas = 'poorstake',
	pos = { x = 0, y = 0 },
	sticker_pos = { x = 0, y = 0 },
	unlocked = false,
	colour = {0.50, 0.19, 0.07, 1}, 
	above_stake = nil, 
	modifiers = function(self)
		G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    G.GAME.inflation = 5
    				G.GAME.dollars = -10
                    return true
                end
            }))
	end
}












SMODS.Challenge {
  key = 'tax2',
  loc_txt = {
	name = 'Tax Evasion',
	text = {}
  },
  deck = {
	type = 'Challenge Deck',
  },
  rules = {
	custom = {
		
	},
	modifiers = {
		{id = "dollars", value = 100},
		{id = "consumable_slots", value = 4},
	}
},
  restrictions = {
	banned_cards = {
		
	},
	banned_tags = {

	},
	banned_other = {

	}
  },
  jokers = {},
  consumeables = {{ id = "c_fams_g-tax"}, { id = "c_fams_g-tax"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'jimboonly',
  loc_txt = {
	name = 'Friends until the end',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_joker', eternal = true},
  },
  deck = {
	type = 'Challenge Deck',
  },
  rules = {
	custom = {
		{id = "no_shop_jokers"}
	},
	modifiers = {
		{id = "joker_slots", value = 1}
	}
  },
    button_colour = G.C.PURPLE,
  restrictions = {
	banned_cards = {{id = "c_ectoplasm"}, {id = "v_antimatter"}},
	banned_tags = {{id = "tag_negative"}, {id = "tag_fams_GB"}, {id = "tag_fams_cts"}, {id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {{id = 'bl_final_heart', type = 'blind'}, {id = 'bl_final_leaf', type = 'blind'}}
  },
  consumeables = {},
  vouchers = {{id = "v_planet_merchant"}, {id = "v_planet_tycoon"}}
}

SMODS.Challenge {
  key = 'Dogtrials',
  loc_txt = {
	name = "Dawg Trials",
	text = {''}
  },
  jokers = {
	
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.FILTER,
  rules = {
	custom = {
		{id = "dog_10"},
		{id = "finalenew1"},
		{id = "finalenew2"}
	},
	modifiers = {
		{id = "joker_slots", value = 0},
		{id = "dollars", value = 125},
	}
  },
  restrictions = {
	banned_cards = {{id = "c_ectoplasm"}, {id = "v_antimatter"}},
	banned_tags = {{id = "tag_negative"}, {id = "tag_fams_GB"}, {id = "tag_fams_cts"}, {id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {{id = "v_planet_merchant"}, {id = "v_planet_tycoon"}, {id = "bl_final_vessel", type = "blind"}, {id = "bl_final_heart", type = "blind"}, {id = "bl_final_bell", type = "blind"}, {id = "bl_final_leaf", type = "blind"}, {id = "bl_final_acorn", type = "blind"}}
  },
  consumeables = {},
  vouchers = {}
}







atlas("gernade", "gernade.png", 71, 95)



atlas("ramsay", "ramsay.png", 71, 95)


currentmult = function()
return G.GAME.current_round.current_hand.mult
end

SMODS.Seal {
    key = "cool_seal",
    loc_txt = {
        name = "Cool Certification",
        label = "Cool",
        text = {
            "{C:edition,E:1}This card is cool B){}."
        }
    },
    atlas = "cool",           -- Use your atlas key or default
    pos = { x = 0, y = 0 },    -- Position in the atlas
    badge_colour = HEX('fffb00'),
    config = {cool = true},               -- Any custom config values
    calculate = function(self, card, context)
    end,
}

SMODS.Seal {
    key = "don_seal",
    loc_txt = {
        name = "Don",
        label = "Don",
        text = {"Plays a {C:mult}Don{} and gives {X:mult,C:white}1.2x{} mult",
	"if on the last card of a pattern of 5 of {C:mult}Don's{} and or {C:chips}ka's{}",
	"gives {X:mult,C:white}5x{} mult instead"}
    },
    atlas = "don",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('F04827'),
    config = {},
    calculate = function(self, card, context)
		if context.before and context.cardarea == G.play then
			drums = 0
		end
         if not hasSeal(card, "fams_don_seal") then return end
        if context.main_scoring and context.cardarea == G.play then
			drums = drums + 1
			if drums == 5 then
				drums = 0
				return {message = "Donderful!", colour = G.C.chips, sound = "fams_donderfulS", repetition = 1, xmult = 5}
			end
            return {message = "Don!",  colour = G.C.red, sound = "fams_Don", xmult = 1.2}
        end
    end,
}

SMODS.Seal {
    key = "ka_seal",
    loc_txt = {
        name = "Katsu",
        label = "Katsu",
        text = {
            "Plays a {C:chips}Katsu{} and gives {X:chips,C:white}1.2x{} chips",
	"if on the last card of a pattern of 5 of {C:mult}Don's{} and or {C:chips}ka's{}",
	"gives {X:chips,C:white}5x{} chips instead"
        }
    },
    atlas = "katsu",           -- Use your atlas key or default
    pos = { x = 0, y = 0 },    -- Position in the atlas
    badge_colour = HEX('5dc0bc'),
    config = {},               -- Any custom config values
    calculate = function(self, card, context)
		if context.before and context.cardarea == G.play then
			drums = 0
		end
         if not hasSeal(card, "fams_ka_seal") then return end
        if context.main_scoring and context.cardarea == G.play then
			drums = drums + 1
			if drums == 5 then
				drums = 0
				return {message = "Donderful!", colour = G.C.chips, sound = "fams_donderfulS", repetition = 1, chips = G.GAME.current_round.current_hand.chips * 5}
			end
            return {message = "katsu!", colour = G.C.chips, sound = "fams_Katsu", repetition = 1, chips = G.GAME.current_round.current_hand.chips * 1.2}
        end
    end,
	
}

SMODS.Tag {
    key = "trap",
    loc_txt = {
        name = "Booby Trap",
        text = {
            "{C:red}Kills your run{}"
        }
    },
    atlas = "trap", -- or your custom atlas
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
     min_ante = 1,
     set_ability = function(self, tag)
        
    end,
     in_pool = function(self, args)
        return true -- Always allow
    end,
     apply = function(self, tag, context)
        tag:yep("X", G.C.RED, function()
            ForceLoss()
            return true
        end)
        tag.triggered = true
    end
}

SMODS.Tag {
    key = "cts",
    loc_txt = {
        name = "Shenron! Grant my wish!",
        text = {
            "Gives up to 3 {C:legendary}legendary{} jokers",
			"{C:inactive}Does NOT need room.{}"
        }
    },
    atlas = "Dball",
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        tag.ability.rarity = math.random(0.01, 1.00) -- Change this to any rarity (1-4) you want
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", G.C.PURPLE, function()
			for i = 1, math.random(1, 3) do
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = true,            -- Legendary rarity (true/false)
        	rarity = 1,                -- Direct rarity value (see docs)
        	skip_materialize = false,     -- Skip animation
        	enhanced_poll = 0.5         -- Chance for 'Base' over 'Enhanced'
    		}
		end
            return true
        end)
		tag.triggered = true
	end
}

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
		end
	}
	local idx = math.random(1, #events)
    events[idx]()
end

SMODS.Tag {
    key = "up",
    loc_txt = {
        name = "Confidence",
        text = {
            "{C:attention}Jumps up 3 antes{}"
        }
    },
    atlas = "up", -- or your custom atlas
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
     min_ante = 1,
     set_ability = function(self, tag)
        
    end,
     in_pool = function(self, args)
        return true -- Always allow
    end,
     apply = function(self, tag, context)
        tag:yep("+", G.C.FILTER, function()
            setAnte(getAnte() + 3)
            return true
        end)
        tag.triggered = true
    end
}

SMODS.Tag {
    key = "down",
    loc_txt = {
        name = "Scaredy Cat",
        text = {
            "{C:attention}Jumps down 3 antes{}"
        }
    },
    atlas = "down", -- or your custom atlas
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
     min_ante = 4,
     set_ability = function(self, tag)
        
    end,
     in_pool = function(self, args)
        return true -- Always allow
    end,
     apply = function(self, tag, context)
        tag:yep("-", G.C.RED, function()
            setAnte(getAnte() - 3)
            return true
        end)
        tag.triggered = true
    end
}

SMODS.Tag {
    key = "shapeshifter",
    loc_txt = {
        name = "ShapeShifter",
        text = {
            "Becomes {C:attention}Any Tag{} on activate"
        }
    },
    atlas = "shapeshifter", -- or your custom atlas
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
     min_ante = 4,
     set_ability = function(self, tag)
        
    end,
     in_pool = function(self, args)
        return true -- Always allow
    end,
     apply = function(self, tag, context)
        tag:yep("+", G.C.GREEN, function()
            -- Get all available tags
            local available_tags = {}
            for k, v in pairs(G.P_TAGS) do
                if k ~= 'tag_fams_shapeshifter' then -- Don't create another shapeshifter
                    table.insert(available_tags, k)
                end
            end
            
            -- Create a random tag
            if #available_tags > 0 then
                local random_tag = pseudorandom_element(available_tags, pseudoseed('shapeshifter'))
                add_tag(Tag(random_tag))
            end
            
            return true
        end)
        tag.triggered = true
    end
}

SMODS.Tag {
    key = "GB",
    loc_txt = {
        name = "Gift Box",
        text = {
            "Triggers a random gift.",
			"{C:inactive}does NOT need room.{}"
        }
    },
    atlas = "GB",
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", G.C.GREEN, function()
            GiftBox()
            return true
        end)
		tag.triggered = true
	end
}

SMODS.Tag {
    key = "CH",
    loc_txt = {
        name = "Cheater Tag",
        text = {
            "gives 10 {C:edition}negative{} playing cards."
        }
    },
    atlas = "cheat",
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", G.C.PURPLE, function()
			addCardsRandom(10, "negative")
            return true
        end)
		tag.triggered = true
	end
}



atlas("toegore", "toegore.png", 71, 95)



local startingHand = 4
local labelset = "???"



atlas("divorce", "divorce.png", 1700, 2200)



SMODS.ConsumableType{
    key = "gimmicks",
    primary_colour = {1, 0.5, 0, 1},
    secondary_colour = {1, 0.5, 0, 1},
    loc_txt = {
        name = "gimmicks",
        collection = "gimmicks",
        undiscovered = {
            name = "???",
            text = {"This gimmick has not been discovered yet."},
        },
    },
    collection_rows = {2},
    shop_rate = 0,
}

atlas("spawn", "spawn.png", 71, 95)







atlas("evilfuckingskeletonfromgoogleimages", "evilfuckingskeletonfromgoogleimages.png", 71, 95)



atlas("gayster", "gayster.png", 71, 95)



atlas("webster", "webster.png", 71, 95)



is_word_new = function(word, found_words)
	for _, found_word in ipairs(found_words) do
		if found_word == word then
			return false
		end
	end
	return true
end

atlas("Searl", "Searl.png", 71, 95)


atlas("pencil", "pencil.png", 71, 95)


atlas("g-tax", "g-tax.png", 71, 95)

SMODS.Consumable {
    key = "g-tax",
    set = "gimmicks",
    loc_txt = {
        name = "IRS",
        text = {"Takes 5$ to 15$ on {C:attention}Blind Selected{}",
	"{C:inactive}Applies only to Small and Big blinds.{}"}
    },
    atlas = "g-tax", 
    cost = 0,
    pools = {
        ["gimmicks"] = true
    },
	use = function(self, card)
        
    end,
	calculate = function(self, card, context)
	if context.setting_blind then
		if getcurrentBlind() == "Small Blind" or getcurrentBlind() == "Big Blind" then
			local random = math.random(5, 15)
			card:juice_up()
			if GetMoney() >= random then
				G.GAME.dollars = G.GAME.dollars - random
			else
				G.GAME.dollars = G.GAME.dollars - random
				ForceLoss()
			end
			
		end
	end
	end,

	remove_from_deck = function(self, card, from_debuff)
		ForceLoss()
	end,

	can_use = function(self, card)
    return false
	end,

	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Gimmick", {1, 0.5, 0, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.ConsumableType{
    key = "mini-joker",
    primary_colour = {1, 0.298, 0.251, 1},
    secondary_colour = {0.663, 0.169, 0.137, 1},
    loc_txt = {
        name = "Mini Joker",
        collection = "Mini Joker",
        undiscovered = {
            name = "???",
            text = {"This joker has not been discovered yet."},
        },
    },
    collection_rows = {3, 3},
    shop_rate = 0.9,
}

atlas("dice-1", "dice-1.png", 71, 95)
atlas("dice-2", "dice-2.png", 71, 95)
atlas("dice-3", "dice-3.png", 71, 95)
atlas("dice-4", "dice-4.png", 71, 95)
atlas("dice-5", "dice-5.png", 71, 95)
atlas("dice-6", "dice-6.png", 71, 95)

SMODS.Atlas {
	key = "M-Joker",
	path = "M-Joker.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "m-joker",
    set = "mini-joker",
    loc_txt = {
        name = "Joker",
        text = {"{C:red}+2{} mult"}
    },
    atlas = "M-Joker", 
    cost = 4,
    pools = {
        ["mini-joker"] = true
    },
	use = function(self, card)
        
    end,
	calculate = function(self, card, context)
	if context.joker_main then
		return {mult = 2}
	end
	end,
	can_use = function(self, card)
    return false
	end
}

SMODS.Atlas {
	key = "m-pt",
	path = "m-pt.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "m-pt",
    set = "mini-joker",
    loc_txt = {
        name = "Prime Time",
        text = {
            "Gives the rank's mult for each card",
			"that is a {C:attention}Prime Number{}",
            "{C:inactive}2, 3, 5, 7, Ace{}"
        }
    },
    atlas = "m-pt", 
    cost = 5,
    pools = {
        ["mini-joker"] = true
    },
    use = function(self, card)
     end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
        local value = context.other_card.base and context.other_card.base.value
        if value == "2" or value == "3" or value == "5" or value == "7" then
            local numeric_value = tonumber(value)
            return {mult = numeric_value, card = context.other_card}
        elseif value == "Ace" then
            return {mult = 11, card = context.other_card}
        end
    end
end,
    can_use = function(self, card)
        return false
    end
}

SMODS.Atlas {
	key = "m-planet",
	path = "m-planet.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "tarotmini",
	path = "tarotmini.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "m-tarot",
    set = "mini-joker",
    loc_txt = {
        name = "Carto",
        text = {
            "On {C:attention}Blind Start{}",
			"creates 1 {C:tarot}Tarot card.{}"
        }
    },
	loc_vars = function(self, info_queue, card)
        return {  }
    end,
	config = {},
    atlas = "tarotmini", 
    cost = 5,
    pools = {
        ["mini-joker"] = true
    },
    use = function(self, card)
     end,
    calculate = function(self, card, context)
		if context.setting_blind then
             local planet_keys = {}
            for k, v in pairs(G.P_CENTERS) do
                if v.set == "Tarot" then
                    table.insert(planet_keys, k)
                end
            end
            if #planet_keys > 0 then
                local random_planet = planet_keys[math.random(#planet_keys)]
                SMODS.add_card{
                    set = "tarot",
                    key = random_planet,
                    area = G.consumeables
                }
            end
            return {message = "+"}
        end
    end,
    can_use = function(self, card)
        return false
    end
}

SMODS.Consumable {
    key = "m-planet",
    set = "mini-joker",
    loc_txt = {
        name = "Astro",
        text = {
            "On {C:attention}Blind Start{}",
			"creates 1 {C:planet}planet card.{}"
        }
    },
	loc_vars = function(self, info_queue, card)
        return {  }
    end,
	config = {},
    atlas = "m-planet", 
    cost = 5,
    pools = {
        ["mini-joker"] = true
    },
    use = function(self, card)
     end,
    calculate = function(self, card, context)
		if context.setting_blind then
             local planet_keys = {}
            for k, v in pairs(G.P_CENTERS) do
                if v.set == "Planet" then
                    table.insert(planet_keys, k)
                end
            end
            if #planet_keys > 0 then
                local random_planet = planet_keys[math.random(#planet_keys)]
                SMODS.add_card{
                    set = "Planet",
                    key = random_planet,
                    area = G.consumeables
                }
            end
            return {message = "+"}
        end
    end,
    can_use = function(self, card)
        return false
    end
}

SMODS.Atlas {
	key = "m-burg",
	path = "m-burg.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "m-burg",
    set = "mini-joker",
    loc_txt = {
        name = "Burg",
        text = {
            "when {C:attention}Blind{} is selected",
			"Gain {C:blue}+2{} hands",
			"{C:attention}lose 2 discards{}"
        }
    },
	loc_vars = function(self, info_queue, card)
        return {  }
    end,
	config = {},
    atlas = "m-burg", 
    cost = 5,
    pools = {
        ["mini-joker"] = true
    },
    use = function(self, card)
     end,
    calculate = function(self, card, context)
		if context.setting_blind then
             G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 2
    		G.GAME.current_round.discards_left = G.GAME.current_round.discards_left - 2
			if G.GAME.current_round.discards_left < 0 then
				G.GAME.current_round.discards_left = 0
			end
            return {message = "+2 hands"}
        end
    end,
    can_use = function(self, card)
        return false
    end
}

SMODS.Atlas {
	key = "m-scallywag",
	path = "m-scallywag.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "m-scallywag",
    set = "mini-joker",
    loc_txt = {
        name = "Scallywag",
        text = {
            "adds half the sell value of",
			"all other {C:money}Jokers{}",
			"to Mult",
			"{C:inactive}(currently{} {C:red}+#1#{} {C:inactive}Mult){}"
        }
    },
	loc_vars = function(self, info_queue, card)
		return { vars = {(get_total_joker_sell_value() / 2)} }
	end,
    atlas = "m-scallywag", 
    cost = 5,
    pools = {
        ["mini-joker"] = true
    },
    use = function(self, card)
     end,
    calculate = function(self, card, context)
    if context.joker_main then
        local total_sell = 0
        if G and G.jokers and G.jokers.cards then
			
            for _, j in ipairs(G.jokers.cards) do
                if j ~= card and j.sell_cost then
                    total_sell = total_sell + (type(j.sell_cost) == "function" and j:sell_cost() or j.sell_cost)
                end
            end
        end
        return {mult = total_sell / 2}
    end
end,
    can_use = function(self, card)
        return false
    end
}

rollglobal = 6

SMODS.Consumable {
    key = "m-dice",
    set = "mini-joker",
    loc_txt = {
        name = "Dice",
        text = {"Rolls the dice",
	"{C:red}#1#X to 6X{} Mult based on roll."}
    },
    atlas = "dice-6", 
    cost = 4,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { currentprobability() } }
	end,
	use = function(self, card)
        
    end,
	calculate = function(self, card, context)
	
	if context.joker_main then
		rollglobal = math.random(currentprobability(), 6)
		card:juice_up()
		if rollglobal > 6 then
			rollglobal = 6
		end
		return {xmult = rollglobal}
	end
	end,

	can_use = function(self, card)
    return false
	end,

	update = function(self, card, dt)
    card.atlas = "dice-" .. tostring(rollglobal)
    if card.set_sprites then card:set_sprites() end
end
	
}

atlas("m-coup", "m-coup.png", 71, 95)

SMODS.Consumable {
    key = "m-coupon",
    set = "mini-joker",
    loc_txt = {
        name = "Coupon",
        text = {"Decreases total",
		"{C:money}Rental Rate{} by {C:attention}1{}",
		"{C:inactive}Rental Rate can be negative.{}"}
    },
    atlas = "m-coup", 
    cost = 8,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { G.GAME.rental_rate + 1, G.GAME.rental_rate } }
	end,
	use = function(self, card)
        
    end,
	calculate = function(self, card, context)
	
	end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		G.GAME.rental_rate = G.GAME.rental_rate - 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.GAME.rental_rate = G.GAME.rental_rate + 1
	end,
}

atlas("m-si", "m-si.png", 71, 95)

SMODS.Consumable {
    key = "m-si",
    set = "mini-joker",
    loc_txt = {
        name = "Middle Man",
        text = {"Gain one extra {C:attention}shop slot{},",
		"Subtracts {C:money}3${} from end of round cashout.",
	"{C:inactive}Currently +#1# joker slots{}"}
    },
    atlas = "m-si", 
    cost = 5,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { G.GAME.shop.joker_max - 2 } }
	end,
	use = function(self, card)
        
    end,
	calc_dollar_bonus = function(self, card)
        return -3
    end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		G.GAME.shop.joker_max = G.GAME.shop.joker_max + 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.GAME.shop.joker_max = G.GAME.shop.joker_max - 1
	end,
}

atlas("m-m", "m-m.png", 71, 95)

SMODS.Consumable {
    key = "m-m",
    set = "mini-joker",
    loc_txt = {
        name = "Investor",
        text = {"Gain {C:money}10${} if round is won on",
	"{C:attention}First Hand{}"}
    },
    atlas = "m-m", 
    cost = 10,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { } }
	end,
	use = function(self, card)
        
    end,
	calc_dollar_bonus = function(self, card)
        if G.GAME.current_round.hands_played == 1 then
			return 10
		else
			return 0
		end
    end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		
	end,

	remove_from_deck = function(self, card, from_debuff)
		
	end,
}

atlas("m-c", "m-c.png", 71, 95)

SMODS.Consumable {
    key = "m-c",
    set = "mini-joker",
    loc_txt = {
        name = "WANTED!",
        text = {"All {C:green}numbered chances{} will always be {C:attention}100%{}"}
    },
    atlas = "m-c", 
    cost = 5,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { } }
	end,
	use = function(self, card)
        
    end,
	calc_dollar_bonus = function(self, card)
        
    end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		G.GAME.probabilities.normal = G.GAME.probabilities.normal + 999999
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.GAME.probabilities.normal = G.GAME.probabilities.normal - 999999
	end,
}

atlas("m-b", "m-b.png", 71, 95)

SMODS.Consumable {
    key = "m-b",
    set = "mini-joker",
    loc_txt = {
        name = "Raffle",
        text = {"when {C:attention}Blind{} is selected",
	"create {C:attention}1{} {C:chips}Common{} {C:attention}joker{}.",
	"{C:inactive}(Must Have Room){}"}
    },
    atlas = "m-b", 
    cost = 4,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { } }
	end,
	use = function(self, card)
        
    end,

	calculate = function(self, card, context)
		if context.setting_blind then
		if can_add_jokers(1) then
			SMODS.add_card{
			area = G.jokers,
			set = 'Joker',  
			rarity = 0.7
			}
		end
	end
	end,

	calc_dollar_bonus = function(self, card)
        
    end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		
	end,

	remove_from_deck = function(self, card, from_debuff)
		
	end,
}

atlas("m-g", "m-g.png", 71, 95)

SMODS.Consumable {
    key = "m-g",
    set = "mini-joker",
    loc_txt = {
        name = "Ghoul",
        text = {"when {C:attention}Blind{} is selected",
	"{C:green}#1# in 4{} chance to create a {C:blue}Spectral{} card"}
    },
    atlas = "m-g", 
    cost = 4,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { currentprobability() } }
	end,
	use = function(self, card)
        
    end,

	calculate = function(self, card, context)
		if context.setting_blind then
		if math.random(currentprobability(), 4) >= 4 then
             local spec_keys = {}
            for k, v in pairs(G.P_CENTERS) do
                if v.set == "Spectral" then
                    table.insert(spec_keys, k)
                end
            end
            if #spec_keys > 0 then
                local spec_keys_s = spec_keys[math.random(#spec_keys)]
				card:juice_up()
                SMODS.add_card{
                    set = "Spectral",
                    key = spec_keys_s,
                    area = G.consumeables
                }
            end
		end
		end
	end,

	calc_dollar_bonus = function(self, card)
        
    end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		
	end,

	remove_from_deck = function(self, card, from_debuff)
		
	end,
}

atlas("m-stargrab", "m-stargrab.png", 71, 95)

SMODS.Consumable {
    key = "m-stargrab",
    set = "mini-joker",
    loc_txt = {
        name = "Star Catcher",
        text = {"Planet card rate is increased by 20",
	"{C:inactive}Currently #1#{}"}
    },
    atlas = "m-stargrab", 
    cost = 6,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { G.GAME.planet_rate } }
	end,
	use = function(self, card)
        
    end,
	calc_dollar_bonus = function(self, card)
        
    end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		G.GAME.planet_rate =  G.GAME.planet_rate + 20
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.GAME.planet_rate =  G.GAME.planet_rate - 20
	end,
}

atlas("m-scratch", "m-scratch.png", 71, 95)

SMODS.Consumable {
    key = "m-scratch",
    set = "mini-joker",
    loc_txt = {
        name = "Scribble",
        text = {"{C:attention}+1 joker slot{}",
	"{C:inactive}Currently #1#{}"}
    },
    atlas = "m-scratch", 
    cost = 6,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
    if G and G.jokers and G.jokers.config and G.jokers.config.card_limit then
        return { vars = { G.jokers.config.card_limit } }
    end
    return { vars = { 0 } }
end,
	use = function(self, card)
        
    end,
	calc_dollar_bonus = function(self, card)
        
    end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
	end,
}



atlas("m-robux", "m-robux.png", 71, 95)

SMODS.Consumable {
    key = "m-robux",
    set = "mini-joker",
    loc_txt = {
        name = "A single Robuck",
        text = {"It's a single robuck"}
    },
    atlas = "m-robux", 
    cost = 0.000865,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
    if G and G.jokers and G.jokers.config and G.jokers.config.card_limit then
        return { vars = { G.jokers.config.card_limit } }
    end
    return { vars = { 0 } }
end,
	use = function(self, card)
        
    end,
	calc_dollar_bonus = function(self, card)
        return 0.0125
    end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
		
	end,

	remove_from_deck = function(self, card, from_debuff)
		
	end,
}
 
SMODS.Atlas {
	key = "fatboi",
	path = "fatboi.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "fatboi",
    set = "dawgcards", -- or another set if you prefer
    loc_txt = {
        name = "FAT BOI",
        text = {"Spawns {C:attention}Earl Joe{}"}
    },
    atlas = "fatboi", -- Make sure you have a sprite named 'triangle'
    cost = 8,
	use = function(self, card)
        SMODS.add_card{
						area = G.jokers,
						key = "j_fams_earl",
						no_edition = true,
			}
        return true
    end,
	can_use = function(self, card)
    return true
end
}

SMODS.Atlas {
	key = "yogee",
	path = "yogee.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "yogee",
    set = "dawgcards", -- or another set if you prefer
    loc_txt = {
        name = "YOGEE",
        text = {"Spawns {C:attention}Yogi{}"}
    },
    atlas = "yogee", -- Make sure you have a sprite named 'triangle'
    cost = 8,
	use = function(self, card)
        SMODS.add_card{
						area = G.jokers,
						key = "j_fams_yogi",
						no_edition = true,
			}
        return true
    end,
	can_use = function(self, card)
    return true
end
}

SMODS.Atlas {
	key = "baer",
	path = "baer.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "baer",
    set = "dawgcards", -- or another set if you prefer
    loc_txt = {
        name = "BAER",
        text = {"Spawns {C:attention}Bear{}"}
    },
    atlas = "baer", -- Make sure you have a sprite named 'triangle'
    cost = 8,
	use = function(self, card)
        SMODS.add_card{
						area = G.jokers,
						key = "j_fams_bear",
						no_edition = true,
			}
        return true
    end,
	can_use = function(self, card)
    return true
end
}

SMODS.Atlas {
	key = "toebee",
	path = "toebee.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "toebee",
    set = "dawgcards", -- or another set if you prefer
    loc_txt = {
        name = "TOEBEE",
        text = {"Spawns {C:attention}Toby Radiation Fox{}"}
    },
    atlas = "toebee", -- Make sure you have a sprite named 'triangle'
    cost = 8,
	use = function(self, card)
        SMODS.add_card{
						area = G.jokers,
						key = "j_fams_radiation",
						no_edition = true,
			}
        return true
    end,
	can_use = function(self, card)
    return true
end
}

SMODS.Atlas {
	key = "buttergod",
	path = "buttergod.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "buttergod",
    set = "dawgcards", -- or another set if you prefer
    loc_txt = {
        name = "BETTER GOD",
        text = {"Spawns {C:attention}Butter Dog{}"}
    },
    atlas = "buttergod", -- Make sure you have a sprite named 'triangle'
    cost = 8,
	use = function(self, card)
        SMODS.add_card{
						area = G.jokers,
						key = "j_fams_butterdog",
						no_edition = true,
			}
        return true
    end,
	can_use = function(self, card)
    return true
end
}

SMODS.ConsumableType{
    key = "dawgcards",
    primary_colour = {0.612, 0.224, 0, 1},
    secondary_colour = {0.612, 0.224, 0, 1},
    loc_txt = {
        name = "The Dawgs Of The Cards",
        collection = "The Art Of Dog",
        undiscovered = {
            name = "???",
            text = {"This DAWG has not been discovered yet."},
        },
    },
    collection_rows = {5},
    shop_rate = 0.08,
}

SMODS.ConsumableType{
    key = "geometry",
    primary_colour = {0, 1, 0.2, 1.0},
    secondary_colour = {0, 1, 0.2, 1.0},
    loc_txt = {
        name = "Geometrics",
        collection = "Geometrics",
        undiscovered = {
            name = "???",
            text = {"This shape has not been discovered yet."},
        },
    },
    collection_rows = {3, 3},
    shop_rate = 0.05,
}

SMODS.Atlas {
	key = "dot",
	path = "dot.png",
	px = 71,
	py = 95
}

SMODS.Seal {
    key = "dot",
    loc_txt = {
        name = "Dot",
        label = "Geometry",
        text = {"{X:mult,C:white}+1{} mult."}
    },
    atlas = "dot",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
			return {mult = 1}
        end
    end,
}

SMODS.Atlas {
	key = "doncard",
	path = "doncard.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "doncard",
    set = "Tarot", -- or another set if you prefer
    loc_txt = {
        name = "Don",
        text = {"Adds a {C:red}Don{} to {C:attention}3{} card."}
    },
    atlas = "doncard", -- Make sure you have a sprite named 'triangle'
    cost = 3,
	use = function(self, card)
        setseal_all_selected("don_seal")
        return true
    end,
	can_use = function(self, card)
    return amountselected() <= 3 and amountselected() ~= 0
end
}

SMODS.Atlas {
	key = "doncard",
	path = "doncard.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "doncard",
    set = "Tarot", -- or another set if you prefer
    loc_txt = {
        name = "Don",
        text = {"Adds a {C:red}Don{} to {C:attention}3{} card."}
    },
    atlas = "doncard", -- Make sure you have a sprite named 'triangle'
    cost = 3,
	use = function(self, card)
        setseal_all_selected("don_seal")
        return true
    end,
	can_use = function(self, card)
    return amountselected() <= 3 and amountselected() ~= 0
end
}

SMODS.Atlas {
	key = "katcard",
	path = "katcard.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "katcard",
    set = "Tarot", -- or another set if you prefer
    loc_txt = {
        name = "Katsu",
        text = {"Adds a {C:blue}Katsu{} to {C:attention}5{} cards."}
    },
    atlas = "katcard", -- Make sure you have a sprite named 'triangle'
    cost = 5,
	use = function(self, card)
        setseal_all_selected("ka_seal")
        return true
    end,
	can_use = function(self, card)
    return amountselected() <= 5 and amountselected() ~= 0
end
}

SMODS.Atlas {
	key = "dotcard",
	path = "dotcard.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "dotcard",
    set = "geometry", -- or another set if you prefer
    loc_txt = {
        name = "Dot",
        text = {"Adds a {C:green}Dot{} to {C:attention}1{} card."}
    },
    atlas = "dotcard", -- Make sure you have a sprite named 'triangle'
    cost = 1,
    pools = {
        ["geometry"] = true
    },
	use = function(self, card)
        setseal(getHighlighted(1), "dot")
        return true
    end,
	can_use = function(self, card)
    return amountselected() == 1
end
}

SMODS.Atlas {
	key = "bi",
	path = "bi.png",
	px = 71,
	py = 95
}

SMODS.Seal {
    key = "bilateral",
    loc_txt = {
        name = "bilateral",
        label = "Geometry",
        text = {"{X:mult,C:white}X2{} mult."}
    },
    atlas = "bi",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
			return {xmult = 2}
        end
    end,
}

SMODS.Atlas {
	key = "bicard",
	path = "bicard.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "line",
    set = "geometry", -- or another set if you prefer
    loc_txt = {
        name = "Bilateral",
        text = {"Adds a {C:green}Bilateral{} to {C:attention}1{} card."}
    },
    atlas = "bicard", -- Make sure you have a sprite named 'triangle'
    cost = 2,
    pools = {
        ["geometry"] = true
    },
	use = function(self, card)
        setseal(getHighlighted(1), "bilateral")
        return true
    end,
	can_use = function(self, card)
    return amountselected() == 1
end
}

SMODS.Atlas {
	key = "tri",
	path = "tri.png",
	px = 71,
	py = 95
}

SMODS.Seal {
    key = "tri",
    loc_txt = {
        name = "Trilateral",
        label = "Geometry",
        text = {"{X:mult,C:white}X3{} mult."}
    },
    atlas = "tri",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
			return {xmult = 3}
        end
    end,
}

SMODS.Atlas {
	key = "tricard",
	path = "tricard.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "triangle",
    set = "geometry", -- or another set if you prefer
    loc_txt = {
        name = "Trilateral",
        text = {"Adds a {C:green}Triateral{} to {C:attention}1{} card."}
    },
    atlas = "tricard", -- Make sure you have a sprite named 'triangle'
    cost = 3,
    pools = {
        ["geometry"] = true
    },
	use = function(self, card)
        setseal(getHighlighted(1), "tri")
        return true
    end,
	can_use = function(self, card)
    return amountselected() == 1
end
}
 
SMODS.Atlas {
	key = "quad",
	path = "quad.png",
	px = 71,
	py = 95
}

SMODS.Seal {
    key = "quad",
    loc_txt = {
        name = "Quadrilateral",
        label = "Geometry",
        text = {"{X:mult,C:white}X4{} mult."}
    },
    atlas = "quad",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
         if context.main_scoring and context.cardarea == G.play then
			return {xmult = 4}
        end
    end,
	
}

SMODS.Atlas {
	key = "quadcard",
	path = "quadcard.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "square",
    set = "geometry", -- or another set if you prefer
    loc_txt = {
        name = "Quadrilateral",
        text = {"Adds a {C:green}Quadrilateral{} to {C:attention}1{} card."}
    },
    atlas = "quadcard", -- Make sure you have a sprite named 'triangle'
    cost = 4,
    pools = {
        ["geometry"] = true
    },
    use = function(self, card)
        setseal(getHighlighted(1), "quad")
        return true
    end,
	can_use = function(self, card)
    return amountselected() == 1
end
}
 
SMODS.Atlas {
	key = "pentcard",
	path = "pentcard.png",
	px = 71,
	py = 95
}

SMODS.Seal {
    key = "pent",
    loc_txt = {
        name = "Pentagon",
        label = "Geometry",
        text = {"{X:mult,C:white}X5{} mult."}
    },
    atlas = "pentcard",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
         if context.main_scoring and context.cardarea == G.play then
			return {xmult = 5}
        end
    end,
	
}

SMODS.Atlas {
	key = "pent",
	path = "pent.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "pentcard",
    set = "geometry", -- or another set if you prefer
    loc_txt = {
        name = "Pentagon",
        text = {"Adds a {C:green}Pentagon{} to {C:attention}1{} card."}
    },
    atlas = "pent", -- Make sure you have a sprite named 'triangle'
    cost = 5,
    pools = {
        ["geometry"] = true
    },
    use = function(self, card)
        setseal(getHighlighted(1), "pent")
        return true
    end,
	can_use = function(self, card)
    return amountselected() == 1
end
}
 
SMODS.Atlas {
	key = "hexcard",
	path = "hexcard.png",
	px = 71,
	py = 95
}

SMODS.Seal {
    key = "hex",
    loc_txt = {
        name = "Hexagon",
        label = "Geometry",
        text = {"{X:mult,C:white}X6{} mult."}
    },
    atlas = "hex",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
         if context.main_scoring and context.cardarea == G.play then
			return {xmult = 6}
        end
    end,
	
}

SMODS.Atlas {
	key = "hex",
	path = "hex.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "hexcard",
    set = "geometry", -- or another set if you prefer
    loc_txt = {
        name = "Hexagon",
        text = {"Adds a {C:green}Hexagon{} to {C:attention}1{} card."}
    },
    atlas = "hexcard", -- Make sure you have a sprite named 'triangle'
    cost = 6,
    pools = {
        ["geometry"] = true
    },
    use = function(self, card)
        setseal(getHighlighted(1), "hex")
        return true
    end,
	can_use = function(self, card)
    return amountselected() == 1
end
}



SMODS.Atlas {
	key = "pootis",
	path = "pootis.png",
	atlas_table = "ANIMATION_ATLAS",
	px = 34,
	py = 34,
	frames = 1
}

SMODS.Blind {
    key = "Pootis",
	atlas = "pootis",
    loc_txt = {
        name = "The Pootis",
        text = {"Chips are pushed back each played hand."}
    },
   	boss = { min = 8, showdown = true },
    dollars = 9,
    mult = 2,
    boss_colour = HEX('90C0E0'), 
    set_blind = function(self)
		
    end,
	press_play = function(self)
    G.E_MANAGER:add_event(Event({
    trigger = "ease",
    delay = 2,
    ref_table = G.GAME,
    ref_value = "chips",
    ease_to = G.GAME.chips / 25,
	}))
	end,

	in_pool = function(self)
		return not isChallenge("Dogtrials")
	end
}


SMODS.Atlas {
	key = "EarlBoss",
	path = "dogboss.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 1
}

SMODS.Blind {
    key = "EarlBoss",
    atlas = "EarlBoss",
    loc_txt = {
        name = "The Big Dawg",
        text = {"1 in 4 to eat a joker every hand."}
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal } }
	end,
    boss = { showdown = true },
    dollars = 12,
    mult = 2,
    boss_colour = HEX('5d3918'),
    set_blind = function(self)
     end,

    press_play = function(self, context)
	if math.random(1, 4) == 1 and context and context.post_joker then
    if G.jokers and #G.jokers.cards > 0 then
        local idx = math.random(1, #G.jokers.cards)
        local joker_to_destroy = G.jokers.cards[idx]
        joker_to_destroy:remove(true)
		self:juice_up_blind()
    end
end
end,

    in_pool = function(self)
        return isChallenge("Dogtrials")
    end
}

SMODS.ConsumableType{
    key = "Pikmin",
    primary_colour = {0, 0.7137, 0, 1},
    secondary_colour = {0, 0.7137, 0, 1},
    loc_txt = {
        name = "Pikmin",
        collection = "Pikmin",
        undiscovered = {
            name = "???",
            text = {"This pikmin has not been discovered yet."},
        },
    },
    collection_rows = {5},
    shop_rate = 0.25,
}
 
SMODS.ConsumableType{
    key = "credits",
    primary_colour = {1.0, 0.4, 0.7, 1.0},
    secondary_colour = {1.0, 0.4, 0.7, 1.0},
    loc_txt = {
        name = "Credits",
        collection = "Credits",
        undiscovered = {
            name = "???",
            text = {"This card has not been discovered yet."},
        },
    },
    collection_rows = {4, 4},
    shop_rate = 0,
}
 if CardSleeves then
atlas("desleeve", "desleeve.png", 73, 95)

CardSleeves.Sleeve {
    key = "desleeve",
    atlas = "desleeve",  -- you will need to create an atlas yourself
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Decisive Sleeve",
        text = { "Start each run with",
			"{C:red}Would{} You {C:blue}Rather{}",
			"Joker" }
    },
	apply = function(self, back)
    if G and G.GAME then
        local jokers = {"j_fams_wouldyourather"}
        for i = 1, #jokers do
            add_joker_by_key(jokers[i], false)
        end
    end
end
}

atlas("dogsleeve", "dogsleeve.png", 73, 95)

CardSleeves.Sleeve {
    key = "earlsleeve",
    atlas = "dogsleeve",  -- you will need to create an atlas yourself
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Earl Sleeve",
        text = { "start with {C:attention}20${}",
		"and {C:attention}Earl Joe{}" }
    },
	apply = function(self, back)
    if G and G.GAME then
        G.GAME.dollars = 20
        local jokers = {"j_fams_earl"}
        for i = 1, #jokers do
            add_joker_by_key(jokers[i], false)
        end
    end
end
}

end

atlas("poly", "poly.png", 71, 95)

SMODS.Booster {
    key = "poly",
    loc_txt = {
    name = "Standard Poly Pack",
    group_name = "Poly Pack",
    text = { "Select {C:attention}1{} of {C:attention}3{}",
	"{X:green,C:white}Geometric{} {X:green,C:white}Shapes{}" } 
	},
    atlas = "poly", -- or your custom atlas key
    pos = { x = 0, y = 0 },
	draw_hand = true,
    cost = 4,
    weight = 0.35,
    config = { extra = 3, choose = 1 }, -- 3 cards, choose 1
	create_card = function(self, card, i)
        return { set = "geometry", area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "fams" }
    end
}

atlas("jpoly", "jpoly.png", 71, 95)

SMODS.Booster {
    key = "jpoly",
    loc_txt = {
    name = "Jumbo Poly Pack",
    group_name = "Poly Pack",
    text = { "Select {C:attention}2{} of {C:attention}6{}",
	"{X:green,C:white}Geometric{} {X:green,C:white}Shapes{}" } 
	},
    atlas = "jpoly", -- or your custom atlas key
    pos = { x = 0, y = 0 },
	draw_hand = true,
    cost = 4,
    weight = 0.15,
    config = { extra = 6, choose = 2 }, -- 3 cards, choose 1
    create_card = function(self, card, i)
        return { set = "geometry", area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "fams" }
    end
}

atlas("stupid", "stupid.png", 71, 95)

SMODS.Booster {
    key = "stupid",
    loc_txt = {
    name = "Stupid Pack",
    group_name = "Stupid Pack",
    text = { "Select {C:attention}1{} of {C:attention}3{}",
	"{C:attention}Useless cards.{}" } 
	},
    atlas = "stupid", -- or your custom atlas key
    pos = { x = 0, y = 0 },
	draw_hand = true,
    cost = 0,
    weight = 0.5,
    config = { extra = 5, choose = 3 }, -- 3 cards, choose 1
    create_card = function(self, card, i)
    local allowed_jokers = { "j_fams_bigboobs", "j_fams_halo", "j_fams_spawn", "j_fams_smurf", "j_fams_penny", "j_fams_nickel", "j_fams_dime", "j_fams_quarter", "j_fams_doller" } -- Add your joker keys here
    local joker_key = allowed_jokers[math.random(#allowed_jokers)]
    return {
        set = "Joker",
        key = joker_key,
        area = G.pack_cards,
        skip_materialize = true,
        soulable = false,
        key_append = "fams"
    }
end
}

atlas("minip", "minip.png", 71, 95)

SMODS.Booster {
    key = "minibooster",
    loc_txt = {
    name = "Mini Pack",
    group_name = "Stupid Pack",
    text = { "Select {C:attention}1{} of {C:attention}3{}",
	"{C:attention}Mini Jokers.{}" } 
	},
    atlas = "minip", -- or your custom atlas key
    pos = { x = 0, y = 0 },
	draw_hand = true,
    cost = 2,
    weight = 1,
	select_card = "consumeables",
    config = { extra = 3, choose = 1 }, -- 3 cards, choose 1
    create_card = function(self, card, i)
		local allowed_jokers = {
			"m-joker",
			"m-pt",
			"m-planet",
			"m-burg",
			"m-scallywag",
			"m-dice",
			"m-coupon",
			"m-si",
			"m-m",
			"m-c",
			"m-b",
			"m-g",
			"m-stargrab",
			"m-scratch",
			"m-robux"
		}
    local joker_key = "c_fams_"..tostring(allowed_jokers[math.random(#allowed_jokers)])
	return {
		set = "mini-joker",
		key = joker_key,
		area = G.pack_cards,
		skip_materialize = true,
		soulable = false,
		key_append = "fams"
	}
end
}

atlas("onsale", "sale.png", 71, 95)

SMODS.Sticker{
    key = "sale",
    loc_txt = {
        name = "ON SALE!",
        text = {"{C:green}1 in 10{} to {C:red}sell{} your {C:attention}Joker{} automatically",
				"On {C:attention}hand played{}"},
        label = "ON SALE!"
    },
    atlas = "onsale",
    pos = {x = 0, y = 0},
    badge_colour = {1, 0.5, 0, 1},
    hide_badge = false,
    default_compat = true,
    compat_exceptions = {"e_eternal"},
    sets = {Joker = true},
    rate = 1,
    needs_enable_flag = false,
    calculate = function(self, card, context)
        if context.joker_main and math.random(1, 5) == 1 then
            if card.sell_cost and card.sell_cost > 0 and not card.ability.eternal then
                card:remove(true)
                return {message = "SOLD!", dollars = card.sell_cost, colour = G.C.MONEY}
            end
        end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		if math.random(1, 25) > math.random(1, 25) then
        return center.set == "Joker" and GetStake() == 10
		end
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
}

atlas("EXsale", "EXsale.png", 71, 95)

SMODS.Sticker{
    key = "EXsale",
    loc_txt = {
        name = "BLACK FRIDAY SALE!",
        text = {"{C:green}1 in 5{} to {C:red}sell{} your {C:attention}Joker{} automatically",
				"On {C:attention}hand played{}",
				"{C:inactive}Gain half the sell value{}"},
        label = "BLACK FRIDAY SALE!"
    },
    atlas = "EXsale",
    pos = {x = 0, y = 0},
    badge_colour = {1, 0.5, 0, 1},
    hide_badge = false,
    default_compat = true,
    compat_exceptions = {"e_eternal"},
    sets = {Joker = true},
    rate = 1,
    needs_enable_flag = false,
    calculate = function(self, card, context)
        if context.joker_main and math.random(1, 5) == 1 then
            if card.sell_cost and card.sell_cost > 0 and not card.ability.eternal then
                card:remove(true)
                return {message = "SOLD!", dollars = card.sell_cost / 2, colour = G.C.MONEY}
            end
        end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        return center.set == "Joker" and isChallenge("BF")
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
}


SMODS.Consumable {
    key = "basketball",
    set = "Planet",
    loc_txt = {
        name = "Basketball",
        text = {
            "Level up your most",
            "played {C:attention}poker hand{} thrice",
            "{C:inactive}(Currently {C:attention}#1#{C:inactive}){}"
        }
    },
    atlas = "basketball",
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
    
    loc_vars = function(self, info_queue, card)
        local most_played = mostPlayedHand() or "High Card"
        return { vars = { most_played } }
    end,
    
    can_use = function(self, card)
        return true
    end,
    
    use = function(self, card, area, copier)
        local most_played = mostPlayedHand()
        if most_played then
            -- Level up the most played hand twice
            SMODS.smart_level_up_hand(card, most_played, false, 3)
            return true
        end
        return false
    end
}

assert(SMODS.load_file('src/jokers.lua'))()
-- assert(SMODS.load_file('src/mainmenu.lua'))()