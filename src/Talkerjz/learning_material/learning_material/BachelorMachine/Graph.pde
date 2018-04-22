void drawGraph(){
  int iLH=300;
  int hLH=400;
  int oLH=250;
  int iNN=brain.input.nodesNumber;
  int hNN=brain.hidden.nodesNumber;
  int oNN=brain.output.nodesNumber;
  for(int i=0;i<iNN;i++){
    for(int j=0;j<hNN;j++){
      stroke(map(brain.input.weights[i][j],-1,1,0,255),70,map(brain.input.weights[i][j],-1,1,255,0));
      line(200,(height-iLH)/2+(iLH/iNN)/2+(iLH/iNN)*i,400,(height-hLH)/2+(hLH/hNN)/2+(hLH/hNN)*j);
    }
  }
  for(int i=0;i<hNN;i++){
    for(int j=0;j<oNN;j++){
      stroke(map(brain.hidden.weights[i][j],-1,1,0,255),70,map(brain.hidden.weights[i][j],-1,1,255,0));
      line(400,(height-hLH)/2+(hLH/hNN)/2+(hLH/hNN)*i,600,(height-oLH)/2+(oLH/oNN)/2+(oLH/oNN)*j);
    }
  }
  stroke(0);
  for(int i=0;i<iNN;i++){
    fill(map(brain.input.nodeValues[i],0,1,0,255));
    ellipse(200,(height-iLH)/2+(iLH/iNN)/2+(iLH/iNN)*i,10,10);    
  }  
  for(int i=0;i<hNN;i++){
    fill(map(brain.hidden.nodeValues[i],0,1,0,255));
    ellipse(400,(height-hLH)/2+(hLH/hNN)/2+(hLH/hNN)*i,10,10);
  }
  for(int i=0;i<oNN;i++){
    fill(map(brain.output.nodeValues[i],0,1,0,255));
    ellipse(600,(height-oLH)/2+(oLH/oNN)/2+(oLH/oNN)*i,10,10);
  }
}


