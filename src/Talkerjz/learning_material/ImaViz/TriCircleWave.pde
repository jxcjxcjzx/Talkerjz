/*
 * TriCircleWave Visualization - Visualization created by one CircleWave representing the mix channel. With two internal CircleWaves representing right and left, and optionally rotating
 */
class TriCircleWave extends Visualization
{
	//Waves
	private CircleWave _left, _right, _mix;
	
	//Properties for current rotation angle and spin value
	protected int _spin = 0;
	protected float _angle = 0;

	//Variables representing size of inner circles and position of the visualization
	protected int _small_width, _small_height, _x, _y;
	
	//Constructor
	public TriCircleWave(int x, int y, int w, int h, int d, color leftColor, color rightColor, color mixColor, int spin)
	{
		//Create the mix wave
		_mix = new CircleWave(x, y, w, h, d, mixColor);
		
		//Assign properties
		_small_width = w / 3;
		_small_height = h / 3;
		_spin = spin;
		_x = x;
		_y = y;
		
		//Create left and right waves
		_left  = new CircleWave(x - _small_width / 1.5, y, _small_width, _small_height, d / 3, leftColor);		
		_right = new CircleWave(x + _small_width / 1.5, y, _small_width, _small_height, d / 3, rightColor);
		
		

	
	}

	//Draw method
	public void draw(float[] left, float[] right, float mix[], float left_level, float right_level, float mix_level)
	{
		//If spinning is enabled
		if(_spin != 0)
		{
			//Increase angle
			_angle += (PI/180 * _spin);
			
			//Set new position of the waves
			_left.setPos (_x - (cos(_angle) * (_small_width / 1.5)), _y - (sin(_angle) * (_small_height / 1.5)));
			_right.setPos(_x + (cos(_angle) * (_small_width / 1.5)), _y + (sin(_angle) * (_small_height / 1.5)));
			
		}	
	
		//Draw the 3 waves
		_mix.draw(mix);
		_left.draw(left);
		_right.draw(right);
	}
}
