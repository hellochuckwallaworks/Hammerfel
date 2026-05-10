extends Node
## Game clock: tracks in-game time, day, season, year. Per GDD: 20 real-time
## minutes per day, 28 days per season, 4 seasons (Deep Winter, Thaw, Stone
## Summer, Amber Harvest), 112 days per year.

enum Season { DEEP_WINTER, THAW, STONE_SUMMER, AMBER_HARVEST }

const SEASON_NAMES := ["Deep Winter", "Thaw", "Stone Summer", "Amber Harvest"]
const DAY_LENGTH_SECONDS := 20.0 * 60.0
const DAYS_PER_SEASON := 28
const SEASONS_PER_YEAR := 4

var day: int = 1
var season: Season = Season.THAW
var year: int = 1
var time_of_day: float = 0.0  # 0.0 .. 1.0 progress through current day
var paused: bool = false

func _process(delta: float) -> void:
	if paused:
		return
	time_of_day += delta / DAY_LENGTH_SECONDS
	if time_of_day >= 1.0:
		time_of_day -= 1.0
		_advance_day()

func _advance_day() -> void:
	day += 1
	if day > DAYS_PER_SEASON:
		day = 1
		season = ((season + 1) % SEASONS_PER_YEAR) as Season
		EventBus.season_changed.emit(season)
		if season == Season.DEEP_WINTER:
			year += 1
	EventBus.day_advanced.emit(day, season, year)

func season_name() -> String:
	return SEASON_NAMES[season]

func date_string() -> String:
	return "%s %d, Year %d" % [season_name(), day, year]
