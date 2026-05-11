extends CanvasLayer
## Minimal inventory HUD pinned to the top-left. Lists every item with its
## current count. Drop this scene into your world scene as a child.

@onready var _label: Label = $Panel/Label

func _ready() -> void:
	Inventory.item_changed.connect(_on_item_changed)
	_refresh()

func _on_item_changed(_id: StringName, _count: int) -> void:
	_refresh()

func _refresh() -> void:
	var lines: Array[String] = []
	var items := Inventory.get_all()
	for id in items.keys():
		if items[id] > 0:
			lines.append("%s: %d" % [String(id).capitalize().replace("_", " "), items[id]])
	_label.text = "\n".join(lines) if lines.size() > 0 else "(empty)"
