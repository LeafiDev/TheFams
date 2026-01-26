SMODS.Enhancement{
    key = "par",
    loc_txt = {
        name = "Parryable",
        text = {
            "This card can be {C:purple,E:2}parry slapped{}"
        },
    },
    atlas = "enhance",
    pos = { x = 0, y = 0 },
    config = {
        
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    apply = function(self, card)
        
    end,
    remove = function(self, card)
        
    end,
    calculate = function(self, card, context)
        
    end,
}

SMODS.Enhancement{
    key = "wireframe",
    loc_txt = {
        name = "Wireframe",
        text = {
            "{C:red}+20{} mult",
            "{C:inactive}Does not count as a rank or suit{}"
        },
    },
    atlas = "enhance",
    pos = { x = 1, y = 0 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = {
        
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    apply = function(self, card)
        
    end,
    remove = function(self, card)
        
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
        return { mult = 20 }
        end
    end,
}

SMODS.Enhancement{
    key = "wireframe",
    loc_txt = {
        name = "Wireframe",
        text = {
            "{C:red}+20{} mult",
            "{C:inactive}Does not count as a rank or suit{}"
        },
    },
    atlas = "enhance",
    pos = { x = 1, y = 0 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = {
        
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    apply = function(self, card)
        
    end,
    remove = function(self, card)
        
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
        return { mult = 20 }
        end
    end,
}

SMODS.Enhancement{
    key = "munched",
    loc_txt = {
        name = "Munched",
        text = {
            "{C:inactive}This card half works now, So not like ranks or suits count right?{}"
        },
    },
    atlas = "enhance",
    pos = { x = 2, y = 0 },
    always_scores = true,
    config = {
        
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    apply = function(self, card)
        
    end,
    remove = function(self, card)
        
    end,
    calculate = function(self, card, context)
        
    end,
}