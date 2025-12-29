

SMODS.Joker {
	key = 'gaster',
	loc_txt = {
		name = 'the world class scientist of the underground',
		text = {
			'W. D. Gaster'
		}
	},
	config = {},
	rarity = 3,
	cost = 1,
	atlas = 'penny',
	pos = { x = 0, y = 0 },
calculate = function(self, card, context)
	-- Wait until the hand has ended before triggering effect
	if context.end_of_round and context.cardarea == G.jokers and card._gaster_pending then
		G.E_MANAGER:add_event(Event({
			func = function()
				SMODS.add_card{set = 'Joker', key = 'j_egg'}
				if card.remove then card:remove() end
				SMODS.restart_game()
				return true
			end
		}))
		card._gaster_pending = nil
		return {}
	elseif context.joker_main then
		card._gaster_pending = true
		return {}
	end
	return 0
end,
	set_card_type_badge = function(self, card, badges)
		badges[#badges+1] = create_badge("Gaster", {0.5, 0.5, 0.5, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.Challenge {
  key = 'toomuch',
  loc_txt = {
	name = 'It\'s not enough!',
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
	},
	modifiers = {
		{id = "joker_slots", value = 1}
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

SMODS.Atlas {
	key = "m-hand",
	path = "m-hand.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "m-hand",
    set = "mini-joker",
    loc_txt = {
        name = "Raised Hand",
        text = {
            "Adds {C:attention}Single{}"
        }
    },
	loc_vars = function(self, info_queue, card)
        return {  }
    end,
	config = {},
    atlas = "m-hand", 
    cost = 5,
    pools = {
        ["Joker"] = true
    },
    use = function(self, card)
        -- No use effect
    end,
    calculate = function(self, card, context)
		if context.joker_main then
            local lowest = getLowestCardInHand()
			if lowest then
    			return {mult = lowest.base.value}
			end
            
        end
    end,
    can_use = function(self, card)
        return false
    end
}


SMODS.Stake {
	key = 'fams_example',
	applied_stakes = {}, 
	loc_txt = {
		name = 'Steak',
		text = {
			'What do you mean? this is a steak.'
		},
		sticker = {
			name = 'Fams Stake Winner',
			text = {'Win a run with the Fams Stake active.'}
		}
	},
	atlas = 'steak',
	pos = { x = 0, y = 0 },
	sticker_pos = { x = 0, y = 0 },
	unlocked = false,
	colour = {1, 1, 1, 1}, 
	above_stake = nil, 
	modifiers = function(self)

	end
}

SMODS.Consumable {
    key = "basketball",
    set = "Planet",
    loc_txt = {
        name = "Basketball",
        text = {
            "Shoots for the stars!",
            "Upgrades #1#."
        }
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { mostPlayedHand() } }
	end,
    atlas = "basketball", -- Make sure you have a basketball.png in your mod folder or change to an existing atlas
    pos = { x = 0, y = 0 },
    cost = 3,
    config = {},
    use = function(self, card, area, copier)
    return upgrade_most_played_hand()
	end,
    can_use = function(self, card)
		print(mostPlayedHand())
        return true
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Basketball", {1, 0.7, 0.2, 1}, G.C.BLACK, 1.2)
    end
}

SMODS.Atlas {
	key = "m-hand",
	path = "m-hand.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "m-hand",
    set = "mini-joker",
    loc_txt = {
        name = "Raised Hand",
        text = {
            "Adds {C:attention}Single{}"
        }
    },
	loc_vars = function(self, info_queue, card)
        return {  }
    end,
	config = {},
    atlas = "m-hand", 
    cost = 5,
    pools = {
        ["Joker"] = true
    },
    use = function(self, card)
        -- No use effect
    end,
    calculate = function(self, card, context)
		if context.joker_main then
            local lowest = getLowestCardInHand()
			if lowest then
    			return {mult = lowest.base.value}
			end
            
        end
    end,
    can_use = function(self, card)
        return false
    end
}

atlas("twitch", "m-twitch.png", 71, 95)

SMODS.Joker {
	key = 'twitch',
	loc_txt = {
		name = 'Twitch Chat',
		text = {
			'Every hand will do something random'
		}
	},
	config = {},
	rarity = 1,
	cost = 0,
	atlas = 'twitch',
	pos = { x = 0, y = 0 },
	calculate = function(self, card, context)
		if context.joker_main then
			local a = math.random(1, 2)
			if a == 1 then
				return {chips = 50}
			end
			if a == 2 then
				return {money = 10}
			end
		end
	end
}

-- v2 update

SMODS.Blind {
    key = "prison",
	atlas = "prison",
    loc_txt = {
        name = "Jailed Joker",
        text = {"Chips and mult are divided by your money"}
    },
   	boss = { showdown = true },
    dollars = 20,
    mult = 1.5,
    boss_colour = HEX('4f6367'), 
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		hand_chips = hand_chips / GetMoney() > 0 or 1
		mult = mult / GetMoney() > 0 or 1
   	 	return mult, hand_chips, true 
	end,
}

SMODS.Challenge {
  key = 'odd',
  loc_txt = {
	name = "To trigger odd todd. You gotta be odd, remember that twin",
	text = {''}
  },
  jokers = {{id = 'j_odd_todd', eternal = true, negative = false, pinned = false}},
  deck = {
	type = 'Challenge Deck',
	cards = (function()
	  local suits = {'H', 'D', 'C', 'S'}
	  local cards = {}
	  for _, s in ipairs(suits) do
		for i = 1, 1 do
		  table.insert(cards, {r = 3, s = s})
		  table.insert(cards, {r = 5, s = s})
		  table.insert(cards, {r = 7, s = s})
		  table.insert(cards, {r = 9, s = s})
		  table.insert(cards, {r = "A", s = s})
		end
	  end
	  return cards
	end)()
  },
  button_colour = G.C.BLUE,
  rules = {
	custom = {},
	modifiers = {
	  {id = "joker_slots", value = 5},
	  {id = "consumable_slots", value = 3},
	  {id = "hand_size", value = 7},
	  {id = "discards", value = 5},
	  {id = "hands", value = 5},
	  {id = "dollars", value = 5},
	  {id = "reroll_cost", value = 7}
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
  key = 'even',
  loc_txt = {
	name = "To trigger even steven. You gotta be even, remember that twin",
	text = {''}
  },
  jokers = {{id = 'j_even_steven', eternal = true, negative = false, pinned = false}},
  deck = {
	type = 'Challenge Deck',
	cards = (function()
	  local suits = {'H', 'D', 'C', 'S'}
	  local cards = {}
	  for _, s in ipairs(suits) do
		for i = 1, 1 do
		  table.insert(cards, {r = 2, s = s})
		  table.insert(cards, {r = 4, s = s})
		  table.insert(cards, {r = 6, s = s})
		  table.insert(cards, {r = 8, s = s})
		  table.insert(cards, {r = "T", s = s})
		  table.insert(cards, {r = "J", s = s})
		  table.insert(cards, {r = "Q", s = s})
		  table.insert(cards, {r = "K", s = s})
		end
	  end
	  return cards
	end)()
  },
  button_colour = G.C.RED,
  rules = {
	custom = {},
	modifiers = {
	  {id = "joker_slots", value = 6},
	  {id = "consumable_slots", value = 2},
	  {id = "hand_size", value = 8},
	  {id = "discards", value = 4},
	  {id = "hands", value = 4},
	  {id = "dollars", value = 4},
	  {id = "reroll_cost", value = 6}
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