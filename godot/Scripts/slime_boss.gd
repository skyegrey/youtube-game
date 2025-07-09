class_name SlimeBoss extends EnemyNode

# Child Refs
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_hitbox = $AttackHitbox

# Properties
@export var jump_frame_to_hitbox_area: Dictionary

func _ready():
	super()
	current_hp = 50
	max_hp = 50
	attack_hitbox.area_entered.connect(_hit_player)
	_update_state(States.IDLE)

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

func _update_animation(new_state: States):
	match new_state:
		States.MOVING:
			animated_sprite_2d.play("moving")
			animated_sprite_2d.animation_looped.connect(_stun, CONNECT_ONE_SHOT)
		States.STUNNED:
			animated_sprite_2d.play("stuned")

func _hit_player(player_area: Area2D):
	player_area.get_parent().apply_squish()
