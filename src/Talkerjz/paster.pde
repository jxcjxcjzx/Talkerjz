class paster
{
  String forpaste = "";
  
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String forjudge = "copy";   // here you can something else
     String forjudgetwo = "for";
     String forjudgethree = "me";
     if(a.contains(forjudge)&&a.contains(forjudgetwo)&&a.contains(forjudgethree)){
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
     Clipboard sysClip = Toolkit.getDefaultToolkit().getSystemClipboard();
	  Transferable clipTf = sysClip.getContents(null);
	  if(clipTf!=null){
		    //检查文本类型
		    if(clipTf.isDataFlavorSupported(DataFlavor.stringFlavor)){
		    	try{
		    	  this.forpaste = (String)clipTf.getTransferData(DataFlavor.stringFlavor);
		    	}
		    	catch (Exception e) 
		        {            
		          e.printStackTrace();    
		        }   
		    }
		  }  
     forreturn = this.forpaste;
     return forreturn; 
   }
}
