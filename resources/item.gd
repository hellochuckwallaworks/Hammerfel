extends Resource
class_name Item
## Generic inventory item base. Specific item kinds (Crop, Brew, Rune, etc.)
## extend this so they all stack and serialise the same way.

@export var id: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var icon: Texture2D
@export var max_stack: int = 99
@export var base_value: int = 0  # in Stone Marks
