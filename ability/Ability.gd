class_name Ability

var type: Type
var metadata: AbilityMetadata

func _init(_type: Type, _metadata: AbilityMetadata):
	type = _type
	metadata = _metadata
	
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
