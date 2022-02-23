extends Control


signal change_scene(to)


func _ready() -> void:
	$Buttons/Quit.visible = not OS.get_name() == "HTML5"
	$Buttons/NewGame.grab_focus()


func _on_NewGame_pressed() -> void:
	emit_signal("change_scene", "res://Scenes/World/Test1.tscn", Vector2(100, 100))


func _on_LoadFile_pressed() -> void:
	pass # Replace with function body.


func _on_Options_pressed() -> void:
	pass # Replace with function body.


func _on_Quit_pressed() -> void:
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
