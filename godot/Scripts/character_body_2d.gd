class_name PlayerCharacter extends CharacterBody2D

@export var player_speed: float = 150

@onready var inventory = %Inventory
@onready var helm = $Helm
@onready var interactables_detection_area = $InteractablesDetectionArea

@onready var interactable: NPC = null

func _ready():
	inventory.equipment_updated.connect(_refresh_equipment_sprites)
	interactables_detection_area.area_entered.connect(_set_interactable)
	interactables_detection_area.area_exited.connect(_remove_interactable)

func _physics_process(delta):
	if interactable && Input.is_action_just_pressed("ui_interact"):
		interactable.interact()
		return

	var movement_vector = Input.get_vector("ui_left", "ui_right", "ui_up", 
	"ui_down")
	if movement_vector != Vector2.ZERO:
		velocity = movement_vector * player_speed
		move_and_slide()
	


func _refresh_equipment_sprites():
	helm.visible = true

func _set_interactable(interactable_area: Area2D):
	interactable = interactable_area.get_parent()

func _remove_interactable(interactable_area: Area2D):
	interactable = null
