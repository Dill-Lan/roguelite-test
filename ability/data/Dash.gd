class_name Dash extends Ability

const _DASH_SPEED_MULTIPLIER = 6

var _velocity_snapshot: Vector2 = Vector2(0, 0)
var _dash_time_remaining: float = 0.0

func _init(_type: Ability.Type, _metadata: AbilityMetadata):
	super(_type, _metadata)

func execute(player: CharacterBody2D):
	_velocity_snapshot = player.velocity
	_dash_time_remaining = 0.2
	pass

func cycle(player: CharacterBody2D, delta: float):
	if _dash_time_remaining > 0:
		_dash_time_remaining -= delta
		player.velocity = _velocity_snapshot.normalized() * Constants.PLAYER_SPEED * _DASH_SPEED_MULTIPLIER
	pass
