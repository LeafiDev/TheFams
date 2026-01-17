
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
	atlas = 'stakes',
	pos = { x = 0, y = 0 },
	sticker_pos = { x = 0, y = 0 },
	unlocked = true,
	colour = {0.69, 0.61, 0.60, 1}, 
	above_stake = "stake_gold", 
	modifiers = function(self)

	end
}



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
        "stake_gold"
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
	atlas = 'stakes',
	pos = { x = 1, y = 0 },
	sticker_pos = { x = 1, y = 0 },
	unlocked = true,
	colour = {0.69, 0.61, 0.60, 1}, 
	above_stake = "stake_fams_timestake", 
	modifiers = function(self)
	end
}



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
	atlas = 'stakes',
	pos = { x = 2, y = 0 },
	sticker_pos = { x = 2, y = 0 },
	unlocked = true,
	colour = {0.50, 0.19, 0.07, 1}, 
	above_stake = "stake_fams_walmert", 
	modifiers = function(self)
		G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    G.GAME.dollars = G.GAME.dollars - 10
					G.GAME.inflation = G.GAME.inflation + 3
                    return true
                end
            }))
	end
}

SMODS.Stake {
	key = 'fuckyou',
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
		"stake_fams_walmert",
		"stake_fams_poor"
    },
	loc_txt = {
		name = 'Fuck you in particular',
		text = {
			"{C:red}-1{} Consumable slots",
			"{C:red}-1{} Joker slots"
		},
		sticker = {
			name = 'I take back my statement, I\'m sorry :)',
			text = {'Win a run with fuck you in particular'}
		}
	},
	atlas = 'stakes',
	pos = { x = 3, y = 0 },
	sticker_pos = { x = 3, y = 0 },
	unlocked = true,
	colour = {0.8, 0.5, 0.5, 1}, 
	above_stake = "stake_fams_poor", 
	modifiers = function(self)
		G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots - 1
		G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - 1
	end
}

SMODS.Stake {
	key = 'clankers',
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
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou"
    },
	loc_txt = {
		name = 'THESE DAMN CLANKAS',
		text = {
			"I need my damn ram dude!",
			"{C:red}+20 Inflation{}",
			"Gain a buffoon tag",
		},
		sticker = {
			name = 'Nice ram dude :)',
			text = {'Win a run with THESE DAMN CLANKAS'}
		}
	},
	atlas = 'stakes',
	pos = { x = 4, y = 0 },
	sticker_pos = { x = 4, y = 0 },
	unlocked = true,
	colour = {1, 0, 0, 1}, 
	above_stake = "stake_fams_fuckyou", 
	modifiers = function(self)
		G.GAME.inflation = G.GAME.inflation + 20
		G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function() 
			createtag("tag_buffoon")
			return true
		end,
		blockable = true
		}))
		
	end
}

SMODS.Stake {
	key = 'egg',
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
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers"
    },
	loc_txt = {
		name = 'Scrambled Eggs',
		text = {
			"Consider your deck, {E:1}Scrambled{}"
		},
		sticker = {
			name = 'Eggcellent',
			text = {'Was it yummy?'}
		}
	},
	atlas = 'stakes',
	pos = { x = 5, y = 0 },
	sticker_pos = { x = 5, y = 0 },
	unlocked = true,
	colour = {1, 1, 0, 1}, 
	above_stake = "stake_fams_clankers", 
	modifiers = function(self)
		G.GAME.starting_params.erratic_suits_and_ranks = true
		
	end
}

SMODS.Stake {
	key = 'half',
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
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers",
		"stake_fams_egg",
    },
	loc_txt = {
		name = 'Halfing it',
		text = {
			"Half joker has had enough of your shit",
			"{C:red}-2{} Max card selection per hand",
			"auto disables {C:attention}The Psychic{}"
		},
		sticker = {
			name = 'Halfings',
			text = {'Win a run with Halfing it'}
		}
	},
	atlas = 'stakes',
	pos = { x = 6, y = 0 },
	sticker_pos = { x = 6, y = 0 },
	unlocked = true,
	colour = {1, 0, 0, 1}, 
	above_stake = "stake_fams_egg", 
	modifiers = function(self)
		G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function() 
			table.insert(G.GAME.banned_keys, "bl_psychic")
			SMODS.change_play_limit(-2)
			return true
		end,
		blockable = true
		}))
		
	end
}

SMODS.Stake {
	key = 'theft',
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
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers",
		"stake_fams_egg",
		"stake_fams_half",
    },
	loc_txt = {
		name = 'Caught in theft',
		text = {
			"Maybe you should stop stealing",
			"{C:red}-1{} booster packs per shop"
		},
		sticker = {
			name = 'I regret nothing!',
			text = {'Do you plan to keep stealing though???'}
		}
	},
	atlas = 'stakes',
	pos = { x = 7, y = 0 },
	sticker_pos = { x = 6, y = 0 },
	unlocked = true,
	colour = {0, 0, 0, 1}, 
	above_stake = "stake_fams_half", 
	modifiers = function(self)
		G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function() 
			SMODS.change_booster_limit(-1)
			return true
		end,
		blockable = true
		}))
		
	end
}

SMODS.Stake {
	key = 'copyright',
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
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers",
		"stake_fams_egg",
		"stake_fams_half",
		"stake_fams_theft",
    },
	loc_txt = {
		name = 'Cease and Desist',
		text = {
			"{C:red,E:4}Stop copying my ideas!{}",
			"Blueprint and Brainstorm are {C:red:E:1}disabled{}"
		},
		sticker = {
			name = 'Law abider',
			text = {'Now you won\'t get sued :)'}
		}
	},
	atlas = 'stakes',
	pos = { x = 8, y = 0 },
	sticker_pos = { x = 8, y = 0 },
	unlocked = true,
	colour = {1, 1, 1, 1}, 
	above_stake = "stake_fams_theft", 
	modifiers = function(self)
		G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function() 
			table.insert(G.GAME.banned_keys, "j_blueprint")
			table.insert(G.GAME.banned_keys, "j_brainstorm")
			return true
		end,
		blockable = true
		}))
		
	end
}

SMODS.Stake {
	key = 'taxes',
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
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers",
		"stake_fams_egg",
		"stake_fams_half",
		"stake_fams_theft",
		"stake_fams_copyright",
    },
	loc_txt = {
		name = 'TAX TIME :3',
		text = {
			"{C:attention}+1{} Consumable slot",
			"Gain 1 {C:red,E:1}IRS{}"
		},
		sticker = {
			name = 'tax payer',
			text = {'Now you won\'t get arrested! :)'}
		}
	},
	atlas = 'stakes',
	pos = { x = 9, y = 0 },
	sticker_pos = { x = 9, y = 0 },
	unlocked = true,
	colour = {0, 0, 1, 1}, 
	above_stake = "stake_fams_theft", 
	modifiers = function(self)
		G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.5,
		func = function() 
			G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots + 1
			G.GAME.dollars = 20
			SMODS.add_card{
			set = "mini-joker",
			legendary = false,        
			key = "c_fams_g-tax",
			skip_materialize = false,
    	}
			return true
		end,
		blockable = true
		}))
		
	end
}

SMODS.Stake {
	key = 'lock',
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
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers",
		"stake_fams_egg",
		"stake_fams_half",
		"stake_fams_theft",
		"stake_fams_copyright",
		"stake_fams_taxes",
    },
	loc_txt = {
		name = 'Lock Stake',
		text = {
			"Jokers can be {C:red}Locked{}"
		},
		sticker = {
			name = 'Lock Stake',
			text = {'Win a run with Lock Stake.'}
		}
	},
	atlas = 'stakes',
	pos = { x = 10, y = 0 },
	sticker_pos = { x = 10, y = 0 },
	unlocked = true,
	colour = {1, 0, 0, 1}, 
	above_stake = "stake_fams_taxes", 
	modifiers = function(self)
		G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.5,
		func = function() 
			
			return true
		end,
		blockable = true
		}))
		
	end
}