extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
var _ability_register = AbilityRegistry.new()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	_ability_register.register_ability(
		Dash.new(Ability.Type.Dash, AbilityMetadata.new(Ability.Tier.Epic, 1, 2))
	)

func _physics_process(delta):
	var v = Vector2()
	v.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	v.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = v.normalized() * Constants.PLAYER_SPEED
	
	if Input.get_action_raw_strength("dash") > 0 and (v.x != 0  or v.y != 0):
		_use_ability(Ability.Type.Dash)

	_ability_register.cycle(self, delta)
	move_and_slide()

func _process(_delta):
	var animationName: String = ""
	if (velocity.y > 0.0):
		animationName = "walk_down"
	elif (velocity.y < 0.0):
		animationName = "walk_up"
	elif (velocity.x > 0.0):
		animationName = "walk_right"
	elif (velocity.x < 0.0):
		animationName = "walk_left"
	if (animationName != ""):
		_animated_sprite.play(animationName)
	else:
		_animated_sprite.stop()
		_animated_sprite.frame = 0

func _use_ability(type: Ability.Type):
	var ability = _ability_register.get_ability(type)
	if not ability:
		return false
	#if _ability_register.is_on_cooldown(type):
		#print("Ability is on cooldown. Remaining: %s" % _ability_register.get_remaining_cooldown(type))
		#return false
	else:
		_ability_register.execute(self, ability)
		return true
