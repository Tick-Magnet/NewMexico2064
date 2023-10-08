/// @description Insert description here
// You can write your code in this editor
if (obj_player.keys > 0) {
	obj_player.keys -= 1;
	audio_play_sound(snd_keybreak, 10, false);
	instance_destroy();
}