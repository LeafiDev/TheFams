startupframe = 0
G.fams_update = function(dt)
	startupframe = (startupframe or 0) + 0.5

	if startupframe > 50 and startupframe < 500 then
		showFloatingText("LeafiDev and Others present", G.C.WHITE, 1, { x = 0, y = 3.1 }, "intro1")
	end

	if startupframe > 500 and startupframe < 700 then
		showFloatingText("A high quality shitpost mod", G.C.WHITE, 1, { x = 0, y = 3.1 }, "intro1")
	end

	if startupframe > 700 and startupframe < 900 then
		showFloatingText("That mod is called...", G.C.WHITE, 1, { x = 0, y = 3.1 }, "intro1")
	end

    --Stop us from appearing in the intro
    if (G.STATE == 13) then return end;
	if (G.GAME.big_money) then G.ut_update(dt); end
	
	-- locking up the intro text
	startupframe = 300
	clearCustomTextAfterDraw()
	forceback = false

	-- Initialize global variables if not present
	BPM = BPM or 100
	targetdisplay = targetdisplay or "nothing"

	-- Reset to default timer settings first
	local DEFAULT_TIMER_LENGTH = 60
	local DEFAULT_USE_TIMERS = false
	local previous_timer_length = TIMER_LENGTH or DEFAULT_TIMER_LENGTH
	TIMER_LENGTH = DEFAULT_TIMER_LENGTH
	USE_TIMERS = DEFAULT_USE_TIMERS

	--Fix for talisman blowing up
	if G.GAME then
		G.GAME.dr_boss = G.GAME.dr_boss or false;
		G.GAME.pikmin_rate = 0
		G.GAME.credits_rate = 0
		G.GAME.gimmicks_rate = 0
		G.GAME["mini-joker_rate"] = 0.9
		G.GAME["dawgcards_rate"] = 0.08
		G.GAME["geometry_rate"] = 0.05
	end

	if G and G.jokers and G.jokers.cards then
	if G and G.jokers and G.jokers.cards then
		for _, joker in ipairs(G.jokers.cards) do
			if joker.ability.fams_lock == true then
				joker.states.drag.can = false
			else
				joker.states.drag.can = true
			end
		end
	end
	end

	-- dlcend stuff
	if isChallenge("dlcend") then 
		SetWinningAnte(38)
		-- Ensure banned_keys is a map of key->true to match other code expectations
		G.GAME.banned_keys = G.GAME.banned_keys or {}
		-- Ban any blind that is a final/showdown boss. Covers modded additions in G.P_BLINDS.
		if G.P_BLINDS then
			for bk, bv in pairs(G.P_BLINDS) do
				-- Skip the specific fams trueend blind key
				if bk == 'bl_fams_trueend' then goto continue end
				if bv and bv.boss and (bv.boss.showdown == true or (bv.boss.min == 10 and bv.boss.max == 10)) then
					G.GAME.banned_keys[bk] = true
				end
				::continue::
			end
		end
	end

	if isChallenge("dlcend") and getAnte() >= 40 and getAnte() < 50 then
  	setrunBG({ 0.545, 0.51, 0.78, 1 }, { 0.357, 0.325, 0.549, 1 }, 1)
	musicPower(4)
	setBPM(120)
	end

	if isChallenge("dlcend") and getAnte() >= 50 and getAnte() < 70 then
    setrunBG({ 0.529, 0.725, 0.922, 1 }, { 0.698, 0.792, 0.89, 1 }, 3)
	musicPower(5)
	setBPM(130)
	end

	if isChallenge("deb1") and G and G.jokers and G.jokers.cards then
		local different = 0
		for _, joker in ipairs(G.jokers.cards) do
			different = different + 1
			if getAnte() < joker.sell_cost then
				joker.debuff = true
			else
				joker.debuff = false
			end
		end
	end

	if isChallenge("nodrag") and G and G.jokers and G.jokers.cards then
	if G and G.jokers and G.jokers.cards then
		for _, joker in ipairs(G.jokers.cards) do
			joker.states.drag.can = false
		end
	end
	end

	if isChallenge("flip2") and G and G.jokers and G.jokers.cards then
	if G and G.jokers and G.jokers.cards then
		for _, joker in ipairs(G.jokers.cards) do
			if joker.highlighted == true then
			joker.facing = "front"
			joker.sprite_facing = "front"
			else
			joker.facing = "back"
			joker.sprite_facing = "back"
			end
		end
	end
	end

	if isChallenge("flip1") and G and G.hand and G.hand.cards then
		local length = #G.hand.cards
		local counter = 0
		for _, card in ipairs(G.hand.cards) do
			counter = counter + 1
			if counter == length or counter == 1 then
				card.facing = "front"
				card.sprite_facing = "front"
			else
				card.facing = "back"
				card.sprite_facing = "back"
			end
		end
	end

	if isPlayingBlind() then
		winnercheck = true
	else
		if winnercheck == true then
			play_sound('fams_imweiner', 1, 1)

		if isChallenge("decay") and G and G.jokers and G.jokers.cards then
				for _, joker in ipairs(G.jokers.cards) do
					if winnercheck == true then
					G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.05,
					func = function()
						joker:juice_up()
						play_sound("cancel", 1, 1)
						joker.ability.mult = joker.ability.mult - (getAnte()) * 0.5
						return true
					end
					}))
					
					end
				end
			end
		winnercheck = false
		end
	end

	if isChallenge("mtn") then
		setrunBG({ 0, 0, 0.2 + sine(0.2, 0.3) + (getAnte() / 5), 1 }, { 0, 0, 0.2 + sine(0.2, 0.3) + (getAnte() / 5), 0 }, 1)
		SetWinningAnte(7)
	end

	if isChallenge("dlcend") and getAnte() >= 70 and getAnte() < 80 then
	musicPower(math.random(1, 8))
	setBPM(math.random(90, 200))
	G.GAME.dollars = math.random(-10, 10)
	spinnerbone = math.random(-10, 10)
	thetimer = thetimer + 1 or 0
	setrunBG({colrandom, colrandom2, colrandom3, 1}, {0, 0, 0, 0}, spinnerbone)
	if thetimer >= math.random(35, 75) then
		colrandom = math.random(0, 0.01)
		colrandom2 = math.random(0, 0.01)
		colrandom3 = math.random(0, 0.01)
		thetimer = 0
	end
	end

	if isChallenge("pastdue") then
		if G and G.GAME and G.GAME.dollars then
			if G.GAME.dollars >= 300 and G.GAME.won ~= true then
				win_game()
			end
		end
		if getAnte() >= 7 then
			setAnte(1)
		end
	end

	if isChallenge("fj")then
		if hasJoker("Joker") and G.GAME.won == false then
			win_game()
		end
		if getAnte() >= 7 then
			setAnte(1)
		end
	end

	if getcurrentBlind() == "bl_fams_disco" and tick_once and G.GAME.blind.disabled ~= true then
		G.hand:shuffle('aajk')
		G.jokers:shuffle('aajk')
	end

	if isChallenge("Dogtrials") and G and G.GAME and getAnte() == G.GAME.win_ante + 1 then
		get_current_profile().dog_trials_win = true
	end

	if isChallenge("dlcend") and G and G.GAME and getAnte() == G.GAME.win_ante + 1 then
		get_current_profile().end_win = true
	end

	-- checks jokers as a clever way to see if tags work
	if isChallenge("BR") and G and G.GAME and G.jokers and G.jokers.cards then
		if G.GAME.boss_rush_trigger == nil then
			G.GAME.boss_rush_trigger = true
			G.E_MANAGER:add_event(Event({
                func = function()
					G.GAME.starting_params.ante_scaling = 0.5
                    add_tag(Tag('tag_investment'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
		end
	end

	if GetStake() >= 15 then
		if isbossblindbanned() then
			G.GAME.blind:disable()
		end
	end


	if isChallenge("Dogtrials") then
		SetWinningAnte(12)
		TIMER_LENGTH = 600
		USE_TIMERS = true
	elseif isChallenge("bomb") then
		TIMER_LENGTH = 30
		USE_TIMERS = true
		TIMER_ADD_BONUS = true
	elseif GetStake() == 9 then
		TIMER_LENGTH = 60
		USE_TIMERS = true
		TIMER_ADD_BONUS = true
	elseif isChallenge("lap2") then
		TIMER_LENGTH = 300
		USE_TIMERS = true
		TIMER_ADD_BONUS = false
		SetWinningAnte(10)
		G.ROOM.jiggle = 0.1
	elseif isChallenge("PT") then
		TIMER_LENGTH = 300
		USE_TIMERS = true
		TIMER_ADD_BONUS = false
		SetWinningAnte(5)
	end



	if G.STATE == G.STATES.WIN then
		if
			timer_active
			and not blind_timer_bonus_given
			and G.GAME
			and G.GAME.current_round
			and type(G.GAME.current_round.hands_left) == "number"
			and G.GAME.current_round.hands_left > 0
		then
			update_timer_text()
			blind_timer_bonus_given = true
		end
		removeUItimer()
	else
		blind_timer_bonus_given = false

		-- Check if timer system is enabled (not on main menu or title screen)
		if USE_TIMERS and G.STATE ~= G.STATES.MAIN_MENU and G.STATE ~= 11 and G.GAME then
			-- Track the current game seed to detect new runs
			local current_seed = G.GAME.pseudorandom and G.GAME.pseudorandom.seed or 0

			local is_new_run = false
			if not timer_last_seed or timer_last_seed ~= current_seed then
				is_new_run = true
				timer_last_seed = current_seed
			end

			if is_new_run or not G.GAME.timer then
				-- New run, initialize timer
				timer = TIMER_LENGTH
				timer_active = true
				timeradd = false
			elseif G.GAME.timer and type(G.GAME.timer) == "number" then
				-- Continue from save
				timer = G.GAME.timer
				if not timer_active then
					timer_active = true
					timeradd = false
				end
			end

			G.GAME.timer = timer

			showUItimer(timer)

			if G.GAME.facing_blind and not G.OVERLAY_MENU and G.STATE ~= 4 then
				local speed = math.min(G.SPEEDFACTOR, 1)
				timer = timer - (dt * speed)
				G.GAME.timer = timer
				timeradd = true
			end
			update_timer_text()
		else
			-- Always reset timer when leaving a run
			timer = TIMER_LENGTH
			if G.GAME then
				G.GAME.timer = 5
			end
			timer_active = false
			timeradd = false
			removeUItimer()
		end
	end

	if USE_TIMERS and TIMER_ADD_BONUS and not isPlayingBlind() and timeradd == true then
		if G.STATE ~= 0 and G.STATE ~= 2 and G.STATE ~= 3 then
			if G.GAME and G.GAME.current_round and G.GAME.current_round.hands_left and G.GAME.current_round ~= 0 then
				if G.GAME.current_round.hands_left > 0 then
					addtime(10 * G.GAME.current_round.hands_left)
				else
					addtime(10)
				end
			end
		end
	end

	if not isPlayingBlind() and timeradd == true then
		timeradd = false
	end

	if isPlayingBlind() then
	else
		triggeronce = true
	end

	if G.STATE == 11 then
		if title_variant == 1 then
			setMenuBG({ 0.85, 0.55, 0.25, 1 }, { 1, 0.9, 0.5, 1 }, { 1, 0.7, 0.3, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 2 then
			setMenuBG({ 0, 0.78, 0, 1 }, { 0, 0.39, 0, 1 }, { 1, 0.7, 0.3, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 3 then
			setMenuBG({ 0.9, 0.9, 0.9, 1 }, { 0.3, 0.3, 0.3, 1 }, { 1, 0.7, 0.3, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 4 then
			setMenuBG({ 2, 0, 0, 1 }, { 0, 0, 2, 1 }, { 1, 0.7, 0.3, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 5 then
			setMenuBG({ 1, 1, 1, 1 }, { 0, 0, 0, 1 }, { 1, 0, 0, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 6 then
			setMenuBG({ 0.8, 0, 0, 1 }, { 0.023, 0.086, 0.435, 1 }, { 1, 0, 0, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 7 then
			setMenuBG({ 0.698, 0.949, 1, 1 }, { 1, 1, 1, 1 }, { 1, 0, 0, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 8 then
			setMenuBG({ 0.85, 0.55, 0.25, 1 }, { 1, 0.9, 0.5, 1 }, { 1, 0.7, 0.3, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 9 then
			setMenuBG({ 0.85, 0.35, 0.25, 1 }, { 1, 0.6, 0.3, 1 }, { 1, 0.7, 0.3, 1 }, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 10 then
			setMenuBG({ 0.2, 0.2, 0.2, 1 }, { 0.2, 0.2, 0.2, 1 }, { 1, 0.7, 0.3, 1 }, 0, 0)
		end
		if title_variant == 11 then
			if love.timer.getTime() % 4 >= 3.96 then
			setMenuBG({ 0, math.random(0.01, 0.99), 0, 1 }, { 0, math.random(0.01, 0.99), 0, 1 }, { 1, 0.7, 0.3, 1 }, 0, 0)
			end
		end
		if title_variant == 12 then
			setMenuBG({ 1, 1, 1, 1 }, { 0, 0, 0, 0 }, { 1, 0.7, 0.3, 1 }, 0, 0)
		end
		local pr = G.PROFILES[G.SETTINGS.profile]
		if pr.dog_trials_win == true then
			setMenuBG({ 0.922, 0.506, 0.408, sine(0.3, 1) + 0.4 }, { 0.91, 0.537, 0.243, sine(0.3, 1) + 0.4 }, { 1, 0.7, 0.3, sine(0.6, 1) }, 0, math.abs(sine(0.6, 1)))
			if not G.winbg then
			G.winbg = Particles(0, 0, 0, 0, {
                    timer = 0.015,
                    scale = 0.1,
                    initialize = true,
                    lifespan = 0.5,
                    speed = 1,
                    padding = -2,
                    attach = G.ROOM_ATTACH,
                    colours = {lighten(G.C.GOLD, 0.2)},
                    fill = true
                })
			end
			showFloatingText("Congratulations!", HEX('a3863c'), 1, { x = 0, y = sine(0.1, 1) + 8.54 }, "100back")
			showFloatingText("Congratulations!", HEX('eac058'), 1, { x = 0, y = sine(0.1, 1) + 8.5 }, "100")
			showFloatingText("Thanks for playing!", HEX('ffffff'), 0.5, { x = 0, y = sine(0.1, 0.8) + 8.85 }, "100sub")
		end

		showFloatingText("BPM: " .. tostring(BPM), G.C.WHITE, 0.29, { x = 999999, y = 3.1 }, "bpmcounter")
		showFloatingText(
			tostring(math.ceil(getBPMTick())) .. "/" .. getBPMMax(),
			G.C.WHITE,
			999999,
			{ x = 4.55, y = 2.85 },
			"bpmcounter2"
		)
		showFloatingText(
			"targetting " .. targetdisplay .. "'s this hand",
			G.C.WHITE,
			0.29,
			{ x = 9999999, y = 3.1 },
			"targettext"
		)
		--]]
	end

	if G.GAME.pseudorandom.seed == "BOOBIES" then
		showFloatingText("I want your seed.", HEX('ffffff'), 0.3, { x = 0, y = -0.1}, "funny")
	end

	if G.STATE and G.STATE < 9 and G.STATE ~= 11 then
		showFloatingText("BPM: " .. tostring(BPM), G.C.WHITE, 0.29, { x = 4.55, y = 3.1 }, "bpmcounter")
		showFloatingText(
			tostring(math.ceil(getBPMTick())) .. "/" .. getBPMMax(),
			G.C.WHITE,
			0.29,
			{ x = 4.55, y = 2.85 },
			"bpmcounter2"
		)
	end
	--]]

	if (isPlayingBlind() and isBoss() and getcurrentBlind() == "bl_fams_extinct") and G.STATE < 9 and G.STATE ~= 11 then
		if targetdisplay == "fams_one" then
			showFloatingText("targetting 1's this hand", G.C.WHITE, 0.29, { x = 0, y = 3.1 }, "targettext")
		elseif targetdisplay == "nothing" then
			showFloatingText("targetting nothing this hand", G.C.WHITE, 0.29, { x = 0, y = 3.1 }, "targettext")
		else
			if isPlayingBlind() and getcurrentBlind() == "bl_fams_extinct" then
				showFloatingText(
					"targetting " .. targetdisplay .. "'s this hand",
					G.C.WHITE,
					0.29,
					{ x = 0, y = 3.1 },
					"targettext"
				)
			else
				showFloatingText(
					"targetting " .. targetdisplay .. "'s this hand",
					G.C.WHITE,
					0.29,
					{ x = 999999, y = 3.1 },
					"targettext"
				)
			end
		end
	end

	timerdisplay = timerdisplay + ((timer - timerdisplay) / 15)

	if isChallenge("choice") and getRoundNumber() ~= 0 then
		SetMoney(0)
	end

	if G.jokers and G.jokers.cards then
		for _, joker in ipairs(G.jokers.cards) do
			if joker.label == "j_fams_mus" then
				if tick_once then
					joker:juice_up()
				end
			end
		end
		currentDeck()
		if G.GAME and G.GAME.blind and G.GAME.blind and G.GAME.blind.chips then
			updateBlindChips()
			update_blind_select_UI()
			updateHandAndDiscardsUI()
		end
	end

	if isChallenge("smol") then
		SetWinningAnte(4)
	end

	if isChallenge("factory") then
		G.GAME.starting_params.ante_scaling = 0.5
	end

	if isChallenge("Dogtrials") then
		setrunBG({ 0.85, 0.55, 0.25, 1 }, { 1, 0.9, 0.5, 1 }, 1)
		SetWinningAnte(10)
	end

	if isChallenge("ghost") then
		setrunBG({ 0.25, 0.25, 0.25, 1 }, { 0.45, 0.45, 0.45, 0.45 }, 1)
	end

	if isChallenge("workshop") then
		setrunBG({ 0, 0, 1, 1 }, { 0, 0, 1, 1 }, 1)
	end

	if isChallenge("SPAWN") and G.STATE ~= 10 then
		setrunBG({ 0, 0, 0, 1 }, { getAnte() / 8, 0, 0, 1 }, 1)
	end

	if isChallenge("jimboonly") and G.STATE ~= 10 then
		setrunBG({ 0.6, 0.2, 0.8, 1 }, { 0.25, 0.05, 0.3, 1 }, 1)
	end

	if isChallenge("court") and G.STATE ~= 10 then
		G.GAME.inflation = G.GAME.inflation + 5
	end

	if isChallenge("DD") and G.STATE ~= 10 then
		if G.GAME.double_down == nil then
		G.GAME.double_down = true
		G.GAME.starting_params.ante_scaling = 2
		SMODS.change_voucher_limit(1)
		SMODS.change_booster_limit(3)
		SMODS.change_play_limit(5)
		SMODS.change_discard_limit(5)
		G.GAME.starting_params.reroll_cost = 10
		SetWinningAnte(16)
		G.GAME.ecto_minus = 2
		G.GAME.edition_rate = 2
		G.GAME.rare_mod = 2
		end
	end

	if isChallenge("bstreet") and G.STATE ~= 10 then
		G.GAME.planet_rate = 0
		G.GAME.tarot_rate = 0
		G.GAME.spectral_rate = 0
	end

	if isChallenge("dogtrials") and getAnte() == GetWinningAnte() + 1 then
		local profile = get_current_profile()
		if profile and not profile.dog_trials_win == true then
			profile.dog_trials_win = true
		end

		if G and G.PROFILES and G.SETTINGS and G.SETTINGS.profile then
			local pr = G.PROFILES[G.SETTINGS.profile]
			if pr then
				pr.fams_dogtrials_completed = true
				if type(set_profile_progress) == "function" then
					pcall(set_profile_progress)
				end
				G.fams_dogtrials_complete = true
			end
		end
	end

	if isChallenge("SPAWN") and G.STATE ~= 10 then
		local now = (love.timer.getTime and love.timer.getTime() or os.clock())
		if now - auto_add_card_timer >= 4 / (getAnte() / 4) then
			SMODS.add_card({
				area = G.jokers,
				key = "j_fams_spawn",
				no_edition = true,
			})
			auto_add_card_timer = now
		end
	end

	if hasWon() or hasLost() then
		triggered_antes_music_update2 = {}
	end
	last_checked_ante = last_checked_ante or 0
	local ante = getAnte and getAnte() or (G and G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante) or 0
	if isChallenge("Dogtrials") and ante > 0 and ante ~= last_checked_ante then
		if not triggered_antes_music_update2[ante] then
			local joker_key = dogtrials_jokers[ante]
			if joker_key and type(joker_key) == "string" and joker_key ~= "" then
				SMODS.add_card({
					area = G.jokers,
					key = joker_key,
					no_edition = true,
				})
			else
			end
		end
		triggered_antes_music_update2[ante] = true
	else
	end
	last_checked_ante = ante

end
