class_name Dash extends Ability

const _DASH_SPEED_MULTIPLIER = 6

var _velocity_snapshot: Vector2 = Vector2(0, 0)
var _dash_time_remaining: float = 0.0
var _charges: int
var _cooldowns: Array[float]

func _init(_type: Ability.Type, _metadata: AbilityMetadata):
	super(_type, _metadata)
	match _metadata.tier:
		Ability.Tier.Common:
			_charges = 1
			_cooldowns = [0.0]
		Ability.Tier.Uncommon:
			_charges = 1
			_cooldowns = [0.0]
		Ability.Tier.Rare:
			_charges = 2
			_cooldowns = [0.0, 0.0]
		Ability.Tier.Epic:
			_charges = 3
			_cooldowns = [0.0, 0.0, 0.0]
		Ability.Tier.Legendary:
			_charges = 4
			_cooldowns = [0.0, 0.0, 0.0, 0.0]

func is_on_cooldown() -> bool:
	return _cooldowns.all(func(number): return number != 0) or _dash_time_remaining > 0.0

func execute(player: CharacterBody2D):
	if is_on_cooldown():
		return
	_velocity_snapshot = player.velocity
	_dash_time_remaining = 0.2
	var free_cooldown_slot = _cooldowns.find(0)
	_cooldowns[free_cooldown_slot] = metadata.cooldown

func cycle(player: CharacterBody2D, delta: float):
	for index in len(_cooldowns):
		print("Cooldowns: %s" % str(_cooldowns))
		var cooldown = _cooldowns[index]
		if cooldown > 0:
			_cooldowns[index] = cooldown - delta
		if cooldown < 0:
			_cooldowns[index] = 0
	if _dash_time_remaining > 0:
		_dash_time_remaining -= delta
		player.velocity = _velocity_snapshot.normalized() * Constants.PLAYER_SPEED * _DASH_SPEED_MULTIPLIER
	pass
