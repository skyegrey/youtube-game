class_name ProjectileNode extends Node2D

var speed: float
var direction: Vector2
var max_range: float
var traveled_distance: float = 0
var projectile: Projectile

@onready var projectile_sprite = $ProjectileSprite

func _physics_process(delta):
	if direction:
		var movement_vector = direction * speed * delta
		position += movement_vector
		traveled_distance += movement_vector.length()
		if traveled_distance >= max_range:
			queue_free()

func set_projectile(_projectile: Projectile):
	speed = _projectile.speed
	max_range = _projectile.max_range
	projectile_sprite.texture = _projectile.texture
	projectile = _projectile
	
