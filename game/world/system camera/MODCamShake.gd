extends Node
var timer: Timer
var tween: Tween
var shake_amount = 0
var default_offset 

func _ready():
	default_offset = Vector2(game.mainCam.h_offset,game.mainCam.v_offset)
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(self._onShakeTimerRunout)
	timer.one_shot = true
	
	game.mainCam.set_process(false)
	randomize()

func _process(delta):
	game.mainCam.h_offset = randf_range(-1, 1) * shake_amount
	game.mainCam.v_offset = randf_range(-1, 1) * shake_amount

func shake(time, amount):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()


func _onShakeTimerRunout():
	set_process(false)
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(
		game.mainCam,
		"h_offset",
		default_offset.x,0.1
	)	
	tween.tween_property(
		game.mainCam,
		"v_offset",
		default_offset.y,0.1
	)	
