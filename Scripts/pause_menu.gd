extends Control

@onready var sound = [
	preload("res://Assets/Audio/leðrublaka 1.mp3"), 
	preload("res://Assets/Audio/leðrublaka hrædd.mp3"), 
	preload("res://Assets/Audio/rotta hljóð 1.mp3"), 
	preload("res://Assets/Audio/rotta hrædd.mp3"), 
	preload("res://Assets/Audio/setja.niður-Plöntur.mp3")
	]
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = false
		queue_free()
		
func game_over(score):
	$CanvasLayer/pause.text = "YOU LOST! Score: %s" % str(score)

func _on_menu_button_down():
	$AudioStreamPlayer.stream = sound.pick_random()
	$AudioStreamPlayer.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
