import com.sun.speech.freetts.*;
import com.sun.speech.freetts.en.us.*;
import com.sun.speech.freetts.en.us.cmu_time_awb.AlanVoiceDirectory;


class speakOut
{
  Voice voice;
  void init()
  {
        VoiceManager voiceManager = VoiceManager.getInstance(); 

		this.voice = voiceManager.getVoice("kevin16");

		 // loads the Voice
		 this.voice.allocate();
  }
  void sayContent(String content)
  {
		 // start talking
		 this.voice.speak(content);
  }

}

