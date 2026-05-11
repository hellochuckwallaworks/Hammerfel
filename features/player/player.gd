extends CharacterBody2D
## 8-directional top-down player.
##
## Sprite sheets: 96x120 px, 4 columns x 5 rows of 24x24 cells. Inside each
## cell the dwarf art is 12w x 16h, centered horizontally (6 px padding each
## side) and offset 8 px down from the cell top. We render a 16x16 window at
## inset (4, 8) — wide enough for the art plus a few px of horizontal slack.
##   row 0 = down
##   row 1 = down-right  (mirror for down-left)
##   row 2 = right       (mirror for left)
##   row 3 = up-right    (mirror for up-left)
##   row 4 = up
## Left-side directions reuse the right-side rows with flip_h = true.
##
## Input: move_left / move_right / move_up / move_down (WASD + arrow keys
## + left analog stick, configured in project.godot).

const SPEED := 60.0
const CELL_W := 24                    # stride between frames in the sheet
const CELL_H := 24
const FRAME_W := 16                   # visible sprite size
const FRAME_H := 16
const FRAME_OFFSET_X := 4             # x inset of the 16x16 capture in each cell
const FRAME_OFFSET_Y := 8             # y inset — art starts 8 px down in each cell
const FRAMES_PER_ANIM := 4
const FRAME_DURATION := 0.12  # seconds per frame (~8 fps cycle)

const IDLE_SHEET := preload("res://assets/sprites/characters/Player/16x16/16x16 Idle-Sheet.png")
const WALK_SHEET := preload("res://assets/sprites/characters/Player/16x16/16x16 Walk-Sheet.png")

# Sector index -> (row in sheet, flip horizontally?)
# Sectors are 45-degree slices starting at "right" and rotating clockwise:
# 0=right, 1=down-right, 2=down, 3=down-left, 4=left, 5=up-left, 6=up, 7=up-right
const ROW_FOR_SECTOR  := [2, 1, 0, 1, 2, 3, 4, 3]
const FLIP_FOR_SECTOR := [false, false, false, true, true, true, false, false]

@onready var sprite: Sprite2D = $Sprite2D
@onready var interact_zone: Area2D = $InteractZone

var _frame_index := 0
var _frame_timer := 0.0
var _facing_row := 0     # default facing down
var _facing_flip := false
var _interactables_in_range: Array[Interactable] = []

func _ready() -> void:
	interact_zone.area_entered.connect(_on_interact_area_entered)
	interact_zone.area_exited.connect(_on_interact_area_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var closest := _closest_interactable()
		if closest:
			closest.interact(self)

func _on_interact_area_entered(area: Area2D) -> void:
	if area is Interactable:
		_interactables_in_range.append(area)
		area.show_prompt()

func _on_interact_area_exited(area: Area2D) -> void:
	if area is Interactable and area in _interactables_in_range:
		_interactables_in_range.erase(area)
		area.hide_prompt()

func _closest_interactable() -> Interactable:
	var closest: Interactable = null
	var min_dist_sq := INF
	for i in _interactables_in_range:
		if not is_instance_valid(i):
			continue
		var d := global_position.distance_squared_to(i.global_position)
		if d < min_dist_sq:
			min_dist_sq = d
			closest = i
	return closest

func _physics_process(delta: float) -> void:
	var input_vec := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_vec * SPEED
	move_and_slide()

	var moving := input_vec.length() > 0.1
	if moving:
		var sector := _sector_for_vector(input_vec)
		_facing_row = ROW_FOR_SECTOR[sector]
		_facing_flip = FLIP_FOR_SECTOR[sector]

	_frame_timer += delta
	if _frame_timer >= FRAME_DURATION:
		_frame_timer -= FRAME_DURATION
		_frame_index = (_frame_index + 1) % FRAMES_PER_ANIM

	sprite.texture = WALK_SHEET if moving else IDLE_SHEET
	sprite.region_rect = Rect2(
		_frame_index * CELL_W + FRAME_OFFSET_X,
		_facing_row * CELL_H + FRAME_OFFSET_Y,
		FRAME_W, FRAME_H
	)
	sprite.flip_h = _facing_flip

func _sector_for_vector(v: Vector2) -> int:
	var sector := int(round(v.angle() / (PI / 4.0))) % 8
	if sector < 0:
		sector += 8
	return sector
