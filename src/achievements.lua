SMODS.Achievement{
    key = "flushdog",
    loc_txt = {
        name = "Dog's Toilet",
        description = {
            'Discover "flush of dog"'
        }
    },
    atlas = "silver",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return G.GAME.current_round.current_hand.handname == "Flush of dog"
    end,
}

SMODS.Achievement{
    key = "eng",
    loc_txt = {
        name = "A BIT of math",
        description = {
            'Discover "Four Bit Binary"'
        }
    },
    atlas = "gold",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return G.GAME.current_round.current_hand.handname == "Four Bit Binary"
    end,
}

SMODS.Achievement{
    key = "slam",
    loc_txt = {
        name = "COME ON AND SLAM",
        description = {
            'AND WELCOME TO THE JAM'
        }
    },
    atlas = "bronze",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return G.GAME.last_tarot_planet == "c_fams_basketball"
    end,
}

SMODS.Achievement{
    key = "raw",
    loc_txt = {
        name = "IT'S FUCKIN RAW!",
        description = {
            'Have gordon ramsay defeat the salmon blind.'
        }
    },
    atlas = "silver",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = false,
    unlock_condition = function(self, args)
        return G.GAME.gordon_secret == true
    end,
}

SMODS.Achievement{
    key = "titleall",
    loc_txt = {
        name = "Sightseeing",
        description = {
            'View all title screen types in one session'
        }
    },
    atlas = "silver",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = false,
    unlock_condition = function(self, args)
        return get_current_profile().viewer == true
    end,
}

SMODS.Achievement{
    key = "wingingding",
    loc_txt = {
        name = "Winging my ding",
        description = {
            'Find the lost doctor'
        }
    },
    atlas = "gold",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = true,
    unlock_condition = function(self, args)
        return G.GAME.found_gaster == true
    end,
}

SMODS.Achievement{
    key = "dingdong",
    loc_txt = {
        name = "You touched the dong",
        description = {
            'Get jumpscared :)'
        }
    },
    atlas = "bronze",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = true,
    unlock_condition = function(self, args)
        return G.dingaling == true
    end,
}

SMODS.Achievement{
    key = "finaleend",
    loc_txt = {
        name = "The End",
        description = {
            'Complete "Dog Trials"'
        }
    },
    atlas = "gold",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = false,
    unlock_condition = function(self, args)
        return isChallenge("dlcend") and G and G.GAME and getAnte() == G.GAME.win_ante + 1
    end,
}

SMODS.Achievement{
    key = "PB",
    loc_txt = {
        name = "Punching Bag",
        description = {
            'Get all death quotes'
        }
    },
    atlas = "gold",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = false,
    unlock_condition = function(self, args)
        return chosen_lose_quotes_has_all()
    end,
}

SMODS.Achievement{
    key = "stakeall",
    loc_txt = {
        name = "You did all the stakes!",
        description = {
            'What the fuck is your problem.'
        }
    },
    atlas = "gold",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = false,
    unlock_condition = function(self, args)
        return G and G.GAME and G.GAME.stake == 19 and getAnte() == G.GAME.win_ante + 1
    end,
}

SMODS.Achievement{
    key = "sight",
    loc_txt = {
        name = "First Sighting",
        description = {
            'First Entity: Skinwalker Dog'
        }
    },
    atlas = "skinwalker",
    pos = { x = 0, y = 0 },
    hidden_text = false,
    hidden_name = false,
    unlock_condition = function(self, args)
        return G.skinwalker == true
    end,
}

SMODS.Achievement{
    key = "finaledlc",
    loc_txt = {
        name = "The end (...again)",
        description = {
            'Complete "To the edge of the universe"'
        }
    },
    atlas = "gold",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = false,
    unlock_condition = function(self, args)
        return get_current_profile().end_win == true
    end,
}

SMODS.Achievement{
    key = "finalepass",
    loc_txt = {
        name = "Beyond The Edge",
        description = {
            'Reach ante 100 in "To The Edge Of The Universe"'
        }
    },
    atlas = "gold",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    hidden_name = false,
    unlock_condition = function(self, args)
        return isChallenge("dlcend") and G and G.GAME and getAnte() >= 100
    end,
}