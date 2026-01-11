G.fams_update = function(dt)
    --Stop us from appearing in the intro
    if (G.STATE == 13) then return end;
	if (G.GAME.dr_boss) then G.ut_update(dt); end

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

	-- dlcend stuff
	if isChallenge("dlcend") then 
		SetWinningAnte(38)
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
	return 9999
	end

	if isChallenge("mtn") then
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
	return 99440024
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

		--[[ Disabled BPM display due to nil value crashes
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

	--[[ Disabled BPM display due to nil value crashes
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

	if isChallenge("bstreet") and G.STATE ~= 10 then
		G.GAME.planet_rate = 0
		G.GAME.tarot_rate = 0
		G.GAME.spectral_rate = 0
	end

	if isChallenge("dogtrials") and getAnte() == GetWinningAnte() + 1 then
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

	if G.STATE ~= 10 and not isMainMenu() then
		showFloatingText(
			"Bankrupt at: " .. tostring(G.GAME.bankrupt_at),
			G.C.BLACK,
			0.29,
			{ x = -7.09, y = 9.26 },
			"bank1bg"
		)
		showFloatingText(
			"Bankrupt at: " .. tostring(G.GAME.bankrupt_at),
			G.C.MONEY,
			0.29,
			{ x = -7.09, y = 9.2 },
			"bank1"
		)
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
