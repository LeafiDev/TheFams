local create_UIBox_game_over_ref = create_UIBox_game_over

-- Standard per-blind lose quotes (for `bl_<name>` keys)
local LOSE_QUOTES_BY_BLIND = {
  bl_small = { "Thought it'd be easier against a guy like me!", "Your chips are belittled by me!" },
  bl_big = { "Bigger, badder, better.", "The biggest between us is me!" },
  bl_ox = { "What? did you need that money?", "refuse my rule, lose your jewels" },
  bl_hook = { "Looks like I caught a big one.", "Dragged off with your cards!" },
  bl_mouth = { "Didn't prefer what you asked for?", "Too sweet or too salty?" },
  bl_fish = { "*blub blub*", "*blub blub blub*", "Hook, line, and sinker." },
  bl_club = { "Your four leaf clover expired", "Your luck runs thin." },
  bl_manacle = { "Your chain was too tight to escape!", "Your prison is me" },
  bl_tooth = { "Your tooth fell off!", "Let's hope the tooth fairy can reperand your loss." },
  bl_wall = { "My persistence is more than you can handle.", "Do you prefer bricks or concrete?" },
  bl_house = { "Like they say, The house always wins", "Sir, I ask you to leave." },
  bl_mark = { "X marks the spot to your loss!", "X marks the spot, YARRRG!" },
  bl_final_bell = { "Taking one card is all it took?", "My bell tolls for your unfortunance" },
  bl_wheel = { "Spin, Spin, Spin, Your loss was destined.", "You lost the game show!" },
  bl_arm = { "Raised my fist for your defeat!", "Pound the bug to bits." },
  bl_psychic = { "Play 5 or die.", "Seems your future was unkind." },
  bl_goad = { "Am I an annoyance to you yet?", "You fell for it." },
  bl_water = { "High tides trap the lackies.", "The captain sinks with his ship." },
  bl_eye = { "I keep my eyes, You lose yours.", "Looked right through you." },
  bl_plant = { "My roots grew faster!", "Lacka sunlight hurts all plants!" },
  bl_needle = { "Ouch! that gotta hurt!", "shoulda been more careful." },
  bl_head = { "Lost your head? sucks to be you", "Mind blowing loss huh?" },
  bl_final_leaf = { "Leaves fall, so do you.", "Swept with the rest of the leaves!" },
  bl_final_vessel = { "Even if not solid, I prevail!", "A ghost, thou are." },
  bl_window = { "Your diamonds can't shine anymore.", "Eyes are the window... to your doom!" },
  bl_serpent = { "A slithery fella like me bit yer leg!", "Too little cards for ye?" },
  bl_pillar = { "Persistent walls beat the unpatent", "Crushed under weight." },
  bl_flint = { "Your half is not enough for my whole!.", "I'm a flint and you're sliced in half!" },
  bl_final_acorn = { "Whoops! Cracked!", "A sturdy 'corn like me against you!?." },
  bl_final_heart = { "Either my heart stops or yours.", "A blade to the heart." },
}

-- Fams-specific boss-blind quotes. Keys are the suffix after `bl_fams_`, grouped under `fams_bossBlinds`.
local LOSE_QUOTES_FAMS_BOSS_BLINDS = {
  the_picky = { "YUCK!", "EUGH!", "BLEH!" },
  the_greedy = { "I requested for "..(G.globalgreedycall or "").."!", "You didn't give me my "..(G.globalgreedycall or "").."!" },
  the_forceful = { "Push and shove all you want, I'm stronger", "Turn around and walk away bucko!" },
  gh = { "Guess who! You lose!" },
  fish2 = { "IT'S RAW!" },
  extinct = { "It seems the dinosaurs are the only extinct creature.", "All life ends eventually." },
  needle2 = { "Big, better and sharper than ever!", "That haystack was bigger than expected." },
  bad = { ":D", "Screw you :D" },
  Pootis = { "Sandvich is life", "Sandvich is GOD!!!!", "I've yet to meet one that can outsmart bullet" },
  EarlBoss = { "BARK! BORF! BYORK!", "*Distant food munching*" },
  disco = { "Dance and Dance all you want! You'll never catch the crowd!" },
  addition = { "Need to meet your ABS of the situation" },
  trueend = { "..." },
}


local LOSE_BLIND_VISUALS = {
  -- Example overrides (edit as needed):
  bl_fams_the_picky = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_the_greedy = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_the_forceful = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_gh = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_fish2 = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_extinct = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_needle2 = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_bad = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_Pootis = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_EarlBoss = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_disco = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_addition = { atlas = 'fams_bossBlinds', scale = 1.8 },
  bl_fams_trueend = { atlas = 'fams_bossBlinds', scale = 1.8 },
}



-- Find the current profile using the provided logic
function get_current_profile()
  if G and G.PROFILES then
    for i=1,#G.PROFILES,1 do
      if (G.PROFILES[i].name) then
        return G.PROFILES[i]
      end
    end
  end
  return nil
end

-- Load chosen_lose_quotes from the current profile if available
function load_chosen_lose_quotes_from_profile()
  local profile = get_current_profile()
  if profile and profile.chosen_lose_quotes then
    chosen_lose_quotes = profile.chosen_lose_quotes
  end
end

-- Save chosen_lose_quotes to the current profile
function save_chosen_lose_quotes_to_profile()
  local profile = get_current_profile()
  if profile then
    profile.chosen_lose_quotes = chosen_lose_quotes
  end
end

-- Load on file load
load_chosen_lose_quotes_from_profile()

-- Check if chosen_lose_quotes contains all quotes from LOSE_QUOTES_BY_BLIND and LOSE_QUOTES_FAMS_BOSS_BLINDS
function chosen_lose_quotes_has_all()
  local chosen_set = {}
  for _, q in ipairs(chosen_lose_quotes or {}) do
    chosen_set[q] = true
  end

  local function all_quotes_in_table(tbl)
    for _, arr in pairs(tbl) do
      for _, quote in ipairs(arr) do
        if not chosen_set[quote] then
          return false, quote
        end
      end
    end
    return true
  end

  local ok1, missing1 = all_quotes_in_table(LOSE_QUOTES_BY_BLIND)
  if not ok1 then return false, missing1 end
  local ok2, missing2 = all_quotes_in_table(LOSE_QUOTES_FAMS_BOSS_BLINDS)
  if not ok2 then return false, missing2 end
  return true
end

-- Debug function: add all lose quotes from both tables to chosen_lose_quotes
function alldeaths()
  chosen_lose_quotes = chosen_lose_quotes or {}
  local chosen_set = {}
  for _, q in ipairs(chosen_lose_quotes) do
    chosen_set[q] = true
  end
  local function add_from_table(tbl)
    for _, arr in pairs(tbl) do
      for _, quote in ipairs(arr) do
        if not chosen_set[quote] then
          table.insert(chosen_lose_quotes, quote)
          chosen_set[quote] = true
        end
      end
    end
  end
  add_from_table(LOSE_QUOTES_BY_BLIND)
  add_from_table(LOSE_QUOTES_FAMS_BOSS_BLINDS)
  save_chosen_lose_quotes_to_profile()
end

local function add_chosen_lose_quote(quote)
  chosen_lose_quotes = chosen_lose_quotes or {}
  for _, q in ipairs(chosen_lose_quotes) do
    if q == quote then return end
  end
  table.insert(chosen_lose_quotes, quote)
  save_chosen_lose_quotes_to_profile()
end

local function resolve_lose_quotes(blind_key, blind_obj)
  if blind_obj and type(blind_obj) == 'table' and blind_obj.lose_quotes and #blind_obj.lose_quotes > 0 then
    
    return blind_obj.lose_quotes
  end

  if blind_key then
    local fams_name = blind_key:match('^bl_fams_(.+)$')
    if fams_name and LOSE_QUOTES_FAMS_BOSS_BLINDS[fams_name] and #LOSE_QUOTES_FAMS_BOSS_BLINDS[fams_name] > 0 then
      return LOSE_QUOTES_FAMS_BOSS_BLINDS[fams_name]
    end

    if LOSE_QUOTES_BY_BLIND[blind_key] and #LOSE_QUOTES_BY_BLIND[blind_key] > 0 then
      return LOSE_QUOTES_BY_BLIND[blind_key]
    end

    local short = blind_key:match('^bl_(.+)$')
    if short then
      local alt = 'bl_' .. short
      if LOSE_QUOTES_BY_BLIND[alt] and #LOSE_QUOTES_BY_BLIND[alt] > 0 then
        return LOSE_QUOTES_BY_BLIND[alt]
      end
    end
  end

  local name = (blind_obj and (blind_obj.name or blind_obj.display_name)) or blind_key or 'that blind'
  return { ('Defeated by %s.'):format(name), 'Better luck next run.' }
end

local game_update_game_over_ref = Game.update_game_over
function Game:update_game_over(dt)

    game_update_game_over_ref(self, dt)
end

function create_UIBox_game_over()

    local is_endless = G.GAME.round_resets.ante > G.GAME.win_ante
    local defeat_color = is_endless and G.C.BLUE or G.C.RED
    

    local eased_black = {0, 0, 0, 0}
    ease_value(eased_black, 4, 0.5, nil, nil, true) 

    local blind_obj = (G.GAME and G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind) or G.P_BLINDS.bl_small


    local blind_key = nil
    if G.P_BLINDS and blind_obj then
      for k,v in pairs(G.P_BLINDS) do
        if v == blind_obj then blind_key = k break end
      end
    end
    if not blind_key and blind_obj and blind_obj.key then blind_key = blind_obj.key end
    blind_key = blind_key or 'bl_small'

    
    local function resolve_blind_visual(bkey, bobj)
      local atlas_name = 'blind_chips'
      local pos = nil
      local scale = 1.4


      if bkey and LOSE_BLIND_VISUALS[bkey] then
        local v = LOSE_BLIND_VISUALS[bkey]
        atlas_name = v.atlas or atlas_name
        pos = v.pos or pos
        scale = v.scale or scale
      end


      if bobj then
        if bobj.atlas then atlas_name = bobj.atlas end
        pos = pos or bobj.pos or (bobj.config and bobj.config.pos)
        scale = bobj.scale or bobj.visual_scale or scale
      end


      if (not pos or not atlas_name) and G.P_BLINDS and bkey then
        local candidate = G.P_BLINDS[bkey]
        if not candidate then
          local short = bkey:match('^bl_fams_(.+)$') or bkey:match('^bl_(.+)$')
          if short then candidate = G.P_BLINDS['bl_'..short] end
        end
        if candidate then
          atlas_name = candidate.atlas or atlas_name
          pos = pos or candidate.pos or (candidate.config and candidate.config.pos)
          scale = scale or candidate.scale
        end
      end

      return atlas_name, pos, scale
    end

    local atlas_name, pos, scale = resolve_blind_visual(blind_key, blind_obj)
    local anim_atlas = G.ANIMATION_ATLAS[atlas_name] or G.ANIMATION_ATLAS['blind_chips']
    local blind_animation = AnimatedSprite(0,0, scale, scale, anim_atlas, pos)

    local quotes = resolve_lose_quotes(blind_key, blind_obj)
    local lose_quote = quotes and quotes[math.random(#quotes)] or "This defaulted. big oops."
    add_chosen_lose_quote(lose_quote)
    
    local t = {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            colour = eased_black,
            padding = 0,
            minh = G.ROOM.T.h + 10,
            minw = G.ROOM.T.w + 10,
            r = 0
        },
        nodes = {

            {n=G.UIT.C, config={align = "cm", padding = 0.25, colour = G.C.WHITE, outline = 2, outline_colour = G.C.L_BLACK, r = 0.06, minw = 4, minh = 6}, nodes={

                {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes={
                  {n=G.UIT.O, config={object = DynaText({string = {localize('ph_game_over')}, colours = {G.C.RED}, shadow = true, float = true, scale = 1.8, pop_in = 0.6, maxw = 6.5})}},
                }},


                {n=G.UIT.R, config={align = "cm", scale = 1, minw = 0.2, minh = 0.2, r = 15, padding = 0.1}, nodes={
                  {n=G.UIT.O, config={padding = 0, id = 'blind_killer', object = blind_animation, scale = 2}},
                }},


                {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes={
                  {n=G.UIT.O, config={object = DynaText({string = {lose_quote}, colours = {G.C.L_BLACK}, shadow = true, float = true, scale = 0.5, pop_in = 0.2, serif = true})}},
                }},


                {n=G.UIT.R, config={align = "cm", padding = 0.12}, nodes={
                  {n=G.UIT.C, config={align = "cm", padding = 0.10}, nodes={
                    UIBox_button({id = "from_game_over", button = 'notify_then_setup_run', label = {localize('b_start_new_run')}, colour = G.C.RED, scale = 0.7, minw = 5.5, minh = 0.6, focus_args = {nav = 'wide', snap_to = true}}),
                    UIBox_button({button = 'go_to_menu', label = {localize('b_main_menu')}, colour = G.C.BLACK, scale = 0.6, minw = 5.5, minh = 0.5, focus_args = {nav = 'wide'}}),
                  }},
                }},


                {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes={
                  {n=G.UIT.T, config={text = '© 2024.  LOCALTHUNK., Death', scale = 0.22, colour = G.C.L_BLACK}}
                }},
            }},
        }
    }
    
    return t
end
