extends Node


const TITLE := "res://Scenes/Title/Title.tscn"
const OVERLAP_SIZE := 64

var cur_scene: Node


func _ready() -> void:
	change_scene(TITLE)


func change_scene(to: String, direction := Vector2.ZERO, player_pos := Vector2.ZERO) -> void:
	var new_scene: Node = load(to).instance()
	add_child(new_scene)
	if cur_scene:
		if cur_scene is GameWorld and new_scene is GameWorld:
			if not direction.x == 0:
				if direction.x > 0:
					new_scene.position.x = cur_scene.position.x + cur_scene.size.x - OVERLAP_SIZE
				else:
					new_scene.position.x = cur_scene.position.x - new_scene.size.x + OVERLAP_SIZE
			else:
				if direction.y > 0:
					new_scene.position.y = cur_scene.position.y + cur_scene.size.y - OVERLAP_SIZE
				else:
					new_scene.position.y = cur_scene.position.y - new_scene.size.y + OVERLAP_SIZE
			cur_scene.free()
			get_tree().get_nodes_in_group("player")[0].global_position = player_pos
			cur_scene = new_scene
		else:
			cur_scene.free()
			cur_scene = new_scene
	else:
		cur_scene = new_scene
	for scene_changer in get_tree().get_nodes_in_group("scene_changer"):
		scene_changer.connect("change_scene", self, "change_scene", [], CONNECT_DEFERRED)
