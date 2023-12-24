extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var _animated_sprite = $AnimatedSprite2D
var _ability_register = AbilityRegister.new()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	_ability_register.register_ability(Ability.Type.Dash, AbilityMetadata.new(Ability.Tier.Common, 1, 4))

func _physics_process(delta):
	_ability_register.process_cooldown(delta)
	var v = Vector2()
	v.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	v.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#print("X: %s | Y: %s" % [str(v.x), str(v.y)])
	velocity = v.normalized() * SPEED
	
	if Input.get_action_raw_strength("dash") > 0:
		_use_ability(Ability.Type.Dash)

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
		return
	if _ability_register.is_on_cooldown(type):
		print("Ability is on cooldown. Remaining: %s" % _ability_register.get_remaining_cooldown(type))
	else:
		print("Start cooldown")
		_ability_register.start_cooldown(ability)
