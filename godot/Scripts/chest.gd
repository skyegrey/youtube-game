class_name Chest extends Interactable

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var inventory = %Inventory
@onready var new_item_display = $"../../UILayer/UI/NewItemDisplay"

#const WITCH_HAT = preload("res://Resources/Instances/Helms/witch-hat.tres")
#const COWBOY_HAT = preload("res://Resources/Instances/Helms/cowboy-hat.tres")
#
#func interact():
	#animated_sprite_2d.play("open")
	#inventory.add_to_inventory([WITCH_HAT, COWBOY_HAT].pick_random())
	#inventory.add_money(100)
	#new_item_display.display_new_item()
