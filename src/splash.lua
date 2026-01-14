

SMODS.Sound {
    key = "intro",
    pitch = 1,
    volume = 1,
    path = "intro.ogg",
}

fams_i = 0
function Game:splash_screen()
    
    --If the skip splash screen option is set, immediately go to the main menu here
    if G.SETTINGS.skip_splash == 'Yes' then 
        G:main_menu()
        return 
    end

    self:prep_stage(G.STAGES.MAIN_MENU, G.STATES.SPLASH, true)
    G.E_MANAGER:add_event(Event({
        func = (function()
            discover_card()
            return true
        end)
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            G.TIMERS.TOTAL = 0
            G.TIMERS.REAL = 0
            --Prep the splash screen shaders for both the background(colour swirl) and the foreground(white flash), starting at black
            G.SPLASH_BACK = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
            G.SPLASH_BACK:define_draw_steps({{
                shader = 'splash',
                send = {
                    {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
                    {name = 'vort_speed', val = 1},
                    {name = 'colour_1', ref_table = G.C, ref_value = 'ORANGE'},
                    {name = 'colour_2', ref_table = G.C, ref_value = 'MONEY'},
                    {name = 'mid_flash', val = 0},
                    {name = 'vort_offset', val = (8*fams_i*os.time())%10000000000000000000},
                }}})
            G.SPLASH_BACK:set_alignment({
                major = G.ROOM_ATTACH,
                type = 'cm',
                offset = {x=0,y=0}
            })
            G.SPLASH_FRONT = Sprite(0,-20, G.ROOM.T.w*2, G.ROOM.T.h*4, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
            G.SPLASH_FRONT:define_draw_steps({{
                shader = 'flash',
                send = {
                    {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
                    {name = 'mid_flash', val = 1}
                }}})
            G.SPLASH_FRONT:set_alignment({
                major = G.ROOM_ATTACH,
                type = 'cm',
                offset = {x=0,y=0}
            })

            --spawn in splash card
            play_sound('fams_intro', 1, 1)
            local SC = nil
            local SC2 = nil
            local SC3 = nil
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = (function()
                local SC_scale = 1.3
                local SC2_scale = 1.5
                local SC3_scale = 1.3
                SC = Card(G.ROOM.T.w/2 - 3 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_fams_yogi'])
                SC.T.y = G.ROOM.T.h/2 - SC_scale*G.CARD_H/2
                SC.ambient_tilt = 0
                SC.states.drag.can = false
                SC.states.hover.can = false
                SC.no_ui = true
                G.VIBRATION = G.VIBRATION + 2

                SC2 = Card(G.ROOM.T.w/2 - SC2_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC2_scale*G.CARD_H/2, SC2_scale*G.CARD_W, SC2_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_fams_earl'])
                SC2.T.y = G.ROOM.T.h/2 - SC2_scale*G.CARD_H/2
                SC2.ambient_tilt = 0
                SC2.states.drag.can = false
                SC2.states.hover.can = false
                SC2.no_ui = true
                G.VIBRATION = G.VIBRATION + 2
                
                SC3 = Card(G.ROOM.T.w/2 + 3 - SC3_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC3_scale*G.CARD_H/2, SC3_scale*G.CARD_W, SC3_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_fams_bear'])
                SC3.T.y = G.ROOM.T.h/2 - SC3_scale*G.CARD_H/2
                SC3.ambient_tilt = 0
                SC3.states.drag.can = false
                SC3.states.hover.can = false
                SC3.no_ui = true
                G.VIBRATION = G.VIBRATION + 2
                play_sound('whoosh1', 0.7, 0.2)
                play_sound('introPad1', 0.704, 0.6)
            return true;end)}))

            --dissolve fool card and start to fade in the vortex
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 1.8,func = (function() --|||||||||||
            print(startupframe)
                SC:start_dissolve({G.C.CHIPS, G.C.CHIPS},true, 12, true)
                SC2:start_dissolve({G.C.ORANGE, G.C.ORANGE},true, 12, true)
                SC3:start_dissolve({G.C.CHIPS, G.C.CHIPS},true, 12, true)
                play_sound('magic_crumple', 1, 0.5)
                play_sound('splash_buildup', 1, 0.7)
            return true;end)}))

            --create all the cards and suck them in
            function make_splash_card(args)
                args = args or {}
                local angle = math.random()*2*3.14
                local card_size = (args.scale or 1.5)*(math.random() + 1)
                local card_pos = args.card_pos or {
                    x = (18 + card_size)*math.sin(angle),
                    y = (18 + card_size)*math.cos(angle)
                }
                local center = G.P_CENTERS.c_base
                local face = pseudorandom_element(G.P_CARDS)
                -- small chance to spawn a random mod 'fams' joker instead of a regular playing card
                    local fams = {}
                    for k, _ in pairs(G.P_CENTERS or {}) do
                        if type(k) == 'string' and (k:match('^j_fams_') or k:match('^c_fams_') or k:match('^bl_fams_') or k:match('^tag_fams_')) and not k:match('^j_fams_skeleton') and not k:match('^c_fams_A') then table.insert(fams, k) end
                    end
                    if #fams > 0 then
                        local chosen = fams[math.random(#fams)]
                        center = G.P_CENTERS[chosen] or center
                        face = nil
                    end
                local card = Card(  card_pos.x + G.ROOM.T.w/2 - G.CARD_W*card_size/2,
                                    card_pos.y + G.ROOM.T.h/2 - G.CARD_H*card_size/2,
                                    card_size*G.CARD_W, card_size*G.CARD_H, face, center)
                if math.random() > 1.1 then card.sprite_facing = 'back'; card.facing = 'back' end
                card.no_shadow = true
                card.states.hover.can = false
                card.states.drag.can = false
                card.vortex = true and not args.no_vortex
                card.T.r = angle
                return card, card_pos
            end

            G.vortex_time = G.TIMERS.REAL
            local temp_del = nil

            for i = 1, 300 do
                temp_del = temp_del or 3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    delay = temp_del,
                    func = (function()
                    local card, card_pos = make_splash_card({scale = 2 - i/300})
                    local speed = math.max(2. - i*0.005, 0.001)
                    ease_value(card.T, 'scale', -card.T.scale, nil, nil, nil, 1.*speed, 'back')
                    ease_value(card.T, 'x', -card_pos.x, nil, nil, nil, 0.9*speed)
                    ease_value(card.T, 'y', -card_pos.y, nil, nil, nil, 0.9*speed)
                    local temp_pitch = i*0.007 + 0.6
                    local temp_i = i
                    G.E_MANAGER:add_event(Event({
                        blockable = false,
                        func = (function()
                            if card.T.scale <= 0 then
                                if temp_i < 30 then 
                                    play_sound('whoosh1', temp_pitch + math.random()*0.05, 0.25*(1 - temp_i/50))
                                end

                                if temp_i == 15 then
                                    play_sound('whoosh_long',0.9, 0.7)
                                end
                                G.VIBRATION = G.VIBRATION + 0.1
                                card:remove()
                                return true
                            end
                        end)}))
                        return true
                    end)}))
                    temp_del = temp_del + math.max(1/(i), math.max(0.2*(170-i)/500, 0.016))
            end

            --when faded to white, spit out the 'Fool's' cards and slowly have them settle in to place
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 2.,func = (function()
                G.SPLASH_BACK:remove()
                G.SPLASH_BACK = G.SPLASH_FRONT
                G.SPLASH_FRONT = nil
                G:main_menu('splash')
            return true;end)}))
        return true
    end)
    }))
end