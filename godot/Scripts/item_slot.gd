class_name ItemSlot extends Control

@onready var texture_rect = $SlotBackground/MarginContainer/TextureRect

@onready var item: ItemResource

func set_item(_item: ItemResource):
	item = _item
	texture_rect.texture = _item.texture
