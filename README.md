# compresor
Compresión de información por factorización aritmética total y una codificación binaria reducida.


Me: luisguillermobultetibles@gmail.com
Id: 74092510328
mobil: 59967848
fijo: +53 32 690574 (Cuba)

Solamente el framework con las funciones útiles del proyecto, todavía no está completo... 
La versión vieja funcionaba pero esta es totalmente nueva, se basa en el formato adoptado.

La sección de números primos del socio de TBigInt no funcionan bien, pretendo implementar los mios propios.
También se puede sustituir la unit, prefiero remodelarla, me gusta su filosofía pero se puede optimizar.

Estado del proyecto:
.Arreglar la solidificación (ceros a la izquierda de los archivos al convertirlos a números).
.Arreglar el factorizador y el chequeo de primalidad de BigInt.
.Incluir las funciones pi de Euler (contadora de primos) y progresión (o serie) de primos; ancladas a tablas de valores típicos
 por ejemplo algunas potencias de dos, potencias enteras de 10.
.Estabilidar una versión que funcione para archivos pequeños (comprimir y descomprimir).
.y luego, incluir pruebas (hch, tdf, etcétara) y funciones estocásticas de factorización, o expeculativas estimación de índices, para primos grandes y muy grandes. 

My english is so bad as your surely, but try to get the main idea:

CALS, compression system:
Prefix 0 -> Codes zero, although it is also used in the factor prefix to determine the product series.
Prefix 10 -> Factor, what follows is a zero-based prime number index and then its exponent.
If the base of the number is 2, it represents or encodes 2^ exponent, otherwise it encodes 2^ (exponent + 1)
Prefix 11 -> Product, what follows is a series of factors, with the particularity that the prefix 10 is not used
in each of them, but a series of pairs (of numbers) to describe bases and exponents; and a zero bit
(0) to finish. In this series, the first base is the index of a zero-base prime
(such that P(0) = 2, P(1) = 3 ... etc.), followed by an exponent that is encoded independently,
It is followed by a number that represents the second base with a number that represents a relative displacement
in base zero (0, which is taken as the next prime or immediate to the right), another exponent follows, idem
to the previous one in its coding (independent), and then, either a zero (0) to express the end of the product,
or as many factors as necessary (after third base), the zero is kept at the end to finish
the series, but from the third factor, if it has one, the displacements to the next prime number will be taken
in base one (1) since 0 ends the series, so that 1 means the next prime or immediate, 2, two to
the right, and so on.
This is the binary expression of the Fundamental Theorem of Arithmetic, although it is recursive, each number has a unique expression.
                  Observations
       To avoid redundancies, other prime numbers than two cannot be used to obtain the value 1, in those cases,
       It is assumed that its power is increased by one, that is, when the base is different than two, the predecessor of the power is encoded.
       In the list of factors, only the absolute index of the first prime number is taken, and thus it is not necessary to encode
       completely the following, a relative displacement is enough, taking the base zero, for the next one.
       Each new prime factor in the list must be based on the index of the previous prime plus one, in this way too,
       we optimize the reference to the indexes. The system consists of two main recurring (or recursive) processes,
       one is the indication of factors and the other is the factorization of indices, which have a termination condition
       concrete (they converge for the entire domain), to which another process is applied to obtain unique binary encoding,
       Thus decoding is guaranteed, since these processes are reversible, that is, compression is a bijective function,
       The function pi exists because the set of primes, being a subset of the natural ones, is also a countable function.


