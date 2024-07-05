# OpenCl_GlobalMemory_Exemple

This program demonstrates the use of OpenCL to apply a 3x3 filter to an image. 

The main components include:

Host Code (main.c):

- Reads an image from a CSV file (original_0.csv).
- Initializes OpenCL environment: platform, device, context, command queue.
- Reads and builds the OpenCL kernel (filter.cl).
- Sets up memory buffers and transfers data between host and device.
- Executes the kernel to apply the filter to the image.
- Measures and prints the execution time.
- Reads the processed image from the device and writes the result to a CSV file (result.csv).

Kernel Code(filter.cl):

- Applies a 3x3 filter to the input image, handling edge cases for pixels at the borders and corners of the image.
- The filter weights and dimensions are defined within the kernel.


Compilation:

	(Geral) 	g++ -Wall main.c -o main -l OpenCL
	(AMD) 		g++ -Wall main.c -o main -I/opt/rocm-4.2.0/opencl/include/ -L/opt/rocm-4.2.0/lib/ -l OpenCL
	(NVIDIA) 	g++ -Wall main.c -o main -I /usr/local/cuda/include/ -l OpenCL

Execution:

./main

