
class Sys_timer
{
  Player p;
  void init_timer()
  {
    try{
       File f = new File("E:/SOFT HOME2/processing-1.5.1/Talker_foryou/Talkerjz/data/sunset.mp3"); 
       MediaLocator ml = new MediaLocator(f.toURL()); 
       p = Manager.createPlayer(ml);        
    }
    catch (Exception e){
        
    }
  }
  
  void action_performed()
  {
     p.stop();
     this.init_timer();
     p.start(); 
  }

}


/*
 String bip = "sunset.mp3"; 
   Media hit = new Media(bip); 
   MediaPlayer mediaPlayer = new MediaPlayer(hit); 
   mediaPlayer.play(); 
*/

