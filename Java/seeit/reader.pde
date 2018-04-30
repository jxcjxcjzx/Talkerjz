;//the objects are listed as follows:
//filename,[]wordsrelated,mainword,[]lines
//the []lines are the array that will take the words in
//functions:
//1.datain: get in the data
//2.getfilename : get the input file name

class reader
{
   String filename;
   String []lines;
   
   void getfilename(String nameforyou)
   {
     this.filename = nameforyou;
   }
   
   void datain()
   {
      this.lines = loadStrings(this.filename);
   }

}
