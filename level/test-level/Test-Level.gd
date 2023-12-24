extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# Instance the player (if it's not already in the scene)
	var player = preload("res://player/Player.tscn").instantiate()
	add_child(player)
	#player.is_player = true
	player.position = Vector2(0, 0)

	# Instance and attach the camera to the player
	var camera = Camera2D.new()
	player.add_child(camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
