extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = false
		queue_free()


func _on_menu_button_down():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
