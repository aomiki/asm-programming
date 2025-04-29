#include<iostream>

extern "C"
{
  int calcDiv (int, char, short, short*);
}

int main(int argc, char* argv[])
{
    if (argc != 4)
    {
        return 1;
    }

    int a = std::stoi(argv[1]);
    char b = std::stoi(argv[2]);
    short c = std::stoi(argv[3]);

    short res = 0;
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
    
    std::cout << (a+c) /b; 

    return 0;
}  
