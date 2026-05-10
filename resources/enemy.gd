extends Resource
class_name EnemyDefinition

@export var id: StringName = &""
@export var display_name: String = ""
@export var max_health: float = 10.0
@export var damage: float = 5.0
@export var move_speed: float = 50.0
@export var xp_reward: int = 5
@export var loot_table: Dictionary = {}  # { item_id: drop_chance_0_to_1 }
@export var scene: PackedScene
