/// @description Insert description here
// You can write your code in this editor

if (image_index>=2) image_index=0;

if (abs(target_scale -image_xscale)>0.1){
	image_xscale = lerp(image_xscale, target_scale, .2);
	image_yscale = lerp(image_yscale, target_scale, .2);
}else{
	image_xscale=target_scale;
	image_yscale=target_scale;
	
}

if (position_meeting(mouse_x, mouse_y, id)){
	show_debug_message("test");
	target_scale=1;
}else{
	target_scale=0.9;
}