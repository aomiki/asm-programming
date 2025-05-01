#include<iostream>

extern "C"
{
  int doAsmCalculations(int, int, int*);
}

int main(int argc, char* argv[])
{
    if (argc != 3)
    {
        return 1;
    }

    int a = std::stoi(argv[1]);
    int b = std::stoi(argv[2]);

    int res = 0;
    int status = doAsmCalculations(a,b, &res);
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
      std::cout << -15 * b << std::endl;
    }
    else if (a < b)
    {
      std::cout << (a*b - 20) / b << std::endl;
    }
    else if (a > b && b < 4)
    {
      std::cout << b*b + 5 << std::endl;
    }
    else
    {
      std::cout << "undefined behavior" << std::endl;
    }

    return 0;
}  
