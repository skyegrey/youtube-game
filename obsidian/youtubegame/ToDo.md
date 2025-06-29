
Comment Features:
- [ ] Add a boss slime with 50hp that jumps & gets stunned when landing
	- [ ] Implement the Enemy Node
	- [ ] Give the boss 50 hp
		- [ ] Create a healthbar
			- [ ] Progress bar
			- [ ] Text
	- [ ] Boss tracks player
	- [ ] Jump sprite
	- [ ] Stun on jump landing
	- [ ] Stun sprite
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

Bugs:
- [ ] Fix tooltip flicker