extends Resource
class_name Building

enum Tier { TIER_1, TIER_2, TIER_3, TIER_4 }

@export var id: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var tier: Tier = Tier.TIER_1
@export var size: Vector2i = Vector2i(2, 2)  # in tiles
@export var construction_cost: Dictionary = {}  # { item_id: count }
@export var construction_time_days: int = 1
@export var renown_value: int = 0
@export var scene: PackedScene
