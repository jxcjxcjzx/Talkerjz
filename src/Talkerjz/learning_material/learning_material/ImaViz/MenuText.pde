/*
 * MenuText - Class to respresent standard text in a menu that cannot be selected
 */
class MenuText extends MenuItem
{
	//Button height
	protected final int HEIGHT = 20;
	protected final int PADDING = 30;
	protected final color TEXT_COLOR = color(150);

	//Array list that stores the message in lines 
	protected ArrayList _lines;
	
	//Constructor
	public MenuText(String message)
	{
		//Assign properties
		_height = HEIGHT;
		
		//Current character being accessed
		int pos = 0;
		
		//Set the inital hight to 0
		_height = 0;		
		
		//Create a ArrayList of length 1
		_lines = new ArrayList(1);
		
		//While there are characters left
		while(pos < message.length())
		{
			//Current line
			String line = "";
		
			//While the current line does not extend past the maximum width + padding
			for(;textWidth(line) < Menu.MENU_WIDTH - PADDING && pos < message.length(); pos++)
			{
				//Add the next character
				line += message.charAt(pos);
			}
			
			//Add the new line
			_lines.add(line);
			//Increment height
			_height += HEIGHT;
		}
		
		//Empty string
		if(_height == 0)
		{
			//Add a blank space
			_lines.add("");
			_height = HEIGHT;
		}
		
		
	}
	
	
	//Draw the element
	public void draw(int x, int y, int width)
	{		
		//Set font
		fill(TEXT_COLOR);	
		textFont(g_font, 20);
		textAlign(CENTER);
		
		//Loop through lines
		for(int i = 0; i < _lines.size(); i++)
		{
			//Get the ypos of the text
			int ypos = (int)(y - (height() / 2) + HEIGHT*(2f/3f) + ((HEIGHT)*i));
			
			//Write the current line
			text((String)_lines.get(i), x, ypos);
		}
	}
	
	
}
