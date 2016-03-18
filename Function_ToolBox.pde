void drawRing(int x, int y, float w1, float w2, int segments)
{
  // w1 == outer radius, w2 == inner radius.
  float deltaA=(1.0/(float)segments)*TWO_PI;
  beginShape(QUADS);
  for(int i=0;i<segments;i++)
  {
    vertex(x+w1*cos(i*deltaA),y+w1*sin(i*deltaA));
    vertex(x+w2*cos(i*deltaA),y+w2*sin(i*deltaA));
    vertex(x+w2*cos((i+1)*deltaA),y+w2*sin((i+1)*deltaA));
    vertex(x+w1*cos((i+1)*deltaA),y+w1*sin((i+1)*deltaA));
  }
  endShape();
} 

void victoryMessage(){
  
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(30);
  fill(150);
  textFont(titleFont);
  text("You beat " + currentLevel.levelName + ". Congratulations!", 400, height-40);
  
}