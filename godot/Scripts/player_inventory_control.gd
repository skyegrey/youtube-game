class_name PlayerInventoryControl extends InventoryControl

const Enums = preload("res://Scripts/enums.gd")

# Scene Refs
@onready var inventory: Inventory = %Inventory

# Prefabs
const INVENTORY_SLOT = preload("res://Scenes/inventory_slot.tscn")

# Properties
@onready var starting_y_position: int = 800
@onready var on_screen_y_position: int = 0
@onready var animate_in_duration: float = .25
@onready var is_open: bool = false

# Child references
@onready var invetory_slots_container = $InventoryPanel/MarginContainer/InvetorySlotsContainer
@onready var dragging_item_texture = $InventoryPanel/DraggingItemTexture
@onready var equipment_slots = $InventoryPanel/EquipmentSlots
@onready var equipment_slot = $InventoryPanel/EquipmentSlots/EquipmentSlot
@onready var helm_sprite = $InventoryPanel/CharacterPreview/MarginContainer/SlotBackground/HelmSprite

# State
@onready var dragging_slot: InventorySlot
@onready var equipment_type_to_slot: Dictionary[Enums.EquipmentType, EquipmentSlot]

func _ready():
	inventory.inventory_updated.connect(_refresh_inventory_ui)
	inventory.equipment_updated.connect(_refresh_inventory_ui)
	equipment_type_to_slot[Enums.EquipmentType.HELM] = equipment_slot
	_setup_inventory_slots()

func _input(event):
	if dragging_item_texture.visible:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
				_end_item_drag(event.global_position)
		if event is InputEventMouseMotion:
			dragging_item_texture.position += event.relative

func toggle():
	if is_open:
		var animate_out_tween = _animate_out()
		animate_out_tween.tween_callback(self._unpause)
	else:
		_pause()
		_animate_in()
	is_open = !is_open

func _animate_in():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position:y", on_screen_y_position, 
	animate_in_duration)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	return tween

func _animate_out():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position:y", starting_y_position, 
	animate_in_duration)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	return tween

func _refresh_inventory_ui():
	for equipment_type: Enums.EquipmentType in inventory.equipment:
		var item: Item = inventory.equipment[equipment_type]
		if item:
			equipment_type_to_slot[equipment_type].set_item(item)
			helm_sprite.visible = true
			helm_sprite.texture = item.texture
		else:
			equipment_type_to_slot[equipment_type].display_item_background()
	for index in range(inventory.items.size()):
		if inventory.items[index] is Item:
			var inventory_item: Item = inventory.items[index]
			invetory_slots_container.get_child(index).set_item(inventory_item)

func _setup_inventory_slots():
	for index in range(inventory.items.size()):
		var new_inventory_slot = INVENTORY_SLOT.instantiate()
		new_inventory_slot.slot_index = index
		new_inventory_slot.begin_item_drag.connect(_begin_item_drag)
		invetory_slots_container.add_child(new_inventory_slot)

func _begin_item_drag(item_slot: ItemSlot):
	if not dragging_item_texture.visible and item_slot.item:
		dragging_item_texture.global_position = get_viewport().get_mouse_position() - \
		 dragging_item_texture.size/2
		dragging_item_texture.visible = true
		dragging_item_texture.texture = item_slot.item.texture
		item_slot.texture_rect.visible = false
		dragging_slot = item_slot

func _end_item_drag(ending_mouse_position):
	dragging_item_texture.visible = false
	for equipment_slot: EquipmentSlot in equipment_slots.get_children():
		if equipment_slot.get_global_rect().has_point(ending_mouse_position):
			inventory.update_equipment_slots(dragging_slot.item, 
			dragging_slot.slot_index, 0)
			return
	for index in range(invetory_slots_container.get_children().size()):
		if dragging_slot.slot_index != index:
			var inventory_slot: InventorySlot = invetory_slots_container.get_child(index)
			if inventory_slot.get_global_rect().has_point(ending_mouse_position):
				inventory.update_inventory_slots(dragging_slot.item, 
				dragging_slot.slot_index, index)
				return
	dragging_slot.texture_rect.visible = true
