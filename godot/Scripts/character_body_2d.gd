class_name PlayerCharacter extends CharacterBody2D

@export var player_speed: float = 150

@onready var inventory = %Inventory
@onready var helm = $Helm

func _ready():
	inventory.equipment_updated.connect(_refresh_equipment_sprites)

func _physics_process(delta):
	var movement_vector = Input.get_vector("ui_left", "ui_right", "ui_up", 
	"ui_down")
	if movement_vector != Vector2.ZERO:
		velocity = movement_vector * player_speed
		move_and_slide()

func _refresh_equipment_sprites():
	helm.visible = true
