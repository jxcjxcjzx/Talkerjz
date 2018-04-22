class paster
{
  String forpaste = "";
  
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String forjudge = "copy";   // here you can something else
     if(a.contains(forjudge)){
        forreturn = true;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  String handle()
  {
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
     return this.forpaste; 
   }
}
