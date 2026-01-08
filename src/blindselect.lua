
function create_UIBox_blind_select()
  G.blind_prompt_box = UIBox{
    definition =
      {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = localize('ph_choose_blind_1'), colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.6, pop_in = 0.5, maxw = 5}), id = 'prompt_dynatext1'}}
        }},
        {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = localize('ph_choose_blind_2'), colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.7, pop_in = 0.5, maxw = 5, silent = true}), id = 'prompt_dynatext2'}}
        }},
        (G.GAME.used_vouchers["v_retcon"] or G.GAME.used_vouchers["v_directors_cut"]) and
        UIBox_button({label = {localize('b_reroll_boss'), localize('$')..'10'}, button = "reroll_boss", func = 'reroll_boss_button'}) or nil
      }},
    config = {align="cm", offset = {x=0,y=-15},major = G.HUD:get_UIE_by_ID('row_blind'), bond = 'Weak'}
  }
  G.E_MANAGER:add_event(Event({
    trigger = 'immediate',
    func = (function()
        G.blind_prompt_box.alignment.offset.y = 0
        return true
    end)
  }))

  local width = G.hand.T.w
  G.GAME.blind_on_deck = 
    not (G.GAME.round_resets.blind_states.Small == 'Defeated' or G.GAME.round_resets.blind_states.Small == 'Skipped' or G.GAME.round_resets.blind_states.Small == 'Hide') and 'Small' or
    not (G.GAME.round_resets.blind_states.Big == 'Defeated' or G.GAME.round_resets.blind_states.Big == 'Skipped'or G.GAME.round_resets.blind_states.Big == 'Hide') and 'Big' or 
    'Boss'
  
  G.blind_select_opts = {}
  local blind_types = {}
  for blind_type, state in pairs(G.GAME.round_resets.blind_states) do
    if state ~= 'Hide' then
      table.insert(blind_types, blind_type)
    end
  end
  
  -- Create UI boxes dynamically with positioning
  for idx, blind_type in ipairs(blind_types) do
    local offset_x = 0
    if idx > 3 then
      offset_x = (idx - 3) * 3.5  -- Shift each one past 3 by 3.5 units
    end
    G.blind_select_opts[blind_type] = UIBox{
      definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, 
        nodes={UIBox_dyn_container({create_UIBox_blind_choice(blind_type)},false,get_blind_main_colour(blind_type))}
      }, 
      config = {align="bmi", offset = {x=offset_x,y=0}}
    }
  end
 
  local blind_nodes = {}
  for _, blind_type in ipairs(blind_types) do
    if G.blind_select_opts[blind_type] then
      table.insert(blind_nodes, {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts[blind_type]}})
    end
  end

  local t = {n=G.UIT.ROOT, config = {align = 'tm',minw = width, r = 0.15, colour = G.C.CLEAR}, nodes={
    {n=G.UIT.R, config={align = "cm", padding = 0.5}, nodes=blind_nodes}
  }}
  return t 
end