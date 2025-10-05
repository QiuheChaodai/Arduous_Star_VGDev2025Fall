class_name dyna_mite extends Enemy


@export_category("rotation")
@export var ROTATION_SPEED:float = 60
@export_category("movement speeds")
var SPEEDS = {
	"idle" : 3.0,
	"approach" : 5.0,
	"broken" : 7.0
}
@export_category("distances")
@export var DETECTION_RANGE:float = 20.0
@export var COUNTDOWN_RANGE:float = 10.0
@export_category("timer info")
@export var COUNTDOWN:float = 2.0
@export var BREAK_RECOVERY:float = 2.0
@export_category("damage")
@export var DAMAGE:float = 1.0
@export_category("PLAYER REFERENCE")
@export var playerRef: Player

var playerPosition:Vector3#note here

func _ready() -> void:
	$Hitbox.damangeAmount = DAMAGE
	$Hitbox.set_disabled(true)#we want the hitbox to be not there at first.

func leadInPlayer(playerInGame:Player):
	playerRef = playerInGame

func _physics_process(_delta: float) -> void:
	if NavigationServer3D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		print("NO NAVIGATION MAP")
		return
	if navigation_agent.is_navigation_finished():
		return
	if is_attacking:
		return
		
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position)
	if navigation_agent.avoidance_enabled:
		navigation_agent.velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)
	
func setSpeed(status:String):
	_movement_speed = SPEEDS.get(status)
	
func PlayerPositionUpd(playerPos:Vector3):
	playerPosition = playerPos
	
func die():
	print("function:die is executed")
	queue_free()
