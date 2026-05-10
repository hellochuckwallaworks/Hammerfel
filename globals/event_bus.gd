extends Node
## Global signal bus. Decouples emitters from listeners across features.
## Pattern: define a signal here, emit via EventBus.foo.emit(...), and any
## node can connect via EventBus.foo.connect(_on_foo).

# --- Time / calendar ---
signal day_advanced(day: int, season: int, year: int)
signal season_changed(season: int)

# --- Player state ---
signal player_health_changed(player_index: int, current: float, maximum: float)
signal player_stamina_changed(player_index: int, current: float, maximum: float)
signal player_died(player_index: int)

# --- Skills ---
signal skill_xp_gained(skill_id: StringName, xp: int)
signal skill_leveled_up(skill_id: StringName, new_level: int)

# --- Settlement ---
signal renown_changed(new_renown: int, new_tier: int)
signal building_constructed(building_id: StringName)
signal settler_arrived(settler_id: StringName)

# --- Combat / raids ---
signal raid_started(raid_type: StringName)
signal raid_ended(victory: bool)
signal threat_meter_changed(value: float)

# --- Inventory / economy ---
signal item_acquired(item_id: StringName, count: int)
signal currency_changed(stone_marks: int)

# --- UI ---
signal ui_open_inventory()
signal ui_open_journal()
signal ui_open_pause()
