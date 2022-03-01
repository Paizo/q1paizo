/*
==============================================================================

SPIDER

==============================================================================
*/
$cd /raid/quake/id1/models/spider
$origin 0 0 -24
$base base
$skin skin
$scale 0.7

$frame frame1 frame2 frame3 frame4 frame5 frame6 frame7 frame8 frame9 frame10
$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10
$frame pain1 pain2 pain3 pain4 pain5 pain6 pain7 pain8 pain9 pain10 pain11

void(entity attacker, float damage) spider_pain;
void(float offset) SpiderMissile;
void() Spider_Melee;
void() aip_jump_to_wall;
void() Spider_JumpFromWallTouch;

void() spid_stand2    =[      $pain2,       spid_stand3    ] {ai_stand();};
void() spid_stand3    =[      $pain3,       spid_stand4    ] {ai_stand();};
void() spid_stand4    =[      $pain4,       spid_stand5    ] {ai_stand();};
void() spid_stand5    =[      $pain5,       spid_stand6    ] {ai_stand();};
void() spid_stand6    =[      $pain4,       spid_stand7    ] {ai_stand();};
void() spid_stand7    =[      $pain3,       spid_stand8    ] {ai_stand();};
void() spid_stand8    =[      $pain2,       spid_stand1    ] {ai_stand();};
void() spid_stand1 = {

    self.frame = $pain1;
    self.nextthink = time + 0.1;

    if (random() < 0.001) {
       self.think = spid_stand2;
       return;
    }

    self.think = spid_stand1;
    ai_stand();
};

void() spid_walk1     =[      $frame1,       spid_walk2    ] {
    if (random() < 0.1)
        sound (self, CHAN_VOICE, "shalrath/idle.wav", 1, ATTN_IDLE);
    ai_walk(4);
};
void() spid_walk2     =[      $frame2,       spid_walk3    ] {ai_walk(4);};
void() spid_walk3     =[      $frame3,       spid_walk4    ] {ai_walk(4);};
void() spid_walk4     =[      $frame4,       spid_walk5    ] {ai_walk(4);};
void() spid_walk5     =[      $frame5,       spid_walk6    ] {ai_walk(4);};
void() spid_walk6     =[      $frame6,       spid_walk7    ] {ai_walk(4);};
void() spid_walk7     =[      $frame7,       spid_walk8    ] {ai_walk(4);};
void() spid_walk8     =[      $frame8,       spid_walk9    ] {ai_walk(4);};
void() spid_walk9     =[      $frame9,       spid_walk10    ] {ai_walk(4);};
void() spid_walk10    =[      $frame10,       spid_walk1    ] {ai_walk(4);};

void() spid_run1     =[      $frame1,       spid_run2    ] {
    if (random() < 0.1)
	    sound (self, CHAN_VOICE, "shalrath/idle.wav", 1, ATTN_IDLE);

    ai_run(6);
};
void() spid_run2     =[      $frame2,       spid_run3    ] {ai_run(6);};
void() spid_run3     =[      $frame3,       spid_run4    ] {ai_run(6);};
void() spid_run4     =[      $frame4,       spid_run5    ] {ai_run(6);};
void() spid_run5     =[      $frame5,       spid_run6    ] {ai_run(6);};
void() spid_run6     =[      $frame6,       spid_run7    ] {ai_run(6);};
void() spid_run7     =[      $frame7,       spid_run8    ] {ai_run(6);};
void() spid_run8     =[      $frame8,       spid_run9    ] {ai_run(6);};
void() spid_run9     =[      $frame9,       spid_run10    ] {ai_run(6);};
void() spid_run10 = {
    self.frame = $frame10;
    ai_run(6);
    if (random() < 0.5) {
        if (self.flags & FL_ONGROUND) {
            sound (self,CHAN_VOICE, "spider/tap.wav", 1, ATTN_IDLE);
            self.think = aip_jump_to_wall;
            self.nextthink = time + 0.1;
            return;
        }
    }
    self.think = spid_run1;
    self.nextthink = time + 0.1;

};

void() spid_melee1  	=[	    $pain6,        spid_melee2	   ] {ai_charge(10);};
void() spid_melee2      =[      $pain7,        spid_melee3     ] {ai_charge(10);};
void() spid_melee3      =[      $pain8,        spid_melee4     ] {ai_charge(10);};
void() spid_melee4      =[      $pain9,        spid_melee5     ] {ai_charge(10);};
void() spid_melee5     =[      $pain10,       spid_run1       ] {Spider_Melee();};


void() spid_pain1       =[      $pain1, spid_pain2      ] {
	if (self.touch == Spider_JumpFromWallTouch)
		return;
};
void() spid_pain2       =[      $pain2, spid_pain3      ] {};
void() spid_pain3       =[      $pain3, spid_pain4      ] {};
void() spid_pain4       =[      $pain4, spid_pain5      ] {};
void() spid_pain5       =[      $pain5, spid_pain6      ] {};
void() spid_pain6       =[      $pain6, spid_pain7      ] {};
void() spid_pain7       =[      $pain7, spid_pain8      ] {};
void() spid_pain8       =[      $pain8, spid_pain9      ] {};
void() spid_pain9       =[      $pain9, spid_pain10     ] {};
void() spid_pain10      =[      $pain10, spid_pain11    ] {};
void() spid_pain11      =[      $pain11, spid_run1      ] {};

void() spid_death1      =[      $death1,        spid_death3     ] {};
void() spid_death2      =[      $death1,        spid_death3     ] {};
void() spid_death3      =[      $death2,        spid_death4     ] {};
void() spid_death4      =[      $death3,        spid_death5     ] {};
void() spid_death5      =[      $death4,        spid_death6     ] {};
void() spid_death6      =[      $death5,        spid_death7     ] {};
void() spid_death7      =[      $death6,        spid_death8    ] {};
void() spid_death8      =[      $death7,        spid_death9    ] {};
void() spid_death9      =[      $death8,        spid_death10    ] {};
void() spid_death10     =[      $death9,        spid_death11    ] {};
void() spid_death11     =[      $death10,       spid_death11    ] {};

void(entity attacker, float damage) spider_pain =
{
	if (self.pain_finished > time)
		return;

	sound (self, CHAN_VOICE, "shalrath/pain.wav", 1, ATTN_NORM);
    self.velocity_x = -50 - 50 * random();
    self.velocity_y = 0;
    self.velocity_z = 150 + 150*random();
    self.flags = self.flags - (self.flags & FL_ONGROUND);
	spid_pain1();
	self.pain_finished = time + 3;
};

void() spider_die =
{
	if (self.health < -90)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
        self.think = SUB_Remove;
        self.nextthink= time + 0.1;
		ThrowHead ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	sound (self, CHAN_VOICE, "shalrath/death.wav", 1, ATTN_NORM);
    self.movetype = MOVETYPE_BOUNCE;
    self.solid = SOLID_NOT;
    self.velocity_x = -50 + 100*random();
    self.velocity_y = -50 + 100*random();
    self.velocity_z = 300 + 300*random();
    self.avelocity_x = -20 + 40*random();
    self.avelocity_y = -200 + 400*random();
    self.avelocity_z = 0;
    self.flags = self.flags - (self.flags & FL_ONGROUND);
	spid_death1();
};

void() Spider_Melee =
{
	local float ldmg;
	local vector delta;

	ai_face ();
	walkmove (self.ideal_yaw, 12);	// allow a little closing

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 90)
		return;
	if (!CanDamage (self.enemy, self))
		return;

    sound (self, CHAN_WEAPON, "demon/dhit2.wav", 1, ATTN_NORM);
	ldmg = 10 + 5*random();
	T_Damage (self.enemy, self, self, ldmg);

	makevectors (self.angles);
	SpawnMeatSpray (self.origin + v_forward*16, 200 * random() * v_up);
};

void()	Spider_JumpFromWallTouch =
{
	local	float	ldmg;

	if (self.health <= 0)
		return;

	if (other.takedamage)
	{
		if ( vlen(self.velocity) > 200 )
		{
			ldmg = 10 + 10*random();
			T_Damage (other, self, self, ldmg);
		}
	}

	if (!checkbottom(self))
	{
		if (self.flags & FL_ONGROUND)
		{
		    //fixme
			// jump randomly to not get hung up
			self.touch = SUB_Null;
			self.think = spid_run1;
			self.nextthink = time + 0.1;
		}
		return;	// not on ground yet
	}

	self.touch = SUB_Null;
	self.frame = $death1;
	self.think = spid_run1;
	self.nextthink = time + 0.1;
};

//TODO can be a whole animation like demon jump
void () spider_jump_from_wall =
{
    bprint("jumping from wall\n");

    self.frame = $death1;
    //self.movetype = MOVETYPE_STEP;
    ai_face();
    if (random() < 0.2) {
        SpiderMissile(0);
    }
	makevectors (self.angles);
    self.velocity = v_forward * 450 + '0 0 50';
	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;

    //TODO touch attack, with running animation?
    //only touch with no nextthink to keep the frame during flight
//    self.think = spid_run1;
//    self.nextthink = time + 0.1;
    self.touch = Spider_JumpFromWallTouch;
};

/*
================
SpiderMissile
================
*/
void(float offset) SpiderMissile =
{
	local	vector	offang;
	local	vector	org, vec;

    bprint ("spider missile");
	offang = vectoangles (self.enemy.origin - self.origin);
	offang_y = offang_y + offset * 6;
	
	makevectors (offang);

	org = self.origin + self.mins + self.size*0.5 + v_forward * 5;//was 20

// set missile speed
	vec = normalize (v_forward);
	vec_z = 0 - vec_z + (random() - 0.5)*0.1;
	
	launch_spike (org, vec);
        newmis.classname = "wizspike";
	setmodel (newmis, "progs/w_spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	newmis.velocity = vec*300;

};

void() Spider_ClimbTouch;
void() aip_jump_to_wall =
{

    if (!self.enemy)
        return;

    bprint ("jumping to wall\n");
    self.touch = Spider_ClimbTouch;
    makevectors (self.angles);
    self.origin_z = self.origin_z + 1;

    if (random() < 0.8) {
        bprint ("jumping to wall forward + up\n");
        self.velocity = v_forward * 300 + '0 0 550';
    } else {
        if (random() < 0.5) {
            bprint ("jumping to wall forward + right up\n");
            self.velocity = v_forward * 300 + '300 0 550';
        } else {
            bprint ("jumping to wall forward + left up\n");
            self.velocity = v_forward * 300 + '0 300 550';
        }
    }

    if (self.flags & FL_ONGROUND)
        self.flags = self.flags - FL_ONGROUND;
}

//the physics functions internally use traces, the last normal of impact will be stored in trace_normal
//you can access it during touch function.
//no need to call traceline, the physics system is already doing that
//with the normal of impact you can tell if it's 'ground' or not (trace_normal.z > 0.7f or something along those lines)

void() Spider_ClimbTouch =
{
    local	float	ldmg;

	if (self.health <= 0)
		return;

    if (other.takedamage)
    {
        bprint (" other.takedamage\n");
        if ( vlen(self.velocity) > 200 )
        {
            ldmg = 5 + 10*random();
            T_Damage (other, self, self, ldmg);
        }
    }

    if (checkbottom(self))
    {
        bprint (" checkbottom TRUE\n");
        self.touch = SUB_Null;
        self.think = spid_run1;
        self.nextthink = time + 0.1;
        return;
    }

    if (self.flags & FL_ONGROUND)
    {
        bprint (" grounded\n");
        self.touch = SUB_Null;
        self.think = spid_run1;
        self.nextthink = time + 0.1;
        return;
    }

    if (other.takedamage)
    {
        bprint (" other.takedamage 2 \n");
        self.touch = SUB_Null;
        self.think = spid_run1;
        self.nextthink = time + 0.1;
        return;
    }

    bprint (" I'm gonna climb!\n");

    self.touch = SUB_Null;
    //self.movetype = MOVETYPE_FLY;
    makevectors (self.angles);
    self.velocity = v_up * 400;
    ai_face();
    self.frame = $death3;
    self.think = spider_jump_from_wall;
    self.nextthink = time + 0.1;

}

//=================================================================

/*QUAKED monster_spider (1 0 0) (-32 -32 -24) (32 32 48) Ambush
*/
void() monster_spider21 =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2 ("progs/spider.mdl");
	precache_model2 ("progs/w_spike.mdl");
	
	precache_sound2 ("spider/tap.wav");
	precache_sound2 ("shalrath/attack.wav");
	precache_sound2 ("shalrath/attack2.wav");
	precache_sound2 ("demon/dhit2.wav");
	precache_sound2 ("shalrath/death.wav");
	precache_sound2 ("shalrath/idle.wav");
	precache_sound2 ("shalrath/pain.wav");
	precache_sound2 ("shalrath/sight.wav");
	
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	
	setmodel (self, "progs/spider.mdl");
	setsize (self, '-32 -32 -24', '32 32 5');
	self.health = 200;

	self.th_stand = spid_stand1;
	self.th_walk = spid_walk1;
	self.th_run = spid_run1;
	self.th_die = spider_die;
	self.th_pain = spider_pain;
//    self.th_missile = spider_attack;
	self.th_melee = spid_melee1;

    self.yaw_speed = 200;

	self.think = walkmonster_start;
	self.nextthink = time + 0.1 + random ()*0.1;	
};
