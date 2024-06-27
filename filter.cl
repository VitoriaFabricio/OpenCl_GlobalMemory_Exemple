#define filterWidth 3
#define filterHeight 3

__kernel void filter(__global unsigned int* input_image,
                    __global unsigned int* output_image,
                    unsigned int height, unsigned int width) {

    int global_id = get_global_id(0);

    int y = global_id / width;
    int x = global_id % width;
    
    int filter[filterWidth][filterHeight] = {
        {1, 1, 1},
        {1, 3, 1},
        {1, 1, 1}
    };

    int filter_sum = 0;
    for (int i = 0; i < filterWidth; i++) {
        for (int j = 0; j < filterHeight; j++) {
            filter_sum += filter[i][j];
        }
    }

    
    // Top-left corner

    for (int h = 1; h <= 64; h++) {
              
        int sum = 0;

        if(y<0 || y>=1024){
            printf("\nala o erro: %d, %d, %d\n", global_id, h, y*width+x);
        }
        if (y == 0 && x == 0) { 
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[y * width + (x + 1)] * filter[1][2];
            sum += input_image[(y + 1) * width + x] * filter[2][1];
            sum += input_image[(y + 1) * width + (x + 1)] * filter[2][2];
        } else if (y == 0 && x == width - 1) { // Top-right corner
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[y * width + (x - 1)] * filter[1][0];
            sum += input_image[(y + 1) * width + x] * filter[2][1];
            sum += input_image[(y + 1) * width + (x - 1)] * filter[2][0];
        } else if (y == height - 1 && x == 0) { // Bottom-left corner
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[y * width + (x + 1)] * filter[1][2];
            sum += input_image[(y - 1) * width + x] * filter[0][1];
            sum += input_image[(y - 1) * width + (x + 1)] * filter[0][2];
        } else if (y == height - 1 && x == width - 1) { // Bottom-right corner
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[y * width + (x - 1)] * filter[1][0];
            sum += input_image[(y - 1) * width + x] * filter[0][1];
            sum += input_image[(y - 1) * width + (x - 1)] * filter[0][0];
        } else if (y == 0) { // Top edge
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[y * width + (x - 1)] * filter[1][0];
            sum += input_image[y * width + (x + 1)] * filter[1][2];
            sum += input_image[(y + 1) * width + x] * filter[2][1];
            sum += input_image[(y + 1) * width + (x - 1)] * filter[2][0];
            sum += input_image[(y + 1) * width + (x + 1)] * filter[2][2];
        } else if (y == height - 1) { // Bottom edge
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[y * width + (x - 1)] * filter[1][0];
            sum += input_image[y * width + (x + 1)] * filter[1][2];
            sum += input_image[(y - 1) * width + x] * filter[0][1];
            sum += input_image[(y - 1) * width + (x - 1)] * filter[0][0];
            sum += input_image[(y - 1) * width + (x + 1)] * filter[0][2];
        } else if (x == 0) { // Left edge
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[(y - 1) * width + x] * filter[0][1];
            sum += input_image[(y + 1) * width + x] * filter[2][1];
            sum += input_image[y * width + (x + 1)] * filter[1][2];
            sum += input_image[(y - 1) * width + (x + 1)] * filter[0][2];
            sum += input_image[(y + 1) * width + (x + 1)] * filter[2][2];
        } else if (x == width - 1) { // Right edge
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[(y - 1) * width + x] * filter[0][1];
            sum += input_image[(y + 1) * width + x] * filter[2][1];
            sum += input_image[y * width + (x - 1)] * filter[1][0];
            sum += input_image[(y - 1) * width + (x - 1)] * filter[0][0];
            sum += input_image[(y + 1) * width + (x - 1)] * filter[2][0];
        } else { // Center
            sum += input_image[(y - 1) * width + (x - 1)] * filter[0][0];
            sum += input_image[(y - 1) * width + x] * filter[0][1];
            sum += input_image[(y - 1) * width + (x + 1)] * filter[0][2];
            sum += input_image[y * width + (x - 1)] * filter[1][0];
            sum += input_image[y * width + x] * filter[1][1];
            sum += input_image[y * width + (x + 1)] * filter[1][2];
            sum += input_image[(y + 1) * width + (x - 1)] * filter[2][0];
            sum += input_image[(y + 1) * width + x] * filter[2][1];
            sum += input_image[(y + 1) * width + (x + 1)] * filter[2][2];
        }

    
            output_image[y * width + x] = sum / filter_sum;
            y += 16;
    }       
    

}
