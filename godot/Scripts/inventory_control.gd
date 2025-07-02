class_name InventoryControl extends Control

# Signals
signal game_paused
signal game_unpaused

func _pause():
	get_tree().paused = true
	game_paused.emit()

func _unpause():
	get_tree().paused = false
	game_unpaused.emit()
