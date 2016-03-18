//wall A should always be closer to the cell body (it should be the cell body itself, if applicable)

class ConnectionPoint { //facilitates charge diffusion between cell wall objects
  
  ChargeSurface wallA;
  ChargeSurface wallB;
  //the two cell walls being connected. A and B are arbitrary
  int positionA;
  int positionB;
  //the position in the charge[] array the the connection occurs at for each cell wall
  
  ConnectionPoint(ChargeSurface cwA, ChargeSurface cwB, int posA, int posB) {
    wallA = cwA;
    wallB = cwB;
    positionA = posA;
    positionB = posB;
  }
  
  void diffuse() { //diffuses charge between the two cell walls
    
    if (wallA.charge[positionA] > wallB.charge[positionB]) {
      wallA.charge[positionA] -= chargeDiffusionRate;
      wallB.charge[positionB] += chargeDiffusionRate;
    }
    else if (wallA.charge[positionA] < wallB.charge[positionB]) {
      wallA.charge[positionA] += chargeDiffusionRate;
      wallB.charge[positionB] -= chargeDiffusionRate;
    }
    
  }
  
  void display() { //in case they need to be displayed
  }
  
}