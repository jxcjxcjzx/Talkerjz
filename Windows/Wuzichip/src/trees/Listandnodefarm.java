package trees;

import java.util.LinkedList;
import java.util.List;

public class Listandnodefarm
{
  public List<TreeNodes> createlist(TreeNodes a)
  {
     List<TreeNodes> newlist = new LinkedList<TreeNodes>();
     newlist.add(a);
     return newlist;
  }
  
  public TreeNodes createnode(String a)
  {
     TreeNodes newnode = new TreeNodes();
     newnode.setData(a);
     return newnode;
  }
}

