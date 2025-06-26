class_name ui extends Control

# Scene Refs
@onready var inventory_control: InventoryControl = %InventoryControl
@onready var modal_background = %ModalBackground

func _ready():
	inventory_control.game_paused.connect(_toggle_modal.bind(true))
	inventory_control.game_unpaused.connect(_toggle_modal.bind(false))

func _process(delta):
	if Input.is_action_just_pressed("ui_inventory"):
		inventory_control.toggle()

func _toggle_modal(is_visible):
	modal_background.visible = is_visible
