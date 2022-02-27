extends Node


func start(timeline: String) -> void:
	var dialog: CanvasLayer = Dialogic.start(timeline)
	add_child(dialog)
	dialog.connect("timeline_end", self, "on_timeline_end")


func on_timeline_end(_timeline_name: String) -> void:
	var arr = get_tree().get_nodes_in_group("player")
	if arr.size() > 0:
		arr[0].state = 0
