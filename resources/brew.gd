extends Item
class_name Brew

enum Rarity { COMMON, UNCOMMON, RARE, LEGENDARY }

@export var rarity: Rarity = Rarity.COMMON
@export_multiline var effect_description: String = ""
@export var buff_duration_days: int = 1
@export var requires_aging: bool = false
@export var aging_days: int = 0
