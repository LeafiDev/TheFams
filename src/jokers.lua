endcheck = false
ritz_round_chips = 0
jimadded = false


SMODS.Joker {
	key = 'earl',
	loc_txt = {
		name = 'Earl Joe',
		text = {
			"Gives {X:mult,C:white}X0.5{} Mult for every {C:money}1${}. ",
			"Every hand eats {C:attention}half{} or {C:attention}up to 10${}",
			"{C:inactive}Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult{}",
			"{C:inactive}Eats{} {C:money}#2#${} {C:inactive}this hand{}"
		}
	},
	config = { extra = { xmult = 0.5 } },
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 0, y = 0 },
	cost = 8,
loc_vars = function(self, info_queue, card)
	local dollars = G.GAME.dollars or 1
	local to_eat = math.min(math.floor(dollars / 2), 10)
	return { vars = { 0.5 * dollars, to_eat } }
end,
set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
calculate = function(self, card, context)

	   if context.joker_main and not context.blueprint then
		if hasJoker("j_fams_pedigree") then
			return { message = "blocked", colour = G.C.GREEN, xmult = 0.5 * force_number(G.GAME.dollars, 1) }
		else
			return { dollars = calculate_div_dollars(2, 0, 10), xmult = 0.5 * force_number(G.GAME.dollars, 1), message = "Munch", sound = "fams_dogeat" }
		end
	   	end
	   return 0
end
}

SMODS.Joker {
	key = 'yogi',
	loc_txt = {
		name = 'Yogi',
		text = {
			"Gives {X:chips,C:white}X0.5{} chips for every {C:money}1${}. ",
			"Every hand eats {C:attention}half{} or {C:attention}up to 10${}",
			"{C:inactive}Currently{} {X:chips,C:white}X#1#{} {C:inactive}Mult{}",
			"{C:inactive}Eats{} {C:money}#2#${} {C:inactive}this hand{}"
		}
	},
	config = { extra = { xchips = 0.5 } },
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 1, y = 0 },
	cost = 8,
loc_vars = function(self, info_queue, card)
	local dollars = G.GAME.dollars or 1
	local to_eat = math.min(math.floor(dollars / 2), 10)
	return { vars = { 0.5 * dollars, to_eat } }
end,
set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
calculate = function(self, card, context)
	   		if context.joker_main and not context.blueprint then
		if hasJoker("j_fams_pedigree") then
			return { message = "blocked", colour = G.C.GREEN, xmult = 0.5 * force_number(G.GAME.dollars, 1)}
		else
			return { dollars = calculate_div_dollars(2, 0, 10), xchips = 0.5 * force_number(G.GAME.dollars, 1), message = "Munch", sound = "fams_dogeat" }
		end
	   		end
end
}

SMODS.Joker {
	key = 'bear',
	loc_txt = {
		name = 'Bear',
		text = {
			"Gives {C:chips}+5{} chips for every {C:money}1${}. ",
			"Every hand eats {C:attention}half{} or {C:attention}up to 5${}",
			"{C:inactive}Currently{} {C:chips}+#1#{} {C:inactive}chips{}",
			"{C:inactive}Eats{} {C:money}#2#${} {C:inactive}this hand{}"
		}
	},
	config = { extra = { xchips = 0.5 } },
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 2, y = 0 },
	cost = 8,
loc_vars = function(self, info_queue, card)
	local dollars = G.GAME.dollars or 1
	local to_eat = math.min(math.floor(dollars / 2), 5)
	return { vars = { 5 * dollars, to_eat } }
end,
set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
calculate = function(self, card, context)

	   if context.joker_main and not context.blueprint then
		if hasJoker("j_fams_pedigree") then
			return {	message = "blocked", colour = G.C.GREEN, xmult = 0.5 * force_number(G.GAME.dollars, 1)}
		else
			return { dollars = calculate_div_dollars(2, 0, 5), chips = 5 * force_number(G.GAME.dollars, 1), message = "Munch", sound = "fams_dogeat" }
		end
	   	end
	   return 0
end
}

SMODS.Joker {
	key = 'radiation',
	loc_txt = {
		name = 'Toby Radiation Fox',
		text = {
			'You\'re carrying too much dog.',
			'{C:inactive}destroys 5 playing cards{}',
			'{C:red}Runs away{}'
		}
	},
	config = {},
	rarity = 1,
	cost = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
calculate = function(self, card, context)
	   if context.joker_main then

			   removeCards(5)
			
				if card.ability and isEternal(card) then

					return {message = "absorbed", sound = "fams_dogres"}
				else
					card:remove(true)
					return {message = "see ya!", sound = "fams_dogres"}
				end
	   end
end,
	set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
}

SMODS.Joker {
	key = 'butterdog', 
	atlas = 'jokers',
	pos = { x = 4, y = 0 },
	loc_txt = {
		name = 'ButterDog, The dog with da buttah on em', 
		text = {
			"Gains {C:red}+1{} mult for each {C:diamonds}Diamond{} card",
			"{C:attention}Resets at the end of the round{}",
			"{C:inactive}currently +#1# Mult{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.mult or 0 } }
	end,
	config = { mult = 0 }, 
	rarity = 1,
	cost = 0, 

	calculate = function(self, card, context)
 		if context.individual and context.cardarea == G.play then
 			if context.other_card.base.suit == 'Diamonds' then
 				self.config.mult = (self.config.mult or 0) + 1
 				return {
					message = localize('k_upgrade_ex'),
					card = card
				}
			end
		end
 		if context.joker_main then
			if self.config.mult and self.config.mult > 0 then
				return { mult = self.config.mult }
			end
			return {}
		end
 		if context.end_of_round and context.cardarea == G.jokers then
			self.config.mult = 0
			return { message = "Reset" }
		end

		return {}
	end,
	set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
}

SMODS.Joker {
	key = 'pedigree',
	loc_txt = {
		name = 'pedigree',
		text = {
			"Blocks DAWGs from eating your money"
		}
	},
	config = { bitesleft = 0 },
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 5, y = 0 },
	cost = 8,
loc_vars = function(self, info_queue, card)
	bites = self.config.bitesleft
	return { vars = { bites} }
end,
add_to_deck = function(self, card, from_debuff)
	self.config.bitesleft = 5
end,
set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
calculate = function(self, card, context)

	   if context.joker_main then
		if hasJoker("j_fams_Earl") or hasJoker("j_fams_bear") or hasJoker("j_fams_yogi") then
			return { message = "Success", colour = G.C.GREEN }
	   end
	   end
end
}

SMODS.Joker {
	key = 'radiationevil',
	loc_txt = {
		name = 'Tony Bronx',
		text = {
			"He needs to repay",
			"He's been mean >:<"
		}
	},
	config = {},
	rarity = 2,
	cost = 5,
	atlas = 'jokers',
	pos = { x = 6, y = 0 },
calc_dollar_bonus = function(self, card)
		play_sound("fams_dogresevil", 1, 1)
        return 5
    end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("EVIL DAWG", {1, 0, 0, 1}, G.C.WHITE, 1.2)
end,
}

SMODS.Joker {
	key = 'penny',
	loc_txt = {
		name = 'Big Ass Penny',
		text = {
			'Yep, That is a penny alright.'
		}
	},
	config = {},
	rarity = 1,
	cost = 0.05,
	atlas = 'jokers',
	pos = { x = 7, y = 0 },
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			return { dollars = 0.01 }
		end
		return 0
	end,
	set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("Money", {0.5, 0.5, 0.5, 1}, G.C.WHITE, 1.2)
end
}

SMODS.Joker {
	key = 'nickel',
	loc_txt = {
		name = 'Big Ass Nickel',
		text = {
			'Yep, That is a nickel alright.'
		}
	},
	config = {},
	rarity = 1,
	cost = 0,
	atlas = 'jokers',
	pos = { x = 8, y = 0 },
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			return { dollars = 0.05 }
		end
		return 0
	end,
	set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("Money", {0.5, 0.5, 0.5, 1}, G.C.WHITE, 1.2)
end
}

SMODS.Joker {
	key = 'dime',
	loc_txt = {
		name = 'Big Ass Dime',
		text = {
			'Yep, That is a dime alright.'
		}
	},
	config = {},
	rarity = 1,
	cost = 0,
	atlas = 'jokers',
	pos = { x = 9, y = 0 },
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			return { dollars = 0.10 }
		end
		return 0
	end,
	set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("Money", {0.5, 0.5, 0.5, 1}, G.C.WHITE, 1.2)
end
}

SMODS.Joker {
	key = 'quarter',
	loc_txt = {
		name = 'Big Ass Quarter',
		text = {
			'Yep, That is a quarter alright.'
		}
	},
	config = {},
	rarity = 1,
	cost = 0,
	atlas = 'jokers',
	pos = { x = 0, y = 1 },
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			return { dollars = 0.25 }
		end
		return 0
	end,
set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("Money", {0.5, 0.5, 0.5, 1}, G.C.WHITE, 1.2)
end,
}

SMODS.Joker {
	key = 'doller',
	loc_txt = {
		name = 'Big Ass Dollar',
		text = {
			'Yep, That is {C:money}1${} alright.'
		}
	},
	config = {},
	rarity = 3,
	cost = 0,
	atlas = 'jokers',
	pos = { x = 1, y = 1 },
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			return { dollars = 1 }
		end
		return 0
	end,
	set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("Money", {0.5, 0.5, 0.5, 1}, G.C.WHITE, 1.2)
end
}

SMODS.Joker {
	key = 'jenkins',
	atlas = 'jokers',
	pos = { x = 2, y = 1 },
	loc_txt = {
		name = 'Ol\' Jenkins Music Machine',
		text = {
			'Gives {X:mult,C:white}X{} mult',
			'based on {C:filter}Music Power{}',
			'{C:inactive}Currently{} {X:mult,C:white}X#1#{}'
		}
	},
	config = {},
	rarity = 1,
	cost = 1,
	loc_vars = function(self, info_queue, card)
		return { vars = {musicpower} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xmult = musicpower }
		end
		return 0
	end,
	set_card_type_badge = function(self, card, badges)

	end
}

SMODS.Joker {
	key = 'ritz',
	atlas = 'jokers',
	pos = { x = 3, y = 1 },
	loc_txt = {
		name = 'Ritz Box',
		text = {
			'Gains 2 {C:attention}crackers{} at the end of each round based on remaining {C:chips}hands{}',
			'gained {C:attention}crackers{} are added to {C:chips}round score{}',
			'{C:inactive}Currently: {C:attention}#1# Crackers{}{}'
		}
	},
	config = {},
	rarity = 1,
	cost = 1,
loc_vars = function(self, info_queue, card)
	G.GAME.ritz_crackers = G.GAME.ritz_crackers or 0
	return { vars = {G.GAME.ritz_crackers} }
end,
calculate = function(self, card, context)
	G.GAME.ritz_crackers = G.GAME.ritz_crackers or 0
	G.GAME.ritz_round = G.GAME.ritz_round or 0
	G.GAME.ritz_cracker_incremented_this_round = G.GAME.ritz_cracker_incremented_this_round or false
	if context.end_of_round then
		if not G.GAME.ritz_cracker_incremented_this_round then
			G.GAME.ritz_crackers = G.GAME.ritz_crackers + handsLeft()
			G.GAME.ritz_cracker_incremented_this_round = true
			G.GAME.ritz_round = G.GAME.ritz_round + handsLeft()
			return {message = "+"..handsLeft(), repetitions = 1}
		end
		return 0
	end
	if context.final_scoring_step then
		G.GAME.ritz_cracker_incremented_this_round = false
		G.GAME.chips = G.GAME.chips + G.GAME.ritz_crackers
		return {message = "+"..G.GAME.ritz_crackers, repetitions = 1}
	end
	return 0
end,
	set_card_type_badge = function(self, card, badges)
		badges[#badges+1] = create_badge("Food", {1, 0.8, 0.6, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.Joker {
    key = 'coke',
	atlas = 'jokers',
	pos = { x = 4, y = 1 },
    loc_txt = {
        name = 'Coke Cola',
        text = {
            "Starts at {X:mult,C:white}X5{} mult.",
            "Every hand decreases mult by {X:mult,C:white}X1{}.",
            "Refills when shop is rerolled",
			"{C:inactive}Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult{}"
        }
    },
    config = { extra = {} },
    rarity = 2,
    cost = 5,

    loc_vars = function(self, info_queue, card)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.coke_mult = card.ability.extra.coke_mult or 5
        return { vars = { card.ability.extra.coke_mult } }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.coke_mult = 5
        card.ability.extra._decremented = false
    end,

	calculate = function(self, card, context)
		card.ability.extra = card.ability.extra or {}
		local extra = card.ability.extra

		if context.reroll_shop then
			extra.coke_mult = 5
			return { message = "Reset", colour = G.C.GREEN }
		end

		if context.joker_main then
 			extra.coke_mult = (extra.coke_mult or 5) - 1
			return { xmult = extra.coke_mult or 5, message = "-1" }
		end
 		return 0
	end,

	set_card_type_badge = function(self, card, badges)
		badges[#badges+1] = create_badge("Food", {1, 0, 0, 1}, G.C.WHITE, 1.2)
	end,

}

SMODS.Joker {
	key = 'bigboobs',
	atlas = 'jokers',
	pos = { x = 5, y = 1 },
	loc_txt = {
		name = 'Big Boobs',
		text = {
			'{C:red}Search him up on google{}',
			'{}'
		}
	},
	config = {},
	rarity = 1,
	cost = 1,
	loc_vars = function(self, info_queue, card)
		return { vars = {musicpower} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			love.system.openURL("https://pbs.twimg.com/media/GB7qCDnbYAAKPPe.jpg:large")
			if card.destroy then
				card:destroy(true)
			end
		return 0
	end
end
}

SMODS.Joker {
	key = 'wouldyourather', 
	atlas = 'jokers',
	pos = { x = 6, y = 1 },
	soul_pos = { x = 7, y = 1 }, 
	loc_txt = {
		name = 'Would You Rather?', 
		text = {
			'On {C:attention}Blind Start{}',
			'you are forced to pick one condition',
			'or the other.',
			'{C:attention}Effective on selection{}'
		}
	},
	config = {}, 
	rarity = 3, 
	cost = 5, 

calculate = function(self, card, context)

	if context.setting_blind then
		card:juice_up()
		wyr()
	end
	return 0
end,
	
}

SMODS.Joker {
	key = 'steve', 
	atlas = 'jokers',
	pos = { x = 8, y = 1 },
	loc_txt = {
		name = '{C:edition,E:1,s:1.5}S T E V E{}', 
		text = {
			"pikmin"
		}
	},
	pools = {
        ["Pikmin"] = true
    },
	config = {}, 
	rarity = 1, 
	cost = 0, 

calculate = function(self, card, context)
	if context.joker_main then
	if math.random(1, 4) == 1 then
		destroycard(card)
	end
	return {message = "pikmin_startup_sfx.ogg", sound = "fams_pikmin"}
	end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Pikmin", {1, 0, 0, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.Joker {
	key = 'bob', 
	atlas = 'jokers',
	pos = { x = 9, y = 1 },
	loc_txt = {
		name = '{C:edition,E:1,s:1.5}B O B{}', 
		text = {
			"pikmin",
			"{C:green}1 in 8{} he trips like a fucking idiot and you lose {C:blue}50{} chips."
		}
	},
	pools = {
        ["Pikmin"] = true
    },
	config = {}, 
	rarity = 1, 
	cost = 0, 

calculate = function(self, card, context)
	if context.joker_main then
	if math.random(1, 8) == 1 then
		G.GAME.chips = G.GAME.chips - 50
		return {message = "tripped (fucking idiot)", sound = "fams_idiotyellow"}
	end
	return {message = "pikmin_startup_sfx.ogg", sound = "fams_pikmin"}
	end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Pikmin", {1, 1, 0, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.Joker {
	key = 'joe', 
	atlas = 'jokers',
	pos = { x = 0, y = 2 },
	loc_txt = {
		name = '{C:edition,E:1,s:1.5}J O E{}', 
		text = {
			"pikmin",
			""
		}
	},
	pools = {
        ["Pikmin"] = true
    },
	config = {}, 
	rarity = 1, 
	cost = 0, 

calculate = function(self, card, context)
	if context.setting_blind then
	love.system.openURL("https://youtu.be/HCSwYhd9yto?list=PL023F0FE11F69F931&t=491")
	end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Pikmin", {0, 0, 1, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.Joker {
	key = 'tidywhitey', 
	atlas = 'jokers',
	pos = { x = 1, y = 2 },
	loc_txt = {
		name = '{C:edition,E:1,s:1.5}T I G H T Y  W H I T E Y{}', 
		text = {
			"pikmin"
		}
	},
	pools = {
        ["Pikmin"] = true
    },
	config = {}, 
	rarity = 1, 
	cost = 0, 

calculate = function(self, card, context)
     if context.end_of_round and context.cardarea == G.jokers then
         local kill = G.jokers.cards[1]
        if kill and kill ~= card and kill.remove and not isEternal(kill) then
            kill:remove()
			card:remove()
            return {message = "Poisoned", sound = "fams_pikmin", repetitions = 1}
        end
    end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Pikmin", {1, 1, 1, 1}, G.C.RED, 1.2)
	end
}

SMODS.Joker {
	key = 'purple', 
	atlas = 'jokers',
	pos = { x = 2, y = 2 },
	loc_txt = {
		name = '{C:edition,E:1,s:1.5}P U R P L E{}', 
		text = {
			"pikmin"
		}
	},
	pools = {
        ["Pikmin"] = true
    },
	config = {}, 
	rarity = 1, 
	cost = 0, 

calculate = function(self, card, context)
     if context.joker_main then
	if math.random(1, 8) == 1 then
		destroycard(card)
		return {message = "tongued", colour = G.C.WHITE}
	end
	return {message = "pikmin_startup_sfx.ogg", sound = "fams_pikmin"}
	end
end,
	set_card_type_badge = function(self, card, badges)
		badges[#badges+1] = create_badge("Pikmin", {0.6, 0, 0.6, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.Joker {
	key = 'halo', 
	atlas = 'jokers',
	pos = { x = 3, y = 2 },
	loc_txt = {
		name = 'The Halo Rule', 
		text = {
			"{C:green}1 in 10000{} chance to",
			"{C:red}kill your run{} on hand played",
			"{C:inactive}lmao{}"
		}
	},
	config = {}, 
	rarity = 1,
	cost = 0,

	
calculate = function(self, card, context)
    if context.joker_main then
	if math.random(1, 10000) == 1 then
		ForceLoss()
	else
		return {message = "Safe"}
	end
	end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge('"Speedrunner"', {0, 0.5, 0, 1}, G.C.GREEN, 1.2)
	end
}

SMODS.Joker {
	key = 'coolj', 
	atlas = 'jokers',
	pos = { x = 4, y = 2 },
	loc_txt = {
		name = 'Thumbs up emoji', 
		text = {
			"Gives {X:mult,C:white}2x{} mult for each",
			"card that is {C:edition,E:2}cool{}",
			"{C:inactive}currently{} {X:mult,C:white}#1#x{}"
		}
	},
	loc_vars = function(self, info_queue, card)
    local cool_count = 0
        if G and G.deck and G.deck.cards then
            for _, c in ipairs(G.deck.cards) do
                if hasSeal(c, "fams_cool_seal") then
                    cool_count = cool_count + 1

                end
            end
        end
        local xmult = 1
        if cool_count > 0 then
            xmult = 2 * cool_count
        end
    return { vars = { xmult, cool_count } }
end,
	config = {}, 
	rarity = 1,
	cost = 0, 

calculate = function(self, card, context)
    if context.joker_main then
        local cool_count = 0
        if G and G.deck and G.deck.cards then
            for _, c in ipairs(G.deck.cards) do
                if hasSeal(c, "fams_cool_seal") then
                    cool_count = cool_count + 1

                end
            end
        end
        local xmult = 1
        if cool_count > 0 then
            xmult = 1.5 * cool_count
        end
		if cool_count > 0 then
			return {xmult = xmult, message = "Certified!"}
		end
        return {message = "Not cool"}
    end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge('Cool', {1, 1, 0, 0.8}, G.C.white, 1.2)
	end
}

SMODS.Joker {
	key = 'kitchgun', 
	atlas = 'jokers',
	pos = { x = 5, y = 2 },
	loc_txt = {
		name = '{C:edition,E:1,s:1.2}Kitchen Gun{}',
		text = {
			"defeats blinds instantly {C:attention}3 times{}",
			"{C:red}Lose 5 cards each shot{}"
		}
	},
	config = {}, 
	rarity = 1,
	cost = 0, 

calculate = function(self, card, context)
    if context.joker_main then
		if card.ability.times then
			card.ability.times = card.ability.times + 1
			if card.ability.times >= 3 then
				destroycard(card)
			end
		else
			card.ability.times = 1
		end
		
		removeCards(5)
		return {chips = G.GAME.blind.chips, sound = "fams_bang", message = tostring(3 - card.ability.times) .. " left"}
	end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge('"All new!"', {0.3, 0.3, 0.3, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.Joker {
	key = 'gernade', 
	atlas = 'jokers',
	pos = { x = 6, y = 2 },
	loc_txt = {
		name = '{C:edition,E:1,s:1.2}Toilet Grenade{}',
		text = {
			"defeats blinds instantly {C:attention}1 times{}",
			"{C:red}Lose 28 cards on trigger{}"
		}
	},
	config = {}, 
	rarity = 2,
	cost = 0, 

calculate = function(self, card, context)
    if context.joker_main then
		card:juice_up()
		removeCards(28)
		destroycard(card)
		return {chips = G.GAME.blind.chips * 2, sound = "fams_bang", message = "Bang"}
	end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge('"New!"', {0.8, 0.8, 0.8, 1}, G.C.WHITE, 1.4)
	end
}

 SMODS.Joker {
	key = 'ramsay',
	atlas = 'jokers',
	pos = { x = 7, y = 2 },
	loc_txt = {
		name = 'Gordon Ramsay',
		text = {
			'on {C:attention}Boss Blind{} start, Tells one random joker to {C:red}"FUCK OFF!"{}',
			'Gains {X:mult,C:white}X1{} Mult for each.',
			'{C:inactive}Currently {X:mult,C:white}X#1#{} {C:inactive}Mult{}'
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.swearmult or 0} }
	end,
	config = { swearmult = 1 },
	rarity = 2,
	cost = 4,
    calculate = function(self, card, context)
	if card.ability.swearmult then
		
	else
		card.ability.swearmult = 1
	end

    if context.setting_blind and isBoss() then
        card.ability.swearmult = card.ability.swearmult + 1
         if G and G.jokers and G.jokers.cards and #G.jokers.cards > 1 then
            local candidates = {}
            for _, j in ipairs(G.jokers.cards) do
                if j ~= card and j.remove and not isEternal(j) then
                    table.insert(candidates, j)
                end
            end
            if #candidates > 0 then
                local idx = math.random(1, #candidates)
                candidates[idx]:remove(true)
				return { message = "FUCK OFF!", colour = G.C.RED }
            end
        end
        
    end
    if context.joker_main then
         return {xmult = card.ability.swearmult}
    end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Master Chef", {1.0, 0.84, 0.0, 1.0}, G.C.WHITE, 1.4)
end
}

SMODS.Joker {
	key = 'smurf',
	loc_txt = {
		name = 'Smurf',
		text = {
			"He's blue",
			"{C:inactive}gives itself as a chip{}"
		}
	},
	config = { extra = { xmult = 0.5 } },
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 8, y = 2 },
	cost = 1,
loc_vars = function(self, info_queue, card)
	
end,
set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("little shit", {0, 0, 1, 1}, G.C.WHITE, 1.2)
end,
calculate = function(self, card, context)
	if context.joker_main then
		destroycard(card)
		return {chips = 1, message = "smurfed up", colour = G.C.BLUE}
	end
end,
update = function(self, card, dt)
	
end
}

SMODS.Joker {
	key = 'toegore',
	loc_txt = {
		name = 'TOGORE DREMURR',
		text = {
			"does anybody remember this undertale character? his name is togore dreemurr the middle child of asgore and toriel dreemurr and brother to asriel and chara dreemurr. he is the only child of the dreemurrs that survived and is still alive in undertale and can be seen in mettaton resort. he doesn't have much plot significance but that doesn't stop him from chilling. the weird thing is when anyone tries to mention togore to toby henry fox he freaks out. don't know what his deal is."
		}
	},
	config = {},
	rarity = 1,
	cost = 1,
	atlas = 'jokers',
	pos = { x = 9, y = 2 },
	soul_pos = { x = 0, y = 3 },
	calculate = function(self, card, context)
	
	end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Middle Child", {0, 0, 0, 1}, G.C.BLUE, 1.2)
	end,
}

SMODS.Joker {
	key = 'stressed',
	loc_txt = {
		name = 'Stressed Joker',
		text = {
			"gives {X:mult,C:white}0.25x{} mult for the less hands you have",
			"{C:inactive}Relative to your starting hands{}",
			"starting from {C:attention}#2# hands:{} {X:mult,C:white}#1#X{}"
		}
	},
	config = { extra = { } },
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 1, y = 3 },
	cost = 6,
loc_vars = function(self, info_queue, card)
	local handlef = handsLeft() or 0
	labelset = math.abs(1 + (1 - (handlef / (startingHand or 0))))
	return { vars = {labelset, startingHand} }
end,
calculate = function(self, card, context)
	local handlef = handsLeft()
	if context.setting_blind then
		startingHand = handsLeft()
		return {message = "Reset"}
	end
	if context.joker_main then
		local handlef = handsLeft()
		local final = math.abs(1 + (1 - (handlef / startingHand)))
		labelset = math.abs(1 + (1 - (handlef / startingHand)))
		return {xmult = final}
	end

end
}

 SMODS.Joker {
	key = 'divorce', 
	atlas = 'divorce', 
	pos = { x = 0, y = 0 }, 
	loc_txt = {
		name = 'Divorce Paper', 
		text = {
			"{C:green}#1# in 2{} chance to give",
			"{X:chips,C:white}5X{} chips or {X:mult,C:white}-5X{} chips",
			"{C:red}Self Destructs{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {currentprobability()}}
	end,
	config = {}, 
	rarity = 2, 
	cost = 5, 

calculate = function(self, card, context)
	if context.joker_main then
		if math.random(currentprobability(), 2) == 2 then
			card:remove(true)
			return { xchips = 5, destroy_card = card }
		else
			card:remove(true)
			return { xchips = -5, destroy_card = card }
		end
	end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Wood", {1, 1, 1, 1}, G.C.BLACK, 1.2)
	end
}

SMODS.Joker {
    key = "spawn",
    loc_txt = {
        name = "TITAN SPAWN",
        text = {"{C:red}takes 2 chips every 2 seconds{}",
	"{X:mult,C:white}Click{}{X:mult,C:white} it.{}",
	"{C:inactive}Currently spawns every #1# seconds{}"}
    },
	atlas = 'jokers',
	pos = { x = 2, y = 3 },
    cost = -5,
	rarity = 1,
	pools = {
    	["gimmicks"] = true
    },
	config = { chip_timer = 0 },
	loc_vars = function()
		return { vars = {(4 / (getAnte() / 4)) or 8} }
	end,

	add_to_deck = function(self, card, from_debuff)
		self.config.chip_timer = 0
	end,

	remove_from_deck = function(self, card, from_debuff)
		
	end,

	update = function(self, card, dt)
         self.config.chip_timer = (self.config.chip_timer or 0) + (dt or 0)
        if self.config.chip_timer >= 20 then
            self.config.chip_timer = 0
            G.GAME.chips = (G.GAME.chips or 0) - 2
            if card.juice_up then card:juice_up() end
        end
    end,

	in_pool = function()
		return false
	end,

	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge("Gimmick", {1, 0.5, 0, 1}, G.C.WHITE, 1.2)
	end
}

SMODS.Joker {
	key = 'mus',
	atlas = 'jokers',
	pos = { x = 3, y = 3 },
	loc_vars = function(self, info_queue, card)
	return { vars = {getBPMTick(), G.GAME.bpmmax}, colours = { HEX('#c1a1d3ff') } }
end,
	loc_txt = {
		name = 'Metronome',
		text = {
			'Gives {X:mult,C:white}X#1#{} mult based on {C:timesignature}Time Signature{}',
		}
	},
	config = {},
	rarity = 3,
	cost = 8,
	calculate = function(self, card, context)
		if context.joker_main then
			return {xmult = getBPMTick()}
		end
	end,
}

SMODS.Joker {
	key = 'skeleton', 
	atlas = 'jokers',
	pos = { x = 4, y = 3 },
	loc_txt = {
		name = 'evil fucking skeleton from google images', 
		text = {
			"{C:red}+15{} Mult if a {C:attention}Jack{} is in played hand.",
			"{C:red}No exceptions.{}"
		}
	},
	loc_vars = function(self, info_queue, card)
	return { vars = { } }
end,
	config = {  }, 
	rarity = 2,
	cost = 0, 

	set_sprites = function(self, card, front)
		play_sound("fams_skull", 1, 1)
	end,
calculate = function(self, card, context)
	if context.individual and context.cardarea == G.play and context.full_hand then
			for _, card in ipairs(context.full_hand) do
				if card.base and card.base.value == "Jack" then
					
					return { mult = 15, sound = "fams_skull", message = 'Bad to the bone - Sound Effect HD.mp3'}
				end
			end
	end
end,
}

SMODS.Joker {
	key = 'gayster', 
	atlas = 'gayster', 
	pos = { x = 0, y = 0 }, 
	loc_txt = {
		name = 'Mystery Man', 
		text = {
			""
		}
	},
	no_collection = true,
	pools = {
        ["Jokers"] = true
    },
	config = {}, 
	rarity = 4, 
	cost = 0, 

calculate = function(self, card, context)
	if context.joker_main then
	
	end
end,
	set_card_type_badge = function(self, card, badges)
	badges[#badges+1] = create_badge(". . .", {1, 1, 1, 1}, G.C.BLACK, 1.2)
	end
}


SMODS.Joker {
	key = 'webster',
	atlas = 'jokers',
	pos = { x = 5, y = 3 },
	loc_vars = function(self, info_queue, card)
		local words_found = card.ability.extra.words_found or {}
		return { vars = { card.ability.extra.mult, #words_found } }
	end,
	loc_txt = {
		name = 'Webster Dictionary',
		text = {
			'all jokers in {C:attention}Jokers or Booster Packs{} with a {C:attention}new word{}, Gain {C:red}+mult{} equal to the',
			'length of each {C:attention}new word{} found in card names',
			'{C:inactive}(Currently {C:red}+#1#{C:inactive} mult from {C:attention}#2#{C:inactive} words)'
		}
	},
	config = { extra = {mult = 0, words_found = {}} },
	rarity = 2,
	cost = 15,
 	extract_words = function(text)
		if not text or type(text) ~= "string" then 
			return {} 
		end
		local words = {}
 		local clean_text = string.lower(text)
		for word in string.gmatch(clean_text, "%a+") do
			if #word > 1 then -- Only consider words with more than 1 letter
				table.insert(words, word)
			else
			end
		end
		return words
	end,
 	is_new_word = function(self, word, found_words)
		for _, found_word in ipairs(found_words) do
			if found_word == word then
				return false
			end
		end
		return true
	end,
	
	calculate = function(self, card, context)
 		if (context.buying_card or context.open_booster or context.using_consumeable or context.add_to_deck) and context.card then
			local bought_card = context.card
			local card_name = ""
 			if bought_card.config and bought_card.config.center then
				if bought_card.config.center.name then
					card_name = bought_card.config.center.name
				elseif bought_card.config.center.loc_txt and bought_card.config.center.loc_txt.name then
					card_name = bought_card.config.center.loc_txt.name
				elseif bought_card.config.center.key then
					card_name = bought_card.config.center.key
				end
			elseif bought_card.ability and bought_card.ability.name then
				card_name = bought_card.ability.name
			elseif bought_card.name then
				card_name = bought_card.name
			end
  		if card_name and type(card_name) == "string" and card_name ~= "" then
			local words_in_name = extract_words_from_text(card_name)
			local found_words = card.ability.extra.words_found or {}
			local new_words = {}
			local total_new_mult = 0
 			for _, word in ipairs(words_in_name) do

				if is_word_new(word, found_words) then
					table.insert(found_words, word)
					table.insert(new_words, word)
					total_new_mult = total_new_mult + #word

				else

				end
			end				-- Update the joker's stored words and mult
				card.ability.extra.words_found = found_words
				card.ability.extra.mult = card.ability.extra.mult + total_new_mult
 				if #new_words > 0 then
					local message = "+" .. total_new_mult .. " from " .. #new_words .. " new word"
					if #new_words > 1 then message = message .. "s" end

					return {
						message = message,
						colour = G.C.RED
					}
				else

				end
			end
		end
 		if context.joker_main then
			if card.ability.extra.mult > 0 then
				return {
					mult = card.ability.extra.mult,
				}
			end
		end
	end,
 	add_to_deck = function(self, card, from_debuff)
 		local is_webster = false
		if card.config and card.config.center and card.config.center.name == "Webster Dictionary" then
			is_webster = true
		end
 		if G and G.jokers and G.jokers.cards then
			for _, joker in ipairs(G.jokers.cards) do
 				local joker_name = ""
				if joker.config and joker.config.center and joker.config.center.name then
					joker_name = joker.config.center.name
				end
				
				if joker_name == "Webster Dictionary" then
					if is_webster and joker == card then
 						self:scan_all_cards_for_webster(joker)
					elseif not is_webster then
 						self:check_card_for_webster(joker, card)
					end
				end
			end
		end
	end,
 	scan_all_cards_for_webster = function(self, webster_card)
		local all_cards = {}
 		if G and G.jokers and G.jokers.cards then
			for _, joker_card in ipairs(G.jokers.cards) do
				if joker_card ~= webster_card then
					table.insert(all_cards, joker_card)
				end
			end
		end
 		if G and G.consumeables and G.consumeables.cards then
			for _, consumable_card in ipairs(G.consumeables.cards) do
				table.insert(all_cards, consumable_card)
			end
		end
 		for _, target_card in ipairs(all_cards) do
			self:check_card_for_webster(webster_card, target_card)
		end
	end,
 	check_card_for_webster = function(self, webster_card, target_card)
		local card_name = ""
 		if target_card.config and target_card.config.center then
    if target_card.config.center.name then
        card_name = target_card.config.center.name
    elseif target_card.config.center.loc_txt and target_card.config.center.loc_txt.name then
        card_name = target_card.config.center.loc_txt.name
    elseif target_card.config.center.key then
        card_name = target_card.config.center.key
    end
elseif target_card.ability and target_card.ability.name then
    card_name = target_card.ability.name
elseif target_card.name then
    card_name = target_card.name
end
		
		if card_name and type(card_name) == "string" and card_name ~= "" then
			local words_in_name = extract_words_from_text(card_name)
			local found_words = webster_card.ability.extra.words_found or {}
			local new_words = {}
			local total_new_mult = 0
 			for _, word in ipairs(words_in_name) do
				if is_word_new(word, found_words) then
					table.insert(found_words, word)
					table.insert(new_words, word)
					total_new_mult = total_new_mult + #word
				else
				end
			end
 			webster_card.ability.extra.words_found = found_words
			webster_card.ability.extra.mult = webster_card.ability.extra.mult + total_new_mult
 			if #new_words > 0 then
				local message = "+" .. total_new_mult .. " from " .. #new_words .. " new word"
				if #new_words > 1 then message = message .. "s" end
 				if webster_card.juice_up then
					webster_card:juice_up()
				end
			end
		end
	end,
}

SMODS.Joker {
	key = 'pencil', 
	atlas = 'jokers',
	pos = { x = 6, y = 3 },
	loc_txt = {
		name = 'Pencil', 
		text = {
			"Takes the value of all {C:attention}numbered cards{} and adds them to Mult."
		}
	},
	pools = {

    },
	config = { }, 
	rarity = 2, 
	cost = 0, 

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
        local value = context.other_card.base and context.other_card.base.value or false
        return {mult = tonumber(context.other_card.base.value)}
    end
	end,
}

SMODS.Joker {
	key = 'dr_soul', 
	atlas = 'jokers',
	pos = { x = 7, y = 3 },
	soul_pos = { x = 8, y = 3 },
	loc_txt = {
		name = 'The Soul', 
		text = {
			"It may awaken during a {C:attention}boss blind{}..."
		}
	},
	pools = {

    },
	config = { }, 
	rarity = 2, 
	cost = 0, 

	calculate = function(self, card, context)
		if context.setting_blind then
			if (not (getcurrentBlind() == "Small Blind" or getcurrentBlind() == "Big Blind")) and (pseudorandom('dr_soul') > 0.6) then
				G.GAME.dr_boss = true;
				return { message = "Awoke", sound = "fams_ut_encounter" };
			end
		end

		return 0;
	end,
}