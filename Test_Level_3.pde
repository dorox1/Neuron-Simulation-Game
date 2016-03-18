class testLevel3 extends Level {
  
  int victoryCountdown = 500;
  int initialWait = 2100;
  
  testLevel3(){
    
    super("Level 3");
    
    CellWall wall1 = new CellWall(20, 100, 300, 210, 0); //main dendrite
    CellWall wall8 = new CellWall(15, 230, 100, 145, 145); //secondary dendrite coming off top left wall
    CellWall wall9 = new CellWall(15, 230, 450, 85, -120);
    
    CellBody body = new CellBody(20, 400, 300, 200, 150); //cell body
    
    Axon theaxon = new Axon(80, 25, 100, 500, 300, 150, 0); //axon
    
    CellWall wall4 = new CellWall(10, 200, 250, 60, 50); //upper main dendrite branch
    CellWall wall5 = new CellWall(10, 150, 360, 100, -65); //lower main dendrite branch
    
    ConnectionPoint connector1 = new ConnectionPoint(wall1, body, wall1.size-1, int((body.size/2))); //connect main dendrite to left half of "cell body"
    
    ConnectionPoint connector3 = new ConnectionPoint(wall4, wall1, 9, 17);
    ConnectionPoint connector4 = new ConnectionPoint(wall5, wall1, 9, 15); //connect dendrite branches to main dendrite
    ConnectionPoint connector5 = new ConnectionPoint(body, wall9, 16, 14);
    ConnectionPoint connector8 = new ConnectionPoint(wall8, body, 14, 13); //connect secondary dendrite to cell body
    
    ConnectionPoint connector10 = new ConnectionPoint(body, theaxon, 0, 0);
    
    
    Synapse syn1 = new Synapse(wall4, 5, maxCharge, 20, 40);
    syn1.selfActivating = true;
    Synapse syn2 = new Synapse(wall5, 5, maxCharge, 20, 40);
    syn2.selfActivating = true;
    Synapse syn3 = new Synapse(wall8, 10, -maxCharge, 20, 40);
    //syn3.clickable = false; //temporarily doensn't work
    Synapse syn4 = new Synapse(wall9, 10, -maxCharge, 20, 40);
    //syn4.clickable = false;
    
    ArrayList<ChargeSurface> thewalls = new ArrayList<ChargeSurface>();  
    thewalls.add(wall1);
    thewalls.add(wall4);
    thewalls.add(wall5);
    thewalls.add(wall8);
    thewalls.add(wall9);
    thewalls.add(body);
    thewalls.add(theaxon);
    //adds walls to the walls list to prepare for level creation
    ArrayList<ConnectionPoint> connectorlist = new ArrayList<ConnectionPoint>();
    connectorlist.add(connector1);
    connectorlist.add(connector3);
    connectorlist.add(connector4);
    connectorlist.add(connector5);
    connectorlist.add(connector8);
    connectorlist.add(connector10);
    //adds connectors to the list to prep level creation
    ArrayList<Synapse> synapses = new ArrayList<Synapse>();
    synapses.add(syn1);
    synapses.add(syn2);
    synapses.add(syn3);
    synapses.add(syn4);
    //adds synapses to the list
    
    wallList = thewalls;
    connectorList = connectorlist;
    synapseList = synapses;
    
  }
  
  boolean victoryConditions(){ //checks if the level is complete. This code is run every frame
    if(victoryFlag) return true; // if level is beat, does not recheck
    if(initialWait==1){ //enables clicking synapses at the end of the countdown
      /*Synapse s3 = synapseList.get(2);
      Synapse s4 = synapseList.get(3);
      s3.clickable = true;
      s4.clickable = true; */
      synapseList.get(2).clickable = true;
      synapseList.get(3).clickable = true;
    }
    if(initialWait > 0){ //initial wait period for lvl 3 while charge builds
      initialWait--;
      rectMode(CENTER);
      textAlign(CENTER);
      textSize(30);
      fill(150);
      textFont(titleFont);
      text("Charge building, please wait..." + int(initialWait/100), 400, height-40);
      initialWait--;
      return false;
    }
    //action-potentials must be prevented for 5 seconds to win
    Axon axon = (Axon)wallList.get(6);
    if(axon.apFlag == false) victoryCountdown--;
    else if(axon.apFlag == true) victoryCountdown = 600;
    if(victoryCountdown <= 0){
      victoryFlag = true;
      return true;
    }
    return false;
  }
  
}