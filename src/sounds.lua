spinnerbone = math.random(-10, 10) 
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

thetimer = 0
colrandom = math.random(0, 0.1)
colrandom2 = math.random(0, 0.1)
colrandom3 = math.random(0, 0.1)
-- dlc finale

SMODS.Sound {
  key = "music_dlcf",
  pitch = 1,
  volume = 0.8,
  path = "music_dlcf.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() <= 9 then
	musicPower(2)
	setBPM(130)
	return 1000
	end
  end
}

SMODS.Sound {
  key = "music_stopit ",
  pitch = 1,
  volume = 0.7,
  path = "music_stopit.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 70 and getAnte() < 80 then
  G.blind_select_opts = {}
  G.blind_select_opts.small = G.GAME.round_resets.blind_states['Boss'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
  G.blind_select_opts.big = G.GAME.round_resets.blind_states['Boss'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
  G.blind_select_opts.boss = G.GAME.round_resets.blind_states['Boss'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
	return 99440024
	end
  end
}

SMODS.Sound {
  key = "music_outer",
  pitch = 1,
  volume = 1,
  path = "music_outer.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 20 and getAnte() < 25 then
  setrunBG({ 0, 0, 0, 1 }, { 0, 0, 0, 0 }, 1)
	musicPower(3)
	setBPM(139)
	return 999
	end
  end
}

SMODS.Sound {
  key = "music_beyond",
  pitch = 1,
  volume = 1,
  path = "music_beyond.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 10 and getAnte() < 20 then
	musicPower(2.5)
  setrunBG({ 0.063, 0.098, 0.149, 1 }, { 0, 0, 0, 0 }, 1)
	setBPM(130)
	return 999
	end
  end
}

SMODS.Sound {
  key = "music_yourlimit",
  pitch = 1,
  volume = 1,
  path = "music_yourlimit.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 100 then
  setrunBG({ 0.063, 0.098, 0.149, 1 }, { 0, 0, 0, 0 }, 1)
	musicPower(10)
	setBPM(130)
	return 9999
	end
  end
}

SMODS.Sound {
  key = "music_nolimit3",
  pitch = 1,
  volume = 0.5,
  path = "music_nolimit3.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 70 and getAnte() < 100 then
	return 9999
	end
  end
}

SMODS.Sound {
  key = "music_nolimit2",
  pitch = 1,
  volume = 0.5,
  path = "music_nolimit2.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 50 and getAnte() < 70 then
	return 9999
	end
  end
}

SMODS.Sound {
  key = "music_nolimit1",
  pitch = 1,
  volume = 0.5,
  path = "music_nolimit1.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 40 and getAnte() < 50 then
    
	return 9999
	end
  end
}

SMODS.Sound {
  key = "music_nolimit",
  pitch = 1,
  volume = 0,
  path = "music_nolimit1.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 39 and getAnte() < 40 then
  setrunBG({ 0, 0, 0, 1 }, { 0, 0, 0, 0 }, 1)
	musicPower(4)
	setBPM(120)
	return 9999
	end
  end
}

SMODS.Sound {
  key = "music_ender",
  pitch = 1,
  volume = 0,
  path = "music_thankyou.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 39 and getAnte() < 45 then
  setrunBG({ 0, 0, 0, 1 }, { 0, 0, 0, 0 }, 1)
	musicPower(3)
	setBPM(135)
	return 9999
	end
  end
}

SMODS.Sound {
  key = "music_thankyou",
  pitch = 1,
  volume = 1,
  path = "music_thankyou.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 37 and getAnte() < 39 then
  setrunBG({ 0, 0, 0, 1 }, { 0, 0, 0, 0 }, 1)
	setBPM(135)
	return 999
	end
  end
}

SMODS.Sound {
  key = "music_vortex",
  pitch = 1,
  volume = 0.7,
  path = "music_wind.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 20 and getAnte() < 37 then
  setrunBG({ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 1)
	musicPower(1)
	setBPM(1)
	return 999
	end
  end
}

SMODS.Sound {
  key = "music_mount",
  pitch = 1,
  volume = 1,
  path = "music_mount.ogg",
  select_music_track = function(self)
	if isChallenge("mtn")then
	musicPower(1.5)
	setBPM(128)
  setrunBG({ 0, 0, 0.2 + sine(0.2, 0.3) + (getAnte() / 5), 1 }, { 0, 0, 0.2 + sine(0.2, 0.3) + (getAnte() / 5), 0 }, 1)
	
  return 999
	end
  end
}

SMODS.Sound {
  key = "music_lap2",
  pitch = 1,
  volume = 1,
  path = "music_lap2.ogg",
  select_music_track = function(self)
	if isChallenge("lap2") then
	musicPower(5)
	setBPM(90 * 2)
  return 999
	end
  end
}