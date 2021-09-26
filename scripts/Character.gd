extends KinematicBody2D

export (int) var life

func damage(amount):
	knockback()

	life -= amount
	if(life <= 0):
		queue_free()
		
func knockback():
	pass
