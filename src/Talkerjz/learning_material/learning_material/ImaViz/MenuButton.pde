/*
 * MenuButton - Class to represent selectable and clickable buttons in a menu
 */
 
class MenuButton extends SelectableMenuItem
{
	//Button height
	final int HEIGHT = 35;
	final color HIGHLIGHT_COLOR = color(100, 200);
	final color TEXT_COLOR = color(255);

	//Message
	protected String _message;
	
	//Constructor
	public MenuButton(String message)
	{
		//Assign properties
		_selectable = true;
		_height = HEIGHT;
		_message = message;
	}
	
	
	//Draw the element
	public void draw(int x, int y, int width)
	{
		//If the item is selected, draw the highlight
		if(_selected)
		{
			noStroke();
			fill(HIGHLIGHT_COLOR);
			rect(x, y, width-2, height());
		}			
			
		//Draw the button text
		fill(TEXT_COLOR);	
		textFont(g_font, 20);
		textAlign(CENTER);
		text(_message, x, y + 5);
	}
	
	//Mouse update
	public boolean updateFromMouse(int x, int y, int width, int mouseX, int mouseY)
	{
		return mouseX >= x - (width-2) / 2 && mouseX <= x + (width-2)/2 && mouseY >= y - HEIGHT/2 && mouseY <= y + HEIGHT/2;		
	}
	
}	
