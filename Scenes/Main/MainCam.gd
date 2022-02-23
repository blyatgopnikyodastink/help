extends Camera2D


var target: Node


func _physics_process(_delta: float) -> void:
	if target:
		if target is CanvasItem:
			position = target.global_position
		elif target is Control:
			position = target.rect_global_position


func target_player() -> void:
	current = true
	target = get_tree().get_nodes_in_group("player")[0]
