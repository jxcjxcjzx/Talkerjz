/*
 * Abstract class for menu items
 */
 
abstract class MenuItem
{
	//Properties
	protected boolean _selectable = false; //If the item can be highlighted/selected via keys or the mouse
	protected int _height; //Height of the element
	
	//Method to return if the item is selectable - cannot be re-written
	public final boolean selectable()
	{
		return _selectable;
	}
	
	//Method to return the height of the element - cannot be re-written
	public final int height()
	{
		return _height;
	}
	
	//Method which elements must use
	abstract public void draw(int x, int y, int width);
	
}
