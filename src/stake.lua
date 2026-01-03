
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
	unlocked = false,
	colour = {0.69, 0.61, 0.60, 1}, 
	above_stake = 4, 
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
	atlas = 'stakes',
	pos = { x = 1, y = 0 },
	sticker_pos = { x = 1, y = 0 },
	unlocked = false,
	colour = {0.69, 0.61, 0.60, 1}, 
	above_stake = 4, 
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