class_name NPC extends Node2D

# Prefabs
const WITCH_HAT = preload("res://Resources/Instances/Hats/witch-hat.tres")
const FEDORA = preload("res://Resources/Instances/Hats/Fedora.tres")
const COWBOY_HAT = preload("res://Resources/Instances/Hats/CowboyHat.tres")
# Scene Refs
@onready var player_character = %PlayerCharacter
@onready var inventory = %Inventory

# Children Refs
@onready var interact_tooltip = $InteractTooltip
@onready var interactable_area = $InteractableArea
@onready var dialouge_box = $DialougeBox
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var sprite_2d = $Sprite2D
@onready var dialouge_label = $DialougeBox/MarginContainer/DialougeLabel

# Props
@onready var tooltip_showing_y_value: float = -22.0
@onready var tooltip_hiding_y_value: float = -4.0
@onready var tooltip_animation_time: float = .25
@onready var dialouge: Array[String] = [
	'Welcome to Unnamed Hat Game!',
	'If you want to survive here, you\'re going to need a hat.',
	'I\'ll lend you one of mine to get started',
	'You can use WASD to move around',
	'Left click to use your main attack',
	'Right click for your secondary attack',
	'Shift to use your movement ability',
	'And R to use your ultimate ability',
	'Use 1 ~ 4 to switch which of your hats are active',
	'Climb (Up / Down) the ladder when you are ready to get started',
	'And good luck!'
]
@onready var current_dialouge_index: int = 0
@onready var dialouge_index_to_event: Dictionary = {
	3: func(): player_character.auto_equip_hat(COWBOY_HAT)
}

# Signals
signal dialouge_finished

func _ready():
	interactable_area.area_entered.connect(_display_interact_key)
	interactable_area.area_exited.connect(_hide_interact_key)
	var with_hat_resource = WITCH_HAT
	_approach_player()

func _display_interact_key(area: Area2D):
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(interact_tooltip, "position:y", 
	tooltip_showing_y_value, tooltip_animation_time)
	tween.tween_property(interact_tooltip, "self_modulate:a", 1, tooltip_animation_time)

func _hide_interact_key(area: Area2D):
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(interact_tooltip, "position:y", 
	tooltip_hiding_y_value, tooltip_animation_time)
	tween.tween_property(interact_tooltip, "self_modulate:a", 0, tooltip_animation_time)
	dialouge_box.visible = false
	dialouge_label.text = ""

func interact():
	interact_tooltip.self_modulate.a = 0
	_display_dialouge_box(dialouge[current_dialouge_index])
	if dialouge_index_to_event.has(current_dialouge_index):
		dialouge_index_to_event[current_dialouge_index].call()
	if current_dialouge_index < dialouge.size()  - 1:
		current_dialouge_index += 1
	else:
		dialouge_finished.emit()
	

func _display_dialouge_box(_dialouge):
	dialouge_box.visible = true
	dialouge_label.text = ""
	var bb_codes = ""
	var completed_dialouge = _dialouge
	for character: String in completed_dialouge:
		dialouge_label.text += character
		audio_stream_player_2d.play()
		await get_tree().create_timer(.035).timeout

func _approach_player():
	var approach_tween = get_tree().create_tween()
	approach_tween.tween_property(self, "position", Vector2(20, -20), 2)
	
	var movement_tween = get_tree().create_tween()
	var movment_angle = .15
	var wiggle_time = .15
	movement_tween.tween_property(sprite_2d, "rotation", movment_angle, wiggle_time)
	movement_tween.tween_property(sprite_2d, "rotation", 0, wiggle_time)
	movement_tween.tween_property(sprite_2d, "rotation", -movment_angle, wiggle_time)
	movement_tween.tween_property(sprite_2d, "rotation", 0, wiggle_time)
	movement_tween.set_loops(0)
	
	approach_tween.tween_callback(func(): movement_tween.stop())
	approach_tween.tween_callback(func(): sprite_2d.rotation = 0)
