extends Control

func _on_start_pressed() -> void:
	GameState.reset_for_new_game()
	get_tree().change_scene_to_file("res://features/world/world.tscn")

func _on_load_pressed() -> void:
	# TODO: open save-slot picker
	push_warning("Load game: not implemented yet")

func _on_settings_pressed() -> void:
	# TODO: open settings panel
	push_warning("Settings: not implemented yet")

func _on_quit_pressed() -> void:
	get_tree().quit()
