SMODS.Sound {
  key = "music_gencom",
  pitch = 1,
  path = "music_completenorm.ogg",
  select_music_track = function(self)
  local pr = G.PROFILES[G.SETTINGS.profile]
  if pr and pr.dog_trials_win == true then
	musicPower(2.3)
	setBPM(130)
	return 800
  end
  end
}


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
  key = "imweiner",
  pitch = 1,
  volume = 1,
  path = "winblind.ogg",
}

SMODS.Sound {
  key = "bang",
  pitch = 1,
  volume = 1,
  path = "bang.ogg",
}

SMODS.Sound {
  key = "honk",
  pitch = 1,
  volume = 1,
  path = "honk.ogg",
}

SMODS.Sound {
  key = "XSCREAM",
  pitch = 1,
  volume = 1,
  path = "XSCREAM.ogg",
}

SMODS.Sound {
  key = "ut_encounter",
  pitch = 1,
  volume = 1,
  path = "ut_encounter.ogg"
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
  key = "baldiohh",
  pitch = 1,
  volume = 0.8,
  path = "baldiohh.ogg",
}

SMODS.Sound {
  key = "splat",
  pitch = 1,
  volume = 0.8,
  path = "splat.ogg",
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
  key = "music_doubledown",
  pitch = 1,
  path = "music_doubledown.ogg",
  select_music_track = function(self)
	if isChallenge("DD") then
	musicPower(2.3)
	setBPM(120)
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
  key = "music_bigmoney_action",
  pitch = 1,
  path = "music_bigmoney_action.ogg",
  select_music_track = function(self)
    if G.GAME.big_money and G.GAME.ut_action then
      return 999999
    end
  end
}

SMODS.Sound {
  key = "music_bigmoney_strategy",
  pitch = 1,
  path = "music_bigmoney_strategy.ogg",
  select_music_track = function(self)
    if G.GAME.big_money and not G.GAME.ut_action then
      return 999999
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
  key = "parry1",
  pitch = 1,
  volume = 1,
  path = "parry1.ogg",
}

SMODS.Sound {
  key = "parry2",
  pitch = 1,
  volume = 1,
  path = "parry2.ogg",
}

SMODS.Sound {
  key = "cupdie1",
  pitch = 1,
  volume = 1,
  path = "cupdie1.ogg",
}

SMODS.Sound {
  key = "cupdie2",
  pitch = 1,
  volume = 1,
  path = "cupdie2.ogg",
}

SMODS.Sound {
  key = "c_announce1",
  pitch = 1,
  volume = 1,
  path = "c_announce1.ogg",
}

SMODS.Sound {
  key = "c_announce2",
  pitch = 1,
  volume = 1,
  path = "c_announce2.ogg",
}

SMODS.Sound {
  key = "c_announce3",
  pitch = 1,
  volume = 1,
  path = "c_announce3.ogg",
}

SMODS.Sound {
  key = "c_announce4",
  pitch = 1,
  volume = 1,
  path = "c_announce4.ogg",
}

SMODS.Sound {
  key = "c_announce5",
  pitch = 1,
  volume = 1,
  path = "c_announce5.ogg",
}

SMODS.Sound {
  key = "c_announcego1",
  pitch = 1,
  volume = 1,
  path = "c_announcego1.ogg",
}

SMODS.Sound {
  key = "c_announcego2",
  pitch = 1,
  volume = 1,
  path = "c_announcego2.ogg",
}

SMODS.Sound {
  key = "c_announcego3",
  pitch = 1,
  volume = 1,
  path = "c_announcego3.ogg",
}

SMODS.Sound {
  key = "c_announcego4",
  pitch = 1,
  volume = 1,
  path = "c_announcego4.ogg",
}

SMODS.Sound {
  key = "c_announcego5",
  pitch = 1,
  volume = 1,
  path = "c_announcego5.ogg",
}

SMODS.Sound {
  key = "c_bell",
  pitch = 1,
  volume = 1,
  path = "c_bell.ogg",
}

SMODS.Sound {
  key = "c_beginbell",
  pitch = 1,
  volume = 1,
  path = "c_beginbell.ogg",
}

SMODS.Sound {
  key = "c_win",
  pitch = 1,
  volume = 1,
  path = "c_win.ogg",
}

SMODS.Sound {
  key = "c_winback",
  pitch = 1,
  volume = 1,
  path = "c_winback.ogg",
}

SMODS.Sound {
  key = "c_winboom",
  pitch = 1,
  volume = 1,
  path = "c_winboom.ogg",
}

SMODS.Sound {
  key = "saiyan",
  pitch = 1,
  volume = 1,
  path = "saiyan.ogg",
}

SMODS.Sound {
  key = "truckcrash",
  pitch = 1,
  volume = 1,
  path = "truckcrash.ogg",
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
  key = "music_stopit",
  pitch = 1,
  volume = 0.7,
  path = "music_stopit.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() >= 70 and getAnte() < 80 then
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
  setrunBG({ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 1)
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
  setrunBG({ 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 1)
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
  setrunBG({ 0.85, 0.55, 0.25, 0 }, { 0.85, 0.55, 0.25, 1 }, sine(0.1, 0.04))
	musicPower(100)
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
	if isChallenge("dlcend") and getAnte() >= 80 and getAnte() < 100 then
  setrunBG({ .659 + (getAnte() - 79) / 5, 0.424 + (getAnte() - 79) / 5, 0.153 + (getAnte() - 79) / 5, 1 }, { 0.969 + (getAnte() - 79) / 5, 0.851 + (getAnte() - 79) / 5, 0.537 + (getAnte() - 79) / 5, 0 }, 1 + (getAnte() - 79) / 5)
  G.ROOM.jiggle = (getAnte() - 79.8) / 100
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
  return 999
	end
  end
}

SMODS.Sound {
  key = "music_dlcf",
  pitch = 1,
  volume = 0.8,
  path = "music_dlcf.ogg",
  select_music_track = function(self)
	if isChallenge("dlcend") and getAnte() <= 9 then
  setrunBG({ 0.85, 0.55, 0.25, 0.5 }, { 1, 0.9, 0.5, 0.5 }, 1)
	musicPower(2)
	setBPM(130)
	return 99999
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