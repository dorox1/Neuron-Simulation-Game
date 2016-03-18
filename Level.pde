abstract class Level {
  
  boolean victoryFlag; //has victory been achieved?
  String levelName; //level name displayed
  String description; //text explaining victory conditions
  ArrayList<ChargeSurface> wallList = new ArrayList<ChargeSurface>(); //creates a dynamically resized list of ChargeSurface objects
  ArrayList<ConnectionPoint> connectorList = new ArrayList<ConnectionPoint>(); //creates a dynamically resized list of ConnectionPoint objects
  ArrayList<Synapse> synapseList = new ArrayList<Synapse>();
  
  Level(String name){
    levelName = name;
    //mostly blank constructor for sublevels to build off of
  }
  
  Level(String name, ArrayList<ChargeSurface> walls, ArrayList<ConnectionPoint> connectors, ArrayList<Synapse> synapses) {
    
    levelName = name;
    wallList = walls;
    connectorList = connectors;
    synapseList = synapses;
    
  }
  
  void display() { //displays the level
    
    for(int i = 0; i < wallList.size(); i++){ //goes through all walls in the array
      ChargeSurface wall = wallList.get(i); //gets the wall at index i
      wall.display(); //displays the wall at index i
    }
    for(int i = 0; i < connectorList.size(); i++){
      ConnectionPoint con = connectorList.get(i);
      con.display();
    }
    for(int i = 0; i < synapseList.size(); i++){
      Synapse syn = synapseList.get(i);
      syn.display();
    }
    
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(32);
    fill(150);
    textFont(titleFont);
    text(levelName, 400, 45);
    
  }
  
  void diffuse() { //calls all diffusion methods and disperse methods for walls and connection points
  
    for(int i = 0; i < wallList.size(); i++){ //goes through all walls in the level
      ChargeSurface wall = wallList.get(i); //gets the wall at index i
      wall.update(); //diffuses charge
    }

    for(int i = 0; i < connectorList.size(); i++){ //goes through all connection points
      ConnectionPoint con = connectorList.get(i); //gets the connection point at index i
      con.diffuse(); //diffuses charge
    }
    for(int i = 0; i < synapseList.size(); i++){ //goes through all connection points
      Synapse syn = synapseList.get(i); //gets the connection point at index i
      if(syn.selfActivating == true) syn.clicked(); //activates all self-activating synapses each frame
    }
    
  
  }
  
  void clicked() { //checks if anything is being clicked
    
    for(int i = 0; i < synapseList.size(); i++){
      Synapse syn = synapseList.get(i);
      if(dist(mouseX, mouseY, syn.location.x, syn.location.y) <= synapseSize){
        syn.clicked();
      }
    }
    
  }
  
  boolean victoryConditions(){ 
    if(victoryFlag) return true;
    else return false;
  }
  
  void assembleNeuron(){ //changes the visibility of charge surfaces to look correct
    
    
    
  }
  
}