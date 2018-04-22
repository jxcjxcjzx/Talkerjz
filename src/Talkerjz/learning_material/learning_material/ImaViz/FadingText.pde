/*
 * Fading Text - A class to show the name of the visualization, which will fade quickly
 */
class FadingText
{
	//Amount of alpha to reduce per frame
	final int ALPHA_STEP = 20;

	//Font for the fading text
	protected PFont _font = loadFont("alt-40.vlw");
	
	//Message string
	public String message = "";
	
	//Position and alpha
	protected int _x, _y, _alpha = 255;
	
	//Constructor
	public FadingText(int x, int y)
	{
		//Assign properties
		this._x = x;
		this._y = y;
	}
	
	//Draw method
	public void draw()
	{	
		//Set font and align cetner
		textFont(_font, 40);
		textAlign(CENTER);
		
		//Draw background
		fill(50, _alpha);		
		rectMode(CENTER);
		noStroke();
		rect(APP_WIDTH / 2, _y, APP_WIDTH, 50);
		
		//Set font color
		fill(255, _alpha);	

		//If the fading text is still visible
		if(_alpha > 0) 
		{
			//Reduce alpha
			_alpha -= ALPHA_STEP;
			//Make sure alpha does not drop below 0
			if(_alpha < 0) _alpha = 0;
		}
		
		
		//Draw the message
		text(message, _x, _y + 15);
			
	}
	
	//Reset method
	public void reset()
	{
		//Reset alpha to max
		_alpha = 255;
	}
	
	
	
}
