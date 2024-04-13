extends Control

@export var enemy: bool = false 
var moused_over: bool = false

func _ready():
	pass


func _process(delta):
	if not enemy and moused_over and Input.is_action_just_released("click") and not GlobalLevelManager.selected_card == null:
		place_card(GlobalLevelManager.selected_card)

func place_card(card : BaseCard):
	create_tween().tween_property($Tile/Blank, "self_modulate", Color(1,1,1,0), 1)
	create_tween().tween_property($Tile/CardImage, "self_modulate", Color(1,1,1,1), 1)
	$Tile/CardImage.texture = load(card._image)
	$Attack2/AttackText.text = str(card._attack)
	$Attack2.visible = true
	$Health2/HealthText.text = str(card._health)
	$Health2.visible = true
	$Name.text = card._name
	card.start_disappear()

func _on_mouse_entered():
	$Name.visible = true
	moused_over = true

func _on_mouse_exited():
	$Name.visible = false
	moused_over = false
