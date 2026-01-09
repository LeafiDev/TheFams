
SMODS.Voucher {
    key = "headstartv",
    loc_txt = {
        name = "Head Start",
        text = {
            "Every blind starts with {C:blue}+500{} chips."
        }
    },
    atlas = "vouchers", 
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
    atlas = "vouchers", 
    pos = {x = 1, y = 0},
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
    atlas = "vouchers", 
    pos = {x = 2, y = 0},
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
    atlas = "vouchers", 
    pos = {x = 3, y = 0},
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

SMODS.Voucher {
    key = "fl",
    loc_txt = {
        name = "FL STUDIO",
        text = {
            "Increases time signature maximum to 8"
        }
    },
    atlas = "vouchers", 
    pos = {x = 4, y = 0},
    cost = 10,
	redeem = function(self, card)
		G.GAME.bpmmax = 8
	end
}

SMODS.Voucher {
    key = "piano",
	requires = {"v_fams_fl"},
    loc_txt = {
        name = "It's just an track for playing poker, No need for it to go hard.",
        text = {
            "Increases time signature maximum to 16"
        }
    },
    atlas = "vouchers", 
    pos = {x = 5, y = 0},
    cost = 20,
	redeem = function(self, card)
		G.GAME.bpmmax = 16
	end
}

SMODS.Voucher {
    key = "moment",
    loc_txt = {
        name = "Do you have a moment to talk about our lord and savior jesus christ?",
        text = {
            "-1 ectoplasm hand removal"
        }
    },
    atlas = "vouchers", 
    pos = {x = 7, y = 0},
    cost = 10,
	redeem = function(self, card)
		G.GAME.ecto_minus = G.GAME.ecto_minus - 1
	end
}

SMODS.Voucher {
    key = "jimbusters",
	requires = {"v_fams_moment"},
    loc_txt = {
        name = "Who you gonna call? JIMBUSTERS!",
        text = {
            "-1 ectoplasm hand removal"
        }
    },
    atlas = "vouchers", 
    pos = {x = 8, y = 0},
    cost = 10,
	redeem = function(self, card)
		G.GAME.ecto_minus = G.GAME.ecto_minus - 1
	end
}