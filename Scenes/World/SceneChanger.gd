extends Area2D


signal change_scene(to, direction, player_pos)

export(String, FILE, "*.tscn") var to: String
export var direction: Vector2


func change_scene(player_pos: Vector2):
		emit_signal("change_scene", to, direction, player_pos)
