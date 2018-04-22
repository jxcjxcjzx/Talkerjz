/*
 * Wave - Used to display a classic scope type wave
 */
class Wave
{
	//The increment of the visualization, the smaller this number is, the more detailed the wave will be
	protected final int STEP = 2;
	//Stroke weight
	protected final int STROKE_WEIGHT = 1;
	
	//Properties for size and position
	protected int _width, _height, _x, _y;
	//Property for color
	color _color;
	
	//Constructor
	public Wave(int x, int y, int w, int h, color c)
	{
		//Assign properties
		_x = x;
		_y = y;
		_width = w;
		_height = h;
		_color = c;
	}
	
	//Draw method	
	void draw(float[] wave)
	{
		//Loop through the data
		for(int i = 0; i < wave.length; i += STEP)
		{
			//Get the start and end position of the current line of the wave
			float startX = _x + (_width * ((float)(i - wave.length / 2) / wave.length));
			float endX = _x + (_width* ((float)(i + STEP - wave.length / 2) / wave.length));
			float startY = _y + (_height / 2 * wave[i]);
			float endY = _y + (_height / 2 * wave[(i+STEP)%wave.length]);
			
			//Set the stroke color and weight
			stroke(_color);
			strokeWeight(STROKE_WEIGHT);
			
			//Draw the line
			line(startX, startY, endX, endY);			
		}
	}
	
}
