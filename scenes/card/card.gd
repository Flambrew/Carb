class_name Card

extends Node2D

static var cardScene:PackedScene = preload("res://scenes/card/card.tscn")

var dmg:int
var def:int
var psn:int

static func strike() -> Node: return build(5)
static func defend() -> Node: return build(0, 5)
static func poison() -> Node: return build(0, 0, 5)
static func turtle() -> Node: return build(5, 5)
static func spikes() -> Node: return build(0, 5, 5)
static func dagger() -> Node: return build(5, 0, 5)

# build a new card instance from parameters
static func build(dmg:int=0, def:int=0, psn:int=0) -> Node:
	var card = cardScene.instantiate()
	card.dmg = dmg
	card.psn = psn
	card.def = def
	
	# hueshift shit - to remove later
	for c in card.get_children():
		if c is Sprite2D:
			var g = Color(1, 1, 1)
			if dmg>0: g += Color(254, 0, 0)
			if psn>0: g += Color(0, 254, 0)
			if def>0: g += Color(0, 0, 254)
			c.set_modulate(g)
	
	return card

func _ready(): scale = scl
func _process(delta): updateTransform()

var pos: Vector2 = Vector2.ZERO
var rot: float = 0
var scl: Vector2 = Vector2(.9, 1.5)
const dmp: float = 0.05

func updateTransform():
	position += (pos - position) * dmp
	rotation_degrees += (rot - rotation_degrees) * dmp
	scale += (scl - scale) * dmp

