extends Node
## Save / load coordinator. Stub for now; real implementation will serialise
## GameState, Clock, settler roster, settlement layout, inventory, etc.
##
## Per GDD: auto-save at end of each in-game day; 3+ manual save slots; cloud
## save support via platform integrations.

const SAVE_DIR := "user://saves/"

func slot_path(slot: int) -> String:
	return "%sslot_%d.save" % [SAVE_DIR, slot]

func has_save(slot: int) -> bool:
	return FileAccess.file_exists(slot_path(slot))

func save_game(_slot: int) -> bool:
	# TODO: serialise GameState, Clock, settlers, buildings, inventory, quests
	push_warning("SaveManager.save_game: not implemented yet")
	return false

func load_game(_slot: int) -> bool:
	# TODO: load file, restore GameState/Clock/etc., return true on success
	push_warning("SaveManager.load_game: not implemented yet")
	return false

func delete_save(slot: int) -> void:
	var path := slot_path(slot)
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
