class_name SlimeBoss extends Node2D

@onready var player_character = $"../PlayerCharacter"

@export var movement_speed: float = .065
var test : Vector2

func _process(delta):
	var movement_vector = position.direction_to(player_character.position) \
	* movement_speed
	position += movement_vector
