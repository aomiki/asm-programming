#include<iostream>

void output_result(int count, int* arr, int status, int res) asm("output_result");
void parse_input(int argc, char* argv[], int* count_out, int** arr_out) asm("parse_input");

void output_result(int count, int* arr, int status, int res)
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

	int positive = 0, negative = 0;
	for (size_t i = 0; i < count; i++)
	{
		if (arr[i] > 0)
		{
			positive += arr[i];
		}
		else
		{
			negative += arr[i];
		}
	}

	std::cout << positive - negative << std::endl;
}

void parse_input(int argc, char* argv[], int* count_out, int** arr_out)
{
	*count_out = argc-1;

	int* arr = new int[*count_out];

	for (size_t i = 0; i < *count_out; i++)
	{
		arr[i] = std::stoi(argv[1 + i]);
	}

	*arr_out = arr;
}
