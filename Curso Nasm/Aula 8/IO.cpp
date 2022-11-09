#include <iostream>
using namespace std;
extern "C" int GetValorASM(int a);

int main()
{
    cout << "ASM retornou " << GetValorASM(32) << endl;
    return 0;
}