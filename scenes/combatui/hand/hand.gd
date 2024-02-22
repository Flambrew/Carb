extends Node2D

const PREV:int = -1			# switch(): previous card
const NEXT:int = 1			# switch(): next card
const DISCARD_COST:int = 1	# energy cost for a discard
const MAX_HAND:int = 4		# hand size limit

var deck:Array[Node] = []	# list of cards available
var stack:Array[Node] = []	# list of cards in the draw pile
var hand:Array[Node] = []	# list of cards in your hand
var current:int = 0			# selected card

func add(c:Node):
	deck.append(c);

func reset():
	stack = deck.duplicate(true)
	hand = []

func play() -> Node: 
	if hand.size() > current && $"../EnergyBar".spendEnergy(hand[current].nrg):
		return _discard(current)
	return null

func discard() -> Node:
	if hand.size() > current && $"../EnergyBar".spendEnergy(DISCARD_COST):
		return _discard(current)
	return null

func switch(direction:int):
	if direction == PREV:
		if current == 0: current = hand.size() - 1
		else: current -= 1
	elif direction == NEXT:
		if current == hand.size() - 1: current = 0
		else: current += 1
	_relocateCards()

func _draw():
	if hand.size() >= MAX_HAND || stack.size() == 0: 
		return 
	var card:Node = stack.pop_at(randi_range(0, stack.size() - 1))
	hand.append(card)
	add_child(card)
	_relocateCards()

func _discard(n:int) -> Node:
	var card:Node = hand[n]
	remove_child(card)
	stack.append(hand.pop_at(n))
	if current >= hand.size() && current != 0:
		switch(PREV)
	else: _relocateCards()
	return card

func _relocateCards():
	for i in range(hand.size()):
		var deg:float = (i - hand.size() / 2.0 + .5) * 5 # last number is angle
		var rad:float = deg_to_rad(deg)
		hand[i].rot = deg
		hand[i].pos = Vector2(sin(rad), 1-cos(rad)) * 500 # arbitrary number
		if i == current:
			hand[i].pos += Vector2(0, -25).rotated(sin(rad))

func _ready(): position = Vector2(960, 600)

func _process(_delta): 
	while (hand.size() < MAX_HAND && stack.size() != 0): _draw()
