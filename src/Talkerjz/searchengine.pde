class searchengine
{  
  String searchname = " ";
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String []forjudge = {"where","is","file","search","for","file"};
     if((a.contains(forjudge[0])&&a.contains(forjudge[1])
     &&a.contains(forjudge[2]))||(a.contains(forjudge[3])
     &&a.contains(forjudge[4])&&a.contains(forjudge[5]))){
        forreturn = true;        
        Pattern p = Pattern.compile(".*file ([^/?]+)+?|.*file (.*)$");
        Matcher m = p.matcher(a);
	if(m.find()){
          this.searchname = m.group(1);            
        } 
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  String handle()
  {
    String readinadd = "diskmap.txt";
    String forreturn = "对不起，我没有找到你要的东西";
    String []lookinto = loadStrings(readinadd);
    for(int i=0;i<lookinto.length;i++){
      if(lookinto[i].contains(this.searchname)){
        forreturn = "A ha, it's in: "+lookinto[i];
        break;
      }
      else{      
      }
    }
    return forreturn; 
   }
   
   String handle(String name)
   {   
         String forreturn = "对不起，我没有找到你要的东西";
     try{
           int lengthofarray = 0;  
           String readincontent = "";
           URL url = new URL("file:///E://SOFT HOME2/processing-1.5.1/for_summer/Talkerjz/diskmap.txt");         
           InputStreamReader isr = new InputStreamReader(url.openStream(),"gbk");
           BufferedReader br = new BufferedReader(isr); 
            while((readincontent = br.readLine())!=null){
                 lengthofarray++;
                 if(readincontent.contains(name)){
                   forreturn = "A ha, it's in: "+readincontent;
                   break;
                 }
                 else{
                 }
           }
     }
     catch (IOException e){
	   e.printStackTrace();    
     }    

    return forreturn; 
   
   }
}
