/// @description Insert description here
// You can write your code in this editor

key_esc = keyboard_check(vk_escape) 
key_f1 = keyboard_check(vk_f1) 
key_f2 = keyboard_check(vk_f2) 
key_f3 = keyboard_check(vk_f3)

if (key_f1) {game_end();}
//if (key_f2) {room_restart();}
//if (key_f3) {game_restart();}

if (key_esc) 
{
    if window_get_fullscreen()
	{
		window_set_fullscreen(false);
		
	} else {window_set_fullscreen(true);}
}

if instance_exists(obj_player) {
	if obj_player.state == "DIE"  {
		audio_stop_sound(last_sound);	
	}
}