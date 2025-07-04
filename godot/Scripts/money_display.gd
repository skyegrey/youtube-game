extends Control

@onready var inventory = %Inventory
@onready var current_money = 0
@onready var last_seen_money = 0
@onready var is_updating = false
@onready var lerp_progress: float = 0.0
@onready var rich_text_label = $MarginContainer/RichTextLabel

func _ready():
	inventory.money_updated.connect(_update_money_display)

func _process(delta):
	if is_updating:
		lerp_progress += delta*2
		rich_text_label.text = "[color=faf36b]" + str(int(lerp(last_seen_money, 
		current_money, lerp_progress)))
		if lerp_progress >= 1:
			lerp_progress = 0
			is_updating = false
			last_seen_money = current_money

func _update_money_display(new_money_value):
	current_money = new_money_value
	is_updating = true
	
