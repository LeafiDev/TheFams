SMODS.PokerHand {
    key = 'Flush Two Pair',
    mult = 4,
    chips = 60,
    l_mult = 2,
    l_chips = 35,
    example = {
        { 'H_K', true },
        { 'H_K', true },
        { 'H_9', true },
        { 'H_9', true },
        { 'D_3', false }
    },
    order_offset = -3,
    loc_txt = {
        name = 'Flush Two Pair',
        description = {
            'Two pairs where all 4',
            'paired cards share a suit'
        }
    },
    visible = true,
    evaluate = function(parts, hand)
        -- Check if we have at least 2 pairs
        if not parts._2 or #parts._2 < 2 then
            return {}
        end
        
        -- Get all cards that are part of pairs
        local pair_cards = SMODS.merge_lists(parts._2)
        
        -- Check if all pair cards share the same suit
        if #pair_cards >= 4 then
            local first_suit = pair_cards[1].base.suit
            local same_suit = true
            
            for i = 2, 4 do
                if pair_cards[i].base.suit ~= first_suit then
                    same_suit = false
                    break
                end
            end
            
            if same_suit then
                return { pair_cards }
            end
        end
        
        return {}
    end
}

SMODS.PokerHand {
    key = 'binary',
    mult = 12,
    chips = 270,
    l_mult = 16,
    l_chips = 160,
    example = {
        { 'H_1', true },
        { 'C_2', true },
        { 'S_4', true },
        { 'D_8', true },
        { 'H_5', false }
    },
    loc_txt = {
        name = 'Four Bit Binary',
        description = {
            'A hand that contains',
            'cards with 1, 2, 4, and 8 as ranks',
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        -- Check for dog jokers
        local has1 = false
        local has2 = false
        local has4 = false
        local has8 = false
        local scorevalid = {}
        if hand then
            for _, c in ipairs(hand) do
                if c.base.nominal == 1 then 
                has1 = true 
                table.insert(scorevalid, c)
                end
                if c.base.nominal == 2 then 
                has2 = true 
                table.insert(scorevalid, c)
                end
                if c.base.nominal == 4 then 
                has4 = true 
                table.insert(scorevalid, c)
                end
                if c.base.nominal == 8 then 
                has8 = true 
                table.insert(scorevalid, c)
                end
            end
        end
        if has1 and has2 and has4 and has8 then
        return {scorevalid}
        end
    end
}

SMODS.PokerHand {
    key = 'flushofdog',
    mult = 5,
    chips = 120,
    l_mult = 2,
    l_chips = 50,
    example = {
        { 'H_K', true },
        { 'H_7', true },
        { 'H_4', true },
        { 'H_5', true },
        { 'H_2', true }
    },
    loc_txt = {
        name = 'Flush of dog',
        description = {
            'A flush, but only valid',
            'if a dog joker is present'
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        -- Check for dog jokers
        local has_dog_joker = false
        if G and G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                local joker_key = joker.config.center.key
                if joker_key == 'j_fams_earl' or 
                   joker_key == 'j_fams_butterdog' or 
                   joker_key == 'j_fams_yogi' or 
                   joker_key == 'j_fams_bear' or 
                   joker_key == 'j_fams_radiation' then
                    has_dog_joker = true
                    break
                end
            end
        end
        
        -- Only valid if we have a dog joker AND a flush
        if has_dog_joker and next(parts._flush or {}) then
            return { hand }
        end
        
        return {}
    end
}

SMODS.PokerHand {
    key = 'nice',
    mult = 6,
    chips = 9,
    l_mult = 0,
    l_chips = 0,
    order_offset = -8,
    example = {
        { 'D_6', true },
        { 'H_9', true },
        { 'S_4', false },
        { 'D_8', false },
        { 'H_5', false }
    },
    loc_txt = {
        name = 'Nice',
        description = {
            'A hand that contains',
            '6 and 9',
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        local has6 = false
        local has9 = false
        local scorevalid = {}
        if hand then
            for _, c in ipairs(hand) do
                if c.base.nominal == 6 then 
                has6 = true 
                table.insert(scorevalid, c)
                end
                if c.base.nominal == 9 then 
                has9 = true 
                table.insert(scorevalid, c)
                end
            end
        end
        if has6 and has9 and #G.hand.highlighted == 2 then
            return {scorevalid}
        end
    end
}

SMODS.PokerHand {
    key = 'kys',
    mult = -999,
    chips = -999,
    l_mult = -999,
    l_chips = -999,
    order_offset = -7,
    example = {
        { 'H_6', true },
        { 'C_7', true },
        { 'S_4', false },
        { 'D_8', false },
        { 'H_5', false }
    },
    loc_txt = {
        name = 'Shut the fuck up',
        description = {
            'A hand that contains',
            '6 and 7 alone (shut the fuck up)',
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        local has6 = false
        local has7 = false
        local scorevalid = {}
        if hand then
            for _, c in ipairs(hand) do
                if c.base.nominal == 6 then 
                has6 = true 
                table.insert(scorevalid, c)
                end
                if c.base.nominal == 7 then 
                has7 = true 
                table.insert(scorevalid, c)
                end
            end
        end
        if has6 and has7 and #G.hand.highlighted == 2 then
            return {scorevalid}
        end
    end
}