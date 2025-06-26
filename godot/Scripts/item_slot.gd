class_name ItemSlot extends Control

@onready var is_mouse_hovering: bool = false
@onready var texture_rect = $SlotBackground/MarginContainer/TextureRect
@onready var tooltip = $Tooltip

@onready var item: Item

signal begin_item_drag

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func set_item(_item: Item):
	item = _item
	texture_rect.texture = _item.texture

func _input(event):
	if is_mouse_hovering:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				begin_item_drag.emit(self)

func _on_mouse_entered():
	is_mouse_hovering = true
	if item:
		tooltip.visible = true

func _on_mouse_exited():
	is_mouse_hovering = false
	tooltip.visible = false
