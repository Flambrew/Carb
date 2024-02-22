extends Node2D

static var hand:PackedScene = preload("res://scenes/combatui/hand/hand.tscn")


func _ready():
	hand.deck = [Card.strike(), Card.defend(), Card.poison(), 
				Card.strike(), Card.defend(), Card.poison(), 
				Card.thorns(), Card.spines(), Card.dagger()]
	hand.reset()

func _process(_delta):
	if Input.is_action_just_pressed("prev"): hand.switch(hand.PREV)
	if Input.is_action_just_pressed("next"): hand.switch(hand.NEXT)
	if Input.is_action_just_pressed("select"): hand.play()
	if Input.is_action_just_pressed("discard"): hand.discard()
