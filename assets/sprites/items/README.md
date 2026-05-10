# Item icons

Inventory / crafting / UI item sprites organized by category. All packs by what appear to be the same author (`[Package]` prefix and consistent naming convention).

Sizing: where multiple sizes shipped (16 / 32 / 48), the **32px version** was extracted to match the project's 32×32 tile / 32×32 inventory icon spec. Single-size packs were kept as-shipped.

## Categories

| Folder | Source pack | Files | Layout notes |
|--------|-------------|-------|--------------|
| `armor/` | Defensive Arsenal — 32x | 8 | One sheet per element: Aqua, Chaos, Demonic, Gaia, Holy, Natura, Order, Rustic |
| `weapons/` | Offensive Arsenal — 32x32 | 8 | Same 8 elements as armor |
| `tools/` | Tools of the Trade V2 — 32x32 | 7 | Material tiers: Wood, Stone, Copper, Silver, Iron, Gold, Mythrill |
| `potions/` | Potionomics x32 | 1 | Single sheet of potion bottles |
| `ores/` | OreStarter V2 (32) + Ore Master 1.0 | 161 | `OreStarter.png` for sheet view; `ore_master/Original/` (20 ores, 1 frame each) + `ore_master/Variants/` (color variants) |
| `gems/` | Gem Master 1.0 | 120 | `Original/` (10 gem cuts: circular, diamond, heart, orb, oval, pentagonal, rectangular, shard, square, teardrop) + `Variants/` (11 color variants per cut) |
| `crops/` | Growing Crops 1.0 | 171 | Multiple presentations: `Separate/` (per-stage files), `full/`, `shadowed/`, `transparent/`. 4 growth stages + produce + seed per crop |
| `books/` | Books Start V1.0 | 45 | `16a/` and `16b/` style variants + `32/` size variant. 15 themes (aqua, emerald, eye, glacial, holy, mystic, nature, official, scale, skull, spriggan, sun, vampiric, volcanic, winged) |
| `keys/` | Keys Starter V1.1 | 45 | `16/` and `16b/` style variants + `32/` size variant. 15 themes (brass, copper, cube, fire, holy, mechanical, natura, owl, potion, royal, rune, skull, steel, thorns, vampire) |
| `runes/` | Runeworks 1.3b (March 2023, 16x16 Crop) | 155 | Subfolders: `Accessories/`, `Fishes/`, `Mineral/`, `Seeds/`, `Skills/`, `Spells/`. Note: chose **1.3b cropped** over 1.3 — same content, but icons centered/cleaned on uniform canvases. |
| `skills/` | SkillMasterV1 | 84 | One folder per skill type: `Core Skills/`, `Dark Skills/`, `Electric Skills/`, `Fire Skills/`, `Freezing Skills/`, `Holy Skills/`, `Nature Skills/`, `Utility Skills/` |

**Total**: 805 PNG icons across 11 categories.

## Use in Godot

These are inventory icons, not world tiles — load as `AtlasTexture` regions or individual `Texture2D` resources for `TextureRect` (UI) / `Sprite2D` (world drops) display.

For sheet-based packs (weapons, armor, tools, potions, etc.), set up a single AtlasTexture per element/material and slice into `region` rects per icon. For per-icon packs (ores, gems, runes, skills, crops/Separate), each PNG is already its own icon.

## License

Not all packs shipped with explicit license files. Check the original zips in `~/Downloads/` for any included licenses before commercial use.
