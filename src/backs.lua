
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
    atlas = "backs",
    pos = {x = 1, y = 0},
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