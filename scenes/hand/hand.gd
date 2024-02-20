extends Node2D

static var cardScene:PackedScene = preload("res://scenes/card/card.tscn")

var cards:Array[Node] = [] # card instances

func addCard(c:Node):
	cards.append(c)
	add_child(cards[cards.size() - 1])
	relocateCards()

func remCard(n:int):
	cards[n].queue_free()
	cards.remove_at(n)
	if selected >= cards.size() && selected != 0:
		prevCard()
	relocateCards()

func relocateCards():
	var len:int = cards.size()
	for i in range(len):
		var card:Node = cards[i]
		var deg:int = (i - (len-1)/2) * 5 # last number is angle
		card.pos = Vector2(sin(deg_to_rad(deg)), 1-cos(deg_to_rad(deg))) * 500
		card.rot = deg

func prevCard():
	if selected == 0: selected = cards.size() - 1
	else: selected -= 1

func nextCard():
	if selected == cards.size() - 1: selected = 0
	else: selected += 1


func _ready(): position = Vector2(960, 600)

var selected:int = 0
var sec:float = 0

func _process(delta):
	if Input.is_action_just_pressed("prev"): prevCard()
	if Input.is_action_just_pressed("next"): nextCard()
	print(selected)
	
	sec += delta
	if sec >= 1.5: 
		sec -= 1.5
		if cards.size() < 7: 
			addCard(Card.strike())
