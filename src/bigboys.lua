local picky_hand_types = {
    "Pair", "Two Pair", "Three of a Kind", "Straight", "Flush",
    "Full House", "Four of a Kind", "Straight Flush", "Five of a Kind", "Flush House"
}

SMODS.Blind {
    key = "the_picky",
	atlas = "bossBlinds",
    pos = { x = 0, y = 0 },
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
	atlas = "bossBlinds",
    pos = { x = 0, y = 1 },
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
	atlas = "bossBlinds",
    pos = { x = 0, y = 2 },
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
	atlas = "bossBlinds",
    pos = { x = 0, y = 3 },
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
	atlas = "bossBlinds",
    pos = { x = 0, y = 4 },
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

local selcardsuit = {"H", "D", "C", "S"}
local selcardrank = {"fams_one", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"}

SMODS.Blind {
    key = "extinct",
	atlas = "bossBlinds",
    pos = { x = 0, y = 5 },
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
	atlas = "bossBlinds",
    pos = { x = 0, y = 6 },
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
	atlas = "bossBlinds",
    pos = { x = 0, y = 7 },
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


SMODS.Blind {
    key = "Pootis",
	atlas = "bossBlinds",
    pos = { x = 0, y = 8 },
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




SMODS.Blind {
    key = "EarlBoss",
	atlas = "bossBlinds",
    pos = { x = 0, y = 9 },
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

SMODS.Blind {
    key = "trueend",
	atlas = "bossBlinds",
    pos = { x = 0, y = 10 },
    loc_txt = {
        name = "The Vortex",
        text = {"Too far out..."}
    },
   	boss = { min = 8, showdown = true },
    dollars = 10,
    mult = 10,
    boss_colour = HEX('4f6367'), 
    set_blind = function(self)
		
    end,
	press_play = function(self)
		
	end,
	in_pool = function(self)
		return isChallenge("dlcend")
	end
}