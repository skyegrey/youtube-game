class_name CharacterNode extends Node2D

enum States {IDLE, MOVING, STUNNED, IN_CUTSCENE}

# Properties
@export var max_hp: int = 10
@export var poison_stacks: int = 0

# State
@export var current_hp: int

# Signals
signal took_damage

func _ready():
	current_hp = max_hp

func _take_damage(damage_amount: int):
	current_hp -= damage_amount
	took_damage.emit()
	_play_hurt_animation()
	_check_is_dead()

func _play_hurt_animation():
	pass

func _check_is_dead():
	pass
