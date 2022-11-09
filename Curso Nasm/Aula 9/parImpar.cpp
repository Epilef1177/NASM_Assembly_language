#include <iostream>
using namespace std;
extern "C" int ParImpar(int a);

int main()
{
    int a = 28;
    int x = ParImpar(a);
    if (x == 0){
        cout << "Número " << a << " é Par" << endl;
    }else if(x == 2){
        cout << "Mudei o curso do programa com o ret. E o eax retornou " << x << endl;
    }else{
        cout << "Número " << a << " é Ímpar" << endl;
    }
    return 0;
}