//Abstract visualization class which all visualizations must inherit to be used within the ImaViz application
abstract class Visualization
{
	//Draw method which is called every frame, the left, right and mix channels are passed in, including the average levels of all 3. Not all values need to be used
	abstract public void draw(float[] left, float[] right, float[] mix, float left_level, float right_level, float mix_level);
	
	//Is called when visualization is changed - useful for pulsar or any other linked-stack type visualization
	public void reset() {};
	
}
