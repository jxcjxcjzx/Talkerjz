interface ManageEncry
{
  boolean AddOneNode(String for_add);
  String GetPassTag(String for_handle);
  boolean AddOnePass(String for_add);
  String GetPass(String require);
}

class EncryManager implements ManageEncry
{
  String manage_file_name = "";
  boolean AddOneNode(String for_add)
  {
     boolean forreturn = false;
     
     // first see the ending of the passage is right or not
     //InputStreamReader isr = new InputStreamReader(url.openStream());
     //BufferedWriter   out=new   BufferedWriter(  new   FileWriter(new File(this.manage_file_name) ,true));
 
     return forreturn;  
  }
  
  String GetPassTag(String for_handle)
  {
     String forreturn = "";  
     
     return forreturn;
  }
  
  boolean AddOnePass(String for_add)
  {
     boolean forreturn = false;
     
     return forreturn;     
  }  
  
  String GetPass(String require)
  {
    String forreturn = "";
    
    return forreturn;
  }

}
