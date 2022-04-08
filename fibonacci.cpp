// Secuencia Fibonacci

#include <iostream>

using namespace std;

int fibonacci(int terminos)
{
    int anterior = 0;
    int actual = 1;
    int contador = 1;
    cout << anterior<< endl;
    while (contador < terminos)
    {   
        int siguiente = 0;
        cout << actual << endl;
        siguiente = actual + anterior;
        anterior = actual;
        actual = siguiente;
        contador += 1;
    }
    cout << endl;
    return 0;
}
int main(void)
{
    int terminos = 0;
    cout << "Dame cuantos numeros quieres: ";
    cin >> terminos;
    fibonacci(terminos);
    return 0;
}
