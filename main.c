#include <string.h>

int i, j;

int main ()
{
    while ( 1 )
    {
        for (i = 0; i < 1000; ++i)
        {
            asm ( "nop;" );
            memcpy ( &j, &i, sizeof ( int ) );
        }
    }

    return 0;
}
