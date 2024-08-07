/// @description Insert description here
// You can write your code in this editor


fade_alpha=1;
fade_alpha_block=1;
fade_alpha_upgrade=1;

dmg_taking=false;
dmg_taken_player=0;
dmg_taken_comp=0;
fade_y=room_height*0.2-10;

upgrade_p=0;
upgrade_c=0;
upgrading=false;
fade_y_upgrade=room_height*0.2-10;

blocking=false;
block_p=false;
block_c=false;
block_counter=0;

starterhelp=false;
starterhelp_firsttime=true;
starter_alpha=1;
starter_up=false;

function dmg_take_start(p,c){
	dmg_taking=true;
	dmg_taken_player=p;
	dmg_taken_comp=c;

}

function upgrade_start(p,c){
	upgrading=true;
	upgrade_p=p;
	upgrade_c=c;
}

function block(p,c){
	blocking=true;
	block_p=p;
	block_c=c;
}
