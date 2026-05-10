extends Node
## Singleton holding session-wide state: which save slot is active, current
## settlement Renown tier, raid threat meter, etc. Anything that survives a
## scene change but not an app restart belongs here.

enum SettlementTier { OUTPOST, CAMP, HOLD, STRONGHOLD }

var current_save_slot: int = 0
var settlement_renown: int = 0
var settlement_tier: SettlementTier = SettlementTier.OUTPOST
var raid_threat: float = 0.0  # 0.0 .. 1.0; triggers a raid at 1.0

func reset_for_new_game() -> void:
	settlement_renown = 0
	settlement_tier = SettlementTier.OUTPOST
	raid_threat = 0.0
