if CardSleeves then

CardSleeves.Sleeve {
    key = "desleeve",
    atlas = "sleeves",
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



CardSleeves.Sleeve {
    key = "earlsleeve",
    atlas = "sleeves",
    pos = { x = 1, y = 0 },
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

CardSleeves.Sleeve {
    key = "astrosleeve",
    atlas = "sleeves",
    pos = { x = 2, y = 0 },
    loc_txt = {
        name = "Astronomy Sleeve",
        text = { "Gain 1 or 2 {C:blue}levels{} for each {C:attention}hand type{}" }
    },
	apply = function(self, back)
    for _, hand in ipairs(G.handlist) do
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
            SMODS.smart_level_up_hand(self, hand, true, math.floor((pseudorandom("astrosleeve") * 2) + 1))
            return true
            end
        }))
    end
end
}