munching1 = {0, 0, 0.2, 1 }
munching2 = {0.15, 0, 0.4, 1 }
munching3 = {0.4, 0, 0.6, 1 }
munching4 = {0.55, 0, 0.67, 1 }
munching5 = {0.65, 0, 0.86, 1 }
munching6 = {0.8, 0, 0.9, 1 }
munching7 = {0.9, 0, 1, 1 }
Cghost = {0.6, 0.6, 0.6, 0.6 }
glass = {0.6, 0.6, 0.6, 0.3 }
darkglass = {0, 0, 0, 0.3 }
timesignature = {0.902, 0.902, 0.980, 1.0 }
edge = { 0.063, 0.098, 0.149, 1 }
fams = { 0.545, 0.271, 0.075, 1 }


SMODS.Challenge {
  key = 'allsix',
  loc_txt = {
	name = "Oops! All 6's (Literally)",
	text = {''}
  },
  jokers = {{id = 'j_oops', eternal = true, negative = false, pinned = true}},
  deck = {
	type = 'Challenge Deck',
	cards = (function()
	  local suits = {'H', 'D', 'C', 'S'}
	  local cards = {}
	  for _, s in ipairs(suits) do
		for i = 1, 6 do
		  table.insert(cards, {r = 6, s = s})
		end
	  end
	  return cards
	end)()
  },
  button_colour = G.C.GREEN,
  rules = {
	custom = {},
	modifiers = {
	  {id = "joker_slots", value = 6},
	  {id = "consumable_slots", value = 6},
	  {id = "hand_size", value = 6},
	  {id = "discards", value = 6},
	  {id = "hands", value = 6},
	  {id = "dollars", value = 6},
	  {id = "reroll_cost", value = 6},
	  {id = "consumable_slots", value = 6},
	}
  },
  restrictions = {
		banned_cards = {
			
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'choose',
  loc_txt = {
	name = 'Joker! I choose you!',
	text = {
	  ''
	}
  },
  
  jokers = {
  },
  deck = {
	type = 'Challenge Deck',

  },
  rules = {
	custom = {
	{id = 'no_shop_jokers'}
	},
	modifiers = {
	}
  },
  button_colour = G.C.CHIPS,
  restrictions = {
	banned_cards = {{id = "p_buffoon_normal_1", type = "booster"}, {id = "p_buffoon_normal_2", type = "booster"}, {id = "p_buffoon_jumbo_1", type = "booster"}, {id = "p_buffoon_mega_1", type = "booster"}, {id = "c_judgement"}, {id = "c_soul"}, {id = "j_riff_raff"}, },
	banned_tags = {{id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {}
  },
  consumeables = {{ id = "c_fams_m-b"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'smol',
  loc_txt = {
	name = "Mini Round",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
		{id = "mini"},
		{id = "no_shop_jokers"}
	},
	modifiers = {
	{id = "joker_slots", value = 0},
	{id = "consumable_slots", value = 5},
	}
  },
  restrictions = {
	banned_cards = {{id = "p_buffoon_normal_1", type = "booster"}, {id = "p_buffoon_normal_2", type = "booster"}, {id = "p_buffoon_jumbo_1", type = "booster"}, {id = "p_buffoon_mega_1", type = "booster"}, {id = "c_judgement"}, {id = "c_soul"}, {id = "j_riff_raff"}, },
	banned_tags = {{id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}, {id = "j_tag_cts", "j_tag_GB"}},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'bigdawg',
  loc_txt = {
	name = 'Munching',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',

  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 20}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = munching1,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'squared',
  loc_txt = {
	name = 'Munching X2',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', eternal = true, edition = "negative"},
	{id = 'j_madness', eternal = true, edition = "negative"}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = munching2,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'cubed',
  loc_txt = {
	name = 'Munching X3',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = munching3,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'quartic',
  loc_txt = {
	name = 'Munching X4',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true},
	{id = 'j_fams_radiation', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40},
	  {id = "hands", value = 6},
	}
  },
  button_colour = munching4,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'sursolid',
  loc_txt = {
	name = 'Munching X5',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_fams_yogi', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true},
	{id = 'j_fams_radiation', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40},
	  {id = "hands", value = 6},
	}
  },
  button_colour = munching5,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'sixthpower',
  loc_txt = {
	name = 'Munching X6',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_fams_yogi', edition = "negative", eternal = true},
	{id = 'j_fams_bear', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true},
	{id = 'j_fams_radiation', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40},
	  {id = "hands", value = 6},
	}
  },
  button_colour = munching6,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'seventhpower',
  loc_txt = {
	name = 'Munching X7',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_fams_earl', edition = "negative", eternal = true},
	{id = 'j_fams_yogi', edition = "negative", eternal = true},
	{id = 'j_fams_bear', edition = "negative", eternal = true},
	{id = 'j_madness', edition = "negative", eternal = true},
	{id = 'j_ceremonial', edition = "negative", eternal = true},
	{id = 'j_fams_radiation', edition = "negative", eternal = true},
	{id = 'j_fams_butterdog', edition = "negative", eternal = true}
  },
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {

	},
	modifiers = {
	  {id = 'dollars', value = 40},
	  {id = "hands", value = 6},
	}
  },
  button_colour = munching7,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'big_money',
  loc_txt = {
	name = 'Small Gains',
	text = {
	  'find dem coins'
	}
  },
  jokers = {
	{id = 'j_fams_doller', eternal = true}
  },
  deck = {
	type = 'Challenge Deck',

  },
  button_colour = G.C.GREEN,
  rules = {
	custom = {
	  {id = 'no_reward'},
	  {id = 'no_extra_hand_money'},
	  {id = 'no_interest'}
	},
	modifiers = {
	  {id = 'dollars', value = 10}
	}
  },
  restrictions = {
	banned_cards = {{id = "j_golden"}, {id = "j_rocket"}, {id = "j_cloud_9"}, {id = "j_ticket"}},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {{id = "v_clearance_sale"}, {id = "v_liquidation"}}
}

SMODS.Challenge {
  key = 'whoopscasino',
  loc_txt = {
	name = "You really suck at the slots don't you",
	text = {
	  'find dem coins'
	}
  },
  jokers = {
	{id = 'j_credit_card', eternal = true}
  },
  deck = {
	type = 'Challenge Deck',

  },
  button_colour = G.C.BLACK,
  rules = {
	custom = {
	  {id = "bruh"}
	},
	modifiers = {
	  {id = 'dollars', value = -50}
	}
  },
  restrictions = {
	banned_cards = {{id = "j_golden"}, {id = "j_rocket"}, {id = "j_cloud_9"}, {id = "j_ticket"}},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {{id = "v_clearance_sale"}, {id = "v_liquidation"}}
}

SMODS.Challenge {
  key = 'bstreet',
  loc_txt = {
	name = 'Balatro Street'
  },
  jokers = {
	
  },
  deck = {
	type = 'Challenge Deck',

  },
  button_colour = G.C.RED,
  rules = {
	custom = {
		{id = "no_tarot"},
		{id = "no_planet"},
		{id = "no_spectral"}
	},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {{ id = "p_arcana_normal_1", type = "booster" }, { id = "p_arcana_normal_2", type = "booster" }, { id = "p_arcana_normal_3", type = "booster" }, { id = "p_arcana_normal_4", type = "booster" },
			{ id = "p_arcana_jumbo_1", type = "booster" }, { id = "p_arcana_jumbo_2", type = "booster" }, { id = "p_arcana_mega_1", type = "booster" }, { id = "p_arcana_mega_2", type = "booster" },
			{ id = "p_celestial_normal_1", type = "booster" }, { id = "p_celestial_normal_2", type = "booster" }, { id = "p_celestial_normal_3", type = "booster" }, { id = "p_celestial_normal_4", type = "booster" },
			{ id = "p_celestial_jumbo_1", type = "booster" }, { id = "p_celestial_jumbo_2", type = "booster" }, { id = "p_celestial_mega_1", type = "booster" }, { id = "p_celestial_mega_2", type = "booster" },
			{ id = "p_spectral_normal_1", type = "booster" }, { id = "p_spectral_normal_2", type = "booster" }, { id = "p_spectral_jumbo_1", type = "booster" }, { id = "p_spectral_mega_1", type = "booster" },},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'HK',
  loc_txt = {
	name = "Hell's Kitchen",
	text = {''}
  },
  jokers = {
	{id = "j_fams_ramsay", eternal = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {
	},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}


SMODS.Challenge {
  key = 'wyrC',
  loc_txt = {
	name = "Red Or Blue?",
	text = {''}
  },
  jokers = {{id = 'j_fams_wouldyourather', edition = "negative", eternal = true},},
  deck = {
	type = 'Challenge Deck',
	
  },
  rules = {
	custom = {},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'ghost',
  loc_txt = {
	name = "G-G-G-Ghosts!!!",
	text = {''}
  },
  jokers = {{id = "j_oops", edition = "negative", eternal = true}, {id = "j_oops", edition = "negative", eternal = true}},
  deck = {
	type = 'Challenge Deck',
  },
  button_colour = Cghost,
  rules = {
	custom = {
		
	},
	modifiers = {
	  {id = "joker_slots", value = 1},
	  {id = "consumable_slots", value = 3},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {{ id = "c_fams_m-g"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'bomb',
  loc_txt = {
	name = 'In a Hurry!',
	text = { '' }
  },
  rules = {
	custom = {
		{id = 'timer'},
		{id = 'recspeed'}
	},
	modifiers = {}
},
deck = {
	type = 'Challenge Deck',
  },
  restrictions = {
	banned_cards = {

	},
	banned_tags = {

	},
	banned_other = {

	}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'hpk',
  loc_txt = {
	name = 'Hey! Pikmin',
	text = {
	  'find dem coins'
	}
  },
  jokers = {
	{id = 'j_fams_steve', eternal = true, edition = "negative"},
	{id = 'j_fams_bob', eternal = true, edition = "negative"},
	{id = 'j_fams_joe'},
	{id = 'j_fams_tidywhitey', eternal = true, edition = "negative"},
	{id = 'j_fams_purple', eternal = true, edition = "negative"}
  },
  deck = {
	type = 'Challenge Deck',

  },
  rules = {
	custom = {
	  
	},
	modifiers = {
	
	}
  },
  button_colour = G.C.GREEN,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'BF',
  loc_txt = {
	name = "Black Friday Sale",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {
		{id = "BF1"}
	},
	modifiers = {
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'sh',
  loc_txt = {
	name = "Study Hall",
	text = {''}
  },
  jokers = {{id = "j_fams_pencil", eternal = false}, {id = "j_fams_webster", eternal = false}},
  deck = {
	type = 'Challenge Deck',
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {
		
	},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}


SMODS.Challenge {
  key = 'exam',
  loc_txt = {
	name = "Exam Day",
	text = {''}
  },
  jokers = {{id = "j_fams_pencil", eternal = true}},
  deck = {
	type = 'Challenge Deck',
  },
  button_colour = G.C.RED,
  rules = {
	custom = {
		
	},
	modifiers = {
		{id = "joker_slots", value = 0}
	}
  },
  restrictions = {
	banned_cards = {{id = "c_ectoplasm"}, {id = "v_antimatter"}},
	banned_tags = {{id = "tag_negative"}, {id = "tag_fams_GB"}, {id = "tag_fams_cts"}, {id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {{id = 'bl_final_heart', type = 'blind'}, {id = 'bl_final_leaf', type = 'blind'}}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'Mini-Corp',
  loc_txt = {
	name = "Mini Corp",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
	{id = 'no_reward'},
	{id = 'no_extra_hand_money'},
	{id = 'no_interest'}
	},
	modifiers = {
	  {id = "hands", value = 1},
	  {id = "discards", value = 6},
	  {id = "consumable_slots", value = 6}
	}
  },
  button_colour = G.C.YELLOW,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {{id = "c_fams_m-m"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'taxseason',
  loc_txt = {
	name = 'Tax Season',
	text = { '' }
  },
  deck = {
	type = 'Challenge Deck',
  },
  rules = {
	custom = {
		{id = "tax1"},
		{id = "tax2"},
		{id = "tax3"}
	},
	modifiers = {
		{id = "dollars", value = 20},
	}
},
button_colour = G.C.CHIPS,
  restrictions = {
	banned_cards = {

	},
	banned_tags = {

	},
	banned_other = {

	}
  },
  jokers = {{ id = "j_golden"}},
  consumeables = {{ id = "c_fams_g-tax"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'SPAWN',
  loc_txt = {
	name = "SPAWN",
	text = {''}
  },
  button_colour = G.C.BLACK,
  jokers = {},
  deck = {
	
  },
  rules = {
	custom = {{id = "ohno"}, {id = "ohno3"}, {id = "ohno2"}},
	modifiers = {
	  	{id = "joker_slots", value = 10},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'court',
  loc_txt = {
	name = "Court Room",
	text = {''}
  },
  jokers = {{id = "j_even_steven", eternal = true}, {id = "j_fams_divorce"}, {id = "j_odd_todd", eternal = true}},
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
		{id = "flavor1"}
	},
	modifiers = {
	}
  },
  button_colour = G.C.FILTER,
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {{ id = "c_fams_g-tax"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'obo',
  loc_txt = {
	name = "One By One",
	text = {''}
  },
  jokers = {
	{id = "j_fams_mus", eternal = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.RED,
  rules = {
	custom = {
		{id = "beat1"}
	},
	modifiers = {
		{id = "joker_slots", value = 3}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'tiar',
  loc_txt = {
	name = "Three in a Row",
	text = {''}
  },
  jokers = {
	{id = "j_fams_mus", eternal = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.RED,
  rules = {
	custom = {
	},
	modifiers = {
		{id = "joker_slots", value = 2}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'edge',
  loc_txt = {
	name = 'Cliff Edge',
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck',
  cards = (function()
	local cards = {}
	table.insert(cards, {r = 2, s = 'S'})
	table.insert(cards, {r = 3, s = 'S'})
	table.insert(cards, {r = 4, s = 'S'})
	table.insert(cards, {r = 5, s = 'S'})
	table.insert(cards, {r = 6, s = 'S'})
	table.insert(cards, {r = 7, s = 'S'})
	table.insert(cards, {r = 8, s = 'S'})
	table.insert(cards, {r = 9, s = 'S'})
	table.insert(cards, {r = "T", s = 'S'})
	table.insert(cards, {r = "J", s = 'S'})
	table.insert(cards, {r = "K", s = 'S'})
	table.insert(cards, {r = "Q", s = 'S'})
	table.insert(cards, {r = "A", s = 'S'})
	return cards
  end)()
  },
  rules = {
	custom = {},
	modifiers = {{id = "hand_size", value = 7},}
  },
  button_colour = G.C.BLACK,
  restrictions = {
	banned_cards = {{id = "p_standard_normal_1", type = "booster"}, {id = "p_standard_normal_2", type = "booster"}, {id = "p_standard_normal_3", type = "booster"}, {id = "p_standard_normal_4", type = "booster"}, {id = "p_standard_jumbo_1", type = "booster"}, {id = "p_standard_jumbo_2", type = "booster"}, {id = "p_standard_mega_1", type = "booster"}, {id = "p_standard_mega_2", type = "booster"}, {id = "v_magic_trick"}, {id = "v_illusion"}, {id = "c_familiar"}, {id = "c_grim"}, {id = "c_incantation"}, {id = "c_familiar"}, {id = "c_cryptid"}, {id = "j_marble"}, {id = "j_certificate"}},
	banned_tags = {
		{id = "tag_standard"}, {id = "tag_fams_CH"},
	},
	banned_other = {
	  {id = "bl_pillar", type = "blind"}
	}
  },
  consumeables = {},
  vouchers = {}
}


SMODS.Challenge {
  key = 'tax2',
  loc_txt = {
	name = 'Tax Evasion',
	text = {}
  },
  deck = {
	type = 'Challenge Deck',
  },
  rules = {
	custom = {
		
	},
	modifiers = {
		{id = "dollars", value = 100},
		{id = "consumable_slots", value = 4},
	}
},
  restrictions = {
	banned_cards = {
		
	},
	banned_tags = {

	},
	banned_other = {

	}
  },
  jokers = {},
  consumeables = {{ id = "c_fams_g-tax"}, { id = "c_fams_g-tax"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'jimboonly',
  loc_txt = {
	name = 'Friends until the end',
	text = {
	  ''
	}
  },
  jokers = {
	{id = 'j_joker', eternal = true},
  },
  deck = {
	type = 'Challenge Deck',
  },
  rules = {
	custom = {
		{id = "no_shop_jokers"}
	},
	modifiers = {
		{id = "joker_slots", value = 1}
	}
  },
    button_colour = G.C.PURPLE,
  restrictions = {
	banned_cards = {{id = "c_ectoplasm"}, {id = "v_antimatter"}},
	banned_tags = {{id = "tag_negative"}, {id = "tag_fams_GB"}, {id = "tag_fams_cts"}, {id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {{id = 'bl_final_heart', type = 'blind'}, {id = 'bl_final_leaf', type = 'blind'}}
  },
  consumeables = {},
  vouchers = {{id = "v_planet_merchant"}, {id = "v_planet_tycoon"}}
}

SMODS.Challenge {
  key = 'Dogtrials',
  loc_txt = {
	name = "Dawg Trials",
	text = {''}
  },
  jokers = {
	
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.FILTER,
  rules = {
	custom = {
		{id = "dog_10"},
		{id = "finalenew1"},
		{id = "finalenew2"}
	},
	modifiers = {
		{id = "joker_slots", value = 0},
		{id = "dollars", value = 125},
	}
  },
  restrictions = {
	banned_cards = {{id = "c_ectoplasm"}, {id = "v_antimatter"}, {id = "c_fams_m-dice"}, {id = "c_fams_m-dice-evil"}},
	banned_tags = {{id = "tag_negative"}, {id = "tag_fams_GB"}, {id = "tag_fams_cts"}, {id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {{id = "v_planet_merchant"}, {id = "v_planet_tycoon"}, {id = "bl_final_vessel", type = "blind"}, {id = "bl_final_heart", type = "blind"}, {id = "bl_final_bell", type = "blind"}, {id = "bl_final_leaf", type = "blind"}, {id = "bl_final_acorn", type = "blind"}}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'gamb',
  loc_txt = {
	name = "0.000001% of gamblers quit before they hit big",
  },
  jokers = {
	
  },
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
		{id = "evil"}
	},
	modifiers = {
		{id = "joker_slots", value = 0},
		{id = "hands", value = 1},
		{id = "discards", value = 1}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {{ id = "c_fams_m-dice"}, { id = "c_fams_m-dice"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'workshop',
  loc_txt = {
	name = "Workshop",
  },
  jokers = {
	{id = "j_blueprint", eternal = true, pinned = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
		{id = "all_eternal"},

	},
	modifiers = {
		{id = "joker_slots", value = 2},
		{id = "dollars", value = 50},
	}
  },
  restrictions = {
	banned_cards = {{id = "c_ectoplasm"}, {id = "v_antimatter"}},
	banned_tags = {{id = "tag_negative"}, {id = "tag_fams_GB"}, {id = "tag_fams_cts"}, {id = "tag_buffoon"}, {id = "tag_uncommon"}, {id = "tag_rare"}, {id = "tag_negative"}, {id = "tag_holo"}, {id = "tag_polychrome"}},
	banned_other = {}
  },
  button_colour = G.C.BLUE,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'fuel',
  loc_txt = {
	name = "Fueling the engine",
  },
  jokers = {
	{id = "j_burnt"},
	{id = "j_yorick"}
  },
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {

	},
	modifiers = {
		{id = "joker_slots", value = 5},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = G.C.FILTER,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'geye',
  loc_txt = {
	name = "Eye for a golden eye",
  },
  jokers = {
	{id = "j_golden"},
  },
  deck = {
	type = 'Challenge Deck',
	cards = (function()
	local cards = {}
	for i = 1, 4 do
	table.insert(cards, {r = "J", s = 'S'})
	table.insert(cards, {r = "K", s = 'S'})
	table.insert(cards, {r = "Q", s = 'S'})
	table.insert(cards, {r = "J", s = 'D'})
	table.insert(cards, {r = "K", s = 'D'})
	table.insert(cards, {r = "Q", s = 'D'})
	table.insert(cards, {r = "J", s = 'H'})
	table.insert(cards, {r = "K", s = 'H'})
	table.insert(cards, {r = "Q", s = 'H'})
	table.insert(cards, {r = "J", s = 'C'})
	table.insert(cards, {r = "K", s = 'C'})
	table.insert(cards, {r = "Q", s = 'C'})
	end
	return cards
  end)()
  },
  rules = {
	custom = {

	},
	modifiers = {
		{id = "hands", value = 1},
		{id = "discards", value = 3},
	}
  },
  restrictions = {
	banned_cards = {{id = "j_fams_earl"}, {id = "j_fams_yogi"}, {id = "j_fams_bear"}},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = G.C.MONEY,
  consumeables = {{ id = "c_fams_m-m"}},
  vouchers = {}
}

SMODS.Challenge {
  key = 'aiot',
  loc_txt = {
	name = "An idea or two",
  },
  jokers = {
	{id = "j_brainstorm", eternal = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.FILTER,
  rules = {
	custom = {
		
	},
	modifiers = {
		{id = "joker_slots", value = 3},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {},
  unlocked = function(self)

  end
}

SMODS.Challenge {
  key = 'pastdue',
  loc_txt = {
	name = "Past due",
  },
  jokers = {
	
  },
  deck = {
	type = 'Challenge Deck'
  },
  rules = {
	custom = {
		{id = "money1"}
	},
	modifiers = {
		{id = "dollars", value = 4},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = G.C.MONEY,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'fj',
  loc_txt = {
	name = "Where's Jimbo",
  },
  jokers = {

  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.FILTER,
  rules = {
	custom = {
		{id = "findjim"}
	},
	modifiers = {
		{id = "joker_slots", value = 1}
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {},
}

SMODS.Challenge {
  key = '',
  loc_txt = {
	name = "I\'m jacking it",
  },
  jokers = {

  },
  deck = {
	type = 'Challenge Deck',
	cards = (function()
	local cards = {}
	for i = 1, 4 do
	table.insert(cards, {r = "J", s = 'H'})
	table.insert(cards, {r = "J", s = 'D'})
	table.insert(cards, {r = "J", s = 'S'})
	table.insert(cards, {r = "J", s = 'C'})
	end
	return cards
  end)()
  },
  rules = {
	custom = {

	},
	modifiers = {

	}
  },
  restrictions = {
	banned_cards = {{id = "c_planet_x"}},
	banned_tags = {},
	banned_other = {}
  },
  button_colour = G.C.BLACK,
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'lap2',
  loc_txt = {
	name = "LAP 2!",
  },
  jokers = {
	
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.PURPLE,
  rules = {
	custom = {
		{id = "lap2"},
		{id = "lap22"}
	},
	modifiers = {
		
	}
  },
  restrictions = {
	banned_cards = {{id = "c_fams_m-dice"}, {id = "c_fams_m-dice-evil"}},
	banned_tags = {{id = "tag_fams_up"}, {id = "tag_fams_down"}},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {},

}

SMODS.Challenge {
  key = 'mtn',
  loc_txt = {
	name = "The Mountain",
  },
  jokers = {
	{id = "j_hiker", eternal = true}
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.CHIPS,
  rules = {
	custom = {
		
	},
	modifiers = {
		{id = "joker_slots", value = 3},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {},

}

SMODS.Challenge {
  key = 'dlcend',
  loc_txt = {
	name = "To the edge of the universe",
  },
  jokers = {
	
  },
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = edge,
  rules = {
	custom = {
		{id = "epi"},
		{id = "finaledlc"},
		{id = "goodluck"},
	},
	modifiers = {
		{id = "joker_slots", value = 5},
		{id = "consumable_slots", value = 6},
		{id = "dollars", value = 10},
	}
  },
  restrictions = {
	banned_cards = {},
	banned_tags = {{id = "c_fams_m-dice-evil"}},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {},
  unlocked = function(self)
	return false
  end
}