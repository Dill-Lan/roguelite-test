class_name AbilityRegister

var abilities = {}
var cooldowns = {}

func register_ability(type: Ability.Type, metadata: AbilityMetadata):
	var ability = Ability.new(type, metadata)
	abilities[type] = ability

func get_ability(type: Ability.Type):
	return abilities.get(type)

func start_cooldown(ability: Ability):
	cooldowns[ability.type] = ability.metadata.cooldown

func is_on_cooldown(type: Ability.Type):
	return cooldowns.has(type) and cooldowns[type] > 0

func get_remaining_cooldown(type: Ability.Type):
	return cooldowns[type] if cooldowns.has(type) else -1

func process_cooldown(delta):
	for ability in cooldowns.keys():
		cooldowns[ability] -= delta
		if cooldowns[ability] <= 0:
			cooldowns.erase(ability)
