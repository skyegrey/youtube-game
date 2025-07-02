class_name Chest extends Interactable

@onready var animated_sprite_2d = $AnimatedSprite2D

func interact():
	animated_sprite_2d.play("open")
