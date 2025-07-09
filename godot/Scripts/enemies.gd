class_name Enemies extends Node2D

# Scene References
@onready var objective_control: ObjectiveControl = %ObjectiveControl


@onready var player_character = $"../PlayerCharacter"
@onready var boss_info_control: BossInfoControl = $"../UILayer/UI/BossInfoControl"
const ENEMY_NODE = preload("res://Scenes/enemy_node.tscn")
const SLIME_BOSS = preload("res://Scenes/slime_boss.tscn")
@onready var spawn_slime_timer = $SpawnSlimeTimer

@onready var slimes_killed: int = 0
@onready var king_slime_spawned: bool = false
@onready var slime_kill_objective: int = 50

func _ready():
	spawn_slime_timer.timeout.connect(spawn_slime)

func _process(delta):
	pass

func spawn_slime():
	var slime_enemy: EnemyNode = ENEMY_NODE.instantiate()
	slime_enemy.player_character = player_character
	slime_enemy.position = player_character.global_position + 300*Vector2.from_angle(randf_range(0, 2*PI))
	add_child(slime_enemy)
	slime_enemy.tree_exited.connect(_add_to_slime_kill_count)

func _spawn_king_slime():
	if king_slime_spawned:
		return
	objective_control.set_boss_has_spawned()
	var slime_boss: SlimeBoss = SLIME_BOSS.instantiate()
	slime_boss.player_character = player_character
	slime_boss.position = Vector2(200, 100)
	add_child(slime_boss)
	boss_info_control.set_as_current_boss(slime_boss)
	king_slime_spawned = true

func _add_to_slime_kill_count():
	slimes_killed += 1
	if not king_slime_spawned:
		objective_control.update_remaining_slimes(slime_kill_objective \
	- slimes_killed)
	if slimes_killed >= slime_kill_objective:
		_spawn_king_slime()
		spawn_slime_timer.stop()
			
