import java.beans.PropertyVetoException;
import java.util.Locale;
import javax.speech.AudioException;
import javax.speech.Central;
import javax.speech.EngineException;
import javax.speech.EngineStateError;
import javax.speech.synthesis.Synthesizer;
import javax.speech.synthesis.SynthesizerModeDesc;
import javax.speech.synthesis.Voice;

import com.sun.speech.freetts.audio.AudioPlayer;

class Sys_speaker {
  
  SynthesizerModeDesc desc;
  Synthesizer synthesizer;
  Voice voice;
  

  void init(String voiceName) 
    throws EngineException, AudioException, EngineStateError, 
           PropertyVetoException 
  {
    if (desc == null) {
      
      System.setProperty("freetts.voices", 
        "com.sun.speech.freetts.en.us.cmu_us_kal.KevinVoiceDirectory");
      
      desc = new SynthesizerModeDesc(Locale.US);
      Central.registerEngineCentral
        ("com.sun.speech.freetts.jsapi.FreeTTSEngineCentral");
      synthesizer = Central.createSynthesizer(desc);
      synthesizer.allocate();
      synthesizer.resume();
      SynthesizerModeDesc smd = 
        (SynthesizerModeDesc)synthesizer.getEngineModeDesc();
      Voice[] voices = smd.getVoices();
      Voice voice = null;
      for(int i = 0; i < voices.length; i++) {
        if(voices[i].getName().equals(voiceName)) {
          voice = voices[i];
          break;
        }
      }
      synthesizer.getSynthesizerProperties().setVoice(voice);
    }
    
  }

   void terminate() throws EngineException, EngineStateError {
    synthesizer.deallocate();
  }
  
  void doSpeak(String speakText) 
    throws EngineException, AudioException, IllegalArgumentException, 
           InterruptedException 
  {
      synthesizer.speakPlainText(speakText, null);
      synthesizer.waitEngineState(Synthesizer.QUEUE_EMPTY);

  }
  
  void init_speak()
  {
    try{
     this.init("kevin16");
    }
    catch (Exception e){
    }

  }
  
  void sayContent(String content){
    try{
    // high quality
    
    this.doSpeak(content);
    }
    catch (Exception e){
    }
  }
} 

