extends Area2D
class_name Interactable
## Base class for anything the player can press E on in the world.
## Concrete interactables (OreNode, FishingSpot, FarmPlot) extend this and
## override `interact()`.
##
## Each Interactable scene should have:
##   - A CollisionShape2D child (so the player's InteractZone detects it)
##   - Optionally a Label child named "Prompt" — auto-managed by this script

@export var prompt_verb: String = "Interact"

@onready var prompt_label: Label = $Prompt if has_node("Prompt") else null

func _ready() -> void:
	if prompt_label:
		prompt_label.text = "[E] " + prompt_verb
		prompt_label.visible = false

func show_prompt() -> void:
	if prompt_label:
		prompt_label.visible = true

func hide_prompt() -> void:
	if prompt_label:
		prompt_label.visible = false

## Subclasses override this.
func interact(_player: Node2D) -> void:
	pass
