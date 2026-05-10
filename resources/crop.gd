extends Item
class_name Crop

enum CropFamily { FUNGI, ROOT, RARE }

@export var family: CropFamily = CropFamily.FUNGI
@export var growth_days: int = 4
@export var seasons: PackedInt32Array = PackedInt32Array([0, 1, 2, 3])  # Clock.Season values
@export var harvest_yield_min: int = 1
@export var harvest_yield_max: int = 1
@export var giant_crop_chance: float = 0.0
