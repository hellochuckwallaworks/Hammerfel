extends Item
class_name Rune

enum Target { TOOL, WEAPON, ARMOUR, STRUCTURE, CROP }
enum Tier { LESSER, GREATER, MASTER, LEGENDARY }

@export var valid_targets: Array[Target] = []
@export var tier: Tier = Tier.LESSER
@export_multiline var effect_description: String = ""
