/*
==============================================================================

BOID (Boid)

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

void() boid_ai;

void() boid_run1  =[      $swim1, boid_run2 ]
{
    boid_ai();
	if (random() < 0.2)
		sound (self, CHAN_VOICE, "fish/idle.wav", 1, ATTN_NORM);
};
void() boid_run2  =[      $swim3, boid_run3 ] {boid_ai();};
void() boid_run3  =[      $swim5, boid_run4 ] {boid_ai();};
void() boid_run4  =[      $swim7, boid_run5 ] {boid_ai();};
void() boid_run5  =[      $swim9, boid_run6 ] {boid_ai();};
void() boid_run6  =[      $swim11, boid_run7 ] {boid_ai();};
void() boid_run7  =[      $swim13, boid_run8 ] {boid_ai();};
void() boid_run8  =[      $swim15, boid_run9 ] {boid_ai();};
void() boid_run9  =[      $swim17, boid_run1 ] {boid_ai();};

void() boid_death1 =[      $death1,        boid_death2        ]
{
    self.movetype = MOVETYPE_TOSS;
	sound (self, CHAN_VOICE, "fish/death.wav", 1, ATTN_NORM);
};
void() boid_death2 =[      $death2,        boid_death3        ] {self.solid = SOLID_NOT;};
void() boid_death3 =[      $death3,        boid_death4        ] {};
void() boid_death4 =[      $death4,        boid_death5        ] {};
void() boid_death5 =[      $death5,        boid_death6        ] {};
void() boid_death6 =[      $death6,        boid_death7        ] {};
void() boid_death7 =[      $death7,        boid_death8        ] {};
void() boid_death8 =[      $death8,        boid_death9        ] {};
void() boid_death9 =[      $death9,        boid_death10       ] {};
void() boid_death10 =[      $death10,       boid_death11       ] {};
void() boid_death11 =[      $death11,       boid_death12       ] {};
void() boid_death12 =[      $death12,       boid_death13       ] {};
void() boid_death13 =[      $death13,       boid_death14       ] {};
void() boid_death14 =[      $death14,       boid_death15       ] {};
void() boid_death15 =[      $death15,       boid_death16       ] {};
void() boid_death16 =[      $death16,       boid_death17       ] {};
void() boid_death17 =[      $death17,       boid_death18       ] {};
void() boid_death18 =[      $death18,       boid_death19       ] {};
void() boid_death19 =[      $death19,       boid_death20       ] {};
void() boid_death20 =[      $death20,       boid_death21       ] {};
void() boid_death21 =[      $death21,       boid_death21       ] {};

void(entity attacker, float damage) boid_pain1  =[      $pain1, boid_pain2 ] {};
void() boid_pain2  =[      $pain2, boid_run1 ] {boid_ai();};

void() boid_die =
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
	boid_death1();
};

void() boid_ai2 =
{
	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;

    self.velocity.z = 100 * random();
    self.velocity.y = 100 * random();
    self.velocity.x = 100 * random();
    self.ideal_yaw = vectoyaw(self.velocity);
    ChangeYaw ();
}

// Clamp a value to a specified range
float(float value, float min, float max) clamp =
{
    if (value < min)
        return min;
    else if (value > max)
        return max;

    return value;
};

// Clamp a vector to specified ranges for each component
vector(vector v, float min, float max) clamp_vec =
{
    v_x = clamp(v_x, min, max);
    v_y = clamp(v_y, min, max);
    v_z = clamp(v_z, min, max);
    return v;
};

void() boid_ai =
{
	if (!walkmove(0,0))
	{
		dprint ("walkmonster: ");
		dprint (vtos(self.origin));
		dprint ("\n");
	}

	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;

    local float centeringFactor = 0.5; // Speed at which boids approach the center of all boids
    local float repulsionFactor = 5.55; // Speed at which boids turn away from each other
    local float matchingFactor = 0.005; // Percentage of neighbors' velocity that will be added to boid
    local float boidSpacing = 64; // Units between boids allowed before avoiding
    local float boidDist;

    local vector avgVel = '0 0 0';
    local vector avgOrigin = '0 0 0';
    local vector repulsion = '0 0 0';
    local vector centering = '0 0 0';

    local float c = 0.0;
    local entity e = world;

//    e = find(world, classname, "monster_boid");

//    bprint("pre vel ");
//    bprint(vtos(self.velocity));
//    bprint("\n");

    do {
//        bprint("loop");
        if ((e.classname == "monster_boid") && (e != self)) {
            c = c + 1.0;
            avgVel = avgVel + e.velocity;
            avgOrigin = avgOrigin + e.origin;
            boidDist = vlen(e.origin - self.origin);
            if (boidDist < boidSpacing)
                repulsion = repulsion + (e.origin - self.origin);
//            else
//                repulsion = (self.origin - e.origin);
        }
        e = nextent(e);
    } while(e);

//    bprint("found ");
//    bprint(ftos(c));
//    bprint(" boids\n");

    if (c > 0.0) {
        avgVel = avgVel / c;
        avgOrigin = avgOrigin / c;
    } else {
        bprint("bad else\n");
        self.velocity.z = 100 * random();
        self.velocity.y = 100 * random();
        self.velocity.x = 100 * random();
        return;
    }

    local vector alignVel;
    alignVel = (avgVel - self.velocity) * matchingFactor;

    local float distance2FlockCenter;
    distance2FlockCenter = vlen(self.origin - avgOrigin);
    if (distance2FlockCenter < boidSpacing) {
        dprint("center repulsion\n");
        repulsion = repulsion + (avgOrigin - self.origin);
    }

    centering = (avgOrigin - self.origin) * centeringFactor;
    repulsion = repulsion * repulsionFactor;

    self.velocity = self.velocity + alignVel + repulsion + centering;

//    bprint("boid self vel, alignVel + repulsion + centering ");
//    bprint (vtos(self.velocity));
//    bprint (vtos(alignVel));
//    bprint (vtos(repulsion));
//    bprint (vtos(centering));
//    bprint("\n");

//    bprint("boid self vel ");
//    bprint (vtos(self.velocity));
//    bprint("\n");


    self.velocity_x = clamp(self.velocity_x, 500, 2000);
    self.velocity_y = clamp(self.velocity_y, -1000, 1000);
    self.velocity_z = clamp(self.velocity_z, -1000, 1000);

//    self.ideal_yaw = vectoyaw(avgOrigin - self.origin);
    self.ideal_yaw = vectoyaw(self.velocity);
    ChangeYaw ();

//    bprint("post vel ");
//    bprint(vtos(self.velocity));
//    bprint("\n");

    //enemy_infront = infront(self.enemy);
    //enemy_range = range(self.enemy);

//    movetogoal (dist);
}

//void() find_boids =
//{
//    local entity e;
//    local vector avgVel = '0 0 0';
//    local vector avgYaw = '0 0 0';
//    local float c = 0.0;
//
//    if (!self.multi_ent) {
//        e = findchain(classname, "monster_boid");
//        self.multi_ent = e; //reusing shotgun specific field
//    }
//
//    dprint("existing multi_ent\n");
//    eprint(self.multi_ent);
//
//    while (e) {
//        if (e != self) {
//            avgVel = avgVel + e.velocity;
//            avgYaw = avgYaw + e.ideal_yaw;
//        }
//        c = c + 1;
//        e = e.chain;
//    }
//    //TODO division by zero
//    avgVel = avgVel / c;
//    avgYaw = avgYaw / c;
//}


/*QUAKED monster_boid (1 0 0) (-16 -16 -24) (16 16 24) Ambush
*/
void() monster_boid =
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
	self.movetype = MOVETYPE_FLYMISSILE;

	setmodel (self, "progs/fish.mdl");

	setsize (self, '-16 -16 -24', '16 16 24');
	self.health = 25;

	self.th_stand = boid_run1;
	self.th_walk = boid_run1;
	self.th_run = boid_run1;
	self.th_die = boid_die;
	self.th_pain = boid_pain1;
	self.th_melee = boid_run1;

	// custom
//	self.velocity = '0 0 0';
	self.velocity.z = 500 * random();
	self.velocity.y = 500 * random();
	self.velocity.x = 500 * random();

	if (random() < 0.5) {
        self.velocity.y = self.velocity.y * -1.0;
    }

    //snipped from flymonster_start
    self.nextthink = self.nextthink + random()*0.5;
    total_monsters = total_monsters + 1;

    //snipped from flymonster_start_go
    self.takedamage = DAMAGE_AIM;
    self.ideal_yaw = self.angles * '0 1 0';
    if (!self.yaw_speed)
        self.yaw_speed = 10;
    self.view_ofs = '0 0 25';
    self.use = monster_use;
//    self.flags = self.flags | FL_FLY;
    self.flags = self.flags | FL_MONSTER;

//    flymonster_start_go();
    self.th_run();

};
