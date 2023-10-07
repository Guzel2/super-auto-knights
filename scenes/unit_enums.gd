extends Node

enum classes {
	paladin,
	mage,
	berserk,
	archer,
	swordsman,
}

enum stats {
	attack,
	defence,
	max_hp,
	attack_time,
}

var unit_stats = {
	classes.paladin: 
		{
			stats.attack: 3,
			stats.defence: 2,
			stats.max_hp: 9,
			stats.attack_time: 2.0,
		},
	classes.mage: 
		{
			stats.attack: 4,
			stats.defence: 1,
			stats.max_hp: 8,
			stats.attack_time: 1.7,
		},
	classes.berserk: 
		{
			stats.attack: 5,
			stats.defence: 1,
			stats.max_hp: 10,
			stats.attack_time: 2.6,
		},
	classes.archer: 
		{
			stats.attack: 4,
			stats.defence: 0,
			stats.max_hp: 10,
			stats.attack_time: 1.7,
		},
	classes.swordsman: 
		{
			stats.attack: 4,
			stats.defence: 0,
			stats.max_hp: 12,
			stats.attack_time: 1.9,
		},
}
