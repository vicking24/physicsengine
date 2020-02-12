class FBomb extends FBox {
  int timer;
  

  FBomb () {
    super (gridsize/1.5, gridsize/1.5); //FBox
    timer=60;
    this.setFillColor (red);
    this.setPosition (rplayer.getX()+gridsize, rplayer.getY());
    world.add(this);
    
  }
  
  void act () {
  timer--;
   pushMatrix();
  translate (-rplayer.getX()+width/2, -rplayer.getY()+height/2);
  fill (black);
  textSize (15);
  text (""+timer, this.getX(), this.getY());
  popMatrix();
  
  if (timer<0){
  explode();
  world.remove (this);
  bomb=null;
  }
  
  }
  
  void explode() {
  int i=0;
  while (i<boxes.size()) {
  FBox b= boxes.get (i);
  if (dist (this.getX(), this.getY(), b.getX(), b.getY ()) <gridsize*5) {
    float vx= (b.getX()-this.getX())*2; //exploading, if want it to suck the grid like a blackhole, reverse the equation
    float vy= (b.getY()-this.getY())*2;
    b.setVelocity (vx*3, vy*3);
  b.setStatic (false);

  }
  i++;
  }
 
  
  
  }
  
}
