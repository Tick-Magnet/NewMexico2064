hp = 6;
state = "IDLE";
image_speed = 0;

unit_sprite = spr_claw;
unit_sprite_hurt = spr_claw_hurt;
unit_death_animation = spr_death_animation;

rng = 0;
x_goal = 0;
y_goal = 0;
spd = 0.2;
sprite_speed = 2;

//Check if player is in collision rectangle
my_room = instance_position(x,y,obj_room);

knockback_x = noone;
knockback_y = noone;
width = 0.5 * sprite_width;

iframes = false;
hit_audio_playing = false;