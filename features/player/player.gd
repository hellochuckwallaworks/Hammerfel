extends CharacterBody2D
class_name Player
## Top-down 4/8-directional movement. The player_index determines which input
## actions the controller reads (move_*_p1 vs move_*_p2), so a second Player
## instance dropped into the world becomes Player 2 with no extra wiring.

const SPEED_WALK := 60.0
const SPEED_RUN := 100.0  # TODO: gate behind sprint input or stamina

@export var player_index: int = 1  # 1 = WASD/gamepad-0, 2 = arrows/gamepad-1

@export_group("Stats", "stat_")
@export var stat_max_health: float = 100.0
@export var stat_max_stamina: float = 100.0

var current_health: float
var current_stamina: float
var facing: Vector2 = Vector2.DOWN

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	current_health = stat_max_health
	current_stamina = stat_max_stamina
	EventBus.player_health_changed.emit(player_index, current_health, stat_max_health)
	EventBus.player_stamina_changed.emit(player_index, current_stamina, stat_max_stamina)

func _physics_process(_delta: float) -> void:
	var input_vec := _read_movement_input()
	if input_vec != Vector2.ZERO:
		facing = input_vec
	velocity = input_vec * SPEED_WALK
	move_and_slide()

func _read_movement_input() -> Vector2:
	var suffix := "_p%d" % player_index
	var vec := Vector2(
		Input.get_action_strength("move_right" + suffix) - Input.get_action_strength("move_left" + suffix),
		Input.get_action_strength("move_down" + suffix) - Input.get_action_strength("move_up" + suffix)
	)
	return vec.normalized() if vec.length() > 1.0 else vec

func take_damage(amount: float) -> void:
	current_health = max(0.0, current_health - amount)
	EventBus.player_health_changed.emit(player_index, current_health, stat_max_health)
	if current_health <= 0.0:
		EventBus.player_died.emit(player_index)

func spend_stamina(amount: float) -> bool:
	if current_stamina < amount:
		return false
	current_stamina -= amount
	EventBus.player_stamina_changed.emit(player_index, current_stamina, stat_max_stamina)
	return true
