class_name Enemies extends Node2D

@onready var player_character = $"../PlayerCharacter"
@onready var boss_info_control: BossInfoControl = $"../UILayer/UI/BossInfoControl"

const SLIME_BOSS = preload("res://Scenes/slime_boss.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_spawn_boss"):
		var slime_boss: SlimeBoss = SLIME_BOSS.instantiate()
		slime_boss.player_character = player_character
		slime_boss.position = Vector2(200, 100)
		add_child(slime_boss)
		boss_info_control.set_as_current_boss(slime_boss)
