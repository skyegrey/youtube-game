class_name PlayerCharacter extends CharacterNode

const Enums = preload("res://Scripts/enums.gd")

# Scenes
const PROJECTILE_NODE = preload("res://Scenes/projectile_node.tscn")

# Scene references
@onready var player_condition = %PlayerCondition
@onready var inventory: Inventory = %Inventory
@onready var projectiles = %Projectiles

# Children references
@onready var character_sprite = $CharacterSprite
@onready var hat = $Hat
@onready var interactables_detection_area = $InteractablesDetectionArea
@onready var npc_detection_area = $NPCDetectionArea
@onready var weapon_sprite = $WeaponSprite
@onready var hurtbox = $Hurtbox

# Properties
@export var player_speed: float = 150

# State
@onready var state = States.IN_CUTSCENE
@onready var npc: NPC = null
@onready var weapon: WeaponResource
@onready var interactable: Interactable = null
@onready var is_vulnerable = true
@onready var hat_resource: HatResource = null

func _ready():
	max_hp = 100
	super()
	npc_detection_area.area_entered.connect(_set_npc)
	npc_detection_area.area_exited.connect(_remove_npc)
	interactables_detection_area.area_entered.connect(_set_interaractable)
	interactables_detection_area.area_exited.connect(_remove_interaractable)
	hurtbox.area_entered.connect(_hit_by_attack)

func _physics_process(delta):
	if state == States.STUNNED:
		return
	
	for hat_slot in inventory.hat_slots:
		if Input.is_action_just_pressed(str("action_equip_slot_", hat_slot  + 1)):
			_equip_hat(hat_slot)
	
	if npc && Input.is_action_just_pressed("ui_interact"):
		npc.interact()
		return
	
	if state == States.IN_CUTSCENE:
		return
	
	if interactable && Input.is_action_just_pressed("ui_interact"):
		interactable.interact()
		return
	
	if state == States.MOVEMENT_LOCKED:
		return
	
	if Input.is_action_just_pressed("attack"):
		_attack()
		return
	
	if Input.is_action_just_pressed("use_ultimate_ability"):
		_ult()
		return

	var movement_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if movement_vector != Vector2.ZERO:
		position += delta * movement_vector * player_speed
		_flip_sprites(movement_vector.x)

func _set_npc(npc_area: Area2D):
	npc = npc_area.get_parent()
	npc.dialouge_finished.connect(_end_cutscene)

func _remove_npc(npc_area: Area2D):
	npc = null

func _set_interaractable(interactable_area: Area2D):
	interactable = interactable_area.get_parent()

func _remove_interaractable(interactable_area: Area2D):
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

func _attack():
	# Redo this with new resource style
	return
	if weapon:
		var new_projectile = PROJECTILE_NODE.instantiate()
		projectiles.add_child(new_projectile)
		new_projectile.global_position = global_position
		new_projectile.set_projectile(weapon.projectile)
		new_projectile.direction = (get_global_mouse_position() - global_position).normalized()

func _hit_by_attack(attack_area: Area2D):
	if not is_vulnerable:
		return
	is_vulnerable = false
	_take_damage(attack_area.get_parent().damage)
	player_condition.update_hp_display(float(current_hp) / float(max_hp))

func _check_is_dead():
	if current_hp <= 0:
		get_tree().reload_current_scene()

func _play_hurt_animation():
	var hurt_tween = get_tree().create_tween()
	hurt_tween.tween_property(character_sprite, "self_modulate", Color.RED, .2)
	hurt_tween.tween_property(character_sprite, "self_modulate", Color.WHITE, .2)
	hurt_tween.set_loops(2)
	await hurt_tween.finished
	is_vulnerable = true

func _end_cutscene():
	state = States.IDLE

func auto_equip_hat(new_hat_resource: HatResource):
	inventory.auto_equip_hat(new_hat_resource)

func _equip_hat(hat_slot: int):
	if inventory.equiped_hats_array[hat_slot]:
		hat_resource = inventory.equiped_hats_array[hat_slot]
		hat.visible = true
		hat.texture = hat_resource.texture
		weapon = hat_resource.weapon_resource
		weapon_sprite.texture = hat_resource.weapon_resource.texture

func _flip_sprites(movement_direction):
	for sprite: Sprite2D in [
		character_sprite, hat, weapon_sprite
	]:
		sprite.flip_h = movement_direction < 0
	var weapon_offset = 7.0
	weapon_sprite.offset.x = weapon_offset if movement_direction >= 0 else -weapon_offset

func _ult():
	if hat_resource:
		if hat_resource.name == 'Witch Hat':
			var projectile_node = PROJECTILE_NODE.instantiate()
			projectiles.add_child(projectile_node)
			projectile_node.global_position = global_position
			projectile_node.set_projectile(
				hat_resource.ultimate_ability.projectile_resource)
			projectile_node.direction = (get_global_mouse_position() - global_position).normalized()
			projectile_node.tree_exited.connect(_spawn_cluster_potions.bind(projectile_node))
			_add_potion_tweener(projectile_node)
		elif hat_resource.name == 'Fedora':
			state = States.MOVEMENT_LOCKED
			var movement_timer = .75 # second
			var movement_distance = 200
			var sword_spin_tweener = get_tree().create_tween()
			sword_spin_tweener.tween_property(weapon_sprite, "rotation", 2*PI, movement_timer/3.0)
			sword_spin_tweener.tween_callback(func(): weapon_sprite.rotation = 0)
			sword_spin_tweener.set_loops(3)
			var movement_tweener = get_tree().create_tween()
			movement_tweener.tween_property(self, "position", 
			global_position + (get_global_mouse_position() - global_position).normalized() * movement_distance, 
			movement_timer)
			movement_tweener.tween_callback(func(): state = States.IDLE)
			
		#var attack = hat_resource.ultimate_ability
		#if attack is RangedAttackResource:
			#var projectile_node = PROJECTILE_NODE.instantiate()
			#projectiles.add_child(projectile_node)
			#projectile_node.global_position = global_position
			#projectile_node.set_projectile(attack.projectile_resource)
			#projectile_node.direction = (get_global_mouse_position() - global_position).normalized()
		#else:
			#pass

func _spawn_cluster_potions(potion: Node2D):
	var spawn_point = potion.position
	for direction: Vector2 in [
			Vector2(1, 1),
			Vector2(1, -1),
			Vector2(-1, 1),
			Vector2(-1, -1)
		]:
		direction = direction.normalized()
		var projectile_node = PROJECTILE_NODE.instantiate()
		projectiles.add_child(projectile_node)
		projectile_node.global_position = spawn_point
		projectile_node.set_projectile(
			hat_resource.basic_attack.projectile_resource)
		projectile_node.max_range = 50
		projectile_node.direction = direction
		_add_potion_tweener(projectile_node)

func _add_potion_tweener(potion: Node2D):
	var tween = get_tree().create_tween()
	tween.tween_property(potion, "rotation", 2*PI, .7)
