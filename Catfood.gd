extends Area2D

var yoda

func _ready():
	yoda = get_tree().root.get_node("Root/Yoda")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Catfood_body_entered(body):
	if body.name == "Player":
		get_tree().queue_delete(self)
		yoda.questobjective = true
