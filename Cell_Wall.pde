/*
Walls should always be drawn from closest to the cell body to farther away, for consistency
*/

class CellWall extends ChargeSurface{
  Vect2 xy1; //wall start
  Vect2 xy2; //vector representing the direction and length of the wall
  
  CellWall(int si, float x1, float y1, float x2, float y2) {
    //initializes a cell wall object
    super(si);
    
    //sets the array of charges to initial values
    xy1 = new Vect2(x1, y1);
    xy2 = new Vect2(x2, y2); //sets the start and end point of the wall
    
    
  }
  
  void display() {
      
    float progress = 0; //stores the progress of the first point of the drawn segment as a decimal
    float nextProgress = 1.0/charge.length; //stores the progress of the second point of the drawn segment as a decimal
    
      for (int i = 0; i < charge.length; i++) {
      //moves along the line, segment by segment
        if (charge[i] >= 0 && charge[i] <= maxCharge) {
          stroke(charge[i], 0, 0);
        }
        else if (charge[i] < 0 && charge[i] >= -1*maxCharge) {
          stroke(0, 0, -1*charge[i]);
        }
        //updates the color to be red or blue with the positive or negative intensity of (i)
        
        
        strokeWeight(10);
        line(xy1.x+(xy2.x*progress), xy1.y+(xy2.y*progress), xy1.x+(xy2.x*nextProgress), xy1.y+(xy2.y*nextProgress)); //draws the line segment by scaling xy2 according to progress to determine start and end points
        progress = nextProgress;
        nextProgress = float(i+1)/charge.length; //updates progress and nextProgress
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
  
  void alterCharge(int position, int value){
    //changes the charge at a given position
    if ((position < charge.length) && (position >= 0) && (value <= maxCharge) && (value >= -maxCharge)){
    this.charge[position] = value;
    }
    else {
      println("Error: charge alteration involving invalid position or value");
    }
    //changes charge[i] to value if arguments are valid, displays error otherwise
  }
  
  Vect2 endPoint(){ //returns the end point of the cell wall
    return(xy1.added(xy2));
  }
  
  Vect2 startPoint(){ //returns the starting point of the cell wall
    return(xy1);
  }
  
  Vect2 chargePoint(int z){ //returns a vector representing the location of charge[x]
  
    if(z<0 || z>=size){
     println("chargePoint["+z+"] called. " + z + " is not in the range of this wall.");
     return null;
    }
    else {
     Vect2 result = new Vect2(xy1.x, xy1.y);
     float distance = (1.0/charge.length)*float(z);
     Vect2 added = xy2.scaled(distance);
     return(result.added(added));
    }
  }
  
}