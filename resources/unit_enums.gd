extends Resource
class_name unit_enums

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
			stats.attack: 6,
			stats.defence: 0,
			stats.max_hp: 10,
			stats.attack_time: 2.6,
		},
	classes.mage: 
		{
			stats.attack: 4,
			stats.defence: 1,
			stats.max_hp: 7,
			stats.attack_time: 2.1,
		},
	classes.berserk: 
		{
			stats.attack: 3,
			stats.defence: 0,
			stats.max_hp: 9,
			stats.attack_time: 2.3,
		},
	classes.archer: 
		{
			stats.attack: 0,
			stats.defence: 1,
			stats.max_hp: 7,
			stats.attack_time: 1.9,
		},
	classes.swordsman: 
		{
			stats.attack: 4,
			stats.defence: 1,
			stats.max_hp: 11,
			stats.attack_time: 2.5,
		},
}
