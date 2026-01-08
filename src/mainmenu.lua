local original_main_menu = Game.main_menu
Game.main_menu = function(self, change_context)
     if not title_screen_randomized then
         title_variant = 1
        title_screen_randomized = true
    else
        math.randomseed(os.time())
        
        title_variant = math.random(11, 11)
    end
     local title_logos = {
        [1] = {atlas = "balatro", pos = {x = 0, y = 0}}, 
        [2] = {atlas = "balatro2", pos = {x = 0, y = 0}}, 
		[3] = {atlas = "balatro3", pos = {x = 0, y = 0}}, 
		[4] = {atlas = "balatro4", pos = {x = 0, y = 0}}, 
		[5] = {atlas = "balatro5", pos = {x = 0, y = 0}}, 
		[6] = {atlas = "balatro6", pos = {x = 0, y = 0}}, 
        [7] = {atlas = "balatro13", pos = {x = 0, y = 0}}, 
        [8] = {atlas = "balatro8", pos = {x = 0, y = 0}}, 
        [9] = {atlas = "balatro", pos = {x = 0, y = 0}}, 
        [10] = {atlas = "balatro12", pos = {x = 0, y = 0}}, 
        [11] = {atlas = "balatro14", pos = {x = 0, y = 0}}, 
    }
    
    local selected_logo = title_logos[title_variant] or title_logos[1]
    if G.ASSET_ATLAS[selected_logo.atlas] then
         G.ASSET_ATLAS["balatro"] = G.ASSET_ATLAS[selected_logo.atlas]
    else
    end
     original_main_menu(self, change_context)
      if G.title_top then
        G.title_top.config.card_limit = 8  -- Allow up to 8 cards
         local original_width = G.title_top.T.w
         G.title_top.T.w = G.title_top.T.w * 8
         G.title_top.T.x = G.title_top.T.x - (G.title_top.T.w - original_width) / 2
        G.title_top:hard_set_T()  -- Apply the changes
    end
     G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0,
        func = function()
            if G.title_top and G.title_top.cards then
                 for i = #G.title_top.cards, 1, -1 do
                    local card = G.title_top.cards[i]
                    if card then
                        card:remove()
                    end
                end
                G.title_top.cards = {}
                 local variants = {
                     {
						{key = "j_fams_butterdog", x = 1.5, y = 0},
                        {key = "j_fams_yogi", x = -1.5, y = 0},
                        {key = "j_fams_earl", x = 0, y = -1.5},
                        {key = "j_fams_bear", x = 1.5, y = 0},
						{key = "j_fams_radiation", x = 1.5, y = 0}
                    },
                    {
                        {key = "j_fams_steve", x = -1.5, y = 0},
                        {key = "j_fams_bob", x = -0.5, y = 0},
                        {key = "j_fams_joe", x = 0.5, y = 0},
						{key = "j_fams_tidywhitey", x = 1.5, y = 0},
						{key = "j_fams_purple", x = 1.5, y = 0}
                        
                    },
					{
                        {key = "j_even_steven", x = -1.5, y = 0},
                        {key = "j_fams_divorce", x = -0.5, y = 0},
                        {key = "j_odd_todd", x = 0.5, y = 0},
                    },
					{
                        {key = "j_fams_wouldyourather", x = 0.5, y = 0},
                    },
					{
                        {key = "j_fams_skeleton", x = 0.5, y = 0},
                    },
					{
                        {key = "j_fams_ritz", x = 0.5, y = 0},
                        {key = "j_fams_coke", x = -0.5, y = 0}
                    },
                    {
                        {key = "c_fams_flushofdog", x = 0, y = 0},
                    },
                    {
                        {key = "c_fams_m-joker", x = 0, y = 0}
                    },
                    {
                        {key = "c_fams_fatboi", x = -1, y = 0},
                        {key = "c_fams_yogee", x = -0.5, y = 0},
                        {key = "c_fams_baer", x = 0, y = 0},
                        {key = "c_fams_toebee", x = 0.5, y = 0},
                        {key = "c_fams_buttergod", x = 1, y = 0}
                    },
                    {
                        {key = "v_fams_fl", x = 0, y = 0},
                    },
                    {
                        {key = "c_fams_dotcard", x = 0, y = 0},
                        {key = "c_fams_line", x = 0, y = 0},
                        {key = "c_fams_triangle", x = 0, y = 0},
                        {key = "c_fams_square", x = 0, y = 0},
                        {key = "c_fams_pentcard", x = 0, y = 0},
                        {key = "c_fams_hexcard", x = 0, y = 0},
                    }
                }
                
                -- Function to get all cards of any type
                local function get_all_cards()
                    local all_cards = {}
                    if G.P_CENTERS then
                        for key, card_center in pairs(G.P_CENTERS) do
                            if card_center.can_spend ~= false then -- Exclude non-spendable cards
                                table.insert(all_cards, {key = key, x = 0, y = 0})
                            end
                        end
                    end
                    return all_cards
                end
                 local selected_variant = variants[title_variant] or variants[1]
                 
                 -- If selected_variant is empty or we want to use all cards, get them dynamically
                 local cards_to_display = selected_variant
                 if not cards_to_display or #cards_to_display == 0 then
                    cards_to_display = get_all_cards()
                    -- Limit to 8 cards for display purposes
                    local limited_cards = {}
                    for i = 1, math.min(8, #cards_to_display) do
                        limited_cards[i] = cards_to_display[i]
                    end
                    cards_to_display = limited_cards
                 end
                 for i, card_info in ipairs(cards_to_display) do
                    local card_center = G.P_CENTERS[card_info.key]
                    if card_center then
                        local joker_card = Card(
                            G.title_top.T.x + (card_info.x or 0) * G.CARD_W, 
                            G.title_top.T.y + (card_info.y or 0) * G.CARD_H, 
                            1.2 * G.CARD_W, 
                            1.2 * G.CARD_H, 
                            nil, 
                            card_center
                        )
                        G.title_top:emplace(joker_card)
                        joker_card.states.visible = true
                        joker_card.no_ui = true
                        joker_card.ambient_tilt = 0.0
                        joker_card.title_card_index = i
                    end
                end
                 G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    delay = 2, -- Change sprites every 2 seconds
                    repeatable = true,
                    func = function()
                        if G.title_top and G.title_top.cards and G.STATE == G.STATES.MAIN_MENU then
                            -- Get a list of all available cards
                            local all_card_keys = {}
                            if G.P_CENTERS then
                                for key, card_center in pairs(G.P_CENTERS) do
                                    if card_center.can_spend ~= false then
                                        table.insert(all_card_keys, key)
                                    end
                                end
                            end
                            
                            if #all_card_keys > 0 then
                                for _, card in ipairs(G.title_top.cards) do
                                    if card.title_card_index then
                                        local current_time = math.floor(G.TIMERS.REAL / 2) -- Change every 2 seconds
                                        local sprite_index = ((current_time + card.title_card_index) % #all_card_keys) + 1
                                        local new_center = G.P_CENTERS[all_card_keys[sprite_index]]
                                        
                                        if new_center and card.config.center ~= new_center then
                                            card.config.center = new_center
                                            card:set_sprites(card.config.center, card.config.card)
                                            card:juice_up(0.1, 0.1) -- Add a small juice effect when changing
                                        end
                                    end
                                end
                            end
                        end
                        return G.STATE == G.STATES.MAIN_MENU -- Continue only if still in main menu
                    end
                }))
            end
            return true
        end
    }))
end