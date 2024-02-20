extends Node2D

var pos: Vector2 = Vector2.ZERO
var rot: float = 0
var scl: Vector2 = Vector2.ONE
const speed: float = 250
const impulse: float = 250

func _ready():
	pos = Vector2(100, 500)
	updateTransform()

func _process(delta):
	movement(delta)
	updateTransform()

func movement(delta):
	var movement = Input.get_vector("left", "right", "forward", "backward")
	if Input.is_action_pressed("sneak"): movement *= .6
	elif Input.is_action_pressed("sprint"): movement *= 1.4
	pos += movement * speed * delta

func updateTransform():
	position = pos
	rotation_degrees += (rot - rotation_degrees) * .05
	scale = scl 
