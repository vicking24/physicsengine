//Victoria 
// Jan 27

//video: 21 FBomb

import fisica.*;

PImage map;
int x, y, vx=0;
color black =color (0, 0, 0);
color green = color (34, 177, 76);
color red= color (255, 0, 0);
color grey= color (127, 127, 127);
int gridsize=30;

FBomb bomb=null;

boolean up, down, left, right, w, s, d, a, zha;

ArrayList <FBox> boxes;

FWorld world;
FCircle lplayer, rplayer;

void setup () {
  size (800, 800);
Fisica.init (this);
world = new FWorld (-1000,-1000, 10000, 10000); //top left, bottom right
world.setGravity (0, 900);

boxes= new ArrayList();

textAlign (CENTER, CENTER);

map=loadImage ("map.png");

while ( y< map.height) {

  color c= map.get (x,y);
  
  if (c==black) {
  FBox b = new FBox(gridsize, gridsize);
  b.setFillColor (black);
  b.setPosition (x*gridsize, y*gridsize);
  b.setStatic (true);
  boxes.add (b);
  world.add (b);
  
  }
  
  if (c==green) {
  FBox grass= new FBox (gridsize, gridsize);
  grass.setFillColor (green);
  grass. setNoStroke ();
  grass.setPosition (x*gridsize, y*gridsize);
  grass.setStatic (true);
  boxes.add (grass);
  world.add (grass);
  }
  
  if (c==grey) {
  FBox border= new FBox (gridsize, gridsize);
  border.setFillColor (black);
  border.setPosition (x*gridsize, y*gridsize);
  border.setStatic (true);
  world.add (border);
  }
  
  
  
  x++;
  
  if (x==map.width) {
  x=0;
  y++; 
  }

}

//lplayer();
rplayer();

}



void draw () {
 background (255);
  
  pushMatrix();
  translate (-rplayer.getX()+width/2, -rplayer.getY()+height/2);
world.step();
world.draw ();
popMatrix();

if (left) vx=-150;
if (right) vx=150;
rplayer.setVelocity (vx, rplayer.getVelocityY());

ArrayList <FContact> rcontact= rplayer.getContacts();
if (rcontact.size() >0 && up) rplayer.setVelocity (rplayer.getVelocityX(), -600);

if (zha && bomb==null) {
bomb=new FBomb ();
}

if (bomb!=null) bomb.act();

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
  if (key== '0') zha=true;
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
   if (key== '0') zha=false;
  if (key =='w') w=false;
  if (key =='s') s=false;
  if (key =='a') a=false;
  if (key =='d') d=false;
}
