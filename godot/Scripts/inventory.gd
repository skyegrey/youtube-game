class_name Inventory extends Node

const Enums = preload("res://Scripts/enums.gd")

@export var inventory_size: int = 14

signal inventory_updated
signal equipment_updated

const PROXIMITY_BANANAS_FEDORA: Item = preload("res://Resources/Instances/proximity-bananas-fedora.tres")

@onready var items: Array[Item] = []
@onready var equipment: Dictionary[Enums.EquipmentType, Item] = {}

func _ready():
	items.resize(inventory_size)
	call_deferred("_add_item_to_inventory", PROXIMITY_BANANAS_FEDORA, 0)

func add_to_inventory(new_item: Item):
	var item_slot = _get_lowest_item_slot()
	_add_item_to_inventory(new_item, item_slot)

func _add_item_to_inventory(new_item: Item, slot: int):
	items[slot] = new_item
	inventory_updated.emit()

func update_inventory_slots(item, old_index, new_index):
	items[old_index] = null
	_add_item_to_inventory(item, new_index)

func update_equipment_slots(item: Item, inventory_slot_index: int, 
equipment_type: Enums.EquipmentType):
	items[inventory_slot_index] = null
	_add_item_to_equipment(item, equipment_type)

func _add_item_to_equipment(item: Item, equipment_type: Enums.EquipmentType):
	equipment[equipment_type] = item
	equipment_updated.emit()

func _get_lowest_item_slot():
	for item_slot in range(items.size()):
		if items[item_slot] == null:
			return item_slot
	return -1
