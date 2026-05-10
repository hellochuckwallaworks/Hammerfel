extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()

func _on_quit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://features/ui/main_menu/main_menu.tscn")
