extends Node


const TITLE := "res://Scenes/Title/Title.tscn"

var cur_scene: Node


func _ready() -> void:
	change_scene(TITLE)
	

func change_scene(to: String) -> void:
	call_deferred("change_scene_deferred", to)
	

func change_scene_deferred(to: String) -> void:
	if cur_scene:
		cur_scene.free()
	cur_scene = load(to).instance()
	add_child(cur_scene)
	if cur_scene.has_signal("change_scene"):
		cur_scene.connect("change_scene", self, "change_scene")
