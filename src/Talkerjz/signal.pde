class signal
{
  int x;
  int y;
  int yy=100;
  int top = 0;
  int gaodu;
  int changdu;
  int gaodutwo;
  int changdutwo;
  int widthadjust = 0;
  private int screenwidth = 300;
  private int screenheight = 600;
  int leftedgeforanswer = 0;
  int leftedgeforshow = 50;
  int m_mousepresslocx = 0;
  int m_mousepresslocy = 0;
  private int sys_scroll = 0;
  private int sys_scroll2 = 0;
  boolean update = false;
  String show = "";
  String showback = "";
  String getanswer = "";
  String askstring = "";
  String answerstring = "";
  boolean answer = false;
  boolean receiveforstore = false;
  String askadd = "ask.txt";
  String answeradd = "answer.txt";
  boolean occupied = false;
  boolean key_of_up_arrow = false;
  boolean key_of_down_arrow = false;
  String []store = new String[1];
  ArrayList<String> listhere = new  ArrayList();
  ArrayList<String> orderarray = new  ArrayList();
  int ordercount = 0;
  boolean m_mousepressed =false;
  boolean m_mousedragged = false;
  boolean m_keypressed = false;
  boolean m_mousemoved = false;
  boolean m_mousereleased = false;
  boolean m_leftpressed = false;
  boolean m_rightpressed = false;
  boolean m_keyreleased = false;
  boolean m_occupied = false;
  boolean onedelay = false;
  int scrolldecide = 0;
  int scrolldecide2 = 0;
  String forjudge ="";
  boolean centerused = false;
  boolean centerstate = false;
  boolean applock = false;
  AudioPlayer public_song;
  
  void reset()
  {
    this.key_of_up_arrow = false;
    this.key_of_down_arrow = false;
  }
  
  void initial()
  {
    this.changdu = width*4/5;
    this.gaodu = height*2/15;
    this.changdutwo = width*4/5;
    this.gaodutwo = height*2/15;
    this.x = width/7;
    this.y = height*5/6;
  }
  
  void sys_vectorjudge()
  {
    String judge = null;
    judge = mainmode.vector + note.vector + pass120.vector
    +ques.vector+pianoplayer.vector+cameraone.vector+lockit.vector
    +readbooks.vector+bookmarket.vector;
    if(!forjudge.equals(judge)){
      forjudge = judge;
      sig.sys_scroll = 0;
    }    
    else{
    }
  }
}
