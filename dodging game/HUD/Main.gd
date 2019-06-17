extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()
	
func game_over():
	$scoretimer.stop()
	$mobtimer.stop()
	
func new_game():
	score = 0
	$Player.start($startposition.position)
	$starttimer.start()
	
func _on_starttimer_timeout():
	$mobtimer.start()
	$scoretimer.start()
	
func _on_scoretimer_timeout():
	score =+ 1

func _on_mobtimer_timeout():
	$mobpath/mobspawnlocation.set_offset9(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $mobpath/mobspawnlocation.rotation + PI / 2
	mob.position = $mobpath/mobspawnlocation.position
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))


func _on_HUD_start_game():
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player._start($Main.startposition.position)
	$HUD.update_score(score)



