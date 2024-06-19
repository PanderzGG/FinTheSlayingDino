extends Area2D

var speedUpgrade = 15


func _on_body_entered(body):
	queue_free()
	
	if body.has_method("gain_speed"):
		body.gain_speed(speedUpgrade)
	
