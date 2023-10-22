extends Control

@onready var sound = [
	preload("res://Assets/Audio/leðrublaka 1.mp3"), 
	preload("res://Assets/Audio/leðrublaka hrædd.mp3"), 
	preload("res://Assets/Audio/rotta hljóð 1.mp3"), 
	preload("res://Assets/Audio/rotta hrædd.mp3"), 
	preload("res://Assets/Audio/setja.niður-Plöntur.mp3")
	]
# Called when the node enters the scene tree for the first time.
func play_sound():
	$AudioStreamPlayer.stream = sound.pick_random()
	$AudioStreamPlayer.play()
	await  $AudioStreamPlayer.finished

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_down():
	play_sound()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_down():
	play_sound()
	get_tree().quit()
