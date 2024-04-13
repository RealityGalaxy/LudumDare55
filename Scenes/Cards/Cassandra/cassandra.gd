extends BaseCard	

func _ready():
	_cost = 1
	_attack = 1
	_health = 1
	_name = 'Norman'
	_flavor_text = ''
	_image = "res://Sprites/Cards/Norman.png"
	tags = ['Human']
	rerender()
