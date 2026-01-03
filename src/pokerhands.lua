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
    loc_txt = {
        name = 'Flush Two Pair',
        description = {
            'Two pairs where all 4',
            'paired cards share a suit'
        }
    },
    visible = false,
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