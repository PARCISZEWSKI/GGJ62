extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func health_text_update(amount1, amount2):
	$Label3.text = "HP %s/%s" % [str(amount1), str(amount2)]

func score_text_update(amount):
	$Label2.text = "Score: %s" % amount
func resource_text_update(amount):
	$Label.text = str(amount)
	
