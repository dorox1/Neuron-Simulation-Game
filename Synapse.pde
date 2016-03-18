class Synapse {
  
  String type;
  int chargePosition; //the position on a wall that the synapse is located at
  int chargeValue; //the value (from 255 to (-255) that the synapse assigns when clicked)
  Vect2 location; //where on the screen the synapse is displayed
  int duration; //the total duration that the synapse fires for when clicked
  int active; //tracks how long the synapse will remain active for
  int refractoryPeriod; //refractory period after clicking
  int cooldown = 0; //tracks cooldown of the refractory period
  boolean clickable; //whether or not the synapse is clickable
  ChargeSurface wall; //the wall that the synapse is connected to
  boolean selfActivating;
  
  Synapse(ChargeSurface wall1, int pos, int value, float x, float y, boolean click){ //constructor with hard-coded synapse display location
    chargePosition = pos;
    chargeValue = value;
    location = new Vect2(x,y);
    clickable = click;
    wall = wall1;
  }
  
  Synapse(CellWall wall1, int pos, int value, boolean click){ //constructor that calculates display location of the synapse, if the surface is a CellWall object
    chargePosition = pos;
    chargeValue = value;
    clickable = click;
    wall = wall1;
    
    float distance = (float(chargePosition)+0.5)/wall1.charge.length; //determines the distance along the wall to travel to reach the synapse
    float x = wall1.xy1.x+(wall1.xy2.x*distance);
    float y = wall1.xy1.y+(wall1.xy2.y*distance); //determines x and y coordiantes of the synapse
    location = new Vect2(x,y); //sets synapse location
  }
  
  Synapse(CellWall wall1, int pos, int value){ //shorthand constructor
    chargePosition = pos;
    chargeValue = value;
    clickable = true;
    wall = wall1;
    
    float distance = (float(chargePosition)-0.75)/wall1.charge.length; //determines the distance along the wall to travel to reach the synapse
    float x = wall1.xy1.x+(wall1.xy2.x*distance);
    float y = wall1.xy1.y+(wall1.xy2.y*distance); //determines x and y coordinates of the synapse
    location = new Vect2(x,y); //sets synapse location
  }
  
  Synapse(CellWall wall1, int pos, int value, int dur, int ref){ //shorthand constructor with duration and refractory period
    chargePosition = pos;
    chargeValue = value;
    clickable = true;
    wall = wall1;
    duration = dur;
    refractoryPeriod = ref;
    
    float distance = (float(chargePosition)-0.75)/wall1.charge.length; //determines the distance along the wall to travel to reach the synapse
    float x = wall1.xy1.x+(wall1.xy2.x*distance);
    float y = wall1.xy1.y+(wall1.xy2.y*distance); //determines x and y coordinates of the synapse
    location = new Vect2(x,y); //sets synapse location
  }
  
  void display(){
    
    strokeWeight(6);
    stroke(0,200,0);
    point(location.x,location.y); //draws a green point at each synapse
    if(cooldown > 0){ //ticks down the cooldown (if the synapse is in it's refractory period)
      stroke(0,0,0); //changes the ring colour if the synapse is on cooldown
      cooldown--; 
    }
    if(active > 0){ //ticks down the activation duration and sets the charge level at the synapse (if it is currently active)
      wall.charge[chargePosition] = chargeValue;
      active--; 
    }
    strokeWeight(2);
    drawRing(int(location.x),int(location.y), synapseSize, synapseSize, 50);
    
  }
  
  void clicked(){ //runs if clicked
    
    if(clickable == true && cooldown == 0){ //activates the synapse and triggers the refractory period if the synapse is clickable and not on cooldown
      wall.charge[chargePosition] = chargeValue;
      cooldown = refractoryPeriod; //starts the refractory period
      active = duration; //begins activating the synapse
    }
    
  }
  
  
}