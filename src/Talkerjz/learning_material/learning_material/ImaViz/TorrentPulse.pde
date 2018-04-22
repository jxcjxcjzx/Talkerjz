/*
 * TorrentPulse - Represents an item in the Torrent linked list and generates a set of partcles in the shape of the wave around a circle
 */
class TorrentPulse
{
	//Constants for animation
	private final int STEP = 10, SPEED = 10, ALPHA_STEP = 35, GRAVITY = 6, SIZE = 20;

	//Attributes for each particle
	protected float[] _particles_x, _particles_y;
	protected float[] _speed_x, _speed_y;
	protected int[][] _colors;
	
	//Attributes for alpha and size
	protected int _alpha = 255;
	protected int _size = 1;
	
	//Parent element in list
	public TorrentPulse parent = null;
	
	//Constructor
	public TorrentPulse(float[] mix, float left, float right, int x, int y, int width, int height, int[][] c)
	{
		//Create new arrays based on the amount of particles being generated
		_particles_x = new float[(int)ceil((float)mix.length/STEP)];
		_particles_y = new float[(int)ceil((float)mix.length/STEP)];
		_speed_x = new float[(int)ceil((float)mix.length/STEP)];
		_speed_y = new float[(int)ceil((float)mix.length/STEP)];
		_colors = new int[(int)ceil((float)mix.length/STEP)][3];
		
		//Get the size of the particles based on the left channel
		_size = (int)(left * SIZE);
		
		//Counter for the particles
		int counter = 0;		
		
		//Loop through the data
		for(int i = 0; i < mix.length; i += STEP)
		{
			//Determine the current angle
			float angle = TWO_PI * ((float)i / mix.length);
			
			//Determine the starting position for the particle
			float sx = x + sin(angle)*(width / 2) * (mix[i] + 0.3);
			float sy = y + cos(angle)*(height / 2) * (mix[i] + 0.3);
			
			//Assign particle location
			_particles_x[counter] = sx;
			_particles_y[counter] = sy;
			
			//Assign speed of the particles based on the right channel
			_speed_x[counter] = sin(angle)*((SPEED) * right);
			_speed_y[counter] = cos(angle)*((SPEED) * right);
			
			//Determine the color of the particles based on the wave
			int index = (int)(round(c.length * abs(mix[i]) + 0.3)) % c.length;					
			_colors[counter] = c[index];
			
			counter++;
		}
		
		
		
	}
	
	//Method to return the alpha
	public int alpha()
	{
		return _alpha;
	}
	
	//Draw method
	public void draw()
	{
	
		//Disable stroke and set ellipse mode
		noStroke();
		ellipseMode(CENTER);

		//If the pulse has a parent
		if(parent != null)
		{			
			//Draw the parent
			parent.draw();
			//If the parent is invisible, delete it
			if(parent.alpha() <= 0) parent = null;
		}
		
		//Loop through the particles
		for(int i = 0; i < _particles_x.length; i++)
		{
			//Set the fill color to the particles color
			fill(_colors[i][0], _colors[i][1], _colors[i][2], _alpha);
			
			//Draw rhe particle
			ellipse(_particles_x[i], _particles_y[i], _size + 1, _size + 1);
						
			//Add to the particle location based on the speed
			_particles_x[i] += _speed_x[i];
			_particles_y[i] += _speed_y[i];
			
			//Add gravity's acceleration to the y_speed
			_speed_y[i] += GRAVITY;
		}
		
		//Decrement alpha
		_alpha -= ALPHA_STEP;	
		
	}
	
}	
