extends Node


const TITLE := "res://Scenes/Title/Title.tscn"
const OVERLAP_SIZE := 64

var cur_scene: Node
var new_scene: Node


func _ready() -> void:
	change_scene(TITLE)


func change_scene(to: String, player_pos := Vector2.ZERO, direction := Vector2.ZERO) -> void:
	new_scene = load(to).instance()
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
			var player: KinematicBody2D = new_scene.find_node("Player")
			var old_player := cur_scene.find_node("Player")
			player.anim_tree.set("parameters/idle/blend_position", old_player.get("parameters/idle/blend_position"))
			player.anim_tree.set("parameters/run/blend_position", old_player.get("parameters/run/blend_position"))
			player.anim_state.travel(old_player.anim_state.get_current_node())
			player.velocity = old_player.velocity
			old_player.free()
			player.global_position = player_pos
			player.connect("tween_completed", self, "on_tween_completed", [], CONNECT_DEFERRED)
			player.tween_cam_limits(Rect2(cur_scene.global_position, cur_scene.size), Rect2(new_scene.global_position, new_scene.size))
		else:
			cur_scene.free()
			cur_scene = new_scene
			if cur_scene is GameWorld:
				var player: KinematicBody2D = get_tree().get_nodes_in_group("player")[0]
				player.global_position = player_pos
				player.set_cam_limits(Rect2(new_scene.global_position, new_scene.size))
	else:
		cur_scene = new_scene
	for scene_changer in get_tree().get_nodes_in_group("scene_changer"):
		if not scene_changer.is_connected("change_scene", self, "change_scene"):
			scene_changer.connect("change_scene", self, "change_scene", [], CONNECT_DEFERRED)


func on_tween_completed() -> void:
	cur_scene.free()
	cur_scene = new_scene
