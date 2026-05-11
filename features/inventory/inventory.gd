extends Node
## Global inventory singleton. Holds counts of every item the player has
## collected. Persists across scene changes.

signal item_changed(id: StringName, new_count: int)

var _items: Dictionary = {}  # { StringName: int }

func add(id: StringName, count: int = 1) -> void:
	_items[id] = _items.get(id, 0) + count
	item_changed.emit(id, _items[id])

func remove(id: StringName, count: int = 1) -> bool:
	var current: int = _items.get(id, 0)
	if current < count:
		return false
	_items[id] = current - count
	item_changed.emit(id, _items[id])
	return true

func get_count(id: StringName) -> int:
	return _items.get(id, 0)

func get_all() -> Dictionary:
	return _items.duplicate()

func has(id: StringName, count: int = 1) -> bool:
	return _items.get(id, 0) >= count

func clear() -> void:
	for id in _items.keys():
		_items[id] = 0
		item_changed.emit(id, 0)
	_items.clear()
