extends Area2D


signal change_scene(to, direction)

export(String, FILE, "*.tscn") var to: String
export var direction: Vector2


func _on_SceneChanger_body_entered(_body: Node) -> void:
	if $Timer.is_stopped():
		emit_signal("change_scene", to, direction)
