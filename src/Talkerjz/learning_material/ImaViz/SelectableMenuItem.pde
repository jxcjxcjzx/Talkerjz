/*
 * SelectableMenuItem - Abstract class which represents selectable items in a menu
 */
abstract class SelectableMenuItem extends MenuItem
{
	//Selected attribute
	protected boolean _selected = false;

	//Select and deselect methods - cannot be overridden
	public final void select()
	{
		_selected = true;
	}
	
	public final void deselect()
	{
		_selected = false;
	}
	
	//updateFromMouse method which all items must implement
	abstract public boolean updateFromMouse(int x, int y, int mouseX, int width, int mouseY);
	
}
