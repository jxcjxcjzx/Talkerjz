class linuz
{
   String []dic={"order:","mkdir","su"};
   String forhandle = "";
   boolean entermode(String a)
   {
      boolean forreturn = false;
         if(a.contains(this.dic[0])){
           forreturn = true;
           this.forhandle = a;
         }
         else{
         }         
      return forreturn;
   }
   
   void tools()
   {
      if(sig.key_of_up_arrow){
          if(sig.ordercount>0){
          sig.show = sig.orderarray.get(sig.ordercount-1);
          sig.ordercount-=1;
          }
        else{
        }  
     }
       if(sig.key_of_down_arrow){
         if(sig.ordercount<sig.orderarray.size()-1){
            sig.show = sig.orderarray.get(sig.ordercount+1);
            sig.ordercount+=1;
         }
         else{
         }
       }
      
   }
   
   String handle()
   {
       String forreturn = "我能力有限，没能完成任务";
       return forreturn; 
   }
}
