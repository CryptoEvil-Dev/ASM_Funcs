#include <stdio.h>
void NASMWrite(char *message);
int NASMSize(char *text);
int main(int argc, char *argv[]){

    char message[] = "Hello NASM\nlen ";
    NASMWrite(message);
    int size = NASMSize(message);

    printf("%d\n", size);
    return 0;
}
