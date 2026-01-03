
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
        return true -- Always allow
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