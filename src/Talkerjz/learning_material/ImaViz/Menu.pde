/*
 * Menu - Class for creating UI menus that can be navigated keyvboard or mouse
 */
class Menu {
	
	//Config consts
	public final static int MENU_WIDTH = 300;
	public final static int TITLE_HEIGHT = 65;
	
	//Title of menu
	protected String _title;
	
	//Array list of MenuItems
	protected MenuItem[] _items;
	
	//Currently selected item
	protected int _selected = -1;
	
	//Position
	protected int _x = 0;
	protected int _y = 0;
	
	//height
	int _height;
	
	//Constructor
	public Menu(String title, MenuItem[] items, int x, int y)
	{
		//Assign properties
		_title = title;
		_x = x;
		_y = y;
		
		//Select first item by default
		_selected = 0;
		
		//Assign menu items
		setItems(items);
			
	}
	
	//Returns the amount of menu items
	public int count()
	{
		return _items.length;
	}

	//Returns the selected index
	public int selected()
	{
		return _selected;
	}
	
	//Method to update the menu via the mouse
	public void updateFromMouse(int mouseX, int mouseY)
	{		
		//Starting y position
		int yPos = _y - (_height / 2) + 50; //Start y position
		
		//Select no item by default
		_selected = -1;

		//Loop through items
		for(int i = 0; i < _items.length; i++)
		{			
			//If the item is selectable and it's updateFroMouseMethod returns true
			if(_items[i].selectable() && ((SelectableMenuItem)_items[i]).updateFromMouse(_x, yPos + _items[i].height()/2, MENU_WIDTH, mouseX, mouseY))
			{
				//Set the currently selected item to the menu items index
				_selected = i;
				//Exit the loop
				break;
			}	

			//Increase the y position by the processed element's height
			yPos += _items[i].height();				
		}
		
	}
	
	//Method to select an item manually
	public void select(int index)
	{
		if(index < 0 || index > _items.length - 1) return;
		
		_selected = index;
		
		//If the item is not selectable try to get the next item
		if(!_items[_selected].selectable()) next();
	}
	
	//Method to select the next item
	public void next()
	{
		//If no item is selected, default to selecting the first item
		if(_selected == -1)
		{
			_selected = 0;
		}
		else
		{
			//Get the currently selected item
			int previous = _selected;
			
			//Whilst the next item cannot be selected 
			while(!_items[(_selected = ++_selected % _items.length)].selectable())
			{
				//If all elements have been processed, exit the loop
				if(_selected == previous) break; //If no selectable elements were found
			}
		}
		
	}
	
	//Method to select the previous item
	public void prev()
	{
		//If no item is selected, default to selecting the last item
		if(_selected == -1)
		{
			_selected = count()-1;
		}
		else
		{
			//Get the currently selected item
			int previous = _selected;
			
			//Whilst the previous item cannot be selected 
			while(!_items[(_selected = _selected == 0 ? _items.length - 1 : _selected - 1)].selectable())
			{
				//If all elements have been processed, exit the loop
				if(_selected == previous) break; //If no selectable elements were found
			}
		}
	}
	
	
	//Method to assign the menu items
	public void setItems(MenuItem[] items)
	{
		//Store them in the array
		_items = items;
		_height = TITLE_HEIGHT; //Minimum height for title
		
		//Add to the menu height per item
		for(int i = 0; i < items.length; i++)
		{
			_height += items[i].height();
		}
		
	}
	
	//Draw method
	public void draw()
	{
	
		//Draw rectangles from the center
		rectMode(CENTER);
		//Set stroke and fill
		stroke(255);
		strokeWeight(2);
		fill(25, 200);
		
		//Draw menu box
		rect(_x, _y, MENU_WIDTH, _height);
		
		//Set text options for title
		fill(255);
		textAlign(CENTER);
		textFont(g_title_font, 32);
		
		//Calculate the starting y position
		int startY = _y - (_height / 2) + 30;
		
		//Draw title
		text(_title, _x, startY);
		
		//Add padding for first item
		int yPos = startY + 20;
		
		//Loop through items
		for(int i = 0; i < _items.length; i++)
		{
			//If the item is selectable
			if(_items[i].selectable())
			{
				//If this item is selected, select it
				if(_selected == i)
					((SelectableMenuItem)_items[i]).select();
				//Otherwise deselect it
				else
					((SelectableMenuItem)_items[i]).deselect();
			}
			
			//Draw the item
			_items[i].draw(_x, yPos + _items[i].height()/2, MENU_WIDTH);
			
			//Increase the y position based on processed element's height
			yPos += _items[i].height();
		}
		
	}
	
	
	
	
}
