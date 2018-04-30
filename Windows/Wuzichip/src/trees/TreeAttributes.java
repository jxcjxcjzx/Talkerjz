package trees;



class TreeAttributes {

	private Integer id;
	private Integer parentId;
	private int level;
	
	public Integer getId(){
		return id;
	}
	public void setId(){
		this.id = id;
	}
	public Integer getParentId(){
		return parentId;
	}
	public void setParentId(Integer parentId){
		this.parentId = parentId;
	}
	public int getLevel(){
		return level;
	}
	public void setLevel(int level){
		this.level = level;
	}
}
