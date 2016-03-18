

class Axon extends ChargeSurface {
  int threshold; // firing threshold for the axon (a charge value)
  int refractoryPeriod; // minimum time between action potentials (in frames)
  int refCooldown; // tracks current refractory period
  int apProgress; // tracks the progress of an action potential
  boolean apFlag; // is an action potential currently firing?
  //int[] APcooldown; //allows the AP to move as a wave by restricting backwards flow and decay rate
  Vect2 xy1; //wall start
  Vect2 xy2; //vector representing the direction and length of the wall
  
  Axon(int si, int thr, int ref, float x1, float y1, float x2, float y2) {
    //initializes an axon object
    super(si);
    threshold = thr;
    refractoryPeriod = ref;
    apFlag = false;
    //APcooldown = new int[size];
    
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
    
    if(charge[0] >= threshold+refractoryPeriod && !apFlag){ //fires an AP if threshold is reached and an AP is not currently underway
                                                            //firing is more difficult immediately following an action potential
      apFlag = true;
      apProgress = 1;
    }
    if(refCooldown > 0 && step%5 == 0) refCooldown--; //reduces refractory period every 5 frames
    if(apFlag) actionPotential(); //runs the action potential function if the apFlag is true
    
  }
  
  void diffuse() { 
    
  }
  
  void disperse(){
    
  }
  
  void actionPotential(){
    
    for(int i = -9; i < 10; i++){ //draws the action potential as a 20-charge[] wide moving burst
      int withinBounds = apProgress + i;
      if(withinBounds >= 0 && withinBounds < size){ //checks that a value is within the charge[] array before changing charge values
        charge[apProgress+i] = maxCharge-(maxCharge/10)*abs(i);
      }
    }
    if(apProgress < size + 10) apProgress++;
    else if(apProgress >= size + 10){ //if an action potential has finished, resets the AP progress/flag and starts refractory period
      apProgress = 0;
      apFlag = false;
      refCooldown = refractoryPeriod;
    }
    
  }
  
  Vect2 chargePoint(int z){ //returns a vector representing the location of charge[x]
  
    if(z<0 || z>=size){
     println("chargePoint["+z+"] called. " + z + " is not in the range of this wall.");
     return null;
    }
    else {
     Vect2 result = new Vect2(xy1.x, xy1.y);
     float distance = ((1.0/charge.length)*float(z));
     Vect2 added = xy2.scaled(distance);
     return(result.added(added));
    }
  
  }
  
}