
Comment Features:
- [x] Chest that gives currency and hats
	- [x] Chest in game world
	- [x] Chest interactable
	- [x] Chest opening
	- [x] Currency
		- [x] Counter on screen
		- [x] Icon
	- [x] Hats
		- [x] Prefab hat object
		- [x] Roll for hat on chest opening
- [x] Add a boss slime with 50hp that jumps & gets stunned when landing
	- [x] Implement the Enemy Node
	- [x] Give the boss 50 hp
		- [x] Create a healthbar
			- [x] Progress bar
			- [x] Text
	- [x] Boss tracks player
	- [x] Progress bar tracks hp correctly
	- [x] Jump sprite
	- [x] Stun on jump landing
	- [x] Stun sprite
	- [x] Update sprites to use real sprites
	- [x] Convert boss to prefab
	- [x] Boss summon key
- [x] Add a talking raccoon that guides the player
	- [x] Add NPC 
	- [x] Remap inventory from E to ESC
	- [x] Add interaction detection range
	- [x] Add E to interact when near NPC
	- [x] Add dialogue pop up 
	- [x] Expand the ground a bit
	- [x] Camera follows player
	- [x] Add typewriter effect
	- [x] Add typewriter noise
- [x] Add a Fedora
	- [x] Create Inventory
		- [x] Create UI
			- [x] Create Inventory Slots
			- [x] Create Equipment Slots
	- [x] Create Hat item
	- [x] Add hat item to inventory
	- [x] Drag item functionality
	- [x] Tooltips
	- [x] Character render in inventory
	- [x] Character render in game

Maintenance:
- [ ] Cleanup Inventory slot / equipment slot scenes to have similar child scenes in prefab (i.e. 'ItemFrame' scene & 'Tooltip' scene)
- [ ] Detach sword from character sprite, render sword as sprite on character
- [ ] Sprite flipping when moving in multiple directions
- [ ] Downgrade player from characterbody2d to node2d (alt. promote enemy / npc to character body)
- [ ] Boss HP bar sprites
- [ ] Chest opening displays text on new items
- [ ] SFX for money increase
- [ ] Inventory sprite alignment on the hat
- [ ] Slots not freeing after equip in inventory
- [ ] Sprite is dissapearining on drag to new inventory slot
- [ ] SFX for chest open
- [ ] New Item display fades out
- [ ] New item display reads from item resource
- [ ] New item display is prefabbed
- [ ] New item display is contained in list

Stretch goal:
- [ ] Separate lootable ui

Bugs:
- [ ] Fix tooltip flicker