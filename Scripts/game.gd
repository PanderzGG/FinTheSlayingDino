extends Node2D


# Mob Spawner

func spawn_mob():
	
	var newMob = preload("res://Scenes/enemy_small.tscn").instantiate()
	
	#Spawn at random position
	%PathFollow2D.progress_ratio = randf()
	newMob.global_position = %PathFollow2D.global_position
	add_child(newMob)




func _on_small_enemy_timer_timeout():
	spawn_mob()
