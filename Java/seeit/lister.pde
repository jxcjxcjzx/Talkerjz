// variable: String[] forlist
// functions: get(String[]), listcontent(int top)

class lister
{
  String []forlist;
  String []forlisttwo;
  
  void get(String []a)
  {
   this.forlist = a.clone();
   this.forlisttwo = new String[this.forlist.length*9];
       for(int i=0;i<this.forlist.length*9;i++)
         {
           this.forlisttwo[i] = this.forlist[i%this.forlist.length];
         }
  }
 
  void listcontent(int top)  // 具体的信息显示模块
  {   
    for(int i=0;i<this.forlist.length*9;i++)
      {     
        text(forlisttwo[i],width/4,i*height/9+height/16+top);
      }
  }


}
