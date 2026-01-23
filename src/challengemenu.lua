-- Custom Challenge Menu for The Fams
-- Simple single box for testing

--[[ Store the original function
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
]]

-- new

function G.UIDEF.challenge_list(from_game_over)
  G.CHALLENGE_PAGE_SIZE = 10
  local challenge_pages = {}
  for i = 1, math.ceil(#G.CHALLENGES/G.CHALLENGE_PAGE_SIZE) do
    table.insert(challenge_pages, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#G.CHALLENGES/G.CHALLENGE_PAGE_SIZE)))
  end
  G.E_MANAGER:add_event(Event({func = (function()
    G.FUNCS.change_challenge_list_page{cycle_config = {current_option = 1}}
  return true end)}))

  local _ch_comp, _ch_tot = 0,#G.CHALLENGES
  for k, v in ipairs(G.CHALLENGES) do
    if v.id and G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or ''] then
      _ch_comp = _ch_comp + 1
    end
  end

  local t = create_UIBox_generic_options({ back_id = from_game_over and 'from_game_over' or nil, back_func = 'setup_run', back_id = 'challenge_list', contents = {
    {n=G.UIT.C, config={align = "cm", padding = 0.0}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.1, minh = 7, minw = 4.2}, nodes={
        {n=G.UIT.O, config={id = 'challenge_list', object = Moveable()}},
      }},
      {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
        create_option_cycle({id = 'challenge_page',scale = 0.9, h = 0.3, w = 3.5, options = challenge_pages, cycle_shoulders = true, opt_callback = 'change_challenge_list_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true}})
      }},
      {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
        {n=G.UIT.T, config={text = localize{type = 'variable', key = 'challenges_completed', vars = {_ch_comp, _ch_tot}}, scale = 0.4, colour = G.C.WHITE}},
      }},

    }},
    {n=G.UIT.C, config={align = "cm", minh = 9, minw = 11.5}, nodes={
      {n=G.UIT.O, config={id = 'challenge_area', object = Moveable()}},
    }},
  }})
  return t
end

function G.UIDEF.challenge_list_page(_page)
  local snapped = false
  local challenge_list = {}
  for k, v in ipairs(G.CHALLENGES) do
    if k > G.CHALLENGE_PAGE_SIZE*(_page or 0) and k <= G.CHALLENGE_PAGE_SIZE*((_page or 0) + 1) then
      if G.CONTROLLER.focused.target and G.CONTROLLER.focused.target.config.id == 'challenge_page' then snapped = true end
      local challenge_completed =  G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or '']
      local challenge_unlocked = G.PROFILES[G.SETTINGS.profile].challenges_unlocked and (G.PROFILES[G.SETTINGS.profile].challenges_unlocked >= k)

      challenge_list[#challenge_list+1] = 
      {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.C, config={align = 'cl', minw = 0.8}, nodes = {
          {n=G.UIT.T, config={text = k..'', scale = 0.4, colour = G.C.WHITE}},
        }},
        UIBox_button({
          id = k, col = true,
          label = {challenge_unlocked and localize(v.id, 'challenge_names') or localize('k_locked')},
          button = challenge_unlocked and 'change_challenge_description' or 'nil',
          colour = challenge_unlocked and G.C.RED or G.C.GREY,
          minw = 4, scale = 0.4, minh = 0.6, focus_args = {snap_to = not snapped},
          func = challenge_unlocked and function()
            G.E_MANAGER:add_event(Event({
              func = function()
                G.OVERLAY_MENU:remove_self()
                G.OVERLAY_MENU = UIBox({
                  n = G.UIT.ROOT,
                  config = {align = "cm", padding = 0.2, colour = G.C.CLEAR, minh = 5, minw = 5},
                  nodes = {
                    {n = G.UIT.T, config = {text = "Custom Menu Opened!", scale = 0.5, colour = G.C.WHITE}},
                    UIBox_button({label = {"Back"}, func = function()
                      G.OVERLAY_MENU:remove_self()
                      G.OVERLAY_MENU = UIBox(G.UIDEF.challenge_list_page(_page))
                    end})
                  }
                })
                return true
              end
            }))
          end or nil
        }),
        {n=G.UIT.C, config={align = 'cm', padding = 0.05, minw = 0.6}, nodes = {
          {n=G.UIT.C, config={minh = 0.4, minw = 0.4, emboss = 0.05, r = 0.1, colour = challenge_completed and G.C.GREEN or G.C.BLACK}, nodes = {
            challenge_completed and {n=G.UIT.O, config={object = Sprite(0,0,0.4,0.4, G.ASSET_ATLAS["icons"], {x=1, y=0})}} or nil
          }},
        }},
      }}      
      snapped = true
    end
  end

  return {n=G.UIT.ROOT, config={align = "cm", padding = 0.1, colour = G.C.CLEAR}, nodes=challenge_list}
end