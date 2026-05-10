extends Resource
class_name SettlerDefinition

enum Role { UNASSIGNED, FARMER, MINER, BREWER, COOK, GUARD, MERCHANT, RUNESMITH }
enum Personality { STOIC, CHEERFUL, GRUFF, SCHOLARLY, BOISTEROUS, RESERVED }

@export var id: StringName = &""
@export var display_name: String = ""
@export var beard_id: StringName = &""
@export var role: Role = Role.UNASSIGNED
@export var personality: Personality = Personality.STOIC
@export var skill_speciality: StringName = &""
@export var friendship: int = 0  # 0 .. 10
@export_multiline var backstory: String = ""
