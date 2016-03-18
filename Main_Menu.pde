class mainMenu {
  
  void display(){
    
    
    
  }
  
  void showMenu(){
    
    cp5.addButton("testButton")
     
     .setValue(0)
     .setPosition(650,20)
     .setSize(150,40)
     .setValueLabel("Test Level");
     ;
     
    cp5.addButton("testButton2")
     
     .setValue(1)
     .setPosition(650,80)
     .setSize(150,40)
     .setValueLabel("Test Level 2");
     ;
     
     cp5.addButton("testButton3")
     
     .setValue(1)
     .setPosition(650,140)
     .setSize(150,40)
     .setValueLabel("Test Level 3");
     
    cp5.addButton("menuButton")
     
     .setValue(2)
     .setPosition(650,200)
     .setSize(150,40)
     ;
    
  }
  
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isController()) { 
    
    if(theEvent.controller().getName()=="testButton") {
          clear();
          gameState = "level";
          testLevel test = new testLevel();
          currentLevel = test;
          println("Clicked testButton.");
    }
    else if(theEvent.controller().getName()=="testButton2") {
          clear();
          gameState = "level";
          testLevel2 test2 = new testLevel2();
          currentLevel = test2;
          println("Clicked testButton2.");
    }
    else if(theEvent.controller().getName()=="testButton3") {
          clear();
          gameState = "level";
          testLevel3 test3 = new testLevel3();
          currentLevel = test3;
          println("Clicked testButton3.");
    }
    else if(theEvent.controller().getName()=="menuButton") {
          gameState = "menu";
          clear();
          println("Clicked menuButton.");
    }
    
  }
}