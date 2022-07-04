#include <math.h>

#include <iostream>

int main(int argc, char *argv[]) {
  std::cout << "add: " << math::Add(2, 3) << std::endl;
  std::cout << "sub: " << math::Sub(3, 2) << std::endl;
  std::cout << "div: " << math::Div(4, 1) << std::endl;
  return 0;
}
