extends Interactable
## A spot on the water's edge the player can fish at.
## Press E -> +1 fish in Inventory. (No minigame yet — minimal loop.)

@export var fish_id: StringName = &"cave_fish"

func _ready() -> void:
	prompt_verb = "Fish"
	super._ready()

func interact(_player: Node2D) -> void:
	Inventory.add(fish_id, 1)
