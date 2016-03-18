class testLevel extends Level {
  
  testLevel(){
    
    super("Level 1");
    
    CellBody body = new CellBody(35, 350, 300, 250, 150);
    Vect2 body0 = body.chargePoint(0);
    Axon theaxon = new Axon(80, 25, 100, body0.x, body0.y, 150, 0); //axon
    
    Vect2 body20 = body.chargePoint(20);
    CellWall dendrite1 = new CellWall(20, body20.x, body20.y, -170, 0);
    Vect2 body27 = body.chargePoint(27);
    CellWall dendrite2 = new CellWall(20, body27.x, body27.y, -150, -100);
    Vect2 body14 = body.chargePoint(14);
    CellWall dendrite3 = new CellWall(20, body14.x, body14.y, -120, 100);
    
    Vect2 d11 = dendrite1.chargePoint(14);
    CellWall dendrite11 = new CellWall(10, d11.x, d11.y, -50, 80);
    Vect2 d12 = dendrite1.chargePoint(6);
    CellWall dendrite12 = new CellWall(10, d12.x, d12.y, -68, -40);
    Vect2 d21 = dendrite2.chargePoint(10);
    CellWall dendrite21 = new CellWall(10, d21.x, d21.y, 20, -80);
    
    ConnectionPoint con1 = new ConnectionPoint(body, dendrite1, 20, 0);
    ConnectionPoint con2 = new ConnectionPoint(body, dendrite2, 27, 0);
    ConnectionPoint con3 = new ConnectionPoint(body, dendrite3, 14, 0);
    ConnectionPoint con11 = new ConnectionPoint(dendrite1, dendrite11, 14, 0);
    ConnectionPoint con12 = new ConnectionPoint(dendrite1, dendrite12, 6, 0);
    ConnectionPoint con21 = new ConnectionPoint(dendrite2, dendrite21, 10, 0);
    ConnectionPoint conax = new ConnectionPoint(body, theaxon, 0, 0);
    
    Synapse syn11 = new Synapse(dendrite11, 7, maxCharge, 5000, 5000);
    Synapse syn12 = new Synapse(dendrite12, 5, maxCharge, 5000, 5000);
    Synapse syn21 = new Synapse(dendrite21, 3, maxCharge, 5000, 5000);
    Synapse syn3 = new Synapse(dendrite3, 7, maxCharge, 5000, 5000);
    
    ArrayList<ChargeSurface> thewalls = new ArrayList<ChargeSurface>();  
    thewalls.add(dendrite21);
    thewalls.add(dendrite12);
    thewalls.add(dendrite11);
    thewalls.add(dendrite3);
    thewalls.add(dendrite2);
    thewalls.add(dendrite1);
    thewalls.add(theaxon);
    thewalls.add(body);
    //adds walls to the walls list to prepare for level creation
    ArrayList<ConnectionPoint> connectorlist = new ArrayList<ConnectionPoint>();
    connectorlist.add(con1);
    connectorlist.add(con2);
    connectorlist.add(con3);
    connectorlist.add(con11);
    connectorlist.add(con12);
    connectorlist.add(con21);
    connectorlist.add(conax);
    //adds connectors to the list to prep level creation
    ArrayList<Synapse> synapses = new ArrayList<Synapse>();
    synapses.add(syn11);
    synapses.add(syn12);
    synapses.add(syn21);
    synapses.add(syn3);
    
    
    //adds synapses to the list
    
    wallList = thewalls;
    connectorList = connectorlist;
    synapseList = synapses;
    
  }
  
  boolean victoryConditions(){ //checks if the level is complete
    if(victoryFlag) return true; // if level is beat, does not recheck
    Axon axon = (Axon)wallList.get(6);
    if(axon.apFlag){
      victoryFlag = true;
    }
    return false;
  }
  
}