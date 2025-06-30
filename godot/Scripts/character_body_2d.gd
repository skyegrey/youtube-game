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
	
	if Input.is_action_just_pressed("debug_squish"):
		_squish()

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

func apply_squish():
	_squish()

func _squish():
	var squish_tween = get_tree().create_tween()
	squish_tween.tween_property(self, "scale:y", .25, .15)
	get_tree().create_timer(1).timeout.connect(_unsquish)

func _unsquish():
	var unsquish_tween = get_tree().create_tween()
	unsquish_tween.tween_property(self, "scale:y", 1, .15)
