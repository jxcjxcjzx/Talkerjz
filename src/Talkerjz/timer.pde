class timer
{  
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String forjudge = "time";
     String forjudgetwo = "what";
     if(a.contains(forjudge)&&a.contains(forjudgetwo)){
        forreturn = true;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  String handle()
  {
    String forreturn = "";
    SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
    String ss = sdf.format(new java.util.Date());
    String addtoss = "The time is: ";
    forreturn = addtoss+ss;
    return forreturn; 
   }
}
