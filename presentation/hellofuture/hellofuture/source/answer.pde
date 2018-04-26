//variavles: filename,answerindex,[]lineshere
//functions: datain(),getfilename()
// boolean haveanswer(String),String getanswer(int)

class answer
{
  String askadd;
  String answeradd;
  int answerindex;
  String []ask;
  String []answer;
  void getfilename(String filename,String filenametwo)
   {
     this.askadd = filename;
     this.answeradd = filenametwo;
   }
   
   void datain()
   {
      this.ask = loadStrings(this.askadd);
      this.answer = loadStrings(this.answeradd);
   }
  boolean haveanswer(String b)
  {
    boolean jieguo = false;
    for(int i=0;i<this.ask.length;i++)
    {
      if(b.equals(this.ask[i]))
       this.answerindex = i;
       jieguo = true;
    }
    return jieguo;
  }
  
  String getanswer()
  {
     return this.answer[answerindex];
  }
  /*
  void addanswer(String a)
  {
 
  }
*/
}
