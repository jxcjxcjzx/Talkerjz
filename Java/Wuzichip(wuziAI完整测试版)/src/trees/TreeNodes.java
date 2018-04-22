package trees;

import java.util.*;

public class TreeNodes{

	private String state;
	private String data;
        private TreeNodes father;
	private List<TreeNodes> children;
	private TreeAttributes attributes;
	public TreeAttributes getAttributes(){
	   return attributes;	
	}
	public void setAttributes(TreeAttributes attributes){
		this.attributes = attributes;
	}
	public String getState(){
		return state;
	}
	public void setState(String state){
		this.state = state;
	}
	public String getData(){
		return data;
	}
	public void setData(String data){
		this.data = data;
	}
	public List<TreeNodes> getChildren(){
	    return children;
	}
	public void setChildren(List<TreeNodes> children){
		this.children = children;
	}
        public void setfather(TreeNodes father){
                this.father = father;
        }
        public TreeNodes getfather(){
          return father;
        }
	public TreeNodes(){
		
	}
	
}
