extends Node

var score

var can_act = true
var forwards = true
var minValue = 0.37
var maxValue = 0.63

var startingHitMarkerScale = Vector2(34.462, 1.28)

var scoreToWin = 11
var currentScore = 0
var misses = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar/ProgressBarPoint/ProgressBarPointSprite.modulate = Color(255, 255, 255)
	$ProgressBar/HitMarker.scale = startingHitMarkerScale * Vector2(maxValue-minValue, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if forwards:
		$ProgressBar/ProgressBarPoint.progress += 800*delta
		if $ProgressBar/ProgressBarPoint.progress > 850:
			forwards = false
	else:
		$ProgressBar/ProgressBarPoint.progress -= 800*delta
		if $ProgressBar/ProgressBarPoint.progress < 20:
			forwards = true
			
func _input(event):
	# Handle input events
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed() and can_act:
		CheckIfHit()
func CheckIfHit():
	can_act = false
	$ProgressBar/ProgressBarPoint/ProgressBarPointSprite.modulate = Color(0, 0, 0)
	if $ProgressBar/ProgressBarPoint.progress_ratio >= minValue and $ProgressBar/ProgressBarPoint.progress_ratio <= maxValue:
		#MAYBE GOOD SOUND PLAY??
		minValue += 0.01
		maxValue -= 0.01
		$ProgressBar/HitMarker.scale = startingHitMarkerScale * Vector2(maxValue-minValue, 1)
		currentScore+=1
		if(currentScore >= scoreToWin):
			show_evaluation()
			return
	else:
		#BAD SOUND
		misses+=1
	$Cooldown.start()
func show_evaluation():
	
	score = 10-misses
	$Score.text = str(score)

func _on_cooldown_timeout():
	can_act = true
	$ProgressBar/ProgressBarPoint/ProgressBarPointSprite.modulate = Color(255, 255, 255)
