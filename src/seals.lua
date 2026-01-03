
SMODS.Seal {
    key = "cool_seal",
    loc_txt = {
        name = "Cool Certification",
        label = "Cool",
        text = {
            "{C:edition,E:1}This card is cool B){}."
        }
    },
    atlas = "seals",
    pos = { x = 0, y = 0 },
    badge_colour = HEX('fffb00'),
    config = {cool = true},               -- Any custom config values
    calculate = function(self, card, context)
    end,
}

SMODS.Seal {
    key = "don_seal",
    loc_txt = {
        name = "Don",
        label = "Don",
        text = {"Plays a {C:mult}Don{} and gives {X:mult,C:white}1.2x{} mult",
	"if on the last card of a pattern of 5 of {C:mult}Don's{} and or {C:chips}ka's{}",
	"gives {X:mult,C:white}5x{} mult instead"}
    },
    atlas = "seals",
    pos = { x = 1, y = 0 },
    badge_colour = HEX('F04827'),
    config = {},
    calculate = function(self, card, context)
		if context.before and context.cardarea == G.play then
			drums = 0
		end
         if not hasSeal(card, "fams_don_seal") then return end
        if context.main_scoring and context.cardarea == G.play then
			drums = drums + 1
			if drums == 5 then
				drums = 0
				return {message = "Donderful!", colour = G.C.chips, sound = "fams_donderfulS", repetition = 1, xmult = 5}
			end
            return {message = "Don!",  colour = G.C.red, sound = "fams_Don", xmult = 1.2}
        end
    end,
}

SMODS.Seal {
    key = "ka_seal",
    loc_txt = {
        name = "Katsu",
        label = "Katsu",
        text = {
            "Plays a {C:chips}Katsu{} and gives {X:chips,C:white}1.2x{} chips",
	"if on the last card of a pattern of 5 of {C:mult}Don's{} and or {C:chips}ka's{}",
	"gives {X:chips,C:white}5x{} chips instead"
        }
    },
    atlas = "seals",
    pos = { x = 2, y = 0 },
    badge_colour = HEX('5dc0bc'),
    config = {},               -- Any custom config values
    calculate = function(self, card, context)
		if context.before and context.cardarea == G.play then
			drums = 0
		end
         if not hasSeal(card, "fams_ka_seal") then return end
        if context.main_scoring and context.cardarea == G.play then
			drums = drums + 1
			if drums == 5 then
				drums = 0
				return {message = "Donderful!", colour = G.C.chips, sound = "fams_donderfulS", repetition = 1, chips = G.GAME.current_round.current_hand.chips * 5}
			end
            return {message = "katsu!", colour = G.C.chips, sound = "fams_Katsu", repetition = 1, chips = G.GAME.current_round.current_hand.chips * 1.2}
        end
    end,
	
}

SMODS.Seal {
    key = "dot",
    loc_txt = {
        name = "Dot",
        label = "Geometry",
        text = {"{X:mult,C:white}+1{} mult."}
    },
    atlas = "seals",
    pos = { x = 3, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
			return {mult = 1}
        end
    end,
}


SMODS.Seal {
    key = "bilateral",
    loc_txt = {
        name = "bilateral",
        label = "Geometry",
        text = {"{X:mult,C:white}X2{} mult."}
    },
    atlas = "seals",
    pos = { x = 4, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
			return {xmult = 2}
        end
    end,
}


SMODS.Seal {
    key = "tri",
    loc_txt = {
        name = "Trilateral",
        label = "Geometry",
        text = {"{X:mult,C:white}X3{} mult."}
    },
    atlas = "seals",
    pos = { x = 5, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
			return {xmult = 3}
        end
    end,
}


SMODS.Seal {
    key = "quad",
    loc_txt = {
        name = "Quadrilateral",
        label = "Geometry",
        text = {"{X:mult,C:white}X4{} mult."}
    },
    atlas = "seals",
    pos = { x = 6, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
         if context.main_scoring and context.cardarea == G.play then
			return {xmult = 4}
        end
    end,
	
}


SMODS.Seal {
    key = "pent",
    loc_txt = {
        name = "Pentagon",
        label = "Geometry",
        text = {"{X:mult,C:white}X5{} mult."}
    },
    atlas = "seals",
    pos = { x = 7, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
         if context.main_scoring and context.cardarea == G.play then
			return {xmult = 5}
        end
    end,
	
}


SMODS.Seal {
    key = "hex",
    loc_txt = {
        name = "Hexagon",
        label = "Geometry",
        text = {"{X:mult,C:white}X6{} mult."}
    },
    atlas = "seals",
    pos = { x = 8, y = 0 },
    badge_colour = HEX('00FF33'),
    config = {},
    calculate = function(self, card, context)
         if context.main_scoring and context.cardarea == G.play then
			return {xmult = 6}
        end
    end,
	
}