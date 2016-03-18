//an abstract class

abstract class ChargeSurface{
  
  final int dendriteSize = 2; //the size of joining points between 
  int size;
  int[] charge = {};
  boolean[] chargeVisible = {}; //determines whether to draw this particular section
  
  ChargeSurface(int si){
    
    size = si;
    charge = new int[size];
    //sets the size of the charge array to match the size of the cell wall
    for (int i = 0; i < si; i++) {
      charge[i] = 0;
      //initial charge is zero
    }
    chargeVisible = new boolean[size];
    for (int i = 0; i < si; i++) {
      chargeVisible[i] = true;
      //initially, all sections are visible
    }
  }
  
  void display(){
    println("ChargeSurface display function invoked instead of subclass function");
    //left blank for subclasses to use
  }
  
  void update(){
    println("ChargeSurface update function invoked instead of subclass function");
    //left blank for subclasses to use    
  }
  
  void diffuse(){
    println("ChargeSurface diffuse function invoked instead of subclass function");
    //left blank for subclasses to use    
  }
  
  void disperse(){
    println("ChargeSurface disperse function invoked instead of subclass function");
    //left blank for subclasses to use    
  }
  
  abstract Vect2 chargePoint(int z);
    
  
}