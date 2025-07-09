class_name ObjectiveControl extends MarginContainer

@onready var objective_label = $ObjectiveLabel

func update_remaining_slimes(new_remaining_slimes: int):
	objective_label.text = str('[center]Slimes Remaining: ', new_remaining_slimes)

func set_boss_has_spawned():
	objective_label.text = str('[center]Boss has spawned!')
