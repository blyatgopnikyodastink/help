extends Node


const TITLE := "res://Scenes/Title/Title.tscn"

var cur_scene: Node


func _ready() -> void:
	change_scene(TITLE)


func change_scene(to: String, direction := Vector2.ZERO, player_pos := Vector2.ZERO) -> void:
	var new_scene: Node = load(to).instance()
	add_child(new_scene)
	if cur_scene:
		if cur_scene is GameWorld and new_scene is GameWorld:
			cur_scene.free()
			cur_scene = new_scene
		else:
			cur_scene.free()
			cur_scene = new_scene
	else:
		cur_scene = new_scene
	for scene_changer in get_tree().get_nodes_in_group("scene_changer"):
		scene_changer.connect("change_scene", self, "change_scene", [], CONNECT_DEFERRED)
