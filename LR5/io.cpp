#include<iostream>

void output_result(float a_out, float b_out, float c_out, int status, float res) asm("output_result");
void parse_input(int argc, char* argv[], float* a_out, float* b_out, float* c_out) asm("parse_input");

void output_result(float a, float b, float c, int status, float res)
{
	switch (status)
	{
		case 0:
			std::cout << "status: OK" << std::endl;
			std::cout << "actual: " << res << std::endl;
			break;

		case 1:
			std::cout << "status: ADD OVERFLOW" << std::endl;
			break;
		case 2:
			std::cout << "status: SUB OVERFLOW" << std::endl;
			break;
		case 3:
			std::cout << "status: DIV OVERFLOW" << std::endl;
			break;
		case 4:
			std::cout << "status: MUL OVERFLOW" << std::endl;
			break;

		case 5:
			std::cout << "status: DIV BY ZERO" << std::endl;
			break;

		case 6:
			std::cout << "b >= 4, undefined behavior" << std::endl;

		default:
			break;
	}

	std::cout << "expected: ";
	std::flush(std::cout);

	std::cout << (2*b + 7*c)/(a/2 - 12*c) << std::endl;
}

void parse_input(int argc, char* argv[], float* a_out, float* b_out, float* c_out)
{
	*a_out = std::stof(argv[1]);
	*b_out = std::stof(argv[2]);
	*c_out = std::stof(argv[3]);
}
