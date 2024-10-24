extends CharacterBody3D
class_name Player

signal page_grabbed(pluger: Pluger)

const SPEED = 4.5
const JUMP_VELOCITY = 3
var flashlightIsOut : bool
var LightLevel : float
var looking_at_page : bool = false   
@export var sensitivity = 2.5
@export var mouse_sensitivity := 0.2
@export var player_control : PlayerControl

@onready var raycast = $RayCast3D


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready(): #MOUSE PRESO NA TELA
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event): #PRIMEIRA PESSOA
	if(event is InputEventMouseMotion):
		rotation.y -= event.relative.x / 1000 * sensitivity
		$Camera3D.rotation.x -= event.relative.y / 1000 * sensitivity
		rotation.x = clamp(rotation.x, PI/-0.6, PI/0.6)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -0.6, 0.6)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector(player_control.left, player_control.right, player_control.up, player_control.down)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = SPEED
	
	looking_at_page = raycast.get_collider() != null
	
	if Input.is_action_just_pressed("flashlight"):
		if flashlightIsOut:
			$AnimationPlayer.play("light_show")
		else:
			$AnimationPlayer.play("light_hide")
		flashlightIsOut = !flashlightIsOut
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()
	
	print(raycast.get_collider() != null )
