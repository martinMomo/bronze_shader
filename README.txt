Earl Martin Momongan
892994476
techwiz@csu.fullerton.edu

Custom Shader Assignment

Description: 

This is the custom shader that is implemented in the hello_glsl teapot code. It applies a bronze/golden shader on to the teapot. To summarize, it functions similarly to the Blinn-Phong shader code. The vertex shader is left alone while all the changes for the fragment shader is done in the ComputeLight function. The majority of the code was taken directly from the Blinn-Phong shader files with minor edits to convert it into a custom shader.

Now, in deeper detail, bronze.vert.shader is exactly the same as the blinn phong vertex shader and is completely untouched. This is the same for bronze.frag.shader with the ComputeLight function being changed to apply the golden shader effect. In terms of parameters, I added one extra parameter into the ComputeLight function to take in the eye direction value that was calculated in the main function. 

Now in the ComputeLight function, I had to calcualte the reflection vector and resulting color with the function given to us to use for the assignment. I declared two vector 3 variables called wRGB and pRGB which stored the W and P values respectively. 

I also created a vector 3 variable, refVal, to hold the reflection vector value. It was calculated using the formula: 2N(N * L) - L with N being the normal vector and L being the light direction vector.

A float angle variable was also made to hold the value of the angle between the eye direction and the reflection vector. This was calculated with the formula: acos of A.B / |A| * |B| with A and B being the eyeVec and the refVal.

Now that we have all these values, we can now compute the color being applied onto the teapot. A vector 3 variable cRGB was created and held the result of the function given to us for the assignment. We then convert the result into a vector 4 and return it along with the lambert and phong shader values. This then applies the color into each pixel individually which creates the color and shader effect we see on the teapot.


