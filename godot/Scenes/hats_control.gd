class_name HatsControl extends Control

@onready var inventory: Inventory = %Inventory

const INVENTORY_SLOT = preload("res://Scenes/inventory_slot.tscn")

@onready var h_box_container = $NinePatchRect/MarginContainer/HBoxContainer

func _ready():
	inventory.inventory_updated.connect(_refresh_hats)
	for __ in range(inventory.hat_slots):
		h_box_container.add_child(INVENTORY_SLOT.instantiate())

func _refresh_hats():
	for hat_index in inventory.equiped_hats_array.size():
		if inventory.equiped_hats_array[hat_index]:
			h_box_container.get_child(hat_index).set_item(
				inventory.equiped_hats_array[hat_index])
