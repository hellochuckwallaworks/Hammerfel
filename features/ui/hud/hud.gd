extends CanvasLayer
## Game HUD: health orb, stamina bar, date/season, held item slot.
## Listens to EventBus for stat updates.

@onready var health_bar: ProgressBar = $Root/TopLeft/HealthBar
@onready var stamina_bar: ProgressBar = $Root/TopLeft/StaminaBar
@onready var date_label: Label = $Root/TopRight/DateLabel

func _ready() -> void:
	EventBus.player_health_changed.connect(_on_health_changed)
	EventBus.player_stamina_changed.connect(_on_stamina_changed)
	EventBus.day_advanced.connect(_on_day_advanced)
	_refresh_date()

func _process(_delta: float) -> void:
	_refresh_date()

func _on_health_changed(player_index: int, current: float, maximum: float) -> void:
	if player_index != 1:
		return
	health_bar.max_value = maximum
	health_bar.value = current

func _on_stamina_changed(player_index: int, current: float, maximum: float) -> void:
	if player_index != 1:
		return
	stamina_bar.max_value = maximum
	stamina_bar.value = current

func _on_day_advanced(_day: int, _season: int, _year: int) -> void:
	_refresh_date()

func _refresh_date() -> void:
	date_label.text = Clock.date_string()
