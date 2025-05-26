#include<iostream>
#include <cmath>

void output_result(double x, int status, double res) asm("output_result");
void parse_input(int argc, char* argv[], double* x_out) asm("parse_input");

void output_result(double x, int status, double res)
{
	switch (status)
	{
		case 0:
			std::cout << "status: OK" << std::endl;
			std::cout << "actual: " << res << std::endl;
			break;

		case 1:
			std::cout << "status: FPTAN OVERFLOW" << std::endl;
			break;
		case 2:
			std::cout << "status: LOG ARG ZERO" << std::endl;
			break;
		case 3:
			std::cout << "status: LOG ARG NEG" << std::endl;
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

	std::cout << std::pow(std::tan(std::log(1/std::tan(2.0*x+M_PIf64x/2))), 3) << std::endl;
}

void parse_input(int argc, char* argv[], double* x_out)
{
	*x_out = std::stod(argv[1]);
}
