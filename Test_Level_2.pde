class testLevel2 extends Level {
  
  testLevel2(){
    
    super("Level 2");
    
    CellWall wall1 = new CellWall(20, 100, 300, 210, 0); //main dendrite
    CellWall wall8 = new CellWall(15, 230, 100, 145, 145); //secondary dendrite coming off top left wall
    
    CellBody body = new CellBody(30, 450, 300, 300, 200); //cell body
    
    CellWall wall4 = new CellWall(10, 200, 250, 60, 50); //upper main dendrite branch
    CellWall wall5 = new CellWall(10, 150, 360, 100, -65); //lower main dendrite branch
    
    Axon theaxon = new Axon(80, 25, 100, 600, 300, 150, 0); //axon
    
    ConnectionPoint connector1 = new ConnectionPoint(wall1, body, 19, 15); //connect main dendrite to left half of "cell body"
    
    ConnectionPoint connector3 = new ConnectionPoint(wall4, wall1, 9, 17);
    ConnectionPoint connector4 = new ConnectionPoint(wall5, wall1, 9, 15); //connect dendrite branches to main dendrite
    
    ConnectionPoint connector8 = new ConnectionPoint(wall8, body, 14, 20); //connect secondary dendrite to cell body
    
    ConnectionPoint axonHillock = new ConnectionPoint(body, theaxon, 0, 0); //connect axon to cell body
    
    
    Synapse syn1 = new Synapse(wall4, 5, maxCharge, 20, 40);
    Synapse syn2 = new Synapse(wall5, 5, maxCharge, 20, 40);
    Synapse syn3 = new Synapse(wall8, 10, maxCharge, 20, 40);
    
    ArrayList<ChargeSurface> thewalls = new ArrayList<ChargeSurface>();  
    thewalls.add(wall1);
    thewalls.add(wall4);
    thewalls.add(wall5);
    thewalls.add(wall8);
    thewalls.add(body);
    thewalls.add(theaxon);
    //adds walls to the walls list to prepare for level creation
    ArrayList<ConnectionPoint> connectorlist = new ArrayList<ConnectionPoint>();
    connectorlist.add(connector1);
    connectorlist.add(connector3);
    connectorlist.add(connector4);
    connectorlist.add(connector8);
    connectorlist.add(axonHillock);
    //adds connectors to the list to prep level creation
    ArrayList<Synapse> synapses = new ArrayList<Synapse>();
    synapses.add(syn1);
    synapses.add(syn2);
    synapses.add(syn3);
    //adds synapses to the list
    
    wallList = thewalls;
    connectorList = connectorlist;
    synapseList = synapses;
    
  }
  
  boolean victoryConditions(){ //checks if the level is complete
    if(victoryFlag) return true; // if level is beat, does not recheck
    Axon axon = (Axon)wallList.get(5);
    if(axon.apFlag){
      victoryFlag = true;
    }
    return false;
  }
  
}