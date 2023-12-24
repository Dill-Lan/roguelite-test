class_name AbilityMetadata

var tier: Ability.Tier
var level: int
var cooldown: int

func _init(_tier, _level, _cooldown):
	tier = _tier
	level = _level
	cooldown = _cooldown
