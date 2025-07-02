class_name ui extends Control

# Scene Refs
@onready var player_inventory_control: InventoryControl = %PlayerInventoryControl
@onready var loot_inventory_control = %LootInventoryControl
@onready var modal_background = %ModalBackground

func _ready():
	var pausables = [player_inventory_control, loot_inventory_control]
	for pausable in pausables:
		pausable.game_paused.connect(_toggle_modal.bind(true))
		pausable.game_unpaused.connect(_toggle_modal.bind(false))

func _process(delta):
	if Input.is_action_just_pressed("ui_inventory"):
		player_inventory_control.toggle()

func _toggle_modal(is_visible):
	modal_background.visible = is_visible
