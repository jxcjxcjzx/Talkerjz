import processing.serial.*;//引入serial库
Serial myPort;

String forshow = "";

void setup()
{
  size(300,300);
  myPort = new Serial(this,"COM3", 9600);
}

void draw()
{
  background(240,156,22);
    fill(0,0,0);
  text(forshow,10,height/2);
}
//



void keyPressed()
{
    forshow+=key;
    if(key=='\n'){
      forshow = "";
    }

    myPort.write(key);
}


