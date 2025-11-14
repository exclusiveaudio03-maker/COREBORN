extends Node
# Mobile input manager: tap, hold, swipe detection
@export var swipe_deadzone := 30
@export var hold_time := 0.35

var _touch_start_pos := null
var _touch_start_time := 0.0
var _is_holding := false

signal tap()
signal hold()
signal swipe_up()
signal swipe_down()
signal swipe_left()
signal swipe_right()

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			_touch_start_pos = event.position
			_touch_start_time = Engine.get_time_in_seconds()
			_is_holding = false
		else:
			# touch released -> determine tap/hold/swipe
			var dt = Engine.get_time_in_seconds() - _touch_start_time
			var delta = event.position - _touch_start_pos
			if delta.length() <= swipe_deadzone:
				if dt >= hold_time:
					emit_signal("hold")
				else:
					emit_signal("tap")
			else:
				# swipe
				if abs(delta.y) > abs(delta.x):
					if delta.y < 0:
						emit_signal("swipe_up")
					else:
						emit_signal("swipe_down")
				else:
					if delta.x > 0:
						emit_signal("swipe_right")
					else:
						emit_signal("swipe_left")
	elif event is InputEventScreenDrag:
		# treat long drags as possible swipes on release
		pass

func is_holding() -> bool:
	return _is_holding
