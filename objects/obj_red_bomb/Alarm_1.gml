//Timer
if (tick > 3) {
	tick -= 1;	
}

audio_play_sound(snd_tick, 100, false);
alarm[1] = tick;