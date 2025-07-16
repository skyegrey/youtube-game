class_name Inventory extends Node

const Enums = preload("res://Scripts/enums.gd")

signal inventory_updated
signal money_updated

@onready var money: int
@onready var equiped_hats_array: Array[HatResource]
@onready var equiped_hats_count: int = 0
@onready var hat_slots: int = 4

func _ready():
	equiped_hats_array.resize(hat_slots)

func auto_equip_hat(new_hat_resource: HatResource):
	equiped_hats_array[equiped_hats_count] = new_hat_resource
	inventory_updated.emit()

func add_money(_money: int):
	money += _money
	money_updated.emit(money)
