function G.UIDEF.run_info()
  return create_UIBox_generic_options({contents ={create_tabs(
    {tabs = {
          {
            label = localize('b_poker_hands'),
            chosen = true,
            tab_definition_function = create_UIBox_current_hands,
        },
        {
          label = localize('b_blinds'),
          tab_definition_function = G.UIDEF.current_blinds,
        },
        {
            label = localize('b_vouchers'),
            tab_definition_function = G.UIDEF.used_vouchers,
        },
        {
          label = 'Parameters',
          tab_definition_function = G.UIDEF.params,
        },
        {
          label = 'Banned',
          tab_definition_function = G.UIDEF.banned_items,
        },
        G.GAME.stake > 1 and {
          label = localize('b_stake'),
          tab_definition_function = G.UIDEF.current_stake,
        } or nil,
    },
    tab_h = 8,
    snap_to_nav = true})}})
end

function G.UIDEF.params()
  local rows = {}
  rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Global Game Parameters"}, hover = true, colours = {G.C.WHITE}, shadow = true, scale = 1, maxw = 6})}}}}
  rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.5}, nodes={{n=G.UIT.O, config={object = DynaText({string = {""}, hover = true, colours = {G.C.WHITE}, shadow = true, scale = 1, maxw = 6})}}}}

  if G and G.GAME and G.GAME.starting_params and next(G.GAME.starting_params) then
    if isChallenge("BR") then
       rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Boss Rush Progress "..tostring(G.GAME.antes_done.."/"..#allnonbosses())}, colours = {G.C.WHITE}, hover = true, shadow = true, scale = 0.5, maxw = 6})}}}}
    end
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Bankrupt Threshold: "..tostring(G.GAME.bankrupt_at)}, hover = true, colours = {G.C.WHITE}, shadow = true, scale = 0.5, maxw = 6})}}}}
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Ante Scale: "..tostring(G.GAME.starting_params.ante_scaling)}, hover = true, colours = {G.C.WHITE}, shadow = true, scale = 0.5, maxw = 6})}}}}
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Vouchers Available: "..tostring(G.GAME.starting_params.vouchers_in_shop)}, hover = true, colours = {G.C.WHITE}, shadow = true, scale = 0.5, maxw = 6})}}}}
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Total Skips: "..tostring(G.GAME.skips)}, colours = {G.C.WHITE}, hover = true, shadow = true, scale = 0.5, maxw = 6})}}}}
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Probability: "..tostring(G.GAME.probabilities.normal)}, colours = {G.C.WHITE}, hover = true, shadow = true, scale = 0.5, maxw = 6})}}}}
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Tarot Rate : "..tostring(G.GAME.tarot_rate)}, colours = {G.C.WHITE}, hover = true, shadow = true, scale = 0.5, maxw = 6})}}}}
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Planet Rate: "..tostring(G.GAME.planet_rate)}, colours = {G.C.WHITE}, hover = true, shadow = true, scale = 0.5, maxw = 6})}}}}
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Edition Rate: "..tostring(G.GAME.edition_rate)}, colours = {G.C.WHITE}, hover = true, shadow = true, scale = 0.5, maxw = 6})}}}}
    rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding=0.02}, nodes={{n=G.UIT.O, config={object = DynaText({string = {"Endless Mode: "..tostring(G.GAME.won)}, colours = {G.C.WHITE}, hover = true, shadow = true, scale = 0.5, maxw = 6})}}}}
  else
    rows[#rows+1] = {n=G.UIT.R, config={align = 'cm', padding = 0.04}, nodes={{n=G.UIT.T, config={text = 'No starting parameters?', scale = 0.7, colour = G.C.RED}}}}
  end

  return {n=G.UIT.ROOT, config={align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes = rows}
end

function G.UIDEF.banned_items()
  local rows = {}
  if G and G.GAME and G.GAME.banned_keys then
    -- collect keys into a list for stable ordering
    local keys = {}
    for k,v in pairs(G.GAME.banned_keys) do
      local banned_key = nil
      if type(k) == 'number' and type(v) == 'string' then
        -- array-style entry: value is the key string
        banned_key = v
      elseif type(k) == 'string' then
        -- map-style entry: key is the key string and value truthy
        if v then banned_key = k end
      end
      if banned_key then table.insert(keys, banned_key) end
    end
    table.sort(keys)
    if #keys == 0 then
      rows[#rows+1] = {n=G.UIT.R, config={align = 'cm', padding = 0.04}, nodes={{n=G.UIT.T, config={text = 'No banned items', scale = 0.7, colour = G.C.WHITE}}}}
    else
      -- Split banned keys into three categories: Cards (centers + cards), Tags, Blinds
      local card_keys, tag_keys, blind_keys = {}, {}, {}
      for _,k in ipairs(keys) do
        if G.P_BLINDS and G.P_BLINDS[k] then table.insert(blind_keys, k)
        elseif G.P_TAGS and G.P_TAGS[k] then table.insert(tag_keys, k)
        elseif (G.P_CENTERS and G.P_CENTERS[k]) or (G.P_CARDS and G.P_CARDS[k]) then table.insert(card_keys, k)
        else table.insert(card_keys, k) end
      end

      local function build_icon_cells(list)
        local cells = {}
        for _,k in ipairs(list) do
          if G.P_BLINDS and G.P_BLINDS[k] then
            local conf = G.P_BLINDS[k]
            local atlas_name = conf.atlas or 'blind_chips'
            local pos = conf.pos or {x=0,y=0}
            local anim = AnimatedSprite(0,0, 1.0, 1.0, G.ANIMATION_ATLAS[atlas_name], pos)
            anim:define_draw_steps({{shader = 'dissolve', shadow_height = 0.05},{shader = 'dissolve'}})
            table.insert(cells, {n=G.UIT.C, config={align='cm', padding = 0.02, minw = 0.9}, nodes={{n=G.UIT.O, config={object = anim}}}})
          elseif G.P_CENTERS and G.P_CENTERS[k] then
            local card = Card(0,0, G.CARD_W*0.86, G.CARD_H*0.86, G.P_CARDS.empty, G.P_CENTERS[k], {bypass_discovery_center = true, bypass_discovery_ui = true})
            table.insert(cells, {n=G.UIT.C, config={align='cm', padding = 0.02, minw = 0.9}, nodes={{n=G.UIT.O, config={object = card}}}})
          elseif G.P_CARDS and G.P_CARDS[k] then
            local card_obj = Card(0,0, G.CARD_W*0.86, G.CARD_H*0.86, G.P_CARDS[k], G.P_CENTERS.c_base)
            table.insert(cells, {n=G.UIT.C, config={align='cm', padding = 0.02, minw = 0.9}, nodes={{n=G.UIT.O, config={object = card_obj}}}})
          elseif G.P_TAGS and G.P_TAGS[k] then
            -- Render tags using the game's Tag UI so they match native appearance
            local ok, temp_tag_ui = pcall(function()
              local t = Tag(k)
              return t:generate_UI(1.0)
            end)
            if ok and temp_tag_ui then
              table.insert(cells, {n=G.UIT.C, config={align='cm', padding = 0.02, minw = 0.9}, nodes={temp_tag_ui}})
            else
              -- Fallback to text if Tag constructor is unavailable
              local display = (G.P_TAGS[k].name) and G.P_TAGS[k].name or k
              table.insert(cells, {n=G.UIT.C, config={align='cm', padding = 0.02, minw = 0.9}, nodes={{n=G.UIT.T, config={text = display, scale = 0.28, colour = G.C.L_BLACK}}}})
            end
          else
            table.insert(cells, {n=G.UIT.C, config={align='cm', padding = 0.02, minw = 0.9}, nodes={{n=G.UIT.R, config={align='cm', minh = 0.9, colour = G.C.GREY}}}})
          end
        end
        return cells
      end

      local cards_cells = build_icon_cells(card_keys)
      local tags_cells = build_icon_cells(tag_keys)
      -- If there are tag keys but no visual cells, render them as small text labels so they are visible
      if #tags_cells == 0 and #tag_keys > 0 then
        tags_cells = {}
        for _,tk in ipairs(tag_keys) do
          local display = (G.P_TAGS and G.P_TAGS[tk] and G.P_TAGS[tk].name) and G.P_TAGS[tk].name or tk
          table.insert(tags_cells, {n=G.UIT.C, config={align='cm', padding = 0.02, minw = 0.9}, nodes={{n=G.UIT.T, config={text = display, scale = 0.28, colour = G.C.L_BLACK}}}})
        end
      end
      local blinds_cells = build_icon_cells(blind_keys)

      local function build_column(title, cells)
        local col_rows = {}
        -- optional header
        col_rows[#col_rows+1] = {n=G.UIT.R, config={align='cm', padding = 0.02}, nodes={{n=G.UIT.T, config={text = title, scale = 0.36, colour = G.C.L_BLACK}}}}
        if #cells == 0 then
          col_rows[#col_rows+1] = {n=G.UIT.R, config={align='cm', padding = 0.4}, nodes={{n=G.UIT.R, config={align='cm', minh = 1.2, colour = G.C.CLEAR}}}}
        else
          for i = 1, #cells, 10 do
            local row = {}
            for j = i, math.min(i+9, #cells) do table.insert(row, cells[j]) end
            col_rows[#col_rows+1] = {n=G.UIT.R, config={align='cm', padding = 0.02}, nodes = row}
          end
        end
        return {n=G.UIT.C, config={align='cm', padding = 0.1, minw = 3.0}, nodes = col_rows}
      end

      local any_cells = (#cards_cells > 0) or (#tags_cells > 0) or (#blinds_cells > 0)
      if any_cells then
        rows[#rows+1] = {n=G.UIT.R, config={align='cm', padding = 0.06}, nodes={{n=G.UIT.T, config={text = 'Banned Items', scale = 1, colour = G.C.WHITE}}}}
      end
      if #cards_cells > 0 then
        rows[#rows+1] = {n=G.UIT.R, config={align='cm'}, nodes={{n=G.UIT.R, config={align='cm', r = 0.06, padding = 0.06, colour = G.C.WHITE, outline = 1, outline_colour = G.C.GREY}, nodes = {build_column('Cards', cards_cells)}}}}
      end
      if #tags_cells > 0 then
        rows[#rows+1] = {n=G.UIT.R, config={align='cm'}, nodes={{n=G.UIT.R, config={align='cm', r = 0.06, padding = 0.06, colour = G.C.WHITE, outline = 1, outline_colour = G.C.GREY}, nodes = {build_column('Tags', tags_cells)}}}}
      end
      if #blinds_cells > 0 then
        rows[#rows+1] = {n=G.UIT.R, config={align='cm'}, nodes={{n=G.UIT.R, config={align='cm', r = 0.06, padding = 0.06, colour = G.C.WHITE, outline = 1, outline_colour = G.C.GREY}, nodes = {build_column('Blinds', blinds_cells)}}}}
      end
    end
  else
    rows[#rows+1] = {n=G.UIT.R, config={align = 'cm', padding = 0.04}, nodes={{n=G.UIT.T, config={text = '', scale = 0.4, colour = G.C.WHITE}}}}
  end

  return {n=G.UIT.ROOT, config={align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes = rows}
end