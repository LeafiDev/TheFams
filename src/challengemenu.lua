-- Custom Challenge Menu for The Fams
-- Simple single box for testing

-- Store the original function
 original_challenge_list = nil

-- Scroll tracking
local scroll_offset = 0
local checker_uibox = nil

-- Custom challenge list that returns a simple box
 function custom_challenge_list(from_game_over)
    -- Create checker pattern background
    local checker_rows = {}
    local checker_size = 1.5
    local rows, cols = 25, 25
    
    for i = 1, rows do
        local checker_cols = {}
        for j = 1, cols do
            local is_dark = (i + j) % 2 == 0
            table.insert(checker_cols, {
                n=G.UIT.C, 
                config={
                    minw = checker_size,
                    minh = checker_size,
                    colour = is_dark and adjust_alpha(G.C.FILTER, 0.7) or adjust_alpha(G.C.MONEY, 0.7)
                }
            })
        end
        table.insert(checker_rows, {n=G.UIT.R, config={align = "cm"}, nodes=checker_cols})
    end
    

    local checker_moveable = Moveable()
    local old_update = checker_moveable.update
    checker_moveable.update = function(self, dt)
        if old_update then old_update(self, dt) end
        

        local mouse_y = love.mouse.getY()
        local screen_height = love.graphics.getHeight()
        
        local scroll_threshold = 100 
        local scroll_speed = 200 
        

        if mouse_y < scroll_threshold then
            scroll_offset = scroll_offset + (scroll_speed * dt)

        elseif mouse_y > (screen_height - scroll_threshold) then
            scroll_offset = scroll_offset - (scroll_speed * dt)
        end
        

        local loop_distance = checker_size * 2
        while scroll_offset >= loop_distance do
            scroll_offset = scroll_offset - loop_distance
        end
        while scroll_offset <= -loop_distance do
            scroll_offset = scroll_offset + loop_distance
        end
        

        if checker_uibox then
            checker_uibox.config.offset = {x = 0, y = scroll_offset}
            checker_uibox.UIBox:recalculate()
        end
    end
    
    local result = {n=G.UIT.ROOT, config={align = "cm", size = 5, padding = 0.1, colour = G.C.CLEAR, minh = 25, minw = 25}, nodes={
        -- Checker pattern background layer
        {n=G.UIT.R, config={id = 'checker_pattern', align = "cm", offset = {x = 0, y = 0}, object = checker_moveable}, nodes=checker_rows},
    }}
    
    -- Get reference to the UIBox after creation
    G.E_MANAGER:add_event(Event({
        func = function()
            if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('checker_pattern') then
                checker_uibox = G.OVERLAY_MENU:get_UIE_by_ID('checker_pattern')
            end
            return true
        end
    }))
    
    return result
end

-- Hook into the challenge list
if G.UIDEF then
    original_challenge_list = G.UIDEF.challenge_list
    G.UIDEF.challenge_list = custom_challenge_list
end

return {}
