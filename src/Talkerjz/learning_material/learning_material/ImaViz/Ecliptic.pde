/*
 * Ecliptic Visualization - Creates a ripple of circles, who's stroke width is determined by the sound level
 */
class Ecliptic extends Visualization
{

	//The increment of the visualization, the smaller this number is, the more circles will appear
	final int STEP = 40;
	
	//Properties for color, maximum stroke weight and color
	protected int _x, _y, _width, _height;
	protected int _weight = 0;
	protected color[] _colors;

	//Constructor
	Ecliptic(int x, int y, int w, int h, int weight, color[] c)
	{
		//Assign properties
		_x = x;
		_y = y;
		_width = w;
		_height = h;
		_weight = weight;
		_colors = c;
	}	


	//Draw method
	public void draw(float[] left, float[] right, float[] mix, float left_level, float right_level, float mix_level)
	{
		//Disable fill, center circles, and enable smoothing
		noFill();
		ellipseMode(CENTER);
		smooth();
		
		//Counter for color
		int count = 0;
		
		//Loop through the data
		for(int i = 0; i < mix.length; i+= STEP)
		{
			//Determine width, height and stroke color based on the iteration		
			int w = (int)(((float)(mix.length - i) / (float)mix.length) * _width);
			int h = (int)(((float)(mix.length - i) / (float)mix.length) * _height);
			stroke(_colors[count]);
			
			//Assign stroke weight based on channel data
			strokeWeight(_weight * abs(mix[i]));
			
			//Draw the current circle
			ellipse(_x, _y, w, h);

			//Increment color and ensure it does not go out of bounds
			count = (count + 1) % _colors.length;
			
		}

		//Disable smoothing
		noSmooth();		
	}
}
