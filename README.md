# compresor
Compresión de información por factorización aritmética total y una codificación binaria reducida.


Me: luisguillermobultetibles@gmail.com
Id: 74092510328
mobil: 53 59967848
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

BCALS, compression system:
#Prefix 0 -> Codes zero, although it is also used in the factor prefix to determine the product series.
#Prefix 10 -> Factor, what follows is a zero-based prime number index and then its exponent.
If the base of the number is 2, it represents or encodes 2^ exponent, otherwise it encodes 2^ (exponent + 1)
#Prefix 11 -> Product, what follows is a series of factors, with the particularity that the prefix 10 is not used
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
                  
                  #Observations
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


# This is not gzip, deflate internet navigator's browser compressor's competence, is just an INTERNET 3 LEVEL 2-DRIVER 
# (RFC Proposal: october 31, 2023, by Lic. Luis Bultet Ibles, Cuba).

  .To use with the previous described algorithm, and with no one else.

  .Guarantees continuity in transmission, speed and maximum use of bandwidth. (Real time)
  .It is proposed for updating the TCP-IPv6 packet format, and layer B (2 or data) of the OSI network model.
  Or, failing that, its implementation in the national intranet, with its prior validation in some experimental sub-network.

  Technical definitions

   Requirements
   -----------------------
   It is assumed that the system can know the speed at which it is connected,
   The estimated compression and decompression times will be adjusted with the tests and
   They depend on the speed of the processor and the quality of the compression algorithms,
   Another of the capabilities that the system should have for better functioning is
   falls forward and backward, (fallforward and fallback) which is when
   there is an increase or decrease in speed while being connected, in that case the system would need
   reevaluate the optimal way of transmitting the remaining part of the packet that remains to be sent,
   Ultimately, a finer adjustment would also include the estimated delivery times.
   analysis so as not to waste time, not even analyzing, when the packages are very small,
   the speed is very high and/or it takes very little time to finish sending the data;
   and in exceptional cases in which it is not necessary to apply the algorithm, since the speeds of
   transfer are much superior to processing.
   An analysis of the minimum route for the transfer of such packets may optionally be included, but
   This last capacity is optional, since it is just what routers and routers have done for some time.
   internet servers.
   Analyze whether to be a preliminary for RFC.


   etc...


   Let the functions be:
   -----------------------
   Vu - Transmission (upload) speed in bits per second (BPS).
   Vd - Reception speed (download), assumed the same as Vu, but can be different.
   Ss(x) - Size of data x, (in bits).
   Sd(x) - Estimated compression size of data x.
   Tc(x) - Estimated compression time of data x, (fractions of seconds).
   Te(x) - Estimated decompression time of data x.
   Tts(x) - Uncompressed data x transmission time, Tts(x) = Vu*Ss(x).
   Ttd(x) - Estimated transmission time of compressed data x, Tt(x) = Vu*Sd(x).

   Relating to the object P, with the following properties:
   -----------------------
   P - Packet to transmit (or to receive), description of the fields.

   Properties Type Description
   C Logic Compressed packet.
   TE Uncompressed integer size (in bits).
   x Array (The blob) Contains the data to be transmitted or received.

   Transmission Algorithm (Construction of the packet).
   -----------------------
   Entry: A piece of information x.
       If [Tc(x) + Ttd(x) + Te(x)] < Tts(x) Then
            1.Transmit the first (Tc(x) + Te(x)) * Vu uncompressed bits.
            2.Compress the rest, and Transmit it after step 1 is finished.
            (These two steps can be performed in parallel, ie, 1 and 2 can be two independent tasks or steps.)
       But
            3.Send the package uncompressed

   Reception Algorithm
   -----------------------
   Entry: A piece of information x.
       1. If the package is compressed then
            1.1 Unzip it (before...)
       2. Give it a normal course.

   Recommendations:
   -----------------------
  There are three typical situations that can be taken into account when optimizing:

   1._Incomprehensible: keep in mind that if it is not understandable, the second part is transmitted (uncompressed), this does not
         affects the transmission speed rate since it is carried out at optimal time, that is, this result is obtained
         while the first part of the data is being sent (uncompressed); so that it is almost transparent.
   2._Time out: If too much time is taken in the actual compression (more than the estimated or the one taken in
         transmit the packet header), will be assumed incomprehensible for the purposes of the transmission algorithm.
   3._Fallforwad: Increased connection speed.
   4._Fallback: Decrease in connection speed.
   5._Buffer: Includes an intermediate store of packets to be transmitted, so that with each new data entry,
         reevaluate whether or not to send them compressed, analyzing all untransmitted data as a
         All-in-all, this would be possible with a parallel process that analyzes the data stream before it reaches them.
         the Porter; If the compression algorithm is convenient, a second improvement could be added, which
         consists of, taking a fragment from the end of the packet before compressing, large enough to
         ensure bit-level interleaving
