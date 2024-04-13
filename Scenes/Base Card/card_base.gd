extends Control	

class_name BaseCard

var _cost: int
var _attack: int
var _health: int
var _name: String
var _flavor_text: String
var _image: String
var start_pos: Vector2
var id

var is_deleting: bool = false

var buffs = []

var tags = []

var attributes = ['cost', 'attack', 'health', 'name', 'flavor_text', 'image']

var moused_over: bool = false
var held: bool = false
var mouse_pos_delta: Vector2 = Vector2(0,0)

var movement_tween: Tween

func add_buff(buff: Buff):
	if is_deleting: return
	buffs.push_back(buff)
	_health += buff.health_add
	_attack += buff.attack_add
	
func remove_buff(buff: Buff):
	if is_deleting: return
	if buffs.has(buff):
		buffs.remove_at(buffs.find(buff))
	_health -= buff.health_add
	_attack -= buff.attack_add

func rerender():
	if is_deleting: return
	for attribute in attributes:
		update_attribute(attribute)

func update_attribute(attribute: String):
	if is_deleting: return
	match attribute:
		'cost':
			$Cost/CostText.text = str(_cost)
		'attack':
			$Attack/AttackText.text = str(_attack)
		'health':
			$Health/HealthText.text = str(_health)
		'name':
			$Name.text = _name
		'flavor_text':
			$FlavorText.text = _flavor_text
		'image':
			$Image/Image.texture = load(_image)

func _process(delta):
	if is_deleting: return
	if held:
		position = get_global_mouse_position() - mouse_pos_delta
	if Input.is_action_just_pressed("click") and moused_over:
		start_dragging()
	if Input.is_action_just_released("click") and held:
		stop_dragging()

func start_dragging():
	if is_deleting: return
	mouse_pos_delta = get_global_mouse_position() - position
	held = true
	start_pos = position
	create_tween().tween_property(self, "modulate", Color(1,1,1,0.7), 0.2)
	GlobalLevelManager.selected_card = self
	
func stop_dragging():
	if is_deleting: return
	movement_tween = create_tween()
	movement_tween.tween_property(self, 'position', start_pos, 0.2)
	create_tween().tween_property(self, "modulate", Color(1,1,1,1), 0.2)
	held = false

func _on_mouse_entered():
	if is_deleting: return
	$CardEdge.self_modulate = Color(0.6569, 0.3284, 0.1225, 1)
	moused_over = true


func _on_mouse_exited():
	if is_deleting: return
	$CardEdge.self_modulate = Color(0.5255, 0.2627, 0.098, 1)
	moused_over = false

func start_disappear():
	movement_tween.stop()
	is_deleting = true
	await create_tween().tween_property(self, "modulate", Color(1,1,1,0), 0.2).finished
	queue_free()
