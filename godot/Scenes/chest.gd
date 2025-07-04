class_name Chest extends Interactable

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var loot_inventory_control = %LootInventoryControl
@onready var inventory = %Inventory
@onready var new_item_display = $"../../UILayer/UI/NewItemDisplay"

const WITCH_HAT = preload("res://Resources/Instances/witch-hat.tres")

func interact():
	animated_sprite_2d.play("open")
	inventory.add_to_inventory(WITCH_HAT)
	inventory.add_money(100)
	new_item_display.display_new_item()
	#loot_inventory_control.open(self)
