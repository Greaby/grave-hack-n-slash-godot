extends Area2D

export (int) var strength

enum STATES { IDLE, ATTACK}

var stricken = []

var state

func _ready():
	idle()
	
func idle():
	_change_state(STATES.IDLE)
	stricken = []

func attack():
	_change_state(STATES.ATTACK)

func _change_state(new_state):
	match new_state:
		STATES.IDLE:
			set_physics_process(false)
		STATES.ATTACK:
			set_physics_process(true)
	
	state = new_state

func _physics_process(delta):
	if(state == STATES.IDLE):
		return
	
	var bodies = get_overlapping_bodies()
	if not bodies:
		return
		
	for body in bodies:
		if not (stricken.has(body)):
			stricken.append(body)
			body.damage(strength)