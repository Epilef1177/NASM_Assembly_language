#include <iostream>
using namespace std;
extern "C" int NParametros(int a, int b, int c);
//                          edi,    esi,    edx
int main()
{
    int a = 10, b = 50, c = 40;
    //cout << NParametros(1, 1, 1) << endl;
    cout << "A soma entre " << a << ", " << b << " e " << c << " é " << NParametros(a, b, c) << endl;
    return 0;
}