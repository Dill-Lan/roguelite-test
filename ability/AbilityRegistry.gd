class_name AbilityRegistry

var abilities = {}
var cooldowns = {}

func register_ability(ability: Ability):
	abilities[ability.type] = ability

func get_ability(type: Ability.Type):
	return abilities.get(type)

func execute(player: CharacterBody2D, ability: Ability):
	cooldowns[ability.type] = ability.metadata.cooldown
	ability.execute(player)

#func is_on_cooldown(type: Ability.Type):
	#return cooldowns.has(type) and cooldowns[type] > 0

#func get_remaining_cooldown(type: Ability.Type):
	#return cooldowns[type] if cooldowns.has(type) else -1

func cycle(player: CharacterBody2D, delta: float):
	for type in abilities.keys():
		#if cooldowns.has(type):
			#cooldowns[type] -= delta
			#if cooldowns[type] <= 0:
				#cooldowns.erase(type)
		abilities[type].cycle(player, delta)
