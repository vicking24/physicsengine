//Victoria 
// Jan 27

//fix animate character

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

ArrayList<PImage> megaman;
ArrayList <PImage> idler;
ArrayList <PImage> idlel;
ArrayList <PImage> jump;
ArrayList <PImage> walkleft;
ArrayList <PImage> walkright;
ArrayList <PImage> currentaction;
int costumenum=0;
int frame=0;


FWorld world;
FBox lplayer, rplayer;

void setup () {
  size (800, 800);
  Fisica.init (this);
  world = new FWorld (-1000, -1000, 10000, 10000); //top left, bottom right
  world.setGravity (0, 900);

  boxes= new ArrayList();

  textAlign (CENTER, CENTER);
  //imageMode (CENTER);

  map=loadImage ("map.png");

  while ( y< map.height) {

    color c= map.get (x, y);

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

  idler = new ArrayList <PImage> ();
  idlel= new ArrayList <PImage> ();
  jump = new ArrayList <PImage> ();
  walkleft = new ArrayList <PImage> ();
  walkright = new ArrayList <PImage> ();

  idler.add (loadImage ("megaman0.png"));
  idlel.add (loadImage ("megaman0flip.png"));
  

  walkleft.add (loadImage ("megaman3flip.png"));
  walkleft.add (loadImage ("megaman4flip.png"));
  walkleft.add (loadImage ("megaman5flip.png"));

  walkright.add (loadImage ("megaman3.png"));
  walkright.add (loadImage ("megaman4.png"));
  walkright.add (loadImage ("megaman5.png"));

  jump.add (loadImage ("megaman6.png"));
  jump.add (loadImage ("megaman7.png"));


  currentaction=idler;
}



void draw () {
  background (255);

  pushMatrix();
  translate (-rplayer.getX()+width/2, -rplayer.getY()+height/2);
  world.step();
  world.draw ();
  popMatrix();

  if (left) {
    vx=-150;
    currentaction=walkleft;
    costumenum=0;
  }
  if (right) {
    vx=150;
    currentaction=walkright;
    costumenum=0;
  }

  if (!right && !left&&vx>0) {
    currentaction=idler;
    costumenum=0;
  }
  
   if (!right && !left&&vx<0) {
    currentaction=idlel;
    costumenum=0;
  }

  rplayer.setVelocity (vx, rplayer.getVelocityY());

  ArrayList <FContact> rcontact= rplayer.getContacts();
  if (rcontact.size() >0 && up) rplayer.setVelocity (rplayer.getVelocityX(), -600);

  if (zha && bomb==null) {
    bomb=new FBomb ();
  }

  if (bomb!=null) bomb.act();

  rplayer.attachImage (currentaction.get (costumenum));


  if (frameCount%10==0) {
    costumenum++;
    if (costumenum >= currentaction.size()) {
      costumenum=0;
    }
  }
}


void lplayer() {
  lplayer= new FBox(20, 20);
  lplayer.setPosition (random (0, width/2), 300);

  lplayer.setFill (255, 0, 0);

  world.add (lplayer);
}

void rplayer () {
  rplayer= new FBox(20, 20);
  rplayer.setPosition (100, 300);

  //rplayer.setFill (0, 255, 0);

  rplayer.setRotatable (false);

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
