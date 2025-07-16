class_name EnemyNode extends CharacterNode

# Scene refs
@onready var player_character: PlayerCharacter

# Child refs
@onready var hurtbox = $Hurtbox
@onready var status_timer = $StatusTimer

# Properties
@export var movement_speed: float = .065
@export var damage: int = 10

# State variables
@onready var state: States = States.MOVING

# Signals
signal took_status

func _ready():
	super()
	current_hp = max_hp
	hurtbox.area_entered.connect(_hit_by_projectile)
	status_timer.timeout.connect(_apply_statuses)

func _process(delta):
	if state == States.STUNNED:
		return

	if state != States.MOVING:
		_update_state(States.MOVING)
	
	if state == States.MOVING:
		position += position.direction_to(player_character.position) * movement_speed

func _update_state(new_state: States):
	if new_state == state:
		return

func _hit_by_projectile(projectile_area: Area2D):
	var projectile: Projectile = projectile_area.get_parent().projectile
	_take_damage(projectile.damage)
	if projectile.poison_stacks >= 0:
		_apply_poison(projectile.poison_stacks)

func _apply_statuses():
	if poison_stacks >= 0:
		_take_damage(poison_stacks * 5)

func _apply_poison(stacks: int):
	poison_stacks += stacks
	took_status.emit()

func _check_is_dead():
	if current_hp <= 0:
		_die()

func _die():
	queue_free()
