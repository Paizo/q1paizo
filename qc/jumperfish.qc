/*  Copyright (C) 1996-1997  Id Software, Inc.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

    See file, 'COPYING', for details.
*/

/*
==============================================================================

FISH (Rotfish)

==============================================================================
*/

$cd id1/models/fish
$origin 0 0 24
$base base
$skin skin

$frame attack1 attack2 attack3 attack4 attack5 attack6
$frame attack7 attack8 attack9 attack10 attack11 attack12 attack13
$frame attack14 attack15 attack16 attack17 attack18

$frame death1 death2 death3 death4 death5 death6 death7
$frame death8 death9 death10 death11 death12 death13 death14 death15
$frame death16 death17 death18 death19 death20 death21

$frame swim1 swim2 swim3 swim4 swim5 swim6 swim7 swim8
$frame swim9 swim10 swim11 swim12 swim13 swim14 swim15 swim16 swim17
$frame swim18

$frame pain1 pain2 pain3 pain4 pain5 pain6 pain7 pain8
$frame pain9


void() jf_keepSwimmingAndUnground;
void() jf_jumpAttack;


void() jf_stand1  =[      $swim1, jf_stand2 ] {
    ai_stand();
};
void() jf_stand2  =[      $swim2, jf_stand3 ] {ai_stand();};
void() jf_stand3  =[      $swim3, jf_stand4 ] {ai_stand();};
void() jf_stand4  =[      $swim4, jf_stand5 ] {ai_stand();};
void() jf_stand5  =[      $swim5, jf_stand6 ] {ai_stand();};
void() jf_stand6  =[      $swim6, jf_stand7 ] {ai_stand();};
void() jf_stand7  =[      $swim7, jf_stand8 ] {ai_stand();};
void() jf_stand8  =[      $swim8, jf_stand9 ] {ai_stand();};
void() jf_stand9  =[      $swim9, jf_stand10  ] {ai_stand();};
void() jf_stand10 =[      $swim10, jf_stand11 ] {ai_stand();};
void() jf_stand11 =[      $swim11, jf_stand12 ] {ai_stand();};
void() jf_stand12 =[      $swim12, jf_stand13 ] {ai_stand();};
void() jf_stand13 =[      $swim13, jf_stand14 ] {ai_stand();};
void() jf_stand14 =[      $swim14, jf_stand15 ] {ai_stand();};
void() jf_stand15 =[      $swim15, jf_stand16 ] {ai_stand();};
void() jf_stand16 =[      $swim16, jf_stand17 ] {ai_stand();};
void() jf_stand17 =[      $swim17, jf_stand18 ] {ai_stand();};
void() jf_stand18 =[      $swim18, jf_stand1 ] {ai_stand();};

void() jf_walk1  =[      $swim1, jf_walk2 ] {
    jf_keepSwimmingAndUnground();
    ai_walk(8);
};
void() jf_walk2  =[      $swim2, jf_walk3 ] {ai_walk(8);};
void() jf_walk3  =[      $swim3, jf_walk4 ] {ai_walk(8);};
void() jf_walk4  =[      $swim4, jf_walk5 ] {ai_walk(8);};
void() jf_walk5  =[      $swim5, jf_walk6 ] {ai_walk(8);};
void() jf_walk6  =[      $swim6, jf_walk7 ] {ai_walk(8);};
void() jf_walk7  =[      $swim7, jf_walk8 ] {ai_walk(8);};
void() jf_walk8  =[      $swim8, jf_walk9 ] {ai_walk(8);};
void() jf_walk9  =[      $swim9, jf_walk10  ] {ai_walk(8);};
void() jf_walk10 =[      $swim10, jf_walk11 ] {ai_walk(8);};
void() jf_walk11 =[      $swim11, jf_walk12 ] {ai_walk(8);};
void() jf_walk12 =[      $swim12, jf_walk13 ] {ai_walk(8);};
void() jf_walk13 =[      $swim13, jf_walk14 ] {ai_walk(8);};
void() jf_walk14 =[      $swim14, jf_walk15 ] {ai_walk(8);};
void() jf_walk15 =[      $swim15, jf_walk16 ] {ai_walk(8);};
void() jf_walk16 =[      $swim16, jf_walk17 ] {ai_walk(8);};
void() jf_walk17 =[      $swim17, jf_walk18 ] {ai_walk(8);};
void() jf_walk18 =[      $swim18, jf_walk1 ] {ai_walk(8);};

void() jf_run1  =[      $swim1, jf_run2 ]
{
    jf_keepSwimmingAndUnground();
	ai_run(12);
	if (random() < 0.5)
		sound (self, CHAN_VOICE, "fish/idle.wav", 1, ATTN_NORM);
};
void() jf_run2  =[      $swim3, jf_run3 ] {ai_run(12);};
void() jf_run3  =[      $swim5, jf_run4 ] {ai_run(12);};
void() jf_run4  =[      $swim7, jf_run5 ] {ai_run(12);};
void() jf_run5  =[      $swim9, jf_run6 ] {ai_run(12);};
void() jf_run6  =[      $swim11, jf_run7 ] {ai_run(12);};
void() jf_run7  =[      $swim13, jf_run8 ] {ai_run(12);};
void() jf_run8  =[      $swim15, jf_run9 ] {ai_run(12);};
void() jf_run9  =[      $swim17, jf_run1 ] {ai_run(12);};

void() jfish_melee =
{
	local vector delta;
	local float ldmg;

	if (!self.enemy)
		// removed before stroke
		return;

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 60)
		return;

	sound (self, CHAN_VOICE, "fish/bite.wav", 1, ATTN_NORM);
	ldmg = (random() + random()) * 3;
	T_Damage (self.enemy, self, self, ldmg);
};

void() jf_attack1        =[      $attack1,       jf_attack2 ] {
    jf_keepSwimmingAndUnground();
    ai_charge(10);
};
void() jf_attack2        =[      $attack2,       jf_attack3 ] {ai_charge(10);};
void() jf_attack3        =[      $attack3,       jf_attack4 ] {jfish_melee();};
void() jf_attack4        =[      $attack4,       jf_attack5 ] {ai_charge(10);};
void() jf_attack5        =[      $attack5,       jf_attack6 ] {ai_charge(10);};
void() jf_attack6        =[      $attack6,       jf_attack7 ] {ai_charge(10);};
void() jf_attack7        =[      $attack7,       jf_attack8 ] {ai_charge(10);};
void() jf_attack8        =[      $attack8,       jf_attack9 ] {ai_charge(10);};
void() jf_attack9        =[      $attack9,       jf_attack10] {jfish_melee();};
void() jf_attack10       =[      $attack10,      jf_attack11] {ai_charge(10);};
void() jf_attack11       =[      $attack11,      jf_attack12] {ai_charge(10);};
void() jf_attack12       =[      $attack12,      jf_attack13] {ai_charge(10);};
void() jf_attack13       =[      $attack13,      jf_attack14] {ai_charge(10);};
void() jf_attack14       =[      $attack14,      jf_attack15] {ai_charge(10);};
void() jf_attack15       =[      $attack15,      jf_attack16] {jfish_melee();};
void() jf_attack16       =[      $attack16,      jf_attack17] {ai_charge(10);};
void() jf_attack17       =[      $attack17,      jf_attack18] {ai_charge(10);};
void() jf_attack18       =[      $attack18,      jf_run1    ] {ai_charge(10);};

void() jf_jump6;
void() jf_jump1  =[      $swim1, jf_jump2 ] {
//    jf_keepSwimmingAndUnground();
};
void() jf_jump2  =[      $swim4, jf_jump3 ] {
//    jf_keepSwimmingAndUnground();
};
void() jf_jump3  =[      $swim8, jf_jump4 ] {
//    jf_keepSwimmingAndUnground();
};
void() jf_jump4 =[      $swim12, jf_jump5 ] {
//    jf_keepSwimmingAndUnground();
};
void() jf_jump5 =[      $swim16, jf_jump6 ] {
//    jf_keepSwimmingAndUnground();
};
void() jf_jump6 =
{
    if (self.health < 0)
        return;

    self.frame= $swim18;
    self.nextthink = time + 0.1;
//    jf_keepSwimmingAndUnground();

    local float content;
    content = pointcontents(self.origin);

    if (CONTENT_WATER == content) {
        bprint ("end in water\n");
        self.flags = self.flags + FL_SWIM;
        if (self.flags & FL_ONGROUND)
            self.flags = self.flags - FL_ONGROUND;
        self.think = jf_run1;
        return;
    }
    //TODO slime lava

    if (self.flags & FL_ONGROUND) {
        bprint ("end on ground\n");
        self.think = jf_jumpAttack;
        return;
    }

    if (CONTENT_SLIME == content || CONTENT_LAVA == content) {
        bprint ("lava slime\n");
        self.think = jf_jumpAttack;
        return;
    }
    bprint ("unknown end\n");
    self.think = jf_run1;

//    if (       CONTENT_WATER  == content
//            || CONTENT_SLIME  == content
//            || CONTENT_LAVA  == content) {


//    self.nextthink = time + 0.1;
//    if (self.flags & FL_SWIM) {
//        bprint ("back to normal\n");
//        self.think = jf_run1;
//        return;
//    }
//
//    //still inflight, looping
//    self.think = jf_jump1;
};

void() jf_death1 =[      $death1,        jf_death2        ]
{
	sound (self, CHAN_VOICE, "fish/death.wav", 1, ATTN_NORM);
};
void() jf_death2 =[      $death2,        jf_death3        ] {self.solid = SOLID_NOT;};
void() jf_death3 =[      $death3,        jf_death4        ] {};
void() jf_death4 =[      $death4,        jf_death5        ] {};
void() jf_death5 =[      $death5,        jf_death6        ] {};
void() jf_death6 =[      $death6,        jf_death7        ] {};
void() jf_death7 =[      $death7,        jf_death8        ] {};
void() jf_death8 =[      $death8,        jf_death9        ] {};
void() jf_death9 =[      $death9,        jf_death10       ] {};
void() jf_death10 =[      $death10,       jf_death11       ] {};
void() jf_death11 =[      $death11,       jf_death12       ] {};
void() jf_death12 =[      $death12,       jf_death13       ] {};
void() jf_death13 =[      $death13,       jf_death14       ] {};
void() jf_death14 =[      $death14,       jf_death15       ] {};
void() jf_death15 =[      $death15,       jf_death16       ] {};
void() jf_death16 =[      $death16,       jf_death17       ] {};
void() jf_death17 =[      $death17,       jf_death18       ] {};
void() jf_death18 =[      $death18,       jf_death19       ] {};
void() jf_death19 =[      $death19,       jf_death20       ] {};
void() jf_death20 =[      $death20,       jf_death21       ] {};
void() jf_death21 =[      $death21,       jf_death21       ] {};

/* Handle fish death, either die animation or gib. */
void() jfish_die =
{
	// check for gib death
	if (self.health < -20)
	{
		// play gib sound
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		// can't call ThrowHead so remove the entity on the next think
		self.think = SUB_Remove;
		self.nextthink= time + 0.1;
		// throw some normal gibs
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	// run normal death animation
	jf_death1();
};

void() jf_pain1  =[      $pain1, jf_pain2 ] {};
void() jf_pain2  =[      $pain2, jf_pain3 ] {ai_pain(6);};
void() jf_pain3  =[      $pain3, jf_pain4 ] {ai_pain(6);};
void() jf_pain4  =[      $pain4, jf_pain5 ] {ai_pain(6);};
void() jf_pain5  =[      $pain5, jf_pain6 ] {ai_pain(6);};
void() jf_pain6  =[      $pain6, jf_pain7 ] {ai_pain(6);};
void() jf_pain7  =[      $pain7, jf_pain8 ] {ai_pain(6);};
void() jf_pain8  =[      $pain8, jf_pain9 ] {ai_pain(6);};
void() jf_pain9  =[      $pain9, jf_run1 ] {ai_pain(6);};

void(entity attacker, float damage)	jfish_pain =
{
	if (self.pain_finished < time) {
        jf_pain1 ();
        self.pain_finished = time + 1;
	}
};


void() jf_jumpAttack =
{
    bprint("jf_jumpAttack\n");

    if (self.health < 0)
        return;

	ai_face();
    makevectors (self.angles);

//    if (self.waterlevel >= 2) {
//        bprint ("self.waterlevel\n");
////        if (self.watertype == CONTENT_WATER)
////            self.velocity_z = 440;
////        else if (self.watertype == CONTENT_SLIME)
////            self.velocity_z = 350;
////        else
////            self.velocity_z = 200;
//    }

    self.attack_finished = time + 0.6;
	self.velocity = v_forward * 300 + '0 0 300';
	if (self.flags & FL_ONGROUND) {
	    bprint("ungrounding\n");
		self.flags = self.flags - FL_ONGROUND;
	}
	if (self.flags & FL_SWIM) {
	    bprint("un FL_SWIM\n");
		self.flags = self.flags - FL_SWIM;
	}
	self.think = jf_jump1;
	self.nextthink = time + 0.1;
};

/*
            jf_keepSwimmingAndUnground
    add FL_SWIM if needed, only after time < self.attack_finished

*/
float() jf_IsOnGround = {
    if (self.flags & FL_ONGROUND)
        return TRUE;
    if (checkbottom(self))
        return TRUE;
    return FALSE;
}
void() jf_keepSwimmingAndUnground = {
    local float content;

//    if (self.flags & FL_ONGROUND) {
//        bprint("ungrounding jf_keepSwimmingAndUnground\n");
//        self.flags = self.flags - FL_ONGROUND;
//        self.attack_finished = time; //don't wait any longer to jump
//    }
//    jf_IsOnGround()

//    if (self.velocity_z == 0) //on top of something
//        return TRUE;

    if (self.flags & FL_ONGROUND) {
        bprint("ungrounding on check\n");
        self.flags = self.flags - FL_ONGROUND;
        ai_face();
        self.think = jf_jumpAttack;
        self.nextthink = time + 0.1;
        self.attack_finished = time; //don't wait any longer to jump
        return;
    }

    if (time < self.attack_finished)
        return;

    if (self.flags & FL_SWIM)
        return;

    content = pointcontents(self.origin);

    if (       CONTENT_WATER  == content
            || CONTENT_SLIME  == content
            || CONTENT_LAVA  == content) {

        bprint("waterish\n");
        self.flags = self.flags + FL_SWIM;
    }
}

void() jf_touchAttack = {
	local	float	ldmg;

	if (self.health <= 0)
		return;

	if (other.takedamage)
	{
	    self.effects = self.effects | EF_MUZZLEFLASH;
        ldmg = 2 + 5*random();
        T_Damage (other, self, self, ldmg);
	}
}


/*QUAKED monster_jumperfish (1 0 0) (-16 -16 -24) (16 16 24) Ambush
*/
void() monster_jumperfish =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2 ("progs/fish.mdl");

	precache_sound2 ("fish/death.wav");
	precache_sound2 ("fish/bite.wav");
	precache_sound2 ("fish/idle.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/fish.mdl");

	setsize (self, '-16 -16 -24', '16 16 24');
	self.health = 25;

	self.th_stand = jf_stand1;
	self.th_walk = jf_walk1;
	self.th_run = jf_run1;
	self.th_die = jfish_die;
	self.th_pain = jfish_pain;
	self.th_melee = jf_attack1;

	self.th_missile = jf_jumpAttack;
	self.touch = jf_touchAttack;
    self.yaw_speed = 25;

	swimmonster_start ();
};
