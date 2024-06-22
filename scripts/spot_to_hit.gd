extends Area2D
var was_hit = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale = scale + Vector2(0.33,0.33) * delta

func _on_existence_timer_timeout():
	get_parent().spots_missed += 1
	queue_free()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		was_hit+=1
		if was_hit >= 3:
			queue_free()
