class_name NewItemDisplay extends Control

@onready var new_item_notification = $NewItemNotification

func display_new_item():
	var tween = get_tree().create_tween()
	tween.tween_property(new_item_notification, "position:y", 75, .25)
	tween.parallel().tween_property(new_item_notification, "modulate:a", 1, .25)
