public void processWXR(String url) {
  // get all <channel><item> entries
  XMLElement wxr = new XMLElement(this, url);  
  XMLElement[] items = wxr.getChildren("channel/item");

  posts=new ArrayList<WPPost>();
  
  for (int i = 0; i < items.length; i++) {
    WPPost post=new WPPost(items[i]);
    if (post.id!=-1) { // only add if valid
      posts.add(post);
      println(post.id+" | "+(i+1)+"/"+items.length+" | "+post.title);
    }
  }

  // sort arraylist according to post ID  
  Collections.sort(posts);

  // save posts to individual text files
  if (!online) {
    println("Saving posts to text files...");
    savePostsToTextfiles();
  }
}

void savePostsToTextfiles() {
  File postFolder=new File(sketchPath("posts"));
  
  if(postFolder.exists()) {// delete old content
    println("Deleting old content.");
    deleteFolderContents(postFolder.getAbsolutePath());
  }
  else postFolder.mkdir();
  
  for(WPPost p : posts) p.saveToTextfile();
}

void deleteFolderContents(String folderName) {
  try {
    File folder=new File(folderName);
    File[] files = folder.listFiles();
    if (files!=null) { //some JVMs return null for empty dirs
      for (File f: files) f.delete();
    }
  } catch(Exception e) {
    e.printStackTrace();
  }
}

