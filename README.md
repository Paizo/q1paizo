# q1paizo

embarrassing quake 1 QuakeC experiments to satisfy my curiosity
https://github.com/Paizo/q1paizo

aka: never finish anything and produce gibberish stuff

most of the experiments are unfinished, abandoned or waiting to be picked up again..one day

### How to Run
compile and do it yourself!

You may find a working artifacts in the [action tab](https://github.com/Paizo/q1paizo/actions), 
unzip it in your quake folder and run the game with `-game q1paizo` and load a test map of your choice.

## Unfinished Experiments

#### Monster Spider 
 - Entity classname `monster_spider21`
 - test map `spidertest`
 - randomly climb walls and jump around
 - both melee and wiz missile attack
 - WHY? attempt to use more the walls and vertical movements
 - model/sound from https://www.quaddicted.com/files/idgames2/quakec/monsters/spider21.zip 

#### Monster Jumper Fish
- Entity classname `monster_jumperfish`
- test map `jumperfishtest`
- fish that can jump in/out from water/lava
  - when in water behave like a vanilla monster fish, may jump towards the player
  - when outside the water will keep jumping around
  - basically it adds/remove the `FL_SWIM` flag and remove `FL_ONGROUND` as necessary
- WHY? Strange stuff can be done, same monsters that can swim/walk/fly ... surprise player with behavior out of the ordinary q1
- based on vanilla fish monster

#### Monster Boid
- Entity classname `monster_boid`
- test map `boidtest`
- Boids in Quake!
- Flying fishes that behave like a flock
- WHY? Same as monster twin, trying to explore monsters coordination or for props usage
- Status: not really working, still getting weird results using `self.velocity`

#### BSP as model experiment
- Entity classname `item_bbox`
- test map `modelboxtest`
- WHY? Testing what is possible with BSP models instead of MDL ones

#### Write text with particles experiment
- Entity classname `particleText`
- test map `particleText`
- WHY? Testing what is possible with the quake particle system, like writing text with it
- Status: failure

#### Monster Twin
- Entity classname `monster_twin`
- test map `monstertwin`
- monsters that coordinate with each other
- WHY? attempt to make more interesting monsters
- Status: there is nothing but the idea, I don't want to add extra fields to the entities as of now


###FGD file creation for Trenchbroom

sample:

    @PointClass base(Monster) size(-16 -16 -24, 16 16 40) model({ "path": ":progs/soldier.mdl" }) = monster_army : "Grunt" []

### useful commands
####Mark V

 - entity info in game: `tool_inspector`
 - texture info in game: `tool_texturepointer`
 - lock monsters for screenshots/debug: `sv_freezenonclients 1`
 - install maps from quaddicted: `install mapName`

### Credits

 - QC sources based on https://github.com/Jason2Brownlee/CleanFixedQuakeC
 - added/modified content from https://www.quaddicted.com/files/idgames2/quakec/monsters/spider21.zip