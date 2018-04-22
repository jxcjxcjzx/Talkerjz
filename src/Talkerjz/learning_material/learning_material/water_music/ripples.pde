/**
* Ripples - Dec 2009
* by volts (Tom Blackwell)
* Utility sketch that simulates defraction from waves in fluid
* and shadows the ripples for better effect over flat colors.
* Algorithm based on http://freespace.virgin.net/hugo.elias/graphics/x_water.htm
*
*/

float damping = .95;   // efficiency of wave propagation
float refraction = 2.; // 
int darkness = 1000;   // darkness of shadow


// surface elevations
float previous[] = new float[X_SIZE*Y_SIZE];
float current[] = new float[X_SIZE*Y_SIZE];
float swap[];	//swap pointer

void simulate(){
  swap = current;
  current = previous;
  previous = swap;
  for (int i=width;i<width*(height-1);i++) {
    current[i] = damping*(((  previous[i-1] + previous[i+1] + previous[i-width] + previous[i+width])/2.) -current[i]);
  }
}

void drawRipples(PImage p){
  simulate();
  defract(p);
}

// renders directly to display, be sure to call loadPixels() in setup() of main sketch
void defract(PImage texture){
  for(int y=1;y<height-1;y++){
    for(int x=1;x<width-1;x++){
       float x_offset = (current[(y*width)+(x+1)]+current[(y*width)+(x-1)])/refraction;
       float y_offset = (current[(y+1)*width+x]+current[(y-1)*width+x])/refraction;
       int x_previous = (int)(x + x_offset);
       int y_previous = (int)(y + y_offset);
       if(x_previous < 1 || x_previous> width-1) x_previous = x - (int)x_offset;
       if(y_previous < 1 || y_previous > height-1) y_previous = y - (int)y_offset;
       int tex_coord = (int)((x_previous)+(int)(y_previous)*texture.width);
       color shadow = color(constrain( ((int)((x_offset+y_offset)*darkness)), 0, 255));
       pixels[x+y*width] = blendColor(shadow,texture.pixels[tex_coord],DIFFERENCE);
     }
   }
   updatePixels();
}

void squareWave(int x, int y, float power, int sqsize){
 if(x<width-sqsize && y<height-sqsize){
   for(int xx=0;xx<sqsize;xx++){
     for(int yy=0;yy<sqsize;yy++){
       current[((y+yy)*width)+x+xx] -= power;
     }
   }
 }
}
