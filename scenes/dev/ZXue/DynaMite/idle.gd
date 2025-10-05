extends State

## Called on state machine process
func update(_delta: float) -> void:
	pass

## Called on state machine physics process
func physics_update(_delta: float) -> void:
	#TODO: make DynaMite walk around when idle.
	#check if player is within detection range or not.
	var distanceToPlayer:float = $"../..".global_transform.origin.distance_to($"../..".playerRef.global_transform.origin)
	if(distanceToPlayer < $"../..".DETECTION_RANGE):
		finished.emit("approach")
	elif($"../.."._hp <= 0):
		finished.emit("dead")
	#I cannot find anything related to break meter in entity class.

## Called on state enter. Make sure to emit entered.
func enter(_prev_state: String, _data := {}) -> void:
	print("===STATE ENTRY [idle]===")
	#set speed to idle speed.
	$"../..".setSpeed("idle")

## Call for another script to end this state. Should pick the next state and emit finished.
func end() -> void:
	#idk why this would be invoked but sure
	finished.emit("approach")
	
## Called on state exit
func exit() -> void:
	#nothing to clear from idle state here.
	pass
