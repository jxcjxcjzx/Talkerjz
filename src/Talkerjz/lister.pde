//variables: ArrayList<Stirng> listit
//functions: getlist(ArrayList<String>),roundrect(int,int,int,int)

class lister
{
  ArrayList<String> listit = new  ArrayList();
 
  void getlist(ArrayList<String> a)
  {
    this.listit = a; 
  }
  
  void addcontent(String b)
  {
    this.listit.add(b);
  }

  void listcontent()
  {
        
    int changdu = this.listit.size();
    String showone = this.listit.get(changdu-1);
    String showtwo = this.listit.get(changdu-2);
    String showthree = this.listit.get(changdu-3);

    fill(0,0,0);
    text(showone,width/5,sig.yy+sig.gaodutwo*3+10+sig.top+sig.gaodutwo/2);
    text(showtwo,width/5,sig.yy+sig.gaodutwo*2+10+sig.top+sig.gaodutwo/2);
    text(showthree,width/5,sig.yy+sig.gaodutwo*1+10+sig.top+sig.gaodutwo/2);

}
  
  void roundrect(int x1,int y1,int x2,int y2)
{
  int radiushere = 20;
  rect(x1,y1+radiushere,x2-x1,y2-y1-2*radiushere);
  rect(x1+radiushere,y1,x2-x1-2*radiushere,y2-y1);
  ellipse(x1+radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x1+radiushere,y2-radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y2-radiushere,radiushere*2,radiushere*2);
}
}
