extends Node

@export var spot_scene: PackedScene

var spots_missed = 0
var spawned = 0
var score
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	spawned += 1
	var spot = spot_scene.instantiate()
	$SpotFormationPath/SpotLocation.progress_ratio = randf_range(0, 1)
	spot.global_position = $SpotFormationPath/SpotLocation.global_position
	add_child(spot)
	if spawned < 35:
		$SpawnTimer.start($SpawnTimer.wait_time - 0.05)
	else:
		$WinTimer.start()


func _on_win_timer_timeout():
	score = round(10 - spots_missed/3.5)
	$Score.text = str(score)
