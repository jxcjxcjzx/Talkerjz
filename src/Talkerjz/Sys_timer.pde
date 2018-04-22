
class Sys_timer
{  
  ddf.minim.AudioPlayer player;
  void init_timer()
  {
    try{
         player = sig.main_minim.loadFile("sunset.mp3",1024);     
    }
    catch (Exception e){        
    }
  }
  
  void action_performed()
  {
    sig.main_minim.stop();
    player = sig.main_minim.loadFile("sunset.mp3", 1024);
    player.play();
  }

}


/*
 String bip = "sunset.mp3"; 
   Media hit = new Media(bip); 
   MediaPlayer mediaPlayer = new MediaPlayer(hit); 
   mediaPlayer.play(); 
*/

