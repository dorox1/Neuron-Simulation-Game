import controlP5.*; //game interface classes and methods //<>//

ControlP5 cp5;

import point2line.*; //allows for use of the Vect2 class, which has some useful functions for vector manipulation

PFont titleFont;
int step;
int maxCharge;
int chargeDiffusionRate;
int synapseSize;
int decayRate;
int wallThickness;
String gameState = "menu";
Level currentLevel;
mainMenu currentMenu;
CellWall mywall;

void setup() {
  
  titleFont = loadFont("Ebrima-48.vlw");
  //colorMode(RGB, 100);
  step = 1;
  //sets initial step value
  maxCharge = 255;
  //sets maximum charge level (should be arbitrary, but higher values cause bugs)
  chargeDiffusionRate = 10;
  //sets charge diffusion rate
  synapseSize = 15;
  //sets synapse click size
  decayRate = 4;
  //sets charge decay rate
  wallThickness = 10;
  //sets wall thickness
  noSmooth();
  size(800, 600);
  //initialize window size
  cp5 = new ControlP5(this);
  //sets the button controller
  
  
    
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  //testLevel test = new testLevel();
  //currentLevel = test;
  mainMenu menu = new mainMenu();
  currentMenu = menu;
  
  
  
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  strokeWeight(wallThickness);
  //set stroke size
  
  currentMenu.showMenu();
  
}

void draw() {
  
  step++;
  if (step >=50){
    step = 1;
  }
  
  switch(gameState){ //determines game state before each draw iteration
    
  case "menu":
    clear();
    currentMenu.display();
    break;
  
  case "level":
    background(153, 255, 255);
    currentLevel.display(); //draws the cell wall
    currentLevel.diffuse();//updates the cell wall
    if(currentLevel.victoryConditions()) victoryMessage(); //displays victory message upon victory
    break;
  
  
  
  //println(step);
  }
}