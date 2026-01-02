
SMODS.Sound {
  key = "music_gen",
  pitch = 1,
  path = "music_gennew.ogg",
  select_music_track = function(self)
	musicPower(1.3)
	setBPM(128)
	return 100
  end
}

SMODS.Sound {
  key = "music_spawn",
  pitch = 1,
  path = "music_spawn.ogg",
  select_music_track = function(self)
	if isChallenge("SPAWN") then
	musicPower(1.6)
	setBPM(135)
	return 999
	end
  end
}

SMODS.Sound {
  key = "death",
  pitch = 1,
  volume = 1,
  path = "death.ogg",
}

SMODS.Sound {
  key = "bang",
  pitch = 1,
  volume = 1,
  path = "bang.ogg",
}

SMODS.Sound {
  key = "earleat",
  pitch = 1,
  volume = 1,
  path = "earleatcard.ogg",
}

SMODS.Sound {
  key = "pikmin",
  pitch = 1,
  volume = 0.5,
  path = "pikmin.ogg",
}

SMODS.Sound {
  key = "idiotyellow",
  pitch = 1,
  volume = 0.5,
  path = "pktrip.ogg",
}

SMODS.Sound {
  key = "skull",
  pitch = 1,
  volume = 0.8,
  path = "skull.ogg",
}

SMODS.Sound {
  key = "music_ghost",
  pitch = 1,
  path = "music_dark.ogg",
  select_music_track = function(self)
	if isChallenge("ghost") then
	musicPower(1.3)
	setBPM(100)
	return 999
	end
  end
}

SMODS.Sound {
  key = "music_beat1",
  pitch = 1,
  path = "music_rhythm.ogg",
  select_music_track = function(self)
	if isChallenge("obo") then
	musicPower(1)
	setBPM(60)
	if G.GAME.bpmmax then
		G.GAME.bpmmax = 3
	end
	return 999
	end
  end
}

SMODS.Sound {
  key = "music_beat2",
  pitch = 1,
  path = "music_rhythm2.ogg",
  select_music_track = function(self)
	if isChallenge("tiar") then
	musicPower(1)
	setBPM(72)
	if G.GAME.bpmmax then
		G.GAME.bpmmax = 4
	end
	return 999
	end
  end
}


SMODS.Sound {
  key = "Don",
  path = "Don.ogg"
}

SMODS.Sound {
  key = "donderfulS",
  path = "donderfulS.ogg"
}

SMODS.Sound {
  key = "Katsu",
  path = "Katsu.ogg"
}

SMODS.Sound {
  key = "dogeat",
  path = "dogeat.ogg"
}

SMODS.Sound {
  key = "gasterleave",
  path = "gasterleave.ogg"
}
SMODS.Sound {
  key = "dogres",
  path = "snd_dogresidue.ogg"
}
SMODS.Sound {
  key = "dogresevil",
  path = "snd_dogresidueevil.ogg"
}
SMODS.Sound {
  key = "dogbark",
  path = "snd_pombark.ogg"
}
SMODS.Sound {
  key = "dogbarkevil",
  path = "snd_pombarkevil.ogg"
}

SMODS.Sound {
  key = "dogsteal",
  pitch = 1,
  volume = 0.5,
  path = "dogsteal.ogg"
}
SMODS.Sound {
  key = "tick1",
  pitch = 1,
  path = "tick.ogg"
}
SMODS.Sound {
  key = "tick2",
  pitch = 0.8,
  path = "tick.ogg"
}


SMODS.Sound {
  key = "music_jimb",
  pitch = 1,
  path = "music_jimb.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("jimboonly") then
		if not isAnte(8) then
		if not isBoss() then
		setBPM(75)
		return 9999
		end
		setBPM(75)
		return 9999
		end
	end
  end
}

SMODS.Sound {
  key = "music_trial",
  pitch = 1,
  path = "music_trial.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("Dogtrials") then
		setBPM(130)
		musicPower(2)
		return 9999
	end
  end
}

SMODS.Sound {
  key = "music_finale",
  pitch = 1,
  path = "music_finale.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("finale") then
		setBPM(82 * 2)
		musicPower(2)
			if getcurrentBlind() == "bl_fams_theend" then
				superease = superease + ((1 - superease) / 15)
				setrunBG({0.2, 1, 0.4, 1}, {0.1, 0.8, 0.2, 1}, superease)
			else
				 juice_up_all_cards()
			end
			return 9999999999
	end
  end
}

SMODS.Sound {
  key = "music_jimbfinal",
  pitch = 1,
  path = "music_nearend.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("jimboonly") then
		if isAnte(8) then
		if isBoss() then
		setBPM(108)
		return 100000
		end
		end
	end
  end
}

SMODS.Sound {
  key = "music_toomuch",
  pitch = 0.8,
  path = "music_geno.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("toomuch")then
		SetWinningAnte(99)
		musicPower(5)
		setBPM(144)
		return 999999
	end
  end
}

SMODS.Sound {
  key = "music_whatthefuck",
  pitch = 0.7,
  path = "music_wind.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.challenge and isChallenge("toomuch") and getAnte() > 8 then
		musicPower(1)
		setBPM(40)
		return 99999999
	end
  end
}

SMODS.Sound {
  key = "music_listen",
  pitch = 1,
  volume = 0.5,
  path = "music_wind.ogg",
  select_music_track = function(self)
	if getcurrentBlind() == "bl_fams_Drum" then
		musicPower(1)
		setBPM(60)
		return 99999999
end
end
}

SMODS.Sound {
  key = "music_bomb",
  pitch = 1,
  path = "music_bomb.ogg",
  select_music_track = function(self)
	if G and G.GAME and G.GAME.facing_blind and isChallenge("bomb") then
		musicPower(2)
		setBPM(180)
		return 99999999
	end
  end
}

SMODS.Sound {
  key = "music_bomblow",
  pitch = 1,
  volume = 1,
  path = "music_bomblow.ogg",
  select_music_track = function(self)
	if G and G.GAME and not G.GAME.facing_blind and isChallenge("bomb") then
		musicPower(1.5)
		setBPM(180)
		return 99999999
	end
  end
}


SMODS.Sound {
  key = "music_update",
  pitch = 0.1,
  volume = 0,
  path = "music_wind.ogg",
  select_music_track = function(self)
	clearCustomTextAfterDraw()
	if G.STATE == G.STATES.WIN then

		if isChallenge("bomb") and not blind_timer_bonus_given and G.GAME and G.GAME.current_round and type(G.GAME.current_round.hands_left) == "number" and G.GAME.current_round.hands_left > 0 then
			update_timer_text()
			blind_timer_bonus_given = true
		end
		removeUItimer()
	else
		blind_timer_bonus_given = false
		if G.STATE ~= G.STATES.MAIN_MENU and (isChallenge("bomb") or isChallenge("finale") or GetStake() == 9) then
			if isChallenge("bomb") then
				showUItimer(30)
			else
				if GetStake() == 9 then
					showUItimer(60)
				else
					showUItimer(600)
				end
				
			end

			if G.GAME and G.GAME.facing_blind and not G.OVERLAY_MENU and G.STATE ~= 4 then
				timer = timer - 0.015
				timeradd = true
			end
			update_timer_text()
		else
			removeUItimer()
		end
	end

	if (G.STATE == 4 or G.STATE == 7 or G.STATE == 1) and not isPlayingBlind() and G.GAME.current_round ~= 0 then
		
	end
	
	if not isPlayingBlind() and timeradd == true then
	if G.STATE ~= 0 and G.STATE ~= 2 and G.STATE ~= 3 then
		if G.GAME and G.GAME.current_round and G.GAME.current_round.hands_left and G.GAME.current_round ~= 0 then
 			if not isChallenge("finale") then
				if G.GAME.current_round.hands_left > 0 then
					addtime(10 * G.GAME.current_round.hands_left)
				else
					addtime(10)
				end
			end
		end
	end
	timeradd = false
end

if isPlayingBlind() then
	
else
	triggeronce = true
end

	if (isChallenge('cor')) and G.hand and G.hand_text_area and G.hand_text_area.ante and G.hand_text_area.ante.config then
		
	end
	
	if G.STATE == 11 then
		if title_variant == 1 then
		setMenuBG({0.85, 0.55, 0.25, 1}, {1, 0.9, 0.5, 1}, {1, 0.7, 0.3, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 2 then
		setMenuBG({0, 0.78, 0, 1}, {0, 0.39, 0, 1}, {1, 0.7, 0.3, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 3 then
		setMenuBG({0.9, 0.9, 0.9, 1}, {0.3, 0.3, 0.3, 1}, {1, 0.7, 0.3, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 4 then
		setMenuBG({2, 0, 0, 1}, {0, 0, 2, 1}, {1, 0.7, 0.3, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 5 then
		setMenuBG({1, 1, 1, 1}, {0, 0, 0, 1}, {1, 0, 0, 1}, 0, math.abs(sine(0.6, 1)))
		end
		if title_variant == 6 then
		setMenuBG({0.8, 0, 0, 1}, {0.023, 0.086, 0.435, 1}, {1, 0, 0, 1}, 0, math.abs(sine(0.6, 1)))
		end
		
		showFloatingText("BPM: " .. tostring(BPM), G.C.WHITE, 0.29, {x = 999999, y = 3.1}, "bpmcounter")
		showFloatingText(tostring(math.ceil(getBPMTick())) .. "/".. getBPMMax(), G.C.WHITE, 999999, {x = 4.55, y = 2.85}, "bpmcounter2")
		showFloatingText("targetting "..targetdisplay.."'s this hand", G.C.WHITE, 0.29, {x = 9999999, y = 3.1}, "targettext")
	end

	if G.STATE < 9 and G.STATE ~= 11 then
		showFloatingText("BPM: " .. tostring(BPM), G.C.WHITE, 0.29, {x = 4.55, y = 3.1}, "bpmcounter")
		showFloatingText(tostring(math.ceil(getBPMTick())) .. "/".. getBPMMax(), G.C.WHITE, 0.29, {x = 4.55, y = 2.85}, "bpmcounter2")
	end

	if (isPlayingBlind() and isBoss() and getcurrentBlind() == "bl_fams_extinct") and G.STATE < 9 and G.STATE ~= 11 then
		if targetdisplay == "fams_one" then
		showFloatingText("targetting 1's this hand", G.C.WHITE, 0.29, {x = 0, y = 3.1}, "targettext")
		elseif  targetdisplay == "nothing" then
		showFloatingText("targetting nothing this hand", G.C.WHITE, 0.29, {x = 0, y = 3.1}, "targettext")
	else
		if (isPlayingBlind() and getcurrentBlind() == "bl_fams_extinct") then
		showFloatingText("targetting "..targetdisplay.."'s this hand", G.C.WHITE, 0.29, {x = 0, y = 3.1}, "targettext")
		else
		showFloatingText("targetting "..targetdisplay.."'s this hand", G.C.WHITE, 0.29, {x = 999999, y = 3.1}, "targettext")
		end
		end
	end

	timerdisplay = timerdisplay + ((timer - timerdisplay) / 10)

	if getcurrentBlind() == "bl_fams_Drum" and tick_once then
		flip_all_cards()
		if (getBPMTick() == 1) then
			play_sound('fams_tick1', 1, 1.1)
		else
			play_sound('fams_tick2', 1, 1)
		end
	end

	if isChallenge("finale") then
		SetWinningAnte(12)
	end

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
end
}

SMODS.Sound {
	key = "music_update2",
	pitch = 0.1,
	volume = 0,
	path = "music_wind.ogg",
	select_music_track = function(self)

		if isChallenge("smol") then
			SetWinningAnte(4)
		end

		if isChallenge("Dogtrials") then
			setrunBG({0.85, 0.55, 0.25, 1}, {1, 0.9, 0.5, 1}, 1)
			SetWinningAnte(10)
		end

		if isChallenge("ghost") then
			setrunBG({0.25, 0.25, 0.25, 1}, {0.45, 0.45, 0.45, 0.45}, 1)
		end

		if isChallenge("SPAWN") and G.STATE ~= 10 then
			setrunBG({0, 0, 0, 1}, {getAnte() / 8, 0, 0, 1}, 1)
		end

		if isChallenge("jimboonly") and G.STATE ~= 10 then
			setrunBG({0.6, 0.2, 0.8, 1}, {0.25, 0.05, 0.3, 1}, 1)
		end

		if isChallenge("court") and G.STATE ~= 10 then
			G.GAME.inflation = G.GAME.inflation + 5
		end

		if isChallenge("tiar") and G.STATE ~= 10 then
   			
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
			showFloatingText("Bankrupt at: " .. tostring(G.GAME.bankrupt_at), G.C.BLACK, 0.29, {x = -7.09, y = 9.26}, "bank1bg")
			showFloatingText("Bankrupt at: " .. tostring(G.GAME.bankrupt_at), G.C.MONEY, 0.29, {x = -7.09, y = 9.2}, "bank1")
		end

		if isChallenge("SPAWN") and G.STATE ~= 10 then
		local now = (love.timer.getTime and love.timer.getTime() or os.clock())
   		if now - auto_add_card_timer >= 4 / (getAnte() / 4) then
        SMODS.add_card{
            area = G.jokers,
            key = "j_fams_spawn",
            no_edition = true
        }
        auto_add_card_timer = now
    end
		end

		if hasWon() or hasLost() then
			cooked1 = 0
			cooked2 = 0
 			triggered_antes_music_update2 = {}
		end
 		last_checked_ante = last_checked_ante or 0
		local ante = getAnte and getAnte() or (G and G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante) or 0
		if isChallenge("Dogtrials") and ante > 0 and ante ~= last_checked_ante then
			if not triggered_antes_music_update2[ante] then
				local joker_key = dogtrials_jokers[ante]
 				if joker_key and type(joker_key) == "string" and joker_key ~= "" then
					SMODS.add_card{
						area = G.jokers,
						key = joker_key,
						no_edition = true,
					}
				else
 				end
				end
				triggered_antes_music_update2[ante] = true
			else
				
			end
			last_checked_ante = ante
		end
}