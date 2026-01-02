SMODS.Booster {
    key = "poly",
    loc_txt = {
    name = "Standard Poly Pack",
    group_name = "Poly Pack",
    text = { "Select {C:attention}1{} of {C:attention}3{}",
	"{X:green,C:white}Geometric{} {X:green,C:white}Shapes{}" } 
	},
    atlas = "boosters", -- or your custom atlas key
    pos = { x = 0, y = 0 },
	draw_hand = true,
    cost = 4,
    weight = 0.35,
    config = { extra = 3, choose = 1 }, -- 3 cards, choose 1
	create_card = function(self, card, i)
        return { set = "geometry", area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "fams" }
    end
}



SMODS.Booster {
    key = "jpoly",
    loc_txt = {
    name = "Jumbo Poly Pack",
    group_name = "Poly Pack",
    text = { "Select {C:attention}2{} of {C:attention}6{}",
	"{X:green,C:white}Geometric{} {X:green,C:white}Shapes{}" } 
	},
    atlas = "boosters", -- or your custom atlas key
    pos = { x = 1, y = 0 },
	draw_hand = true,
    cost = 4,
    weight = 0.15,
    config = { extra = 6, choose = 2 }, -- 3 cards, choose 1
    create_card = function(self, card, i)
        return { set = "geometry", area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "fams" }
    end
}



SMODS.Booster {
    key = "stupid",
    loc_txt = {
    name = "Stupid Pack",
    group_name = "Stupid Pack",
    text = { "Select {C:attention}1{} of {C:attention}3{}",
	"{C:attention}Useless cards.{}" } 
	},
    atlas = "boosters", -- or your custom atlas key
    pos = { x = 3, y = 0 },
	draw_hand = true,
    cost = 0,
    weight = 0.5,
    config = { extra = 5, choose = 3 }, -- 3 cards, choose 1
    create_card = function(self, card, i)
    local allowed_jokers = { "j_fams_bigboobs", "j_fams_halo", "j_fams_spawn", "j_fams_smurf", "j_fams_penny", "j_fams_nickel", "j_fams_dime", "j_fams_quarter", "j_fams_doller" } -- Add your joker keys here
    local joker_key = allowed_jokers[math.random(#allowed_jokers)]
    return {
        set = "Joker",
        key = joker_key,
        area = G.pack_cards,
        skip_materialize = true,
        soulable = false,
        key_append = "fams"
    }
end
}



SMODS.Booster {
    key = "minibooster",
    loc_txt = {
    name = "Mini Pack",
    group_name = "Stupid Pack",
    text = { "Select {C:attention}1{} of {C:attention}3{}",
	"{C:attention}Mini Jokers.{}" } 
	},
    atlas = "boosters", -- or your custom atlas key
    pos = { x = 2, y = 0 },
	draw_hand = true,
    cost = 2,
    weight = 1,
	select_card = "consumeables",
    config = { extra = 3, choose = 1 }, -- 3 cards, choose 1
    create_card = function(self, card, i)
		local allowed_jokers = {
			"m-joker",
			"m-pt",
			"m-planet",
			"m-burg",
			"m-scallywag",
			"m-dice",
			"m-coupon",
			"m-si",
			"m-m",
			"m-c",
			"m-b",
			"m-g",
			"m-stargrab",
			"m-scratch",
			"m-robux"
		}
    local joker_key = "c_fams_"..tostring(allowed_jokers[math.random(#allowed_jokers)])
	return {
		set = "mini-joker",
		key = joker_key,
		area = G.pack_cards,
		skip_materialize = true,
		soulable = false,
		key_append = "fams"
	}
end
}