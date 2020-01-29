//Victoria 
// Jan 27

import fisica.*;

PImage map;
int x, y, vx=0;
color black =color (0, 0, 0);
color green = color (34, 177, 76);
int gridsize=50;

boolean up, down, left, right, w, s, d, a, ljump, rjump;

FWorld world;
FCircle lplayer, rplayer;

void setup () {
  size (800, 800);
Fisica.init (this);
world = new FWorld ();
world.setGravity (0, 900);

map=loadImage ("map.png");

while ( y< map.height) {

  color c= map.get (x,y);
  
  if (c==black) {
  FBox b = new FBox(gridsize, gridsize);
  b.setFillColor (black);
  b.setPosition (x*gridsize, y*gridsize);
  b.setStatic (true);
  //b.setFriction(5);
  world.add (b);
  
  }
  
  if (c==green) {
  FBox grass= new FBox (gridsize, gridsize);
  grass.setFillColor (green);
  grass. setNoStroke ();
  grass.setPosition (x*gridsize, y*gridsize);
  grass.setStatic (true);
  world.add (grass);
  }
  
  
  
  x++;
  
  if (x==map.width) {
  x=0;
  y++; 
  }

}

lplayer();
rplayer();

}



void draw () {
 background (255);
  
world.step();
world.draw ();

if (left) vx=-100;
if (right) vx=100;
rplayer.setVelocity (vx, rplayer.getVelocityY());

ArrayList <FContact> rcontact= rplayer.getContacts();
if (rcontact.size()>0&& up) rplayer.setVelocity (rplayer.getVelocityX(), -500);

}


void lplayer() {
  lplayer= new FCircle(20);
  lplayer.setPosition (random (0, width/2), 300);

  lplayer.setFill (255, 0, 0);

  world.add (lplayer);
}

void rplayer () {
  rplayer= new FCircle(20);
  rplayer.setPosition (100, 300);
  
  rplayer.setFill (0, 255, 0);

  world.add (rplayer);
}

void keyPressed () {
  if (keyCode == UP) up=true;
  if (keyCode == DOWN) down=true;
  if (keyCode == LEFT) left=true;
  if (keyCode == RIGHT) right=true;
  if (key== '0') rjump=true;
  if (key ==' ') ljump=true;
  if (key =='w') w=true;
  if (key =='s') s=true;
  if (key =='a') a=true;
  if (key =='d') d=true;
  
}

void keyReleased () {
  if (keyCode == UP) up=false;
  if (keyCode == DOWN) down=false;
  if (keyCode == LEFT) left=false;
  if (keyCode == RIGHT) right=false;
   if (key== '0') rjump=false;
  if (key ==' ') ljump=false;
  if (key =='w') w=false;
  if (key =='s') s=false;
  if (key =='a') a=false;
  if (key =='d') d=false;
}
