extends Node2D

var amount:float = 0

func _ready():
	scale = Vector2(0.5, 4)
	position = Vector2(1200, 360)

func _process(delta):
	if amount <= 10: amount += delta
	else: amount = 10

func spendEnergy(n:int) -> bool:
	if amount >= n: 
		amount -= n
		return true
	return false
