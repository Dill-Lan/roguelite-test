extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var _animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var v = Vector2()
	v.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	v.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#print("X: %s | Y: %s" % [str(v.x), str(v.y)])
	velocity = v.normalized() * SPEED

	move_and_slide()

func _process(delta):
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
