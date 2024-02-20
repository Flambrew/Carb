extends Sprite2D

func _ready():
	scale = Vector2(1, 0)

func _process(delta):
	var amount:float = floorf(get_parent().amount) / 10 
	pos = Vector2(0, 64 * (1-amount))
	scl = Vector2(1, amount)
	updateTransform()

var pos: Vector2 = Vector2.ZERO
var rot: float = 0
var scl: Vector2 = Vector2(1, 0)
const dmp: float = 0.15

func updateTransform():
	position += (pos - position) * dmp
	rotation_degrees += (rot - rotation_degrees) * dmp
	scale += (scl - scale) * dmp
