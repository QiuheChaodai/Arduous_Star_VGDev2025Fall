extends State

## Called on state machine process
func update(_delta: float) -> void:
	pass

## Called on state machine physics process
func physics_update(_delta: float) -> void:
	##move closer to player
	#set movement target to player reference and connect signal
	$"../..".set_movement_target($"../..".playerRef.global_transform.origin)
	'''
	I checked and I think NavigationAgent is currently an unavailable function,
	so I am implementing my own movement code.
	'''
	
	$"../..".velocity = $"../.."._movement_speed * ($"../..".playerRef.global_transform.origin - $"../..".global_transform.origin).normalized()
	$"../..".move_and_slide()
	
	#update
	#check if player is within detection range or not.
	var distanceToPlayer:float = $"../..".global_transform.origin.distance_to($"../..".playerRef.global_transform.origin)
	if(distanceToPlayer < $"../..".COUNTDOWN_RANGE):
		finished.emit("countdown")
	elif($"../.."._hp <= 0):
		finished.emit("dead")
	
	

## Called on state enter. Make sure to emit entered.
func enter(_prev_state: String, _data := {}) -> void:
	print("===STATE ENTRY [approach]===")
	#set _movement_speed to approach speed
	$"../..".setSpeed("approach")
	#connect NavigationAgent3D.velocity_computed signal to base method _on_velocity_computed
	$"../../NavigationAgent3D".velocity_computed.connect(Callable($"../..", "_on_velocity_computed"))

## Call for another script to end this state. Should pick the next state and emit finished.
func end() -> void:
	finished.emit("idle")
	
## Called on state exit
func exit() -> void:
	#stop connection the NavigationAgent3D.velocity_computed signal so as to stop the movement
	$"../../NavigationAgent3D".velocity_computed.disconnect(Callable($"../..", "_on_velocity_computed"))
