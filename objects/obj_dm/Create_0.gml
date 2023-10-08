//Randomize Function (Add the RNG to our Rouge-Lite)
randomize();
global.pause = false; // Add later
last_sound = noone;

 if !window_get_fullscreen() {
        width = window_get_width();
        height = window_get_height();
    } else {
        width = display_get_width();
        height = display_get_height();
    }
display_set_gui_size(width,height);
window_set_fullscreen(true);

lastroom = noone;