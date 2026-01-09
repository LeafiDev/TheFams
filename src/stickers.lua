SMODS.Sticker{
    key = "sale",
    loc_txt = {
        name = "ON SALE!",
        text = {"{C:green}1 in 10{} to {C:red}sell{} your {C:attention}Joker{} automatically",
				"On {C:attention}hand played{}"},
        label = "ON SALE!"
    },
    atlas = "stickers",
    pos = {x = 0, y = 0},
    badge_colour = {1, 0.5, 0, 1},
    hide_badge = false,
    default_compat = true,
    compat_exceptions = {"e_eternal"},
    sets = {Joker = true},
    rate = 1,
    needs_enable_flag = false,
    calculate = function(self, card, context)
        if context.joker_main and math.random(1, 5) == 1 then
            if card.sell_cost and card.sell_cost > 0 and not card.ability.eternal then
                card:remove(true)
                return {message = "SOLD!", dollars = card.sell_cost, colour = G.C.MONEY}
            end
        end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		if math.random(1, 25) > math.random(1, 25) then
        return center.set == "Joker" and GetStake() == 10
		end
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
}

SMODS.Sticker{
    key = "EXsale",
    loc_txt = {
        name = "BLACK FRIDAY SALE!",
        text = {"{C:green}1 in 5{} to {C:red}sell{} your {C:attention}Joker{} automatically",
				"On {C:attention}hand played{}",
				"{C:inactive}Gain half the sell value{}"},
        label = "BLACK FRIDAY SALE!"
    },
    atlas = "stickers",
    pos = {x = 1, y = 0},
    badge_colour = {1, 0.5, 0, 1},
    hide_badge = false,
    default_compat = true,
    compat_exceptions = {"e_eternal"},
    sets = {Joker = true},
    rate = 1,
    needs_enable_flag = false,
    calculate = function(self, card, context)
        if context.joker_main and math.random(1, 5) == 1 then
            if card.sell_cost and card.sell_cost > 0 and not card.ability.eternal then
                card:remove(true)
                return {message = "SOLD!", dollars = card.sell_cost / 2, colour = G.C.MONEY}
            end
        end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        return center.set == "Joker" and isChallenge("BF")
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
}