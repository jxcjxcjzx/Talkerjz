/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/40530*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
import java.text.SimpleDateFormat ;
import java.util.Date;
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.color.*;
import toxi.color.theory.*;

VerletPhysics2D physics;

boolean debug=false;
PFont font;

float daysForum;
Capa iniciaCapa() {

  Capa c=new Capa();
  PGraphics  pg = createGraphics(1200, 600, this.P3D);

  c.g=pg;
  return c;
}
void iniciaPGraphics(Capa c, Visualizable v) {
  PGraphics  pg = createGraphics(1200, 600, this.P3D);
  pg.beginDraw();
  pg.colorMode(HSB, 100);
  pg.smooth();
  c.g=pg;
  if (v!=null)
    c.reset(v);
}
ColorList nueva;
void setup() {
  size(1200, 600);
  TColor col = TColor.newRandom();
    ColorTheoryStrategy s = new CompoundTheoryStrategy();
    ColorList list = ColorList.createUsingStrategy(s, col);
     nueva=new ColorList(list);
    for(int i=0; i<list.size(); i++){
      TColor c=(TColor)list.get(i);
      nueva.add(c.getInverted());
    }
  physics=new VerletPhysics2D();
  physics.setWorldBounds(new Rect(10, 10, width-10, height-10));

  equipos=iniciaCapa();
  usuarios=iniciaCapa();
  comentariosG=iniciaCapa();
  relaciones=iniciaCapa();
  mensajes=iniciaCapa();


  colorMode(HSB, 100);
  smooth();
  iniciaEquipos();
  procesaXML();
  // analizaPosicionamiento();
  background(0);
  font = loadFont("Courier10PitchBT-Roman-25.vlw"); 
  textFont(font); 

  Collections.reverse(comentarios);
  if (comentarios.size()>2) {
    daysForum=calculaDiferencia(comentarios.get(0).fecha, comentarios.get(comentarios.size()-1).fecha);
    if (debug) {
      println("tiempo de foro inicio: "+comentarios.get(0).fecha+"> fin: "+comentarios.get(comentarios.size()-1).fecha);
      println("days: "+daysForum);
    }
  }
  else {
    noLoop();
    pintaMensaje(color(100), "comentarios insuficientes", 0, 0, this.g, 25);
  }
}
Capa equipos, usuarios, comentariosG, relaciones, mensajes;


void draw() {
  physics.update();

  background(0);
  pintaMensaje(color(100), ((30*30)-frameCount)+"", width-100, 50, this.g,20);
//  daysForum

  // equipos.beginDraw();
//  usuarios.beginDraw();
  // comentariosG.beginDraw();
  iniciaPGraphics(usuarios, null);
  iniciaPGraphics(comentariosG, null);
  iniciaPGraphics(equipos, null);
  relaciones.beginDraw();
  iniciaPGraphics(mensajes, null);
  comprueba();

  for (Visualizable c:comentariosG.elementos)
    ((Comentario)c).pinta(comentariosG);
  for (Visualizable u:usuarios.elementos)
    ((Usuario)u).pinta(usuarios);
  for (Visualizable e:equipos.elementos)
    ((Equipo)e).pinta(equipos);
  for (Visualizable r:relaciones.elementos)
    ((Relacion)r).pinta(relaciones);

 int contaM=0;
  for (int i=comentariosG.elementos.size()-1; i>=0;i--) {
    Comentario cc=((Comentario)comentariosG.elementos.get(i));
    color colorMensaje=color(hue(cc.usuario.equipo.c),70,90, map(contaM, 0,comentariosG.elementos.size(),100,20 ));
    pintaMensaje(colorMensaje, cc.titulo, 10, 10+(contaM*25), this.g, 15);
    if(contaM<3){
    mensajes.g.stroke(colorMensaje);
    mensajes.g.line(10+textWidth(cc.titulo),10+(contaM*25), cc.particle.x, cc.particle.y);
    }
    contaM++;
  }
  image(equipos.g, 0, 0); 
  image(usuarios.g, 0, 0); 
  image(comentariosG.g, 0, 0); 
  image(relaciones.g, 0, 0); 
  image(mensajes.g, 0, 0); 

  equipos.endDraw();
  usuarios.endDraw();
  comentariosG.endDraw();
  relaciones.endDraw();
  mensajes.endDraw();
}





//tamanyo == cantidad de palabras
//tiempo == tiempointeractivo/tiempo foro ---- las fechas muy largas habría que acortarlas....
//numero aportaciones=luminosidad
//polemico=numero de contestaciones
//lugar:pais-barrio
//onMouse-over
//toxi-color

int contador;
Comentario comentarioActual;

int frame;
void comprueba() {
  if (contador>=comentarios.size()) return ;
  comentarioActual=comentarios.get(contador);
 
  
  for(Visualizable v:equipos.elementos){
    Equipo e=(Equipo)v;
    pintaMensaje(color(100), e.nombre,e.particle.x, e.particle.y, mensajes.g, 20);

  }

  float daysDiff=calculaDiferencia(comentarios.get(0).fecha, comentarioActual.fecha);
   frame=int(map(daysDiff, 0, daysForum, 0, 30*30));
  if (debug)
    println(contador+">>>>>>>>>><"+daysDiff+" "+frame+" --- "+frameCount);

  if (int(frame)==(frameCount-1)) {


    Equipo e=comentarioActual.usuario.equipo;
    boolean existeEquipo=equipos.addElemento(e);
    if (existeEquipo) {
      iniciaPGraphics(equipos, e);
    }
    else {
      physics.addParticle(e.particle);
      VerletParticle2D  particleOrigin=new VerletParticle2D(e.particle.copy());
      particleOrigin.lock();
      //physics.addParticle(particleOrigin);

      VerletConstrainedSpring2D spring1=new VerletConstrainedSpring2D(particleOrigin, e.particle, 50, 0.05f);

      physics.addSpring(spring1);

      for (Visualizable v:equipos.elementos) {
        Equipo equ=(Equipo)v;
        if (e!=equ) {     
          VerletMinDistanceSpring2D spring=new VerletMinDistanceSpring2D(e.particle, equ.particle, 100, 0.5f);
          physics.addSpring(spring);
        }
      }
    }





    Usuario u=comentarioActual.usuario;
    boolean existeUsuario=usuarios.addElemento(u);
    if (existeUsuario) {
      iniciaPGraphics(usuarios, u);
    }else{
    
        u.particle=new VerletParticle2D(e.particle.copy().add(random(-1, 1), random(-1, 1)));
        VerletConstrainedSpring2D springParticle=new VerletConstrainedSpring2D(e.particle, u.particle, 20, 0.05f);
        physics.addSpring(springParticle);
    }


    comentarioActual.particle=new VerletParticle2D(comentarioActual.usuario.particle.copy().add(random(-1, 1), random(-1, 1)));
    VerletConstrainedSpring2D springUsuParticle=new VerletConstrainedSpring2D(comentarioActual.usuario.particle, comentarioActual.particle, 20, 0.05f);
    physics.addSpring(springUsuParticle);

    comentariosG.elementos.add(comentarioActual);


    if (comentarioActual.parent!=0) {
      Comentario parent=dameComentario(comentarioActual.parent);
      Relacion r=new Relacion();
      r.origen=parent;
      r.fin=comentarioActual;
      relaciones.addElemento(r);
    }

    contador++;
    comprueba();
  }
}



void pintaMensaje(color c, String mensaje, float x, float y, PGraphics g, int tam) {
  g.textFont(font); 
  g.fill(0);
  g.noStroke();
  g.textSize(tam);

  g.rect(x, y, textWidth(mensaje), textAscent());
  g.fill(c);
  g.text(mensaje, x, y+textAscent());
}



Comentario dameComentario(int id) {
  for (Comentario c:comentarios)
    if (c.id==id)return c;
  throw new RuntimeException();
}
@Deprecated
void analizaPosicionamiento() {
  for (Equipo e:equiposIn) {

    for (Usuario u:e.usuarios) {

      u.particle.x=e.particle.x+random(-25, 25);
      u.particle.y=e.particle.y+random(-25, 25);

      for (Comentario c:u.comentarios) {

        float provX=u.particle.x+random(-5, 5);
        float provY=u.particle.y+random(-5, 5);
        c.particle=new VerletParticle2D(new Vec2D(provX, provY));
        c.particle.addBehavior(new AttractionBehavior(u.equipo.particle, 50, 0.05));
        physics.addParticle(c.particle);
      }
    }
  }
}
List<Comentario> comentarios=new ArrayList<Comentario>();



void procesaXML() {
  XMLElement xml = new XMLElement(this, "foros.xml");
  int numSites = xml.getChildCount();
  XMLElement[] kids = xml.getChildren();
  println(kids.length);
  for (XMLElement el:kids) {
    try {
      String fecha=el.getChild("created-at").getContent();
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      Date d = sdf.parse(fecha);
      String texto=el.getChild("textoes").getContent();
      String titulo=el.getChild("tituloes").getContent();
      int idComentario=int(el.getChild("id").getContent());
      String idComentarioParentString=el.getChild("comentario-id").getContent();
      int idComentarioParent=0;
      if (idComentarioParentString!=null) {
        idComentarioParent=int(idComentarioParentString);
      }
      int idEquipo=int(el.getChild("usuarioforo/equipo-id").getContent());
      Equipo e=getEquipo(idEquipo);

      String nombreUsuario=el.getChild("usuarioforo/nombre").getContent();
      String mailUsuario=el.getChild("usuarioforo/email").getContent();
      int idUsuario=int(el.getChild("usuarioforo/id").getContent());

      Usuario usuario=new Usuario(idUsuario, nombreUsuario, mailUsuario, e);
      usuario=e.addUsuario(usuario);

      if (debug) {
        print(texto);
        print(idEquipo);
        println("");
      }
      Comentario comentario=new Comentario(idComentario, titulo, texto, usuario, idComentarioParent, d);
      usuario.addComentario(comentario);
      comentarios.add(comentario);
    }
    catch (Exception e) {
      println("el message"+e.getMessage());
      e.printStackTrace();
    }
  }
}
Equipo getEquipo(int id ) {
  Equipo e=equiposIn.get(id-1);
  return e;
}

List<Equipo> equiposIn=new ArrayList();
void iniciaEquipos() {

  equiposIn.add(new Equipo(1, "bamako", 224, 122));
  equiposIn.add(new Equipo(2, "barcelona", 236, 55));
  equiposIn.add(new Equipo(3, "bogota", 133, 145));
  equiposIn.add(new Equipo(4, "elalto", 141, 174));
  equiposIn.add(new Equipo(5, "evry", 238, 39));
  equiposIn.add(new Equipo(6, "montreuil", 243, 43));
  equiposIn.add(new Equipo(7, "palma", 241, 61 ));
  equiposIn.add(new Equipo(8, "pikine", 210, 121));
  equiposIn.add(new Equipo(9, "rio", 175, 221));
  equiposIn.add(new Equipo(10, "sale", 224, 72));
  for(int i=0;i<equiposIn.size();i++)
    equiposIn.get(i).setColor((TColor)nueva.get(i));
  
}
float calculaDiferencia(Date inicio, Date fin) {
  long diff = fin.getTime() - inicio.getTime();
  return (diff / (1000 * 60 * 60 * 24));
}

