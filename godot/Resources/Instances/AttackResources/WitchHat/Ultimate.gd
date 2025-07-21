class_name WitchHatUltimateResource extends AttackResource

const PROJECTILE_NODE = preload("res://Scenes/projectile_node.tscn")

@export var cluster_potion_projectile: Projectile

func spawn_projectiles(player_character: PlayerCharacter, projectiles_manager: Projectiles):
	var projectile_node = PROJECTILE_NODE.instantiate()
	projectiles_manager.add_child(projectile_node)
	projectile_node.global_position = player_character.global_position
	projectile_node.set_projectile(cluster_potion_projectile)
	projectile_node.direction = (player_character.get_global_mouse_position() - player_character.global_position).normalized()
	#projectile_node.tree_exited.connect(_spawn_cluster_potions.bind(projectile_node))
	#_add_potion_tweener(projectile_node)
