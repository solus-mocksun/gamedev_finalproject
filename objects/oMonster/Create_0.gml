/// @description Insert description here
// You can write your code in this editor
x=start_x;
y=start_y
image_speed=0.1;

start_attack=false;
start_def=false;
start_upgrade=false;

taking_dmg=false;
taking_dmg_score=0;

function takedmg(dmg){
	taking_dmg=true;
	taking_dmg_score=dmg;
}

function upgrade(){
	attack_score+=upgrade_score;
	hp_score+=int64(upgrade_score/2);
	
}

counter_toend=0;