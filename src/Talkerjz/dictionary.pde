class dictionary
{
  String forhandle;
  String word;
  String []lineshere;
  
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String readinadd = "dic.txt";
     String forjudge = "dic:";
     if(a.contains(forjudge)){
        forreturn = true;
        this.forhandle = a;
        String []lines = loadStrings(readinadd);
        this.lineshere = lines;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  String handle()
  {
     String wordhere = "";
     String forreturn = "search failure";
     Pattern p = Pattern.compile("dic:(.*)");
      Matcher m = p.matcher(this.forhandle);
	if(m.find()){
         wordhere = m.group(1);
      }
    this.word = wordhere;
    for(int i=0;i<this.lineshere.length;i+=2){
        if(this.word.equals(this.lineshere[i]))
          forreturn = this.lineshere[i+1];
     }
    return forreturn; 
   }
}
