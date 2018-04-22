/*
 * CircleWave class to draw a wave form in a circle instead of a horizontal line (Wave class does this)
 */
class CircleWave
{
	
	//The increment of the visualization, the smaller this number is, the more detailed the wave will be
	protected int _step = 2;
	//Thickness of the line depicting the wave
	protected final int STROKE_WEIGHT = 2;	
	
	//Properties for size, color, and position
	protected float _multiplier = 50; //The amount the wave will traverse in/out of the circumference
	protected float _x = 0;
	protected float _y = 0;
	protected float _height = 0, _width = 0;
		
	//Color of the wave
	protected color _foreground = color(255);
	
	
	
	//Constructor	
	public CircleWave(float x, float y, float w, float h, float multiplier, color c)
	{
		//Set properties
		_x = x;
		_y = y;
		_width = w;
		_height = h;
		_multiplier = multiplier;
		_foreground = c;
	}
		
		
	//Draw method
	public void draw(float[] wave)
	{
		//Remove fill, set stroke weight and color and enable smoothing
		noFill();
		stroke(_foreground);
		strokeWeight(STROKE_WEIGHT);
		smooth();
	
		//Start shape drawing
		beginShape();
	
		//Loop through data
		for(int i = 0; i < wave.length; i += _step)
		{
			//Current angle
			float angle = angle(i, wave.length);
			//Distance from center
			float distance_x = distance(wave[i], false);
			float distance_y = distance(wave[i], true);
			//Starting point
			PVector start_point = point(wave[i], angle, distance_x, distance_y);
			
			//Get ending point
			int index = (i + _step);
			if(index > wave.length - 1) index = 0;
			float end_angle = angle(index, wave.length);
			float end_distance_x = distance(wave[index], false);
			float end_distance_y = distance(wave[index], true);
			PVector end_point = point(wave[i], end_angle, end_distance_x, end_distance_y);
	
			//Assign the vertex of the current line
			vertex(start_point.x, start_point.y);
			vertex(end_point.x, end_point.y);
			
		}
		
		//End the shape
		endShape();

		//Disable smoothing
		noSmooth();
		
	}
	
	//Method to set the position
	public void setPos(float x, float y)
	{
		_x = x;
		_y = y;
	}
	
	//Method to determine the angle of the current wave peak
	protected float angle(int index, int total)
	{
		return TWO_PI * ((float)index/(float)total);
	}
	
	//Method to determine the position of the current wave
	protected float distance(float value, boolean y)
	{
		return (y ? _height / 2 : _width / 2) + _multiplier * value;
	}
	
	//Get the x and y position of the current peak
	protected PVector point(float value, float angle, float x_distance, float y_distance)
	{
		return new PVector((int)(_x + (sin(angle) * x_distance)), (int)(_y + (cos(angle) * y_distance)));
	}
}
