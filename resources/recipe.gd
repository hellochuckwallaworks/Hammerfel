extends Resource
class_name Recipe
## Generic crafting/cooking/brewing recipe. The station that uses it is
## inferred from `station_id` (e.g. "forge", "cookhouse", "brew_shed").

@export var id: StringName = &""
@export var display_name: String = ""
@export var station_id: StringName = &""
@export var ingredients: Dictionary = {}  # { item_id: count }
@export var result: Item
@export var result_count: int = 1
@export var craft_time_seconds: float = 0.0
@export var unlock_skill_id: StringName = &""
@export var unlock_skill_level: int = 0
