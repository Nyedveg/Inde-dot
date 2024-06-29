extends Node

@onready var menu_sfx = $MenuSFX
@onready var transition = $UI/Transition

var transitioning: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if transitioning:
		transition.color += Color(0.0, 0.0, 0.0, 0.01)

func _on_start_button_pressed():
	button_interact()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_exit_button_pressed():
	button_interact()
	await get_tree().create_timer(1.0).timeout
	get_tree().quit()
	
func button_interact():
	menu_sfx.play()
	transitioning = true
