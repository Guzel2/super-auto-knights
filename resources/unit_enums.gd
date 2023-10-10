extends Resource
class_name unit_enums

enum classes {
	paladin_lv1,
	mage_lv1,
	berserk_lv1,
	archer_lv1,
	swordsman_lv1,
	paladin_lv2,
	mage_lv2,
	berserk_lv2,
	archer_lv2,
	swordsman_lv2,
}

enum stats {
	attack,
	defence,
	max_hp,
	attack_time,
}

var unit_stats = {
	classes.paladin_lv1: 
		{
			stats.attack: 6,
			stats.defence: 0,
			stats.max_hp: 10,
			stats.attack_time: 2.6,
		},
	classes.mage_lv1: 
		{
			stats.attack: 4,
			stats.defence: 1,
			stats.max_hp: 7,
			stats.attack_time: 2.1,
		},
	classes.berserk_lv1: 
		{
			stats.attack: 3,
			stats.defence: 0,
			stats.max_hp: 9,
			stats.attack_time: 2.3,
		},
	classes.archer_lv1: 
		{
			stats.attack: 0,
			stats.defence: 1,
			stats.max_hp: 7,
			stats.attack_time: 1.9,
		},
	classes.swordsman_lv1: 
		{
			stats.attack: 4,
			stats.defence: 1,
			stats.max_hp: 11,
			stats.attack_time: 2.5,
		},
}

var unit_level_up_stats = {
	classes.paladin_lv1: 
		{
			stats.attack: 0,
			stats.defence: 1,
			stats.max_hp: 2,
			stats.attack_time: -.1,
		},
	classes.mage_lv1: 
		{
			stats.attack: 1,
			stats.defence: 0,
			stats.max_hp: -2,
			stats.attack_time: -.1,
		},
	classes.berserk_lv1: 
		{
			stats.attack: 1,
			stats.defence: 0,
			stats.max_hp: 1,
			stats.attack_time: .1,
		},
	classes.archer_lv1: 
		{
			stats.attack: -2,
			stats.defence: 0,
			stats.max_hp: -1,
			stats.attack_time: -.2,
		},
	classes.swordsman_lv1: 
		{
			stats.attack: 1,
			stats.defence: 0,
			stats.max_hp: 1,
			stats.attack_time: 0,
		},
	#level 2
	classes.paladin_lv2: 
		{
			stats.attack: 1,
			stats.defence: 0,
			stats.max_hp: 2,
			stats.attack_time: .1,
		},
	classes.mage_lv2: 
		{
			stats.attack: 1,
			stats.defence: 1,
			stats.max_hp: 1,
			stats.attack_time: 0,
		},
	classes.berserk_lv2: 
		{
			stats.attack: 0,
			stats.defence: 0,
			stats.max_hp: 3,
			stats.attack_time: .1,
		},
	classes.archer_lv2: 
		{
			stats.attack: 1,
			stats.defence: 1,
			stats.max_hp: 0,
			stats.attack_time: 0,
		},
	classes.swordsman_lv2: 
		{
			stats.attack: 0,
			stats.defence: 0,
			stats.max_hp: 1,
			stats.attack_time: -.1,
		},
}
