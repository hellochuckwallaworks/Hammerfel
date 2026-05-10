# RPG Worlds asset packs

Third-party pixel-art tilesets and props bundled with the project as placeholder/early art.

## Layout

Each biome/category folder follows the same shape:

```
<biome>/
  png/          Engine-ready PNG tilesets and sprites
    anim/       Animation frames (separate from static tiles)
  psd/          Source Photoshop files (kept for editing; not imported by Godot)
    anim/
    _help/      Reference/help screens shipped with some packs
  info.txt      Pack-specific notes (only present for some packs)
```

## Biomes

| Folder            | Source pack                       | Notes                                                                |
|-------------------|-----------------------------------|----------------------------------------------------------------------|
| `grassland/`      | RPGW_GrassLand v2.01              | Includes `MainLev_autotiling.png` for Godot terrain autotiles        |
| `ancient_forest/` | RPGW_AncientForest v1.0           | Big animated trees                                                   |
| `ecave/`          | RPGW_ECave v1.0                   | Entrance / shallow cave (grounds + hills + plants)                   |
| `deepcave/`       | RPGW_DeepCave v1.0                | Deep underground; animated lights                                    |
| `wetland/`        | RPGW_Wetland v1.2                 | v1.1 was identical content; only v1.2 kept                           |
| `marshland/`      | RPGW_Marshland v2.0               | v2.0 adds autotiling tileset over v1.2                               |
| `strangeland/`    | RPGW_StrangeLand v1.0             | Big mushrooms + marsh effects (35 anim frames)                       |
| `harbor/`         | RPGW_Harbor v1.0                  | Docks, ships, lanterns, water                                        |
| `mountains/`      | RPGW_Mountains v1.2               |                                                                      |
| `desert/`         | RPGW_Desert v2.01 + waterenv from v1.0 | v2.01 dropped `waterenv.png`; preserved from v1.0                |
| `snowylands/`     | RPGW_SnowyLands v2.0              | v2.0 is a strict superset of v1.0 (adds autotile + 6 trees)          |
| `props/`          | RPGW_DecorativeProps v1.0         | Generic props/fences, animated vegetation, lanterns, flag            |
| `camp_graves/`    | RPGW_FC_G v1.0                    | Campfire (animated) + graveyard. Nested `UNITY_*.zip` was discarded. |
| `buildings/castle/`  | RPG_Buildings_CASTLE v1.0      | Outside, interiors, decoratives, animated torches/lights             |
| `buildings/houses/`  | RPG_Buildings_HOUSES v1.1      |                                                                      |
| `buildings/windmill/`| RPG_Buildings_WINDMILL v1.1    |                                                                      |
| `buildings/desert/`  | RPG_Buildings_Desert v1.0      | Most prolific buildings pack (3 main building sets + interiors)      |

## License

Per `_licenses/*.txt` (text identical across packs):

- Free to use for personal **or commercial** projects.
- May be edited, modified, and incorporated into derivative works.
- Works built with the assets may be sold.
- **Cannot** be resold (original or modified) as a standalone asset pack.
- **Cannot** be used in a logo, trademark, or service mark.
- Credit is not required but appreciated.

One license file is preserved per pack in `_licenses/<biome>.txt`.

## Conventions for use in Godot

- **Tile size: 32×32.** All `MainLev*.png` are tile sheets on a 32×32 grid.
- `MainLev_autotiling.png` (where present) is laid out for Godot 4 terrain autotiles — set up as a `TileSet` `Terrain` source.
- `decorative*.png` are atlas sheets — slice into `AtlasTexture` regions or set up as additional `TileSet` sources.
- Animations in `png/anim/` come as separate frames — assemble via `AnimatedSprite2D` `SpriteFrames` or `AnimationPlayer`.
- `_PSD/` files are NOT imported by Godot (no `.import` is generated). They are checked in for source editing only.

## Palette

`rpg_worlds_palette.gpl` is a 64-color palette quantized from every static tileset in this folder. Load it in Aseprite (`Palette` panel → `Load Palette`) when drawing characters/props/UI so they color-match the world. `rpg_worlds_palette_preview.png` is a swatch sheet showing the colors visually.
