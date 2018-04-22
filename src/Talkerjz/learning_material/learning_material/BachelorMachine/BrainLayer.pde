class NetworkLayer{//
  int nodesNumber;//number of neurons
  int childNodesNumber;
  int parentNodesNumber;
  float[][] weights;//weights conecting each neuron[except output layer] with its children
  float[] nodeValues;//neuron values
  float[] desiredValues;//desired neuron values used for training
  float[] errors;
  float learningRate;
  NetworkLayer parent, child;
  void initialize(int _nodesNumber,int _parentNodesNumberint,int _childNodesNumber,NetworkLayer _parent,NetworkLayer _child,float _learningRate){
    nodesNumber=_nodesNumber;
    learningRate=_learningRate;
    errors=new float[nodesNumber];
    nodeValues=new float[nodesNumber];
    desiredValues=new float[nodesNumber];
    parent=_parent;
    child=_child;
    if(parent!=null)parentNodesNumber=_parentNodesNumberint;
    if(child!=null)childNodesNumber=_childNodesNumber;
    if(child!=null){
      weights=new float[nodesNumber][childNodesNumber];
      for(int i=0;i<nodesNumber;i++){
        for(int j=0;j<childNodesNumber;j++){
          weights[i][j]=random(-1,1);//initialy all weights have random values. training adjusts them. 
        }
      }
    }
  }
  void calculateNodeValues(){
    float val;
    if (parent!=null){
      for(int i=0;i<nodesNumber;i++){
        val=0;
        for(int j=0;j<parentNodesNumber;j++){
          val+=parent.nodeValues[j]*parent.weights[j][i]; 
        }
          nodeValues[i]=1/(1+exp(-val));//neuron's activation function  
      }
    } 
  }
  void calculateErrors(){
    float sum;
    if(child==null){
      for(int i=0;i<nodesNumber;i++){
        errors[i]=(desiredValues[i]-nodeValues[i])*nodeValues[i]*(1-nodeValues[i]);
      }
    }
    else if(parent==null){
      for(int i=0;i<nodesNumber;i++){
        errors[i]=0;
      }
    }
    else{
      for(int i=0;i<nodesNumber;i++){
        sum=0;
        for(int j=0;j<childNodesNumber;j++){
          sum+=child.errors[j]*weights[i][j];
        }
        errors[i]=sum*nodeValues[i]*(1-nodeValues[i]);
      }
    }
  }
  void adjustWeights(){
    float adj;
    if(child!=null){
      for(int i=0;i<nodesNumber;i++){
        for(int j=0;j<childNodesNumber;j++){
          adj=learningRate*child.errors[j]*nodeValues[i];
          weights[i][j]+=adj;
        }        
      } 
    }  
  }
}






