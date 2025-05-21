#include<iostream>

void output_result(double a, double b, int status, double res) asm("output_result");
void parse_input(int argc, char* argv[], double* a_out, double* b_out) asm("parse_input");

void output_result(double a, double b, int status, double res)
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

	if (a == b)
	{
	  std::cout << -15.0 * b << std::endl;
	}
	else if (a < b)
	{
	  std::cout << (a*b - 20.0) / b << std::endl;
	}
	else if (a > b && b < 4)
	{
	  std::cout << b*b + 5.0 << std::endl;
	}
	else
	{
	  std::cout << "undefined behavior" << std::endl;
	}
}

void parse_input(int argc, char* argv[], double* a_out, double* b_out)
{
	*a_out = std::stod(argv[1]);
	*b_out = std::stod(argv[2]);
}
