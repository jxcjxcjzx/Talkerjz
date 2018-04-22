class Comentario  implements Visualizable{

  VerletParticle2D particle; 
  
  String texto;
  String titulo;
  Usuario usuario;
  int parent;
  int id;
  Date fecha;
  public Comentario(int _id, String _titulo, String _texto, Usuario usuario, int _parent, Date _fecha) {
    this.id=_id;
    this.usuario=usuario;
    this.texto=_texto;
    this.parent=_parent;
    this.titulo=_titulo;
    this.fecha=_fecha;
    particle=new VerletParticle2D(0,0);
  }
  float tono=70;
  boolean representado;
    void repinta(Capa pg){
    }
  void pinta(Capa pg) {
      //if(!representado){
      pinta(pg, color(80, tono));
 
    //}
    if (tono<99) {
      tono+=1;
    }
    else {
      representado=true;
    }
  
  }
  
    void pinta(Capa pg, color col){
  
       pg.g.pushStyle();
    pg.g.stroke(100);
    pg.g.strokeWeight(0.2);
    pg.g.fill(hue(usuario.equipo.c),100,100);
    pg.g.ellipse(particle.x, particle.y, 10, 10);
    pg.g.popStyle();
  }
  
  void reset(Capa pg){
    representado=false;
  }

}

