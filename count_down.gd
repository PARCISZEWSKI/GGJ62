extends Control

func _process(_delta):
	$CanvasLayer/Label.text = str(int($CanvasLayer/Timer.time_left + 1))

func _on_timer_timeout():
	get_tree().paused = false
	queue_free()

