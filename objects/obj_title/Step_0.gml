start = gamepad_button_check(0,gp_start) or gamepad_button_check(0,gp_select);


if (start == true) {
	room_goto(rm_New_Mexico);
}