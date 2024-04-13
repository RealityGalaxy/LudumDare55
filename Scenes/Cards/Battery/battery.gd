extends BaseCard	

func _ready():
	_cost = 4
	_attack = 3
	_health = 4
	_name = 'Assault Battery'
	_flavor_text = ''
	_image = "res://Sprites/Cards/Assault Battery.png"
	tags = ['Criminal']
	rerender()
