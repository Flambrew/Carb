class_name Card

extends Node2D

static var cardScene:PackedScene = preload("res://scenes/card/card.tscn")

var nrg:int
var dmg:int
var def:int
var psn:int

static func strike() -> Node: return build(1, 5)
static func defend() -> Node: return build(1, 0, 5)
static func poison() -> Node: return build(1, 0, 0, 5)
static func thorns() -> Node: return build(2, 5, 5)
static func spines() -> Node: return build(2, 0, 5, 5)
static func dagger() -> Node: return build(2, 5, 0, 5)

# build a new card instance from parameters
static func build(nrg:int=0, dmg:int=0, def:int=0, psn:int=0) -> Node:
	var card = cardScene.instantiate()
	card.nrg = nrg
	card.dmg = dmg
	card.psn = psn
	card.def = def
	return card

static func dupe(card:Node) -> Node:
	return build(card.nrg, card.dmg, card.def, card.psn)

func _ready(): scale = scl
func _process(delta): updateTransform()

var pos: Vector2 = Vector2.ZERO
var rot: float = 0
var scl: Vector2 = Vector2(.6, 1)
const dmp: float = 0.05

func updateTransform():
	position += (pos - position) * dmp
	rotation_degrees += (rot - rotation_degrees) * dmp
	scale += (scl - scale) * dmp

