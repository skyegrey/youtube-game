class_name PlayerCondition extends MarginContainer

@onready var progress_bar = $HBoxContainer/ProgressBar

func update_hp_display(hp_percentage: float):
	progress_bar.value = hp_percentage * 100
