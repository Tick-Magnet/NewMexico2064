//audio_play_sound(snd_background, 1, false);

layer_set_visible("Effect_Layer", false);

//Background Music

if (lastroom == rm_dg1_f1 or lastroom == rm_dg1_f2) and (room == rm_dg1_f1 or room = rm_dg1_f2) {
	
} else if (lastroom == rm_dg3_f2 or lastroom == rm_dg3_f1) and (room == rm_dg3_f1 or room = rm_dg3_f2) {
	
} else {
audio_stop_sound(last_sound);



switch room {
	case rm_title:
		last_sound = snd_intro;
		audio_play_sound(last_sound, 1, true);
		break; 
	case rm_dg1_f1:
		last_sound = snd_bb;
		audio_play_sound(last_sound, 1, true);
		break;
	case rm_dg1_f2:
		last_sound = snd_bb;
		audio_play_sound(last_sound, 1, true);
		break;
	case rm_New_Mexico:
		last_sound = snd_mystery;
		audio_play_sound(last_sound, 1, true);
		break;	
	case rm_dg2_f1:
		last_sound = snd_crate;
		audio_play_sound(last_sound, 1, true);
		break;
	case rm_dg3_f1:
		last_sound = snd_bop;
		audio_play_sound(last_sound, 1, true);
		break;
	case rm_dg3_f2:
		last_sound = snd_bop;
		audio_play_sound(last_sound, 1, true);
		break;
	
	default:
		last_sound = snd_cave;
		audio_play_sound(last_sound, 1, true);
		break;
	}
}
