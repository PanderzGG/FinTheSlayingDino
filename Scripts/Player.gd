extends CharacterBody2D

@onready var anim = $Player_SpriteAnimation

@onready var label = Label
@onready var time = Timer

# speed is going to reference a Global var in the future to make sure we can modulate it. Or through a different node ain't sure yet
var speed: int = 150

# Maybe will be Global later on
var health: float = 100
var max_health: float = 100
var regen_rate: int = Global.player_health_regen_rate



func _ready():
	label = %TimerLabel
	time = %GameTimer
	
	time.start()
# Physicsprocess is part of the Main Game Loop. Use delta for time dependend actions like movement.

func _process(delta):
	update_label_text()


func _physics_process(delta):
	
	var currenthealth: float
	
	# The strings correspond with our custom
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# The property velocity is part of the CharacterBody2D and gets a Vector2D(x,y)
	velocity = direction * speed
	# Move and slide is a Godot funktion. It moves the player depending on the velocity we just declared
	# Rember to not multiply move_and_slide by delta. Godot already takes that into account.
	
	move_and_slide()
	take_damage(delta)
	_on_regen_timer_timeout(delta)
	
	%HealthBar.max_value = max_health
	%HealthBar.value = lerp(health, max_health, delta)
	
	print(round(%RegenTimer.time_left))
	
	
	# Simple first Animation Setup nothing fancy
	if velocity.length() > 0.0:
		if Input.is_action_pressed("move_left"):
			anim.play("walk_left")
		elif Input.is_action_pressed("move_right"):
			anim.play("walk_right")
		elif Input.is_action_pressed("move_up"):
			anim.play("walk_up")
		elif Input.is_action_pressed("move_down"):
			anim.play("walk_down")
	else:
		anim.play("idle")
	


	
func take_damage(delta):
	var damage_rate: int = 5
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		health -= damage_rate * overlapping_mobs.size() * delta
		if health <= 0:
			health = 0
		
		%RegenTimer.one_shot = true
		%RegenTimer.start(3)
		
	

func _on_regen_timer_timeout(delta):
	
	if %RegenTimer.is_stopped() == true:
		for n in range(health, max_health):
			health += regen_rate * delta
			
		

func update_label_text():
	label.text = str(ceil(time.time_left))
