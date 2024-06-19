extends CharacterBody2D



@onready var player = get_node("/root/Game/Player")

var speed: int = 120


func _physics_process(delta):
	
	var look_direction = to_local(player.global_transform.origin).normalized()
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
	if look_direction.x > 0:
		$EnemyAnimation.play("walk_right")
	else:
		$EnemyAnimation.play("walk_left")
	
	



