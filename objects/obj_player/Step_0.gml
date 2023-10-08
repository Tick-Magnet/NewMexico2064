/// @description Player Code

if (state != "DIE") {

#region //Controls

if (state != "HIT") or (state != "FREEZE") {
	
	key_north = keyboard_check(ord("W")) or keyboard_check(vk_up) or (gamepad_axis_value(0,gp_axislv) < 0) or (gamepad_button_check(0,gp_padu));
	//key_north_check = keyboard_check_pressed(ord("W"))

	key_south = keyboard_check(ord("S")) or keyboard_check(vk_down) or (gamepad_axis_value(0,gp_axislv) > 0) or (gamepad_button_check(0,gp_padd));
	//key_south_check = keyboard_check_pressed(ord("S"))

	key_east = keyboard_check(ord("D")) or keyboard_check(vk_right) or (gamepad_axis_value(0,gp_axislh) > 0) or (gamepad_button_check(0,gp_padr));
	//key_east_check = keyboard_check_pressed(ord("D"))

	key_west = keyboard_check(ord("A")) or keyboard_check(vk_left) or (gamepad_axis_value(0,gp_axislh) < 0) or (gamepad_button_check(0,gp_padl));
	//key_west_check = keyboard_check_pressed(ord("A"))

//key_rb = gamepad_button_check_pressed(0,gp_shoulderr);
key_rb = false;
key_a = gamepad_button_check_pressed(0,gp_face1) or keyboard_check(ord("Z"));
key_b = gamepad_button_check(0,gp_face2) or keyboard_check(ord("X"));
key_x = gamepad_button_check(0,gp_face3) or keyboard_check(ord(";"));
key_y = gamepad_button_check(0,gp_face4) or keyboard_check(ord(","))

}

#endregion

#region//Player States





	
	

if max_hp > 12 {
	
	max_hp = 12;
	
}



//Attacked By Enemy
if instance_place(x,y,par_enemy) and state != "HIT" {
	
	state = "HIT"	
	attacking_enemy = instance_place(x,y,par_enemy)
	attacking_enemy.state = "ATTACKED";
	
	//Take Damage
	hp -= 1;
	
	
	objdist_x = x - attacking_enemy.x;
	objdist_y = y - attacking_enemy.y;

	if abs(objdist_x) > abs(objdist_y) {
		
		for (i = 16; i >= 0; i -= 1) {
			if !place_meeting(x + (sign(objdist_x) * i), y, obj_wall)
				{
					dest_x = x + (sign(objdist_x) * i);
					dest_y = noone;
					break;
				}
		}
	} else {
		for (i = 16; i >= 0; i -= 1) {
			if !place_meeting(x, y + (sign(objdist_y) * i), obj_wall)
				{
					dest_x = noone;
					dest_y = y + (sign(objdist_y) * i);
					break;
				}
		}	
	}	
}


//Hit by Bomb
if instance_place(x,y,obj_explosion) and state != "HIT" {
	
	state = "HIT"	
	attacking_enemy = instance_place(x,y,obj_explosion)
	attacking_enemy.state = "ATTACKED";
	
	//Take Damage
	hp -= 1;
	
	objdist_x = x - attacking_enemy.x;
	objdist_y = y - attacking_enemy.y;

	if abs(objdist_x) > abs(objdist_y) {
		
		for (i = 16; i >= 0; i -= 1) {
			if !place_meeting(x + (sign(objdist_x) * i), y, obj_wall)
				{
					dest_x = x + (sign(objdist_x) * i);
					dest_y = noone;
					break;
				}
		}
	} else {
		for (i = 16; i >= 0; i -= 1) {
			if !place_meeting(x, y + (sign(objdist_y) * i), obj_wall)
				{
					dest_x = noone;
					dest_y = y + (sign(objdist_y) * i);
					break;
				}
		}	
	}
}




//First Check If Attacking
if (state != "ATTACK") and (state != "HIT") and (state != "FREEZE") {

	//If Yes Idle
	if (!key_north) && (!key_south) && (!key_east) && (!key_west) {state = "IDLE";}


	//Change State Depending First on Movement
	if (key_north) {state = "NORTH";}
	if (key_south) {state = "SOUTH";}
	if (key_east) {state = "EAST";}
	if (key_west) {state = "WEST";}

	//Then If Attacking 	
	if (key_a) {state = "ATTACK";}

}


switch (state) {
	case "IDLE": {
		image_speed = 0; 
		image_index = 0;
		vx = 0;
		vy = 0;
		
		break;
	}
	
	case "FREEZE": {
		//Does Nothing
		break;	
	}
	
	
	case "HIT": {
		
		//Delete Spear
		if (instance_exists(obj_spear)) {instance_destroy(obj_spear);}
		
		
		sprite_index = spr_player_hurt;
		
		
		//Play Damage Audio
		if !audio_is_playing(snd_hit_hard) {
			audio_play_sound(snd_hit_hard, 1, false);
		}
	
		
		if dest_x != noone {
				
			if (dest_x > x) and (!place_meeting(x + knockback_dist, y, obj_wall)) {
					x += knockback_dist;	
			} else if (dest_x < x) and (!place_meeting(x - knockback_dist, y, obj_wall)) {
					x -= knockback_dist;
				} else {dest_x = noone;}	
				
		} else if dest_y != noone {
			
			if (dest_y > y) and (!place_meeting(x, y + knockback_dist, obj_wall)) {
					y += knockback_dist;	
			} else if (dest_y < y) and (!place_meeting(x, y - knockback_dist, obj_wall)) {
					y -= knockback_dist;
				} else {dest_y = noone;}
				
		} else {
			
			//Leave
			state = "IDLE";
			sprite_index = spr_player_south;
			hit_audio_playing = snd_hit_medium;
			//alarm[1] = 60;	
			
		}
		
		break;
		
	}
	
	case "ATTACK": {
		image_speed = 0;
		vx = 0;
		vy = 0;
		
	
		if !instance_exists(obj_spear) {alarm[0] = 12;} //Attack Cooldown Timer
		
		switch (sprite_index) {
			case spr_player_north: {
				sprite_index = spr_player_attack_north;
				instance_create_layer(x,y-16,"Instances",obj_spear);
				obj_spear.image_index = 0;
				break;
			}
			case spr_player_south: {
				sprite_index = spr_player_attack_south;
				instance_create_layer(x,y+16,"Instances",obj_spear);
				obj_spear.image_index = 1;
				break;
			}
			case spr_player_east: {
				sprite_index = spr_player_attack_east;
				instance_create_layer(x+16,y,"Instances",obj_spear);
				obj_spear.image_index = 2;
				break;
			}
			case spr_player_west: {
				sprite_index = spr_player_attack_west;
				instance_create_layer(x-16,y,"Instances",obj_spear);
				obj_spear.image_index = 3;
				break;
			}
		}
		
		//End Attack Case
		break;
	}
		
		
	case "NORTH": {
		image_speed = anim_speed;
		sprite_index = spr_player_north;
	
		vx = align_to_grid(x, grid);
		vy = -1 * player_speed;
		break;
		
	}
	
	
	case "SOUTH": {
		image_speed = anim_speed;
		sprite_index = spr_player_south;
		
		vx = align_to_grid(x, grid);
		vy = player_speed;
		break;
		
	}
	
	case "EAST": {
		image_speed = anim_speed;
		sprite_index = spr_player_east;
		
		vx = player_speed;
		vy = align_to_grid(y, grid);
		break;
		
	}
	
	case "WEST": {
		image_speed = anim_speed;
		sprite_index = spr_player_west;
		image_xscale = 1;

		
		vx =  -1 * player_speed;
		vy = align_to_grid(y, grid);
		break;
		
	}
}

#endregion



//Collision Detection
if !place_meeting(x + vx, y + vy, obj_wall) {
	
	//Execute Movement:
	x += vx;
	y += vy;
	
} else {
	state = "IDLE";
	image_speed = 0; 
}



#region ///Items 

	if instance_place(x,y,obj_heart) and hp < max_hp {
			item = instance_place(x,y,obj_heart);
			instance_destroy(item);
			audio_play_sound(snd_heal, 1, false);	
			hp += 1;
	}

	if instance_place(x,y,obj_heart_container) {
			item = instance_place(x,y,obj_heart_container);
			instance_destroy(item);
			audio_play_sound(snd_heal, 1, false);	
			max_hp += 1;
	}

	if instance_place(x,y,obj_shot) {
			item = instance_place(x,y,obj_shot);
			instance_destroy(item);
			layer_set_visible("Effect_Layer", true);
			alarm[2] = 180;	
	}
	
	if instance_place(x,y,obj_cash) {
			item = instance_place(x,y,obj_cash);
			instance_destroy(item);
			audio_play_sound(snd_cash, 1, false);	
			cash += 1;
	}
	if instance_place(x,y,obj_bomb_item) and bombs < 9{
			item = instance_place(x,y,obj_bomb_item);
			instance_destroy(item);
			audio_play_sound(snd_tick, 1, false);	
			bombs += 1;
	}
	if instance_place(x,y,obj_key) {
			item = instance_place(x,y,obj_key);
			instance_destroy(item);
			audio_play_sound(snd_key, 1, false);	
			keys += 1;
	}
	if instance_place(x,y,obj_1up) {
			item = instance_place(x,y,obj_1up);
			instance_destroy(item);
			audio_play_sound(snd_hpup, 1, false);	
			life += 1;
	}
	

#endregion



//Camera
if (global.active_room !=-1)
{
	
	cam_x=clamp(x-88,global.active_room.x-16, global.active_room.x + global.active_room.sprite_width+16-camera_get_view_width(view_camera[0]));
	cam_y=clamp(y-184,global.active_room.y-16, global.active_room.y + global.active_room.sprite_width+16-camera_get_view_height(view_camera[0]));
	
	camera_set_view_pos(view_camera[0],
	lerp(camera_get_view_x(view_camera[0]),cam_x,0.1),
	lerp(camera_get_view_y(view_camera[0]),cam_y,0.1));
	
}


#region //Bombs
//Selecting Bombs
if (key_rb) {
	//if instance_exists(par_player_bomb) {instance_destroy(par_player_bomb);}
	bomb_selected = bomb_selected * -1;
}


//Action Key -- Bombs
if (key_b) and !instance_exists(par_player_bomb) and (bombs > 0)
{	
	bombs -= 1;
	
	switch (bomb_selected) {
		
		case 1: 
			bomb = obj_red_bomb;
			break;
		case -1: 
			bomb = obj_purple_bomb;
			break;	
	}
	
	switch (sprite_index) {
		case spr_player_north: {
			instance_create_layer(x,y - 20,"Drops",bomb)
			break;
		}
	
	
		case spr_player_south: {
			instance_create_layer(x,y + 20,"Drops",bomb)
			break;
		}
	
		case spr_player_east: {
			instance_create_layer(x + 20,y,"Drops",bomb)
			break;
		}
	
		case spr_player_west: {
			instance_create_layer(x - 20,y,"Drops",bomb)
			break;
		}
	}
}  

#endregion


//Death Code
if hp <= 0 {	
	
	if (life > 1) {
		life -= 1;
		hp = max_hp;
	} else {
		
		
	state = "DIE";	
	
	
	if (state = "DIE") {
		sprite_index = spr_player_hurt;
		instance_create_layer(0,0,"GUI",obj_gameover)
		audio_play_sound(snd_gameover, 1, false);
	}
		
		
	}
}	
}