class_name BossInfoControl extends MarginContainer

# Child References
@onready var hp_bar: ProgressBar = $VBoxContainer/HPBar
@onready var hp_label: Label = $VBoxContainer/HPBar/HPLabel

# State
@onready var current_boss: Node2D

func set_as_current_boss(boss_enemy: Node2D):
	visible = true
	current_boss = boss_enemy
	current_boss.took_damage.connect(_update_progress_bar)
	_update_progress_bar()

func _update_progress_bar():
	_update_hp_bar()
	_update_hp_label()

func _update_hp_bar():
	hp_bar.value = float(current_boss.current_hp) / float(current_boss.max_hp) * 100

func _update_hp_label():
	hp_label.text = str(current_boss.current_hp, '/', current_boss.max_hp)
