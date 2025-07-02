class_name SlimeBoss extends Node2D

enum States {IDLE, MOVING, STUNNED}

# Scene references
@onready var player_character: PlayerCharacter

# Child Refs
@onready var timer = $Timer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_hitbox = $AttackHitbox

# Properties
@export var movement_speed: float = .065
@export var max_hp: int = 50

# State
@onready var current_hp: int
@onready var state: States = States.IDLE

# Signals
signal took_damage

func _ready():
	current_hp = max_hp
	attack_hitbox.area_entered.connect(_hit_player)

func _take_damage(damage_amount: int):
	current_hp -= damage_amount
	took_damage.emit()
	_check_is_dead()

func _check_is_dead():
	if current_hp <= 0:
		_die()

func _die():
	queue_free()

func _update_state(new_state: States):
	if new_state == state:
		return
	state = new_state
	match state:
		States.MOVING:
			attack_hitbox.monitoring = false

	_update_animation(new_state)

func _stun():
	attack_hitbox.monitoring = true
	_update_state(States.STUNNED)
	animated_sprite_2d.animation_finished.connect(_update_state.bind(States.IDLE), CONNECT_ONE_SHOT)

func _process(delta):
	if state == States.STUNNED:
		return

	if state != States.MOVING:
		_update_state(States.MOVING)
	
	if state == States.MOVING:
		position += position.direction_to(player_character.position) * movement_speed

func _update_animation(new_state: States):
	match new_state:
		States.MOVING:
			animated_sprite_2d.play("moving")
			animated_sprite_2d.animation_looped.connect(_stun, CONNECT_ONE_SHOT)
		States.STUNNED:
			animated_sprite_2d.play("stuned")

func _hit_player(player_area: Area2D):
	player_area.get_parent().apply_squish()
