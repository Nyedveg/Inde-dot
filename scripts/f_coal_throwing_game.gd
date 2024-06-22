extends Node

@export var coal_scene: PackedScene

var forwards = true
var is_charging
var can_shoot = true
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
	
func _input(event):
	# Handle input events
	if event is InputEventMouseButton:
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
		for i in range(5):
			var direction_randomness = randf_range(-PI/16, PI/16)
			var speed_randomness = randi_range(-50, 50)
		
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


func _on_cool_down_timeout():
	can_shoot = true
