class Brain{
  NetworkLayer input,hidden,output;
  Brain(int _in, int _hid, int _out, float _learningRate){
    input=new NetworkLayer();   
    hidden=new NetworkLayer(); 
    output=new NetworkLayer(); 
    input.initialize(_in,0,_hid,null,hidden,_learningRate);
    hidden.initialize(_hid,_in,_out,input,output,_learningRate);
    output.initialize(_out,_hid,0,hidden,null,_learningRate);
  } 
  void setInput(int n, float val){  
    input.nodeValues[n]=val; 
  }
  float getOutput(int n){
    return output.nodeValues[n];  
  }
  void setDesiredOutput(int n, float val){
    output.desiredValues[n]=val;
  }
  void feedForward(){
    input.calculateNodeValues();
    hidden.calculateNodeValues();
    output.calculateNodeValues(); 
  }
  void backPropagate(){
    output.calculateErrors();
    hidden.calculateErrors();
    hidden.adjustWeights();
    input.adjustWeights(); 
  }
}





