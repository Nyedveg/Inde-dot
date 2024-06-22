extends Node

@export var coal_scene: PackedScene

var forwards = true
var is_charging
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_charging:
		if forwards:
			$CoalBox/ArrowPath.progress += 50*delta
			if $CoalBox/ArrowPath.progress > 310:
				forwards = false
		else:
			$CoalBox/ArrowPath.progress -= 50*delta
			if $CoalBox/ArrowPath.progress < 10:
				forwards = true
	
func _input(event):
	# Handle input events
	if event is InputEventMouseButton:
		if event.button_index == "BUTTON_LEFT":
			if event.is_pressed():
				is_charging = true
			else:
				stop_charging()

func stop_charging():
	is_charging = false
	
	$CoalBox/ArrowPath.progress = 0
	forwards = true
	
	for i in range(5):
		var direction_randomness = randf_range(-PI/4, PI/4)
		var speed_randomness = randi_range(-50, 50)
		
		var coal = coal_scene.instantiate()
		var direction = $CoalBox/ArrowPath/ArrowPoint.global_position - $CoalBox/ShootingPoint.global_position
		direction = direction.normalized()
		coal.linear_velocity = (direction * (300 + speed_randomness)).rotated(direction_randomness)
		add_child(coal)
	

func _on_forge_body_entered(body):
	body.queue_free()
