# Project-1---Creature

My program features 3 different creatures which perform actions based on user inputs.

The main creature is the one that spawns on startup() and will be refered to simply as creature ghoing forward.
The second are the worms which is refered to as "food" throughout the program and the third are the creatureChibis which will be refered to as chibis.

First, let's go over some general information:

- All visual assets were drawn my myself, apart from the background
- All creature sounds were created by meyself
- The background music was cut from an over hour long YouTube video
- The window is able to be resized without issue
- The cursor has been changed to a custom asset
- You are able to exit the program using the ESC key
- On startup(), the cursor will never be on window. This allows for the effect that the user will always choose the initial location of the cursor on screen and the the Creature   will never be able to interact with the cursor on startup() without input from the user

Regarding the Creature:

- The creature will always spawn in a random location on screen
- The creature attempt to run away from the cursor if the user comes too close
- The longer the creature is bothered by the user, the graeter the chance the creature will run off screen
- The creature will never choose to run off screen first
- If the creature runs off screen, it will jumpscare the user and become infuriated, moving around the screen
- If the creature position moves slightly off screen but returns on screen, the jumpscare will not occur
- The creature is able to eat the worms if he is not bothered
- Eating worms causes the creature to "gulp"
- The creture will also not attempt to eat the worms if they are under the protection of (close to) the cursor
- Likewise, worms cannot spawn within a certain distance of the creature
- If there are worms on the screen but the creature is bothered/enraged/infuriated, he will be unable to eat the worms
- The creature's face and sound change based on his emotion
- Eating worms will increase the size of the creature
- If the creature eats too many worms, he will become bloated and sick
- When sick, the creature will "poop" out chibis and shake
- "Pooping" out all the chibis will return the creature to being healthy

Regarding the Worms:

- The worms spawn based on when the user clicks with the mouse
- The worms cannot spawn within a certain distance of the creature
- The worms will turn to face towards the creature
- If the creature gets close to the worms or if the creature is bothered or enraged, the worms become scared
- The worms scared sound will only play once when they get scared, not continually. The worms can get scared again if the creature leaves the "scared" distance but comes back
- Worms will make a death sound if eaten
- Worms come in different sizes
- Worms expression changes based on emotion
- Worms are not scared of the chibis since the chibis are small

Regarding the Chibis:

- The chibis spawn when the creature is sick
- The chibis will always move to a random location off screen in all four directions
- The chibis make mini creature noises
- The chibis are agitated after spawning 


Other functions pretaining to the program and the code can be found in the code comments. 

***The program will require the Official Processing Foundation Sound Library whcih can be found in the library manager.*** 
