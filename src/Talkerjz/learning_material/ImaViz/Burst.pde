/*
 * Burst visualization - Creates rectangles within a circle pattern, length is determined by the mix channel, width by the right channel, and color by the left channel
 */
class Burst extends Visualization 
{
	
	//The increment of the visualization, the smaller this number is, the more rectangles will appear
	protected final int STEP = 1;
	//Maximum width of a rectangle
	protected final int MAX_THICKNESS = 5;
	
	//Properties for size and position
	protected float _diameter, _x, _y;
	
	//Array to store possible colors
	protected color[] _colors;
	
	//Constructor
	Burst(float x, float y, float d, color[] c)
	{
		//Assign properties
		_x = x;
		_y = y;
		_diameter = d;
		_colors = c;
	}
	
	//Draw method
	public void draw(float[] left, float[] right, float[] mix, float left_level, float right_level, float mix_level)
	{
		//Remove stroke
		noStroke();
		
		//Enable smoothing
		smooth();
	
		//Rect mode
		rectMode(CENTER);
	
		//Store original translation
		pushMatrix();		
		
		translate(_x, _y); //Set center as 0,0
		
		//Loop through channel data
		for(int i = 0; i < mix.length; i += STEP)
		{
					
			//Set color based on volume of left channel
			int colorIndex = (int)round(_colors.length * abs(left[i]));			
			if(colorIndex == _colors.length) colorIndex = 0;		
			fill(_colors[colorIndex]);
			
			
			//Determing y position and length
			float y = _diameter / 4 + (_diameter / 4 * abs(mix[i]) * 0.5) * (mix[i] < 0 ? -1 : 1);
			float height = 1 + (_diameter / 4) * abs(mix[i]);
			
			//Determine thickness
			float thick = STEP + ((MAX_THICKNESS-STEP) * right[i]);
			
			//Draw rect
			rect(0, y, thick, height);
			
			//Rotate to next rect
			rotate(TWO_PI * ((float)i / mix.length));
		}
		
		
		//Disable smoothing
		noSmooth();
		
		//Restore original translation
		popMatrix();
	}
	
}
