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
    atlas = "creditCards",
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
            "Worked on more than half of the entire refactor lol",
            "redrew the piano voucher, FL studio, Jynx's card sprite",
            "added shine to all boss blinds",
			"{C:inactive}S l e e p y  f e l l a{}"
        }
    },
    atlas = "creditCards",
    pos = {x = 1, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
}

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
    atlas = "creditCards",
    pos = {x = 2, y = 0},
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
    atlas = "creditCards",
    pos = {x = 3, y = 0},
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
    atlas = "creditCards",
    pos = {x = 4, y = 0},
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
	atlas = 'jokers',
	pos = { x = 0, y = 0 },
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
	atlas = 'jokers',
	pos = { x = 1, y = 0 },
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
	atlas = 'jokers',
	pos = { x = 2, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
}



SMODS.Consumable {
    key = "g-tax",
    set = "gimmicks",
    loc_txt = {
        name = "IRS",
        text = {"Takes 5$ to 15$ on {C:attention}Blind Selected{}",
	"{C:inactive}Applies only to Small and Big blinds.{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 0, y = 3 },
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
			if force_number(G.GAME.dollars) >= random then
                return { dollars = -random };
			else
				ForceLoss()
                return { dollars = -random };
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

SMODS.Consumable {
    key = "m-joker",
    set = "mini-joker",
    loc_txt = {
        name = "Joker",
        text = {"{C:red}+2{} mult"}
    },
    atlas = "miniJokers", 
    pos = { x = 0, y = 0 },
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
    atlas = "miniJokers", 
    pos = { x = 1, y = 0 },
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
    atlas = "miniJokers", 
    pos = { x = 2, y = 0 },
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
    atlas = "miniJokers", 
    pos = { x = 3, y = 0 },
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
    atlas = "miniJokers", 
    pos = { x = 4, y = 0 },
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
    atlas = "miniJokers", 
    pos = { x = 0, y = 1 },
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

SMODS.Consumable({
	key = "m-dice",
	set = "mini-joker",
	loc_txt = {
		name = "Dice",
		text = { "Rolls the dice", "{X:mult,C:white}1X{} to {X:mult,C:white}6X{} Mult based on roll." },
	},
    atlas = "dice", 
    pos = { x = 0, y = 0 },
	cost = 4,
	pools = {
		["mini-joker"] = true,
	},
	loc_vars = function()
		return { vars = { currentprobability() } }
	end,
	use = function(self, card) end,
	calculate = function(self, card, context)
        if context.before then
			card.rollAnim = 30;
            card.rolling = true;
            return;
		end

		if context.joker_main then
			card.roll = math.floor(pseudorandom('dice') * 6) + 1;
			card:juice_up()

			return { xmult = card.roll }
        end
	end,

	can_use = function(self, card)
		return false
	end,

    in_pool = function(self)
        return (pseudorandom('dice') < G.GAME.probabilities.normal / 4)
    end,

	update = function(self, card, dt)
        if (card.rolling) then
            card.children.center.sprite_pos = { x = math.floor(card.rollAnim % 6), y = 1 };
			card.rollAnim = card.rollAnim - dt * 12 * math.max(2, G.SPEEDFACTOR);
			card:set_sprites();

            if (card.rollAnim <= 0) then
                card.rolling = false;
                card.children.center.sprite_pos = { x = (card.roll or 1) - 1, y = 0 };
                card:set_sprites();
            end
        end

		if (card.center) then
			kill();
		end
	end,
})

SMODS.Consumable({
	key = "m-dice-evil",
	set = "mini-joker",
	loc_txt = {
		name = "{C:edition, E:1}Evil Dice{}",
		text = { "Rolls the {X:edition, C:white}evil{} {X:edition, C:white}dice{}", "{X:mult,C:white}^1{} to {X:mult,C:white}^6{} of the", "hand's mult based on roll." },
	},
    atlas = "dice", 
    pos = { x = 0, y = 2 },
	cost = 4,
	pools = {
		["mini-joker"] = true,
	},
	loc_vars = function()
		return { vars = { currentprobability() } }
	end,
	use = function(self, card) end,
	calculate = function(self, card, context)
        if context.before then
			card.rollAnim = 30;
            card.rolling = true;
            return;
		end

		if context.joker_main then
			card.roll = math.floor(pseudorandom('dice') * 6) + 1;
			card:juice_up()

            local expoMult = 1;
            for i = 0, card.roll - 1, 1 do 
                expoMult = expoMult * G.GAME.current_round.current_hand.mult;
            end

			return { xmult = expoMult }
        end
	end,

	can_use = function(self, card)
		return false
	end,

	update = function(self, card, dt)
        if (card.rolling) then
            card.children.center.sprite_pos = { x = math.floor(card.rollAnim % 6), y = 3 };
			card.rollAnim = card.rollAnim - dt * 12 * math.max(2, G.SPEEDFACTOR);
			card:set_sprites();

            if (card.rollAnim <= 0) then
                card.rolling = false;
                card.children.center.sprite_pos = { x = (card.roll or 1) - 1, y = 2 };
                card:set_sprites();
            end
        end

		if (card.center) then
			kill();
		end
	end,

    in_pool = function(self)
		return (pseudorandom('dice') < G.GAME.probabilities.normal / 8);
    end
})

SMODS.Consumable {
    key = "m-coupon",
    set = "mini-joker",
    loc_txt = {
        name = "Coupon",
        text = {"Decreases total",
		"{C:money}Rental Rate{} by {C:attention}1{}",
		"{C:inactive}Rental Rate can be negative.{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 1, y = 1 },
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

SMODS.Consumable {
    key = "m-si",
    set = "mini-joker",
    loc_txt = {
        name = "Middle Man",
        text = {"Gain one extra {C:attention}shop slot{},",
		"Subtracts {C:money}3${} from end of round cashout.",
	"{C:inactive}Currently +#1# joker slots{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 2, y = 1 },
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

SMODS.Consumable {
    key = "m-m",
    set = "mini-joker",
    loc_txt = {
        name = "Investor",
        text = {"Gain {C:money}10${} if round is won on",
	"{C:attention}First Hand{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 3, y = 1 },
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

SMODS.Consumable {
    key = "m-c",
    set = "mini-joker",
    loc_txt = {
        name = "WANTED!",
        text = {"All {C:green}numbered chances{} will always be {C:attention}100%{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 4, y = 1 },
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
		G.GAME.probabilities.normal = G.GAME.probabilities.normal + 9999
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.GAME.probabilities.normal = G.GAME.probabilities.normal - 9999
	end,
}

SMODS.Consumable {
    key = "m-tag",
    set = "mini-joker",
    loc_txt = {
        name = "Medium Double Tag",
        text = {"When this joker is used, self destructs and becomes a {C:attention}double tag{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 4, y = 4 },
    cost = 4,
    pools = {
        ["mini-joker"] = true
    },
    use = function(self, card)
        add_tag(Tag("tag_double"))
		SMODS.destroy_cards(card, nil, nil, true)
    end,

	can_use = function(self, card)
    return true
	end
}

SMODS.Consumable {
    key = "m-b",
    set = "mini-joker",
    loc_txt = {
        name = "Raffle",
        text = {"when {C:attention}Blind{} is selected",
	"create {C:attention}1{} {C:chips}Common{} {C:attention}joker{}.",
	"{C:inactive}(Must Have Room){}"}
    },
    atlas = "miniJokers", 
    pos = { x = 0, y = 2 },
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

SMODS.Consumable {
    key = "m-g",
    set = "mini-joker",
    loc_txt = {
        name = "Ghoul",
        text = {"when {C:attention}Blind{} is selected",
	"{C:green}#1# in 4{} chance to create a {C:blue}Spectral{} card"}
    },
    atlas = "miniJokers", 
    pos = { x = 1, y = 2 },
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

SMODS.Consumable {
    key = "m-stargrab",
    set = "mini-joker",
    loc_txt = {
        name = "Star Catcher",
        text = {"Planet card rate is increased by 20",
	"{C:inactive}Currently #1#{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 2, y = 2 },
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

SMODS.Consumable {
    key = "m-scratch",
    set = "mini-joker",
    loc_txt = {
        name = "Scribble",
        text = {"{C:attention}+1 joker slot{}",
	"{C:inactive}Currently #1#{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 3, y = 2 },
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

SMODS.Consumable {
    key = "m-darkface",
    set = "mini-joker",
    loc_txt = {
        name = "Face in the dark",
        text = {"If played card is a {C:attention}face{} card,", "Change the card to a random {C:attention}enhancement.{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 1, y = 3 },
    cost = 4,
    config = { gain = 0 },
    pools = {
        ["mini-joker"] = true
    },

    calculate = function(self, card, context)

    if context.before and not context.blueprint then
            for i = 1, #context.scoring_hand do
                local played_card = context.scoring_hand[i]
                if played_card and played_card.config.center.set == 'Default' and not played_card.config.center.enhancement then
                    G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1 * G.SPEEDFACTOR,
					func = function()
                        -- List of available enhancements
                        local enhancements = {'m_bonus', 'm_mult', 'm_wild', 'm_glass', 'm_steel', 'm_stone', 'm_gold', 'm_lucky', 'm_fams_par'}
                        
                        -- Pick a random enhancement
                        local random_enhancement = enhancements[math.random(#enhancements)]
                        
                        -- Apply the enhancement
                        played_card:set_ability(G.P_CENTERS[random_enhancement])
                        played_card:juice_up()
						return true
					end
					}))
                    
                end
            end
        end

    end,
    
	can_use = function(self, card)
    return false
	end
}

SMODS.Consumable {
    key = "m-table",
    set = "mini-joker",
    loc_txt = {
        name = "table.insert",
        text = {"On {C:attention}Blind Start{},", "Gain 1 random joker,", "destroy your {C:attention}left-most joker.{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 2, y = 5 },
    cost = 4,
    config = {  },
    pools = {
        ["mini-joker"] = true
    },

    calculate = function(self, card, context)
        if context.setting_blind then
        if G.jokers.cards[1] then
        SMODS.destroy_cards(G.jokers.cards[1], nil, nil, true)
        end
        if isChallenge("factory") then
        SMODS.add_card{
        area = G.jokers,
        set = 'Joker', 
        rarity = 0.7,
        stickers = {'fams_locked'}
        }
        else
        SMODS.add_card{
        area = G.jokers,
        set = 'Joker', 
        rarity = 0.7
        }
        end
        
    end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if isChallenge("factory") then
            ForceLoss()
        end
    end,

    in_pool = function(self)
        return not isChallenge("factory")
    end,
    
	can_use = function(self, card)
    return false
	end
}

SMODS.Consumable {
    key = "m-robux",
    set = "mini-joker",
    loc_txt = {
        name = "A single Robuck",
        text = {"It's a single robuck"}
    },
    atlas = "miniJokers", 
    pos = { x = 4, y = 2 },
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

SMODS.Consumable {
    key = "m-cuphead",
    set = "mini-joker",
    loc_txt = {
        name = "Cup",
        text = {"Click this card to check {C:purple,E:1}Parry{} purple cards.", "Parried cards will be destroyed and this card will gain {X:mult,C:white}1X{} mult", "currently {X:mult,C:white}#1#X{}", "{C:red}Clicking has a #3# in 100 to destroy the card{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 0, y = 5 },
    config = { mult = 0 },
    cost = 8,
    pools = {
        ["mini-joker"] = true
    },
	loc_vars = function()
		return { vars = { G.parryreturn or 0, G.hits, G.GAME.probabilities.normal } }
	end,
	use = function(self, card)
        
    end,
	calculate = function(self, card, context)
        if context.setting_blind then
            if isBoss() then
		    local callnum = math.random(1, 5)
		    play_sound("fams_c_announce"..callnum, 1, 1)
            play_sound("fams_c_beginbell", 1, 1)

            attention_text({
                text = "Get Ready!",
                scale = 4, 
                hold = 2,
                backdrop_colour = colour or G.C.BLACK,
                align = card_aligned or "cm",
                major = G.ROOM_ATTACH,
                offset = {x = 0, y = -0.5}
            })

            
                G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 1.8 * G.SPEEDFACTOR,
					func = function()
						play_sound("fams_c_announcego"..callnum, 1, 1)
                        G.ROOM.jiggle = 12
                        attention_text({
                            text = "WALLOP!",
                            scale = 4, 
                            hold = 6,
                            backdrop_colour = colour or G.C.BLACK,
                            align = card_aligned or "cm",
                            major = G.ROOM_ATTACH,
                            offset = {x = 0, y = -0.5}
                        })
                        
						return true
					end
					}))
            end
        end

        if context.end_of_round and context.main_eval then
            play_sound("fams_c_bell", 1, 1)
            if getAnte() == G.GAME.win_ante then
                play_sound("fams_c_win", 1, 1)
                attention_text({
                            text = "KNOCKOUT!",
                            scale = 4, 
                            hold = 6,
                            backdrop_colour = colour or G.C.BLACK,
                            align = card_aligned or "cm",
                            major = G.ROOM_ATTACH,
                            offset = {x = 0, y = -0.5}
                        })
                G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.5 * G.SPEEDFACTOR,
					func = function()
						play_sound("fams_c_winback", 1, 1)
                        play_sound("fams_c_winboom", 1, 1)
                        G.ROOM.jiggle = 12
                        
						return true
					end
					}))
                
            end
        end

        if context.joker_main then
            return { xmult = G.parryreturn }
        end
	end,

	can_use = function(self, card)
    return false
	end,

	add_to_deck = function(self, card, from_debuff)
        local callnum = math.random(1, 5)
		play_sound("fams_c_announce"..callnum, 1, 1)
        G.hits = 0
        G.parryreturn = 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.parryreturn = 1
        G.hits = 0
	end,
}

SMODS.Consumable {
    key = "m-fps",
    set = "mini-joker",
    loc_txt = {
        name = "Runtime",
        text = {"adds mult based on half of your current FPS.", "{C:inactive}Currently{} {C:red}+#1#{} {C:inactive}mult.{}"}
    },
    atlas = "miniJokers", 
    pos = { x = 1, y = 5 },
    cost = 30,
    pools = {
        ["mini-joker"] = true
    },
    config = { fps = math.min(love.timer.getFPS(), 60) },
	loc_vars = function(self, info_queue, card)
    if G and G.jokers and G.jokers.config then
        return { vars = { card.config.fps or 0 } }
    end
    end,

        calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.config.fps or 0
            }
        end
    end,

	can_use = function(self, card)
    return false
	end,

	update = function(self, card, dt)
        card.config.fps = love.timer.getFPS() / 2
	end,
}

SMODS.Consumable {
    key = "fatboi",
    set = "dawgcards",
    loc_txt = {
        name = "FAT BOI",
        text = {"Spawns {C:attention}Earl Joe{}"}
    },
    atlas = "dogArt",
    pos = { x = 0, y = 0 },
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

SMODS.Consumable {
    key = "yogee",
    set = "dawgcards",
    loc_txt = {
        name = "YOGEE",
        text = {"Spawns {C:attention}Yogi{}"}
    },
    atlas = "dogArt",
    pos = { x = 1, y = 0 },
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

SMODS.Consumable {
    key = "baer",
    set = "dawgcards",
    loc_txt = {
        name = "BAER",
        text = {"Spawns {C:attention}Bear{}"}
    },
    atlas = "dogArt",
    pos = { x = 2, y = 0 },
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

SMODS.Consumable {
    key = "toebee",
    set = "dawgcards",
    loc_txt = {
        name = "TOEBEE",
        text = {"Spawns {C:attention}Toby Radiation Fox{}"}
    },
    atlas = "dogArt",
    pos = { x = 3, y = 0 },
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

SMODS.Consumable {
    key = "buttergod",
    set = "dawgcards",
    loc_txt = {
        name = "BETTER GOD",
        text = {"Spawns {C:attention}Butter Dog{}"}
    },
    atlas = "dogArt",
    pos = { x = 4, y = 0 },
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

SMODS.Consumable {
    key = "doncard",
    set = "Tarot",
    loc_txt = {
        name = "Don",
        text = {"Adds a {C:red}Don{} to {C:attention}3{} card."}
    },
    atlas = "tarots",
    pos = { x = 0, y = 0 },
    cost = 3,
	use = function(self, card)
        setseal_all_selected("don_seal")
        return true
    end,
	can_use = function(self, card)
    return amountselected() <= 3 and amountselected() ~= 0
end
}

SMODS.Consumable {
    key = "katcard",
    set = "Tarot", -- or another set if you prefer
    loc_txt = {
        name = "Katsu",
        text = {"Adds a {C:blue}Katsu{} to {C:attention}5{} cards."}
    },
    atlas = "tarots",
    pos = { x = 1, y = 0 },
    cost = 5,
	use = function(self, card)
        setseal_all_selected("ka_seal")
        return true
    end,
	can_use = function(self, card)
    return amountselected() <= 5 and amountselected() ~= 0
end
}

SMODS.Consumable {
    key = "dotcard",
    set = "geometry",
    loc_txt = {
        name = "Dot",
        text = {"Adds a {C:green}Dot{} to {C:attention}1{} card."}
    },
    atlas = "geometrics",
    pos = { x = 0, y = 0 },
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

SMODS.Consumable {
    key = "line",
    set = "geometry",
    loc_txt = {
        name = "Bilateral",
        text = {"Adds a {C:green}Bilateral{} to {C:attention}1{} card."}
    },
    atlas = "geometrics",
    pos = { x = 1, y = 0 },
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

SMODS.Consumable {
    key = "triangle",
    set = "geometry",
    loc_txt = {
        name = "Trilateral",
        text = {"Adds a {C:green}Triateral{} to {C:attention}1{} card."}
    },
    atlas = "geometrics",
    pos = { x = 2, y = 0 },
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

SMODS.Consumable {
    key = "square",
    set = "geometry",
    loc_txt = {
        name = "Quadrilateral",
        text = {"Adds a {C:green}Quadrilateral{} to {C:attention}1{} card."}
    },
    atlas = "geometrics",
    pos = { x = 3, y = 0 },
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


SMODS.Consumable {
    key = "pentcard",
    set = "geometry",
    loc_txt = {
        name = "Pentagon",
        text = {"Adds a {C:green}Pentagon{} to {C:attention}1{} card."}
    },
    atlas = "geometrics",
    pos = { x = 4, y = 0 },
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

SMODS.Consumable {
    key = "hexcard",
    set = "geometry",
    loc_txt = {
        name = "Hexagon",
        text = {"Adds a {C:green}Hexagon{} to {C:attention}1{} card."}
    },
    atlas = "geometrics",
    pos = { x = 5, y = 0 },
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

SMODS.Consumable {
    key = "basketball",
    set = "Planet",
    loc_txt = {
        name = "Basketball",
        text = {
            "level up", "{}most played hand{}", "thrice"
        }
    },
    atlas = "planets",
    soul_rate = 0.005,
    soul_set = 'Planet',
    pos = {x = 0, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = true,
    
    loc_vars = function(self, info_queue, card)
        local most_played = mostPlayedHand() or "High Card"
        return { vars = { most_played} }
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
    end,
}

SMODS.Consumable {
    key = "flushofdog",
    set = "Planet",
    loc_txt = {
        name = "DAWG",
        text = {
            "(lvl.#1#) level up", "{C:attention}Flush Of Dog{}", "{C:red}+2{} Mult", "{C:blue}+50{} Chips"
        }
    },
    atlas = "planets",
    pos = {x = 1, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
    
    loc_vars = function(self, info_queue, card)
        local most_played = G.GAME.hands.fams_flushofdog.level
        return { vars = { most_played } }
    end,
    
    can_use = function(self, card)
        return true
    end,
    
    use = function(self, card, area, copier)
        SMODS.smart_level_up_hand(card, "fams_flushofdog", false, 1)
        return false
    end,
}

SMODS.Consumable {
    key = "flushtwopair",
    set = "Planet",
    loc_txt = {
        name = "Jupanus",
        text = {
            "(lvl.#1#) level up", "{C:attention}Flush Two Pair{}", "{C:red}+2{} Mult", "{C:blue}+35{} Chips"
        }
    },
    atlas = "planets",
    pos = {x = 2, y = 0},
    cost = 3,
    unlocked = true,
    discovered = true,
    
    loc_vars = function(self, info_queue, card)
        local most_played = G.GAME.hands.fams_flushofdog.level
        return { vars = { most_played } }
    end,
    
    can_use = function(self, card)
        return true
    end,
    
    use = function(self, card, area, copier)
        SMODS.smart_level_up_hand(card, "fams_Flush Two Pair", false, 1)
        return false
    end,
}


--[[ SMODS.ConsumableType{
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
} ]]
 
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

SMODS.ConsumableType{
    key = "gimmicks",
    primary_colour = {1, 0.5, 0, 1},
    secondary_colour = {1, 0.5, 0, 1},
    loc_txt = {
        name = "Gimmicks",
        collection = "Gimmicks",
        undiscovered = {
            name = "???",
            text = {"This Gimmick has not been discovered yet."},
        },
    },
    collection_rows = {2},
    shop_rate = 0,
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

SMODS.ConsumableType{
    key = "summon",
    primary_colour = {0.357, 0.478, 0.729, 1.0},
    secondary_colour = {0.357, 0.478, 0.729, 1.0},
    loc_txt = {
        name = "Summons",
        collection = "Summons",
        undiscovered = {
            name = "???",
            text = {"Thy has not discovered this summon"},
        },
    },
    collection_rows = {2, 3},
    shop_rate = 0.15,
}

SMODS.Consumable {
    key = "wu",
    set = "Tarot",
    loc_txt = {
        name = "Long before time had a name,",
        text = {"Ninjago was created by the First Spinjitzu Master, using the Four Weapons of Spinjitzu. The Scythe of Quakes, the Nunchucks of Lightning, the Shurikens of Ice and the Sword of Fire. Weapons so powerful, no one can handle all of their power at once! When he passed away, his two sons swore to protect them, but the oldest was consumed by darkness and wanted to possess them. A battle between brothers broke out, and the oldest was struck down and banished to the Underworld. Peace returned, and the younger brother hid the weapons, but knowing his older brother's relentless ambition for power, he placed a guardian to protect them. And for fear of his own demise, a map for an honest man to hide. That honest man was your father. The older brother is Lord Garmadon, and I... need to find those weapons before he does", "Makes 4 chosen cards change to enhancements in order", "{C:blue}Bonus{}, {C:red}mult{}, glass, stone"}
    },
    atlas = "actualtarots",
    config = { max_highlighted = 4 },
    pos = { x = 0, y = 0 },
    cost = 5,
    use = function(self, card)
        for i = 1, 4 do
            local enhancements = {'m_bonus', 'm_mult', 'm_glass', 'm_stone'}
            G.hand.highlighted[i]:set_ability(G.P_CENTERS[enhancements[i]])
            delay(0.1)
        end
         
    end,
	can_use = function(self, card)
    return amountselected() == 4
end
}

SMODS.Consumable {
    key = "sum-eternal",
    set = "summon",
    loc_txt = {
        name = "Eternal Light",
        text = {"Applies {C:purple}Eternal{} to 1 random joker", "Lose 1 {C:blue}hand{}"}
    },
    atlas = "eternalcandle",
    config = {  },
    pos = { x = 0, y = 0 },
    cost = 5,
    use = function(self, card)
        local random = pseudorandom('sum-eternal') * #G.jokers.cards + 1
        local target = G.jokers.cards[math.floor(random)]
        target:juice_up()
        setEternal(target, true)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
    end,
    update = function(self, card, front)
        card.children.center.sprite_pos = { x = math.ceil(love.timer.getTime() * 8) % 4, y = 0 };
        card:set_sprites();
    end,
	can_use = function(self, card)
    return #G.jokers.cards ~= 0
    end
}

SMODS.Consumable {
    key = "sum-unperish",
    set = "summon",
    loc_txt = {
        name = "Defying Decay",
        text = {"Removes {C:blue}Perishable{} from 1 random {C:blue}Perishable{} joker", "Lose 1 {C:blue}hand{}"}
    },
    atlas = "perishcandle",
    config = {  },
    pos = { x = 0, y = 0 },
    cost = 5,
    use = function(self, card)
        if not (G and G.jokers and G.jokers.cards) then return false end
        local filter = {}
        for i = 1, #G.jokers.cards do
            local j = G.jokers.cards[i]
            if isPerishable(j) then
                table.insert(filter, j)
            end
        end
        if #filter == 0 then return false end
        local idx = math.floor(pseudorandom('sum-unperish') * #filter) + 1
        local target = filter[idx]
        if target then
            if target.juice_up then pcall(target.juice_up, target) end
            setPerishable(target, false)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
            return true
        end
        return false
    end,
    update = function(self, card, front)
        card.children.center.sprite_pos = { x = math.ceil(love.timer.getTime() * 8) % 4, y = 0 };
        card:set_sprites();
    end,
    can_use = function(self, card)
        if not (G and G.jokers and G.jokers.cards and #G.jokers.cards > 0) then return false end
        for _, j in ipairs(G.jokers.cards) do
            if isPerishable(j) then return true end
        end
        return false
    end
}

SMODS.Consumable {
    key = "sum-unrental",
    set = "summon",
    loc_txt = {
        name = "Unlinked Mortgage",
        text = {"Removes {C:money}Rental{} from 1 random {C:money}Rental{} joker", "Lose 1 {C:blue}hand{}"}
    },
    atlas = "rentalcandle",
    config = {  },
    pos = { x = 0, y = 0 },
    cost = 5,
    use = function(self, card)
        if not (G and G.jokers and G.jokers.cards) then return false end
        local filter = {}
        for i = 1, #G.jokers.cards do
            local j = G.jokers.cards[i]
            if isRental(j) then
                table.insert(filter, j)
            end
        end
        if #filter == 0 then return false end
        local idx = math.floor(pseudorandom('sum-unrental') * #filter) + 1
        local target = filter[idx]
        if target then
            if target.juice_up then pcall(target.juice_up, target) end
            setRental(target, false)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
            return true
        end
        return false
    end,
    update = function(self, card, front)
        card.children.center.sprite_pos = { x = math.ceil(love.timer.getTime() * 8) % 4, y = 0 };
        card:set_sprites();
    end,
    can_use = function(self, card)
        if not (G and G.jokers and G.jokers.cards and #G.jokers.cards > 0) then return false end
        for _, j in ipairs(G.jokers.cards) do
            if isRental(j) then return true end
        end
        return false
    end
}

SMODS.Consumable {
    key = "discard-candle",
    set = "summon",
    loc_txt = {
        name = "One man's trash, Another man's treasure",
        text = {"Gain 3 {C:red}Discards{},", "Lose 1 {C:blue}hand{}"}
    },
    atlas = "discardcandle",
    config = {  },
    pos = { x = 0, y = 0 },
    cost = 5,
    use = function(self, card)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 3
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
    end,
    update = function(self, card, front)
        card.children.center.sprite_pos = { x = math.ceil(love.timer.getTime() * 8) % 4, y = 0 };
        card:set_sprites();
    end,
	can_use = function(self, card)
    return true
    end
}

SMODS.Consumable {
    key = "tags-candle",
    set = "summon",
    loc_txt = {
        name = "Medallion of tags",
        text = {"Recieve 3 random tags", "Lose 1 {C:blue}hand{}"}
    },
    atlas = "tagcandle",
    config = {  },
    pos = { x = 0, y = 0 },
    cost = 5,
    use = function(self, card)
        G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.5 * G.SPEEDFACTOR,
					func = function()
						add_tag(Tag("tag_fams_shapeshifter"))
                        add_tag(Tag("tag_fams_shapeshifter"))
                        add_tag(Tag("tag_fams_shapeshifter"))
                        add_tag(Tag("tag_fams_shapeshifter"))
						return true
					end
					}))
    end,
    update = function(self, card, front)
        card.children.center.sprite_pos = { x = math.ceil(love.timer.getTime() * 8) % 4, y = 0 };
        card:set_sprites();
    end,
	can_use = function(self, card)
    return true
    end
}
