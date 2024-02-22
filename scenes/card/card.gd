class_name Card
extends Node2D
static var cardScene:PackedScene = preload("res://scenes/card/card.tscn")

const SELF = 0
const MEELEE = 1
const RANGED = 2
const NONE = 0
const SHORT = 1
const MEDIUM = 2
const LONG = 3

var typ:int
var rch:int
var nrg:int
var dmg:int
var shd:int
var psn:int

static func strike() -> Node: return build(MEELEE, MEDIUM, 3, 5, 0, 0)
static func defend() -> Node: return build(SELF, NONE, 4, 0, 5, 0)
static func poison() -> Node: return build(RANGED, LONG, 5, 0, 0, 5)
static func thorns() -> Node: return build(MEELEE, SHORT, 6, 5, 5, 0)
static func spines() -> Node: return build(SELF, SHORT, 8, 0, 5, 5)
static func dagger() -> Node: return build(MEELEE, SHORT, 9, 5, 0, 5)

# build a new card instance from parameters
static func build(TYP:int, RCH:int, NRG:int, DMG:int, SHD:int, PSN:int) -> Node:
	var card = cardScene.instantiate()
	card.typ = TYP # type
	card.rch = RCH # reach 
	card.nrg = NRG # energy
	card.dmg = DMG # damage
	card.shd = SHD # shield
	card.psn = PSN # poison
	
	# temp schtuff
	if NRG == 3: card.modulate = Color(255, 1, 1)
	if NRG == 4: card.modulate = Color(1, 255, 1)
	if NRG == 5: card.modulate = Color(1, 1, 255)
	if NRG == 6: card.modulate = Color(255, 255, 1)
	if NRG == 8: card.modulate = Color(255, 1, 255)
	if NRG == 9: card.modulate = Color(1, 255, 255)
	
	return card

static func dupe(card:Node) -> Node:
	return build(card.typ, card.rch, card.nrg, card.dmg, card.def, card.psn)

func _ready(): scale = scl
func _process(_delta): updateTransform()

var pos: Vector2 = Vector2.ZERO
var rot: float = 0
var scl: Vector2 = Vector2(.6, 1)
const dmp: float = 0.05

func updateTransform():
	position += (pos - position) * dmp
	rotation_degrees += (rot - rotation_degrees) * dmp
	scale += (scl - scale) * dmp

