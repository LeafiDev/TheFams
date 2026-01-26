
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
    atlas = "backs",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                SMODS.add_card  {
                set = "Joker",                
                legendary = false,            
                key = "j_fams_wouldyourather",
                skip_materialize = false,     
                }
                return true
            end
        }))
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
    atlas = "backs",
    pos = {x = 1, y = 0},
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                SMODS.add_card  {
                set = "Joker",                
                legendary = false,            
                key = "j_fams_stressed",
                skip_materialize = false,     
                }
                return true
            end
        }))
    end
}



SMODS.Back {
    key = "modeck",
    loc_txt = {
        name = "Poor as fuck Deck",
        text = {
            "You lost the game of life.",
			"Take this dollar for your struggles."
        }
    },
    atlas = "backs",
    pos = {x = 2, y = 0},
    apply = function(self, back)
    if G and G.GAME then
        G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                SMODS.add_card  {
                set = "Joker",                
                legendary = false,            
                key = "j_fams_doller",
                skip_materialize = false,     
                }
                return true
            end
        }))
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



SMODS.Back {
    key = "paper",
    loc_txt = {
        name = "Paper Deck",
        text = {
            "{C:red}OOOO MATH HOMEWORK!{}"
        }
    },
    atlas = "backs",
    pos = {x = 4, y = 0},
    apply = function(self, back)
    if G and G.GAME then
        G.E_MANAGER:add_event(Event({

            trigger = "immediate",
            func = function()
                SMODS.add_card  {
                set = "Joker",                
                legendary = false,            
                key = "j_fams_pencil",
                skip_materialize = false,     
                }
                SMODS.add_card  {
                set = "Joker",                
                legendary = false,            
                key = "j_fams_ritz",
                skip_materialize = false,     
                }
                return true
            end
        }))
    end
end
}


SMODS.Back {
    key = "dogdeck",
    loc_txt = {
        name = "Earl Deck",
        text = {
			"start with {C:attention}20${}",
			"and {C:attention}Earl Joe{}"
        }
    },
    atlas = "backs",
    pos = {x = 3, y = 0},
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                G.GAME.dollars = 20
                SMODS.add_card  {
                set = "Joker",                
                legendary = false,            
                key = "j_fams_earl",
                skip_materialize = false,     
                }
                return true
            end
        }))
end
}

SMODS.Back {
    key = "bigmoney",
    loc_txt = {
        name = "The Big One",
        text = {
			"Earn some {C:attention}Big Money (TM){}."
        }
    },
    atlas = "backs",
    pos = {x = 5, y = 0},
    calculate = function(self, back, context)
        if context.setting_blind then
            G.GAME.big_money = true;
            if (not (getcurrentBlind() == "Small Blind" or getcurrentBlind() == "Big Blind")) then
                G.GAME.ut_action = true;
                G.GAME.ut_colors = 6;
                G.GAME.ut_width = 13;
            elseif (getcurrentBlind() == "Small Blind") then
                G.GAME.ut_colors = 4;
            end
        end
    end
}

SMODS.Back {
    key = "astrodeck",
    loc_txt = {
        name = "Astrology Deck",
        text = {
			"Gain 1 or 2 {C:blue}levels{} for each {C:attention}hand type{}"
        }
    },
    atlas = "backs",
    pos = {x = 6, y = 0},
    apply = function(self, back)
    for _, hand in ipairs(G.handlist) do
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
            SMODS.smart_level_up_hand(self, hand, true, math.floor((pseudorandom("astrodeck") * 2) + 1))
            return true
            end
        }))
    end
end
}