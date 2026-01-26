extends TextureButton

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)

@onready var book: Control = $"../../Book"

var stay_big = false

func _ready() -> void:
	$"../../Book".connect("visibility_changed", _on_book_visibility_changed)
	
	mouse_entered.connect(_button_enter)
	mouse_exited.connect(_button_exit)
	pressed.connect(_button_pressed)
	
	call_deferred("_init_pivot")

#func _process(_delta: float) -> void:
	#if book.visible == true:
		#_button_enter()

func _init_pivot() -> void:
	pivot_offset = size/2.0

func _button_enter() -> void:
	SoundsManager.play("hover")
	
	create_tween().tween_property(self, "scale", hover_scale, 0.1).set_trans(Tween.TRANS_SINE)

func _button_exit() -> void:
	if book.visible == false:
		create_tween().tween_property(self, "scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_SINE)

func _button_pressed() -> void:
	SoundsManager.play("click")
	
	var button_press_tween: Tween = create_tween()
	button_press_tween.tween_property(self, "scale", pressed_scale, 0.06).set_trans(Tween.TRANS_SINE)
	button_press_tween.tween_property(self, "scale", hover_scale, 0.12).set_trans(Tween.TRANS_SINE)


func _on_book_visibility_changed() -> void:
	if book.visible == true:
		var timer: Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 0.5
		timer.timeout.connect(_button_enter)
		timer.start()
	else:
		create_tween().tween_property(self, "scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_SINE)
