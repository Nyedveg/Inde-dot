extends Node

@onready var menu_sfx = $MenuSFX

@export var firstGame_scene: PackedScene
@export var secondGame_scene: PackedScene
@export var thirdGame_scene: PackedScene
@export var fourthGame_scene: PackedScene
@export var fifthGame_scene: PackedScene
@export var sixthGame_scene: PackedScene

var score = 0
var item
var current_task = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$WiseManUI.visible = true
	#Outline for shovel


# Leaving the game with 'ESC'
func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()


func _on_spear_button_pressed():
	item = 0
	$WiseManUI.visible = false


func _on_gladius_button_pressed():
	item = 1
	$WiseManUI.visible = false


func _on_axe_button_pressed():
	item = 2
	$WiseManUI.visible = false


func _on_shovel_pressed():
	button_interact()
	if current_task == 0:
		#Bellow outline
		add_child(firstGame_scene.instantiate())


func _on_bellow_pressed():
	button_interact()
	if current_task == 1:
		#Hammer outline
		add_child(secondGame_scene.instantiate())


func _on_hammer_pressed():
	button_interact()
	if current_task == 2:
		#Prongs outline
		add_child(thirdGame_scene.instantiate())


func _on_prongs_pressed():
	button_interact()
	if current_task == 3:
		#Grindstone outline
		add_child(fourthGame_scene.instantiate())


func _on_grindstone_pressed():
	button_interact()
	if current_task == 4:
		#Table outline
		add_child(fifthGame_scene.instantiate())


func _on_table_pressed():
	button_interact()
	if current_task == 5:
		add_child(sixthGame_scene.instantiate())

func button_interact():
	menu_sfx.play()
