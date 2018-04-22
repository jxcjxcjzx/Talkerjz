/*
 * Classic Visualization - Creates a classic style visualization in an scope style. 3 waves are created, representing mix, left and right. Left and right waves only gain 1/3 of the height of the mix wave
 */
class Classic extends Visualization
{
	//The 3 waves
	protected Wave _left, _right, _mix;	
	
	//Constructor
	public Classic(int x, int y, int width, int height, color leftColor, color rightColor, color mixColor)
	{
		//Create the 3 waves
		_left = new Wave(x, y, width, height/3, leftColor);
		_right = new Wave(x, y, width, height/3, rightColor);
		_mix = new Wave(x, y, width , height, mixColor);
	}

	//Draw method
	public void draw(float[] left, float[] right, float[] mix, float left_level, float right_level, float mix_level)
	{
		//Enable smoothing
		smooth();
		//Draw the 3 waves
		_left.draw(left);
		_right.draw(right);
		_mix.draw(mix);
		
		//Disable smoothing
		noSmooth();
	}
}
