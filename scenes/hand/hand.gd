extends Node2D
static var cardScene:PackedScene = preload("res://scenes/card/card.tscn")

const PREV:int = -1
const NEXT:int = 1
const DISCARD_COST:int = 1
const MAX_HAND:int = 7

var deck:Array[Node] = []	# list of cards available
var stack:Array[Node] = []	# list of cards in the draw pile
var hand:Array[Node] = []	# list of cards in your hand
var trash:Array[Node] = []	# list of cards in the discard pile
var current:int = 0			# selected card

func add(c:Node):
	deck.append(c);

func start():
	stack = deck.duplicate(true)
	hand = []
	trash = []

func play(): 
	if hand.size() > current && $"../EnergyBar".spendEnergy(hand[current].nrg):
		_discard(current)
	# implement something actually playing the card ingame

func discard():
	if hand.size() > current && $"../EnergyBar".spendEnergy(DISCARD_COST):
		_discard(current)

func endTurn():
	pass

func _draw():
	if hand.size() < MAX_HAND: 
		if stack.size() == 0:
			stack = trash.duplicate(true)
			trash = []
		if stack.size() != 0:
			var card:Node = stack.pop_at(randi_range(0, stack.size() - 1))
			hand.append(card)
			add_child(card)
			_relocateCards()

func _switch(direction:int):
	if direction == PREV:
		if current == 0: current = hand.size() - 1
		else: current -= 1
	if direction == NEXT:
		if current == hand.size() - 1: current = 0
		else: current += 1
	_relocateCards()

func _discard(n:int):
	remove_child(hand[n])
	trash.append(hand.pop_at(n))
	if current >= hand.size() && current != 0:
		_switch(PREV)
	else: _relocateCards()

func _relocateCards():
	for i in range(hand.size()):
		var deg:float = (i - hand.size() / 2.0 + .5) * 5 # last number is angle
		var rad:float = deg_to_rad(deg)
		hand[i].rot = deg
		hand[i].pos = Vector2(sin(rad), 1-cos(rad)) * 500 # arbitrary number
		if i == current:
			hand[i].pos += Vector2(0, -25).rotated(sin(rad))

func _ready():
	position = Vector2(960, 600)
	
	#debug
	deck = [Card.strike(), Card.defend(), Card.poison(), 
			Card.thorns(), Card.spines(), Card.dagger()]
	start()

func _process(delta):
	if Input.is_action_just_pressed("prev"): _switch(PREV)
	if Input.is_action_just_pressed("next"): _switch(NEXT)
	if Input.is_action_just_pressed("select"): play()
	if Input.is_action_just_pressed("discard"): discard()
	if Input.is_action_just_pressed("debug"): _draw()
