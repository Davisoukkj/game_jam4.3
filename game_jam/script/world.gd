extends Node3D
class_name World

@export var plugers : Array[Pluger]
var pluger_counter : int = 0  
var num_plugers : int = 0

@export var hud : HUD 
@export var player : Player

func _ready() -> void:
	num_plugers = plugers.size()
	pass # Replace with function body.



func player_grabbed_page(pluger: Pluger) -> void:
	pass




func _process(delta: float) -> void:
	pass
