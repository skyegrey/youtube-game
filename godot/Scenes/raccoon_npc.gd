class_name NPC extends Node2D

# Children Refs
@onready var interact_tooltip = $InteractTooltip
@onready var interactable_area = $InteractableArea

# Props
@onready var tooltip_showing_y_value: float = -22.0
@onready var tooltip_hiding_y_value: float = -4.0
@onready var tooltip_animation_time: float = .25


func _ready():
	interactable_area.area_entered.connect(_display_interact_key)
	interactable_area.area_exited.connect(_hide_interact_key)

func _display_interact_key(area: Area2D):
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(interact_tooltip, "position:y", 
	tooltip_showing_y_value, tooltip_animation_time)
	tween.tween_property(interact_tooltip, "self_modulate:a", 1, tooltip_animation_time)

func _hide_interact_key(area: Area2D):
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(interact_tooltip, "position:y", 
	tooltip_hiding_y_value, tooltip_animation_time)
	tween.tween_property(interact_tooltip, "self_modulate:a", 0, tooltip_animation_time)
