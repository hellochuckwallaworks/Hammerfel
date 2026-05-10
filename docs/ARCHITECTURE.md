# Hammerfel — Project Architecture

This document explains the folder layout and conventions. Read this before adding new code so the project stays coherent as it grows.

## Top-level layout

```
Hammerfel/
├── addons/            Godot plugins (empty for now)
├── assets/            Art, audio, fonts — Git LFS-tracked binaries
├── data/              Concrete .tres resource instances (specific crops, buildings, runes, etc.)
├── docs/              Design docs, architecture notes, GDD
├── features/          Game code, organized by feature (NOT by file type)
├── globals/           Autoload singletons (GameState, EventBus, Clock, SaveManager, AudioManager)
├── resources/         Typed Resource scripts (the *classes* that .tres files in data/ instantiate)
├── tests/             Unit tests (TBD — GUT or Gd-Unit)
├── project.godot      Godot project config + autoloads + input map
└── README.md          Setup instructions for collaborators
```

## Why feature-based, not type-based?

Most Godot tutorials put scenes in `scenes/`, scripts in `scripts/`, sounds in `audio/`. That's fine for tiny projects but breaks down at scale:

- A change to "farming" touches files across 5 top-level folders, making PRs hard to review
- Two devs working on different features still trip over each other in shared folders
- Discovering "everything related to mining" means grepping across the whole tree

In **feature-based** layout, everything related to one game system lives under one folder:

```
features/farming/
├── farming_plot.tscn       The scene placed in the world
├── farming_plot.gd
├── crop_growth.gd          Standalone helper script
├── farming_ui.tscn         Farming-specific UI overlay
└── ...
```

Adding farming = touching one folder. Two devs working on farming + mining never touch the same files.

The exception is `globals/` (autoloads are inherently cross-cutting) and `resources/` (typed Resource base classes are cross-feature).

## features/ contents

Each major game system from the GDD has its own folder:

| Folder | What goes here | Status |
|---|---|---|
| `player/` | Player character scene, controller, stats | ✅ scaffolded |
| `world/` | Top-level world scene, terrain, world manager | ✅ scaffolded |
| `ui/main_menu/` | Title screen | ✅ scaffolded |
| `ui/hud/` | In-game HUD (health, stamina, date) | ✅ scaffolded |
| `ui/pause_menu/` | Pause overlay | ✅ scaffolded |
| `ui/inventory/` | Player inventory grid | placeholder |
| `ui/journal/` | Quest log, lore, recipes, relationships | placeholder |
| `ui/settings/` | Settings menu | placeholder |
| `ui/dialogue/` | Settler/NPC dialogue UI | placeholder |
| `farming/` | Crop plots, watering, compost, growth | placeholder |
| `mining/` | Ore veins, pickaxe, cave-ins, supports | placeholder |
| `brewing/` | Malting, fermentation, ageing, kegging | placeholder |
| `rune_crafting/` | Rune bench, fragment system, application | placeholder |
| `fishing/` | Fishing minigame, spots, legend fish | placeholder |
| `cooking/` | Recipes, cookhouse, feasts | placeholder |
| `crafting/` | Forge, carpentry, alchemy, loom, mason | placeholder |
| `combat/` | Player melee/ranged, dodge, block, enemy AI | placeholder |
| `raids/` | Threat meter, raid types, defence | placeholder |
| `settlement/` | Buildings, growth tiers, renown, roles | placeholder |
| `settlers/` | Settler NPC scenes, AI, relationship system | placeholder |
| `economy/` | Stone Marks, market, merchant trade | placeholder |
| `quests/` | Story acts, side quests, bounties | placeholder |
| `audio/` | Music tracks, ambient loops, custom audio nodes | placeholder |

## resources/ vs data/

These two are easy to confuse:

- **`resources/`** holds GDScript files that `extend Resource` and define a *schema* — e.g. `crop.gd` defines what a Crop is (family, growth_days, seasons, yield range).
- **`data/`** holds `.tres` files — concrete *instances* of those schemas. `data/crops/cave_mushroom.tres` is one specific crop with its values filled in.

Adding a new crop = create a `.tres` in `data/crops/` (no code change). Adding a new *kind* of thing (e.g. a Cosmetic resource) = add `.gd` in `resources/` plus `.tres` files in a new `data/cosmetics/` folder.

## globals/ — the autoload singletons

These are loaded before any scene runs and accessible everywhere as bare names:

| Name | Purpose |
|---|---|
| `GameState` | Session state: save slot, settlement renown, raid threat |
| `EventBus` | Signal bus — every cross-feature signal is defined here |
| `Clock` | In-game time / day / season / year |
| `SaveManager` | Save/load slots (stub) |
| `AudioManager` | Music + SFX bus control (stub) |

**Rule of thumb:** if two features need to communicate without knowing about each other, route the signal through `EventBus`. Don't hard-reference one feature from another.

Example — mining levels up and farming wants to know:

```gdscript
# features/mining/pickaxe.gd
EventBus.skill_xp_gained.emit(&"mining", 5)

# features/farming/farming_plot.gd
func _ready():
    EventBus.skill_leveled_up.connect(_on_skill_level_up)
```

Neither file imports the other.

## Naming conventions

- **Files**: `snake_case.gd`, `snake_case.tscn`
- **Classes** (`class_name`): `PascalCase` — only declare `class_name` if the type is referenced from elsewhere
- **Signals**: `snake_case`, past-tense (`day_advanced`, `building_constructed`)
- **Constants**: `SCREAMING_SNAKE_CASE`
- **Resource IDs** (`StringName` in `id` fields): `snake_case`, prefixed by category if ambiguous (`crop_cave_mushroom` vs `rune_crop_cave_mushroom`)

## Input map convention

Every player-facing input is suffixed `_p1` or `_p2`:

```
move_up_p1, move_up_p2
interact_p1, interact_p2
attack_p1, attack_p2
...
```

The `Player` scene has a `player_index` export. It reads `move_up_p%d % player_index`. To add a second player to the world:

1. Instance `features/player/player.tscn` a second time in `World`
2. Set `player_index = 2` in the inspector

That's it — P2 reads the `_p2` actions automatically. No code change needed.

(Some inputs like `pause` are not player-suffixed — they apply globally.)

## Adding a new feature — checklist

1. Create `features/<feature_name>/`
2. Add scene + script files there
3. If the feature emits cross-feature events, add signals to `globals/event_bus.gd`
4. If the feature defines a new data type (a new kind of Resource), add the schema script to `resources/` and a `data/<feature_name>/` folder
5. Update this doc's table

## Pixel-art rendering settings

`project.godot` already sets:
- `rendering/textures/canvas_textures/default_texture_filter = 0` (Nearest filtering)
- `rendering/2d/snap/snap_2d_transforms_to_pixel = true`
- `rendering/2d/snap/snap_2d_vertices_to_pixel = true`
- `display/window/stretch/mode = canvas_items`

Don't change these without good reason — they're what makes pixel art look crisp at any window size.
