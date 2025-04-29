#include<iostream>

extern "C"
{
  int calcDiv (int, int, int, int*);
}

int main(int argc, char* argv[])
{
    if (argc != 4)
    {
        return 1;
    }

    int a = std::stoi(argv[1]);
    int b = std::stoi(argv[2]);
    int c = std::stoi(argv[3]);

    int res = 0;
    int status = calcDiv(a,b,c, &res);
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

      default:
        break;
    }

    std::cout << "expected: ";
    std::flush(std::cout);

    if (b == 0 || (c/b + a) == 0)
    {
      std::cout << "status: DIV BY ZERO" << std::endl;
    }
    else
    {
      std::cout << (4*a - b - 1) / (c/b + a) << std::endl;
    }

    return 0;
}  
