class_name ui extends Control

# Scene Refs
@onready var modal_background = %ModalBackground

func _toggle_modal(is_visible):
	modal_background.visible = is_visible
