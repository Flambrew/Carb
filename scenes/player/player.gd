extends Node2D



var pos: Vector2 = Vector2.ZERO
var rot: float = 0
var scl: Vector2 = Vector2.ONE
const speed: float = 250
const impulse: float = 250

func movement(delta):
	var dir = Input.get_vector("left", "right", "forward", "backward")
	if Input.is_action_pressed("sneak"): dir *= .6
	elif Input.is_action_pressed("sprint"): dir *= 1.4
	pos += dir * speed * delta

func updateTransform():
	position = pos
	rotation_degrees += (rot - rotation_degrees) * .05
	scale = scl 

func play(c:Node):
	var card = $"res://scenes/combatui/hand/card.tscn"
	if c.typ == card.MELEE:
		pass
	
	
	

func _ready(): pos = Vector2(100, 500)

func _process(delta):
	movement(delta)
	updateTransform()
