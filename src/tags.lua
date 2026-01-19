
SMODS.Tag {
    key = "trap",
    loc_txt = {
        name = "Booby Trap",
        text = {
            "{C:red}Kills your run{}"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
     min_ante = 1,
     set_ability = function(self, tag)
        
    end,
     in_pool = function(self, args)
        return true -- Always allow
    end,
     apply = function(self, tag, context)
        tag:yep("X", G.C.RED, function()
            ForceLoss()
            return true
        end)
        tag.triggered = true
    end
}

SMODS.Tag {
    key = "cts",
    loc_txt = {
        name = "Shenron! Grant my wish!",
        text = {
            "Gives up to 3 {C:legendary}legendary{} jokers",
			"{C:inactive}Does NOT need room.{}"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 1, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        tag.ability.rarity = math.random(0.01, 1.00) -- Change this to any rarity (1-4) you want
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", G.C.PURPLE, function()
			for i = 1, math.random(1, 3) do
			SMODS.add_card{
        	set = "Joker",                -- Card type: 'Joker', 'Tarot', 'Spectral', etc.
        	legendary = true,            -- Legendary rarity (true/false)
        	rarity = 1,                -- Direct rarity value (see docs)
        	skip_materialize = false,     -- Skip animation
        	enhanced_poll = 0.5         -- Chance for 'Base' over 'Enhanced'
    		}
		end
            return true
        end)
		tag.triggered = true
	end
}


SMODS.Tag {
    key = "up",
    loc_txt = {
        name = "Confidence",
        text = {
            "{C:attention}Jumps up 3 antes{}"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 2, y = 0 },
    config = {},
    discovered = false,
     min_ante = 1,
     set_ability = function(self, tag)
        
    end,
     in_pool = function(self, args)
        return true -- Always allow
    end,
     apply = function(self, tag, context)
        tag:yep("+", G.C.FILTER, function()
            setAnte(getAnte() + 3)
            return true
        end)
        tag.triggered = true
    end
}

SMODS.Tag {
    key = "down",
    loc_txt = {
        name = "Scaredy Cat",
        text = {
            "{C:attention}Jumps down 3 antes{}"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 3, y = 0 },
    config = {},
    discovered = false,
     min_ante = 4,
     set_ability = function(self, tag)
        
    end,
     in_pool = function(self, args)
        return true
    end,
     apply = function(self, tag, context)
        tag:yep("-", G.C.RED, function()
            setAnte(getAnte() - 3)
            return true
        end)
        tag.triggered = true
    end
}

SMODS.Tag {
    key = "shapeshifter",
    loc_txt = {
        name = "ShapeShifter",
        text = {
            "Becomes {C:attention}Any Tag{} on activate"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 4, y = 0 },
    config = {},
    discovered = false,
     min_ante = 4,
     set_ability = function(self, tag)
        
    end,
     in_pool = function(self, args)
        return true -- Always allow
    end,
     apply = function(self, tag, context)
        tag:yep("+", G.C.GREEN, function()
            -- Get all available tags
            local available_tags = {}
            for k, v in pairs(G.P_TAGS) do
                if k ~= 'tag_fams_shapeshifter' then -- Don't create another shapeshifter
                    table.insert(available_tags, k)
                end
            end
            
            -- Create a random tag
            if #available_tags > 0 then
                local random_tag = pseudorandom_element(available_tags, pseudoseed('shapeshifter'))
                add_tag(Tag(random_tag))
            end
            
            return true
        end)
        tag.triggered = true
    end
}

SMODS.Tag {
    key = "GB",
    loc_txt = {
        name = "Gift Box",
        text = {
            "Triggers a random gift.",
			"{C:inactive}does NOT need room.{}"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 5, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", G.C.GREEN, function()
            GiftBox()
            return true
        end)
		tag.triggered = true
	end
}

SMODS.Tag {
    key = "CH",
    loc_txt = {
        name = "Cheater Tag",
        text = {
            "gives 10 {C:edition}negative{} playing cards."
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 6, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", G.C.PURPLE, function()
			addCardsRandom(10, "negative")
            return true
        end)
		tag.triggered = true
	end
}

SMODS.Tag {
    key = "SS",
    loc_txt = {
        name = "Shining Star",
        text = {
            "Recieve one {C:red,E:1}dawg{}."
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 7, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", fams, function()
			SMODS.add_card{
                area = G.jokers,
                set = "dawgcards",
				no_edition = true
			}
            return true
        end)
		tag.triggered = true
	end
}

SMODS.Tag {
    key = "SS",
    loc_txt = {
        name = "Shining Star",
        text = {
            "Recieve one {C:red,E:1}dawg{}."
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 7, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", fams, function()
			SMODS.add_card{
                area = G.jokers,
                set = "dawgcards",
				no_edition = true
			}
            return true
        end)
		tag.triggered = true
	end
}

SMODS.Tag {
    key = "MBP",
    loc_txt = {
        name = "Mini Buffoon Pack",
        text = {
            "Gives a free",
            "{C:attention}Mini Joker Pack{}"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 8, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_fams_minibooster', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
	end
}

SMODS.Tag {
    key = "al",
    loc_txt = {
        name = "Algebra",
        text = {
            "Gives a free",
            "{C:green,E:1}Poly Pack{}"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 9, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.GREEN, function()
                local booster = SMODS.create_card { key = 'p_fams_poly', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
	end
}

SMODS.Tag {
    key = "feb",
    loc_txt = {
        name = "Febreze, Fa la la la la",
        text = {
            "Disables one {C:attention}boss blind{}"
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 10, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' and isBoss() then
            tag:yep(':D', G.C.GREEN, function()
                G.GAME.blind:disable()
                return true
            end)
            tag.triggered = true
            return true
        end
	end
}

SMODS.Tag {
    key = "rev",
    loc_txt = {
        name = "Uno Reverse",
        text = {
            "Makes 1 Joker {C:attention}free{} in shop", "and gives it's cost back as {C:filter}dollars{}."
        }
    },
    atlas = "tags", -- or your custom atlas
    pos = { x = 11, y = 0 },
    config = {},
    discovered = false,
    min_ante = 4,

    set_ability = function(self, tag)
        
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        if context.type == 'shop_final_pass' and G.shop and not G.GAME.shop_free then
            G.GAME.shop_free = true
            tag:yep('+', G.C.RED, function()
                if G.shop_jokers then
                        card = G.shop_jokers.cards[math.ceil(math.random(1, #G.shop_jokers.cards))]
                        ease_dollars(card.cost)
                        card.ability.couponed = true
                        card:set_cost()
                end
                return true
            end)
            tag.triggered = true
            return true
        end
	end
}