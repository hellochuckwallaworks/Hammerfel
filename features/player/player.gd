extends CharacterBody2D
## 8-directional top-down player.
##
## Sprite sheets: 96x120 px, 16x24 px per frame, 6 frames per row, 5 rows:
##   row 0 = down
##   row 1 = down-right  (mirror for down-left)
##   row 2 = right       (mirror for left)
##   row 3 = up-right    (mirror for up-left)
##   row 4 = up
## Left-side directions reuse the right-side rows with flip_h = true.
##
## Input: ui_left / ui_right / ui_up / ui_down (arrow keys + gamepad d-pad
## by default). To add WASD: Project Settings -> Input Map -> add KEY_W/A/S/D
## events to those actions.

const SPEED := 60.0
const FRAME_W := 16
const FRAME_H := 24
const FRAMES_PER_ANIM := 6
const FRAME_DURATION := 0.12  # seconds per frame (~8 fps cycle)

const IDLE_SHEET := preload("res://assets/sprites/characters/Player/16x16/16x16 Idle-Sheet.png")
const WALK_SHEET := preload("res://assets/sprites/characters/Player/16x16/16x16 Walk-Sheet.png")

# Sector index -> (row in sheet, flip horizontally?)
# Sectors are 45-degree slices starting at "right" and rotating clockwise:
# 0=right, 1=down-right, 2=down, 3=down-left, 4=left, 5=up-left, 6=up, 7=up-right
const ROW_FOR_SECTOR  := [2, 1, 0, 1, 2, 3, 4, 3]
const FLIP_FOR_SECTOR := [false, false, false, true, true, true, false, false]

@onready var sprite: Sprite2D = $Sprite2D

var _frame_index := 0
var _frame_timer := 0.0
var _facing_row := 0     # default facing down
var _facing_flip := false

func _physics_process(delta: float) -> void:
	var input_vec := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if input_vec.length() > 1.0:
		input_vec = input_vec.normalized()

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
		_frame_index * FRAME_W,
		_facing_row * FRAME_H,
		FRAME_W, FRAME_H
	)
	sprite.flip_h = _facing_flip

func _sector_for_vector(v: Vector2) -> int:
	var sector := int(round(v.angle() / (PI / 4.0))) % 8
	if sector < 0:
		sector += 8
	return sector
