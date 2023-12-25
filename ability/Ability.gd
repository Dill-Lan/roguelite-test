class_name Ability

var type: Type
var metadata: AbilityMetadata

func _init(_type: Type, _metadata: AbilityMetadata):
	type = _type
	metadata = _metadata

func is_on_cooldown() -> bool:
	return false # Override this in extending classes.

func execute(player: CharacterBody2D):
	pass # Override this in extending classes.

func cycle(player: CharacterBody2D, delta: float):
	pass # Override this in extending classes.
	
enum Tier {
	Common,
	Uncommon,
	Rare,
	Epic,
	Legendary,
}

enum Type {
	Dash,
}
