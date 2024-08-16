/// @description Insert description here
// You can write your code in this editor

//starter help

draw_set_font(Font1);
draw_set_halign(fa_center);

if (starterhelp and starterhelp_firsttime and false){
	draw_set_alpha(starter_alpha);
draw_set_color(c_black);
	///
	x1 = room_width*.85;
	y1 = room_height*0.26;
	x2 = room_width*.97;
	y2 = room_height*0.74;
	color = c_black
	width = 5
	draw_set_color(color)
	draw_rectangle(x1,y1,x2,y2,true)
	var i = 0
	do
	{
	    i += 1
	    draw_rectangle(x1-i,y1-i,x2+i,y2+i,true)
	}
	until(i = width)
	///

	draw_text(room_width*0.9,room_height*0.1,	"HOVER OVER TO\nSEE WHAT THESE\nCARDS DO");
	if (starter_up){
		starter_alpha+=0.01;
		if (starter_alpha>=1)starter_up = false;
	}else{
		starter_alpha-=0.01;
		if (starter_alpha<=0)starter_up=true;
	}
}
draw_set_alpha(1);
draw_set_color(c_gray);
//PLAYER
var pc;
pc = (oMPlayer.hp_score /oMPlayer.hp_max) * 100;
draw_healthbar(room_width*0.68-100,room_height*0.2+30,room_width*0.68+100,room_height*0.2+60, pc, c_gray, make_color_rgb(147, 53, 62), make_color_rgb(147, 53, 62), 0, true, false)
draw_text(room_width*0.68,room_height*0.2,"HP: "+string(oMPlayer.hp_score)+" / "+string(oMPlayer.hp_max)+"    attack:"+string(oMPlayer.attack_score));

//COMPUTER
pc = (oMComputer.hp_score /oMComputer.hp_max) * 100;
draw_healthbar(room_width*0.32-100,room_height*0.2+30,room_width*0.32+100,room_height*0.2+60, pc, c_gray, make_color_rgb(147, 53, 62), make_color_rgb(147, 53, 62), 0, true, false)
draw_text(room_width*0.32,room_height*0.2,"HP: "+string(oMComputer.hp_score)+" / "+string(oMComputer.hp_max)+"    attack:"+string(oMComputer.attack_score));


//ANIMATE DYING AND UPGRADING
draw_set_font(fScore);
if (dmg_taking){
	draw_set_color(make_color_rgb(147, 53, 62));
	var coll=make_color_rgb(147, 53, 62);
	if (dmg_taken_player!=0){
	draw_text_color(room_width*0.65,fade_y,"-"+string(dmg_taken_player),coll,coll,coll,coll,fade_alpha);
	}
	if (dmg_taken_comp!=0){
	draw_text_color(room_width*0.28,fade_y,"-"+string(dmg_taken_comp),coll,coll,coll,coll,fade_alpha);
	}
	if (fade_alpha<=0){
		dmg_taking=false;
		dmg_taken_player=0;
		dmg_taken_comp=0;
		fade_y=room_height*0.2-10;
		fade_alpha=1;
	}
	fade_alpha-=0.01;
	fade_y-=0.03;
}
if (upgrading){
var coll=make_color_rgb(58, 93, 145);
	if (upgrade_p!=0){
		draw_text_color(room_width*0.72,fade_y_upgrade,"+"+string(upgrade_p),coll,coll,coll,coll,fade_alpha_upgrade);
		draw_text_color(room_width*0.65,fade_y_upgrade,"+"+string(int64(upgrade_p/2)),coll,coll,coll,coll,fade_alpha_upgrade);
	}
	if (upgrade_c!=0){
		draw_text_color(room_width*0.32,fade_y_upgrade,"+"+string(upgrade_c),coll,coll,coll,coll,fade_alpha_upgrade);
		draw_text_color(room_width*0.28,fade_y_upgrade,"+"+string(int64(upgrade_c/2)),coll,coll,coll,coll,fade_alpha_upgrade);
	}	
	if (fade_alpha_upgrade<=0){
		upgrade_p=0;
		upgrade_c=0;
		upgrading=false;
		fade_alpha_upgrade=1;
		fade_y_upgrade=room_height*0.2-10;
	}
	fade_alpha_upgrade-=0.01;
	fade_y_upgrade-=0.03;
}

if (blocking){
	if (block_counter>20){
	var coll=make_color_rgb(58, 93, 145);
	if (block_p){
		draw_text_color(room_width*0.60,room_height*0.3,"DEFLECTED",coll,coll,coll,coll,fade_alpha_block);
	}
	if (block_c){
		draw_text_color(room_width*0.4,room_height*0.3,"DEFLECTED",coll,coll,coll,coll,fade_alpha_block);
	}
	
	if (fade_alpha_block<=0){
		blocking=false;
		block_p=false;
		block_c=false;
		block_end=true;
		fade_alpha_block=1;
		block_counter=0;
	}

	fade_alpha_block-=0.01;
}
block_counter++;
}
