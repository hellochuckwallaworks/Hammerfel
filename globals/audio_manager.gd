extends Node
## Central audio control: bus volumes, music crossfades, one-shot SFX helper.
## Stub for now — actual buses will be configured via Audio panel.

@export var music_volume: float = 1.0
@export var sfx_volume: float = 1.0
@export var ui_volume: float = 1.0

func play_sfx(_stream: AudioStream, _volume_db: float = 0.0) -> void:
	# TODO: pool AudioStreamPlayer nodes, play one-shot
	pass

func play_music(_stream: AudioStream, _crossfade_seconds: float = 1.0) -> void:
	# TODO: crossfade between current music track and new one
	pass

func stop_music(_fade_out_seconds: float = 1.0) -> void:
	pass
