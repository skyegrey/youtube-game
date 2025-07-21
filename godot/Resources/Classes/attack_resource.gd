class_name AttackResource extends Resource

func use(player_character: PlayerCharacter, projectiles_manager: Projectiles):
	play_animation()
	spawn_melee_hitboxes()
	spawn_projectiles(player_character, projectiles_manager)

func play_animation():
	pass

func spawn_melee_hitboxes():
	pass

func spawn_projectiles(player_character: PlayerCharacter, projectiles_manager: Projectiles):
	pass
