extends Node2D
## The active world / cavern the player explores. For now this just hosts
## the player, a placeholder ground polygon, and an empty TileMapLayer ready
## for biome tilesets. Future: stream chunks, manage spawners, hook raids.

func _ready() -> void:
	# Spawn the HUD on top of this world
	var hud_scene := preload("res://features/ui/hud/hud.tscn")
	add_child(hud_scene.instantiate())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_scene := preload("res://features/ui/pause_menu/pause_menu.tscn")
		add_child(pause_scene.instantiate())
		get_viewport().set_input_as_handled()
