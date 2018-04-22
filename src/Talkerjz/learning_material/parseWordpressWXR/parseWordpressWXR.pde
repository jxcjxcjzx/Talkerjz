/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/58042*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
// parseWordpressWXR.pde
// Marius Watz - http://workshop.evolutionzone.com
// 
// Simple parser for Wordpress WXR format, which is used to export
// content from blogs running Wordpress. Allows for text import
// and analysis, but could be extended to include all metadata
//
// The included sample.wxr was taken from
// http://code.google.com/p/google-blog-converters-appengine/source/browse/trunk/samples/wordpress-sample.wxr

ArrayList<WPPost> posts;
int currPost=-1;
WPPost thePost;
PFont fnt,fntBold;

public void setup() {
  size(500,400);
  
  // Load wxr feed - replace with your own WXR filename
  processWXR("sample.wxr");
  
  getNextPost();
  
  fnt=createFont("Arial",15,false);
  fntBold=createFont("Arial Bold",15,false);
}

void draw() {
 background(255);
 
 // draw post content to screen
 textFont(fntBold);
 fill(120);
 text(currPost+" ID "+thePost.id+": "+thePost.title,20,35);
 stroke(120);
 line(20,45,480,45);
 
 textFont(fnt);
 fill(0); 
 text(thePost.content,20,75,460,290);
 
 if(frameCount>0 && frameCount%100==0) getNextPost();
}

// get next post to show on screen
void getNextPost() {
  currPost=(currPost+1)%posts.size();
  thePost=posts.get(currPost);
  println("-----------\n"+thePost.id+" "+thePost.content);
}
