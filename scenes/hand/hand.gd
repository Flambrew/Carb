extends Node2D

func _ready():
	position = Vector2(640, 575)

var secs:float
func _process(delta):
	secs += delta
	if secs >= 1 : 
		secs -= 1
		if cards.size() != 0 && randi_range(cards.size(), 6) == 6:
			remCard(randi_range(0, cards.size()-1))
		elif cards.size() < 7:
			var n = randi_range(0, 5)
			if (n == 0):
				addCard(Card.strike())
			elif (n == 1):
				addCard(Card.defend())
			elif (n == 2):
				addCard(Card.poison())
			if (n == 3):
				addCard(Card.turtle())
			elif (n == 4):
				addCard(Card.spikes())
			elif (n == 5):
				addCard(Card.dagger())

var cards:Array[Node] = [] # card instances

func addCard(c:Node):
	cards.append(c)
	add_child(cards[cards.size() - 1])
	relocateCards()

func remCard(n:int):
	cards[n].queue_free()
	cards.remove_at(n)
	relocateCards()

const xbuf:int = 150
const ybuf:int = 10
const angle:int = 5
func relocateCards():
	var len = cards.size()
	for i in range(len):
		var card:Node = cards[i]
		card.pos = Vector2(xbuf*i - xbuf*(len-1)/2, ybuf*abs((len-1)-(2*i)))
		card.rot = angle*i - angle*(len-1)/2

