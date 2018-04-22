/*
 * Pulsar Visualization - Utilizes the CircleWave alongside a linked stack to created a pulsing wave animation
 */
class Pulsar extends Visualization
{

	//Properties
	protected float _multiplier = 50;
	protected float _x, _y, _width, _height;
	
	//Root pulse
	protected Pulse _pulse = null;

	//Colors
	protected int[][] _colors;
	
	//Color count
	protected int _count = 0;
	
	//Constructor
	public Pulsar(float x, float y, float w, float h, float multiplier, int[][] colors) 
	{
		//Assign properties
		_x = x;
		_y = y;
		_width = w;
		_height = h;
		_multiplier = multiplier;
		_colors = colors;
	}
	
	//Draw method
	void draw(float[] left, float[] right, float[] mix, float left_level, float right_level, float mix_level)
	{
		//Create a new pulse
		Pulse p = new Pulse(_x, _y, _width / 4, _height / 4, _multiplier, mix, _colors[_count][0], _colors[_count][1], _colors[_count][2]);
		
		//Set the parent of the new pulse to the current stack top
		p.parent = _pulse;
		
		//Set the stack top to the new pulse
		_pulse = p;
		
		//Draw the top pulse - and it's parents
		_pulse.draw();
		
		//Increment color count and ensure it does not go out of bounds
		_count = (_count + 1) % _colors.length;
		
	}
	
	//Reset method
	void reset()
	{
		//Reset the stack with a blank pulse
		float[] mix = new float[BUFFER_SIZE];
		_pulse = new Pulse(_x, _y, _width / 4, _height / 4, _multiplier, mix, 0, 0, 0);
	}
}
