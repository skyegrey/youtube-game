class_name EquipmentSlot extends ItemSlot

const Enums = preload("res://Scripts/enums.gd")

@export var equipment_type: Enums.EquipmentType

@onready var placeholder_sprite = $SlotBackground/MarginContainer/PlaceholderSprite

func set_item(item: ItemResource):
	super(item)
	placeholder_sprite.visible = false

func display_item_background():
	placeholder_sprite.visible = true
