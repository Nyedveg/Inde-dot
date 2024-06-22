extends Node

@export var coal_scene: PackedScene

var score

var progress_needed = 100
var progress_per_coal = 5
var progress = 0
var shots_taken = 0
var coals_hit = 0

var forwards = true
var is_charging
var can_shoot = true
var game_ended = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_charging:
		if forwards:
			$CoalBox/ArrowPath/ArrowPoint.progress += 500*delta
			if $CoalBox/ArrowPath/ArrowPoint.progress > 310:
				forwards = false
		else:
			$CoalBox/ArrowPath/ArrowPoint.progress -= 500*delta
			if $CoalBox/ArrowPath/ArrowPoint.progress < 10:
				forwards = true
	$Hits.text = str(progress)
	
func _input(event):
	# Handle input events
	if event is InputEventMouseButton and not game_ended:
		if event.button_index == 1:
			if event.is_pressed():
				is_charging = true
			else:
				stop_charging()

func stop_charging():
	$CoolDown.start()
	is_charging = false
	forwards = true
	if can_shoot:
		shots_taken += 1
		for i in range(5):
			var direction_randomness = randf_range(-PI/16, PI/16)
			var speed_randomness = randi_range(-100, 100)
		
			var coal = coal_scene.instantiate()
			var direction = $CoalBox/ArrowPath/ArrowPoint.global_position - $CoalBox/ShootingPoint.global_position
			direction = direction.normalized()
			coal.global_position = $CoalBox/ShootingPoint.global_position
			coal.linear_velocity = (direction * (1200 + speed_randomness)).rotated(direction_randomness)
			add_child(coal)
	can_shoot = false
	$CoalBox/ArrowPath/ArrowPoint.progress = 0

func _on_forge_body_entered(body):
	body.queue_free()
	#MAYBE SOUND??
	progress += progress_per_coal
	coals_hit += 1
	if progress >= progress_needed:
		$WinTimer.start()
		game_ended = true
func show_evaluation():
	var hit_rate = (20 * coals_hit) / shots_taken
	score = round(hit_rate / 10)
	$Score.text = str(score)
	$FinishMinigameButton.visible = true

func _on_cool_down_timeout():
	can_shoot = true


func _on_win_timer_timeout():
	show_evaluation()
	#VICTORY SOUND


func _on_finish_minigame_button_pressed():
	get_parent().score += score
	get_parent().current_task = 1
	queue_free()
