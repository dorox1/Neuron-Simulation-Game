//an elliptical cell body
//charge array starts and ends at the right side, going clockwise around it

class CellBody extends ChargeSurface {
  
  final int nucleusSize = 20;
  final color cellColour = color(204,153,255);
  final color nucleusColour = color(102,0,204);
  Vect2 location; //the center of the cell body
  float wide; //width of the cell body
  float high; //height of the cell body
              //seperate width and height allow for non-round cell bodies
  Vect2 nucleus; //the location of the nucleus relative to the cell body

  
  
  CellBody(int si, float x, float y, float wi, float hi){
    super(si);
    location = new Vect2(x,y);
    wide = wi;
    high = hi;
    nucleus = new Vect2(random(0.5*wide)-(0.25*wide), random(0.5*high)-0.25*high);
  }
  
  void display() {
      
    float progress = 0; //stores the progress of the first point of the drawn wall segment in Pi Radians
    float nextProgress = (1.0/charge.length)*TWO_PI; //stores the progress of the second point of the drawn wall segment in Pi Radians
    float progressStep = (1.0/charge.length)*TWO_PI; //stores the progress made each step
    
    noStroke();
    fill(204,153,255);
    //println(hex(g.fillColor,6)+ " 1");
    ellipse(location.x, location.y, wide, high);
    //println(hex(g.fillColor,6)+" 2");
    //draws the inside of the cell body
    
    strokeWeight(1);
    //println(hex(g.fillColor,6)+" 3");
    fill(102,0,204);
    //I have no idea why, but the above line changes the fill colour of the cell body (line 34).
    //As far as I can tell there is no reason for this, and tests on line 33 and 35 both say this isn't the fill colour when that ellipse is drawn
    ellipse(location.x+nucleus.x, location.y+nucleus.y, nucleusSize, nucleusSize);
    fill(204,153,255);
    //adding this line afterwards appears to change the colour back for the second ellipse
    //the second ellipse is not displayed if it overlaps the first, implying the nucleus is drawn first
    //this makes absolutely no sense
    //even switching the order in which these are drawn does not change this
    //println(hex(g.fillColor,6)+" 4");
    strokeWeight(wallThickness);
    //draws the nucleus
    
      for (int i = 0; i < charge.length; i++) {
      //moves along the line, segment by segment
        if (charge[i] >= 0 && charge[i] <= maxCharge) {
          stroke(charge[i], 0, 0);
        }
        else if (charge[i] < 0 && charge[i] >= -1*maxCharge) {
          stroke(0, 0, -1*charge[i]);
        }
        //updates the color to be red or blue with the positive or negative intensity of (i)
        strokeWeight(wallThickness);
        arc(location.x, location.y, wide, high, progress, nextProgress);
        progress = nextProgress;
        nextProgress += progressStep;
        //draws the outside wall of the cell body, by drawing arcs that represent segments of charge
      }
      
    
      
  }
  
  void update() {
    this.diffuse();
    if (step == 1){
      this.disperse();
      //println("dispersed");
    }
  }
  
  void diffuse() { //slowly allows charge to propagate along the cell wall
    
    if (charge[0] > charge[1]){ //checks charge at 0 seperately from other charges for coding simplicity
      charge[0] -= chargeDiffusionRate;
      charge[1] += chargeDiffusionRate;  
    }
    if (charge[charge.length-1] > charge[charge.length-2]){ //checks charge at the end point seperately from other charges for coding simplicity
      charge[charge.length-1] -= chargeDiffusionRate;
      charge[charge.length-2] += chargeDiffusionRate;  
    }
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //the following statement diffuse charge across the two "ends" of the loop, closing it
    //only for CellBody objects
    
    if (charge[charge.length-1] > charge[0]){
      charge[charge.length-1] -= chargeDiffusionRate;
      charge[0] += chargeDiffusionRate;
    }
    if (charge[charge.length-1] < charge[0]){
      charge[charge.length-1] += chargeDiffusionRate;
      charge[0] -= chargeDiffusionRate;
    }
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    for (int i = 1; i < charge.length-1; i++) { //checks charge at each location, and compares to the charges before and after it
      if (charge[i] > charge[i-1] && charge[i] > charge[i+1]) {//if both charges are lower than charge[i], diffuses in both direction
        charge[i+1] += chargeDiffusionRate;
        charge[i-1] += chargeDiffusionRate;
        charge[i] -= 2*chargeDiffusionRate;
      }
    }
    for (int i = 1; i < charge.length-1; i++) {
      if (charge[i] <= charge[i-1] && charge[i] > charge[i+1]) { //if charge is only greater to the right...
        charge[i+1] += chargeDiffusionRate;
        charge[i] -= chargeDiffusionRate;
      }
    }
    for (int i = charge.length-2; i > 1; i--) {
      if (charge[i] > charge[i-1] && charge[i] <= charge[i+1]) { //if charge is greater only to the left...
        charge[i-1] += chargeDiffusionRate;
        charge[i] -= chargeDiffusionRate;
      }
    }
    
  }
  
  void disperse(){
    //all charges move toward zero over time
    for (int i = 0; i < charge.length; i++) {
      if (charge[i] > 0) {
          charge[i] -= decayRate;
      }
      else if (charge[i] < 0) {
          charge[i] += decayRate;
      }
    }
  }
  
  Vect2 chargePoint(int z){ //returns a vector representing the location of charge[x]
  
    if(z<0 || z>=size){
     println("chargePoint["+z+"] called. " + z + " is not in the range of this cell body.");
     return null;
    }
    else {
     Vect2 result = location;
     float distance = (1.0/charge.length)*float(z)*TWO_PI;
     println("distance = " + distance);
     float ePX = (float) (wide/2 * Math.cos(distance));
     println("ePX = " + ePX);
     float ePY = (float) (high/2 * Math.sin(distance));
     println("ePY = " + ePY);
     Vect2 added = new Vect2(ePX, ePY);
     return(result.added(added));
    }
  }
  
}