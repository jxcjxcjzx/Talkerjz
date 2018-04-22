//variavles: filename,answerindex,[]lineshere
//functions: datain(),getfilename()
// boolean haveanswer(String),String getanswer(int)

class answer
{
  String askadd;
  String answeradd;
  int answerindex =1;
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
      if(b.equals(this.ask[i])){
       this.answerindex = i;
       jieguo = true;
       break;
      }
      else{
      continue;
      }
    }
    return jieguo;
  }
  
  String getanswer()
  {
    return this.answer[this.answerindex];
  }

  void addanswer(String a,String b)
  {
     String []dd = loadStrings(this.askadd);
     String []ee = loadStrings(this.answeradd);
     String []aa = new String[dd.length+1];
     String []bb = new String[ee.length+1];
     for(int i =0;i<aa.length-1;i++){
        aa[i] = dd[i];
     }
     for(int i =0;i<bb.length-1;i++){
        bb[i] = ee[i];
     }
     aa[aa.length-1] = a;
     bb[bb.length-1] = b;
     saveStrings(this.askadd, aa);
     saveStrings(this.answeradd, bb);
  }

}
