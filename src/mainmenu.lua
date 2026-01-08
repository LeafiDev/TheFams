local original_main_menu = Game.main_menu
Game.main_menu = function(self, change_context)
     if not title_screen_randomized then
         title_variant = 1
        title_screen_randomized = true
    else
          local variants_list = {1, 2, 3, 4, 5, 6, 7}
        math.randomseed(os.time())
        math.random(); math.random(); math.random() -- warm up
        
        local random_index = math.random(#variants_list)
        local random_num = variants_list[random_index]
        
        title_variant = random_num
    end
     local title_logos = {
        [1] = {atlas = "balatro", pos = {x = 0, y = 0}}, -- Default Balatro
        [2] = {atlas = "balatro2", pos = {x = 0, y = 0}}, -- Variant 2
		[3] = {atlas = "balatro3", pos = {x = 0, y = 0}}, -- Variant 2
		[4] = {atlas = "balatro4", pos = {x = 0, y = 0}}, -- Variant 2
		[5] = {atlas = "balatro5", pos = {x = 0, y = 0}}, -- Variant 2
		[6] = {atlas = "balatro6", pos = {x = 0, y = 0}}, -- Variant 2
        [7] = {atlas = "balatro7", pos = {x = 0, y = 0}}, -- Variant 2
    }
    
    local selected_logo = title_logos[title_variant] or title_logos[1]
    if G.ASSET_ATLAS[selected_logo.atlas] then
         G.ASSET_ATLAS["balatro"] = G.ASSET_ATLAS[selected_logo.atlas]
    else
    end
     original_main_menu(self, change_context)
      if G.title_top then
        G.title_top.config.card_limit = 8  -- Allow up to 4 cards
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
                        {key = "j_fams_radiation", x = -0.5, y = 0},
                        {key = "j_fams_radiationevil", x = 0.5, y = 0}
                    }
                }
                 local selected_variant = variants[title_variant] or variants[1]
                 for i, card_info in ipairs(selected_variant) do
                    local joker_card = Card(
                        G.title_top.T.x + card_info.x * G.CARD_W, 
                        G.title_top.T.y + card_info.y * G.CARD_H, 
                        1.2 * G.CARD_W, 
                        1.2 * G.CARD_H, 
                        nil, 
                        G.P_CENTERS[card_info.key]
                    )
                    G.title_top:emplace(joker_card)
                    joker_card.states.visible = true
                    joker_card.no_ui = true
                    joker_card.ambient_tilt = 0.0
                     joker_card.title_card_index = i
                end
                 G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    delay = 2, -- Change sprites every 2 seconds
                    repeatable = true,
                    func = function()
                        if G.title_top and G.title_top.cards and G.STATE == G.STATES.MAIN_MENU then
                            for _, card in ipairs(G.title_top.cards) do
                                if card.title_card_index then
                                     local joker_keys = {"j_fams_earl", "j_fams_stressed", "j_fams_mus", "j_fams_yogi", "j_fams_bear"}
                                    local current_time = math.floor(G.TIMERS.REAL / 2) -- Change every 2 seconds
                                    local sprite_index = ((current_time + card.title_card_index) % #joker_keys) + 1
                                    local new_center = G.P_CENTERS[joker_keys[sprite_index]]
                                    
                                    if new_center and card.config.center ~= new_center then
                                         card.config.center = new_center
                                        card:set_sprites(card.config.center, card.config.card)
                                        card:juice_up(0.1, 0.1) -- Add a small juice effect when changing
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