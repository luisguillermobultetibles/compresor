program compress;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.StrUtils,
  System.SysUtils,
  Math,
  BigInt,
  MyUtils in 'MyUtils.pas';

var
  i, test, root: LongWord;

function isperfectsquare(x: LongWord): Boolean;
var
  r: LongWord;
begin
  r := trunc(sqrt(x));
  Result := (r * r = x);
end;

function factoris(x: LongWord): LongWord;
var
  tmp, y, xx: LongWord;
begin
  if (x = 0) or (x = 1) then
  begin
    Result := x;
    exit;
  end;
  tmp := trunc(sqrt(sqrt(x)));
  while (tmp > 0) do
  begin
    test := (x - tmp * tmp * tmp * tmp);
    if (test mod 4) = 0 then
    begin // sg theorem
      if isperfectsquare(test) then
      begin
        y := trunc(sqrt(sqrt(test / 4)));
        xx := trunc(sqrt(sqrt(x - test)));
        Result := xx * xx + 2 * y * y + 2 * x * y;
        exit;
      end;
    end;
    tmp := tmp - 1;
  end;
  Result := 1;
end;

// Área de pruebas, pasa esta clase para BigIntegers

// Cribación
function pn(n: LongWord): LongWord;
var
  logn, loglogn: Extended;
begin
  // Calcular los valores de log(n) y log(log(n))
  logn := Ln(n);
  loglogn := Ln(Ln(n));

  // Calcular la fórmula para pn
  pn := trunc(n * (logn + loglogn - 1 + (loglogn - 2) / logn -
    ((sqr(loglogn) - 6 * loglogn + 11) / (2 * Ln(2)))));
end;

/// //////////////
///
///

function Pi(x: Integer): Integer;
var
  count, num: Integer;
begin
  count := 0;

  for num := 2 to x do
  begin
    if TBigInt.longWordIsPrime(num) then
      count := count + 1;
  end;

  Pi := count;
end;

// π(10)                             = 4
// π(100)                            = 25
// π(1000)                           = 168
// π(10000)                          = 1229
// π(100000)                         = 9592
// π(1000000)                        = 78498
// π(10000000)                       = 664579
// π(100000000)                      = 5761455
// π(1000000000)                     = 50847534
// π(10000000000)                    = 455052511
// π(100000000000)                   = 4118054813
// π(1000000000000)                  = 37607912018
// π(10000000000000)                 = 346065536839
// π(100000000000000)                = 3204941750802
// π(1000000000000000)               = 29844570422669
// π(10000000000000000)              = 279238341033925
// π(100000000000000000)             = 2623557157654233
// π(1000000000000000000)            = 24739954287740860
// π(10000000000000000000)           = 234057667276344607
// π(100000000000000000000)          = 2220819602560918841
// π(1000000000000000000000)         = 21127269486018731928
// π(10000000000000000000000)        = 201467286689315906290
// π(100000000000000000000000)       = 1925320391606803968923
// π(1000000000000000000000000)      = 18435599767349200867866
// π(10000000000000000000000000)     = 176844944073500872481823
// π(100000000000000000000000000)    = 1699198003310734225063668
// π(1000000000000000000000000000)   = 16351491779623324752602866
// π(10000000000000000000000000000)  = 15757361258476702191607674 ?
// π(100000000000000000000000000000) = 152046297512555434361215206 ?
//
// Primo 4:                           7
// Primo 25:                          97
// Primo 168:                         997
// Primo 1229:                        9973
// Primo 9592:                        99991
// Primo 78498:                       999983
// Primo 664579:                      9999991
// Primo 5761455:                     99999989
// Primo 50847534:                    999999937
// Primo 455052511:                   9999999967
// Primo 4118054813:                  99999999977
// Primo 37607912018:                 999999999989
// Primo 346065536839:                9999999999967
// Primo 3204941750802:               99999999999997
// Primo 29844570422669:              999999999999989
// Primo 279238341033925:             9999999999999937
// Primo 2623557157654233:            99999999999999997
// Primo 24739954287740860:           1000000000000000037
// Primo 234057667276344607:          10000000000000000039
// Primo 2220819602560918841:         100000000000000000031
// Primo 21127269486018731928:        1000000000000000000319
// Primo 201467286689315906290:       1000000000000000000039
// Primo 1925320391606803968923:      10000000000000000000359
// Primo 18435599767349200867866:     100000000000000000000031
// Primo 176844944073500872481823:    1000000000000000000000039
// Primo 1699198003310734225063668:   10000000000000000000000037
// Primo 16351491779623324752602866:  100000000000000000000000069
// Primo 15757361258476702191607674:  1000000000000000000000000039
// Primo 152046297512555434361215206: 1000000000000000000000000187


//
// procedure testMiller();
// var
// x: Integer;
// begin
// Write('Ingrese un número: ');
// ReadLn(x);
//
// WriteLn('π(', x, ') = ', Pi(x));
// end.

// primes less than 2^n
function prime_count(n: Integer): Integer;
var
  i, count: Integer;
  log2, x, t: real;

begin // Set the power of two you want to count primes up to
  count := 0;
  Result := 0;

  // Si el valor de n es 0 o 1, no hay números primos menores que n
  if (n = 0) or (n = 1) then
    exit;

  // Calcular log2(n)
  log2 := Math.logn(2, n);

  // Inicializar x y t
  x := 0.5;
  t := 0.5;

  // Iterar hasta la convergencia
  for i := 1 to trunc(log2) do
  begin
    t := t * (1 + 2 * x);
    x := x / 2;
  end;

  // Calcular el número de primos usando la fórmula corregida
  count := trunc(n / ln(n) * t);

  Result := count;
end;

var
  degugTime: Boolean;
  a, b, c, inputFileName, outputFileName: String;
  ba, bb, bc: TBigInt;
  jj: Integer;

begin
  // for jj := 0 to 100 do
  // begin
  // Write(trunc(Math.power(10, jj)));
  // Write(' - ');
  // WriteLn(Pi(trunc(Math.power(10, jj))));
  // ReadLn;
  // end;

  try
    { TODO -oUser -cConsole Main : Insert code here }
    WriteLn('Bienvenidos a la aplicación de prueba de compresión.');
    WriteLn('Objetivo: comprimir el archivo enwik9 de 1GB en menos que el record actual de 116MB.');
    WriteLn('Versión: 2023.');
    WriteLn('Autores: .');
    WriteLn;

    if (ParamCount = 3) or (ParamStr(1) = '-i') then
    Begin
      inputFileName := ParamStr(2);
      outputFileName := ParamStr(3);
      WriteLn('Inflating out:', outputFileName, ' from: ', inputFileName);

    End
    else if (ParamCount = 3) or (ParamStr(1) = '-d') then
    Begin
      inputFileName := ParamStr(2);
      outputFileName := ParamStr(3);
      WriteLn('Deflating: ', inputFileName, ' into: ', outputFileName);

    End
    Else if (ParamCount = 1) or (ParamStr(1) = '-t') then
    Begin
      WriteLn('Test and benchmarks:');
      for jj := 0 To MaxInt do
      Begin
        WriteLn(jj, '--> es primo', TBigInt.longWordIsPrime(jj));
        WriteLn(jj, 'primos menores que 2^', jj, ' --> ', prime_count(jj));
        WriteLn(jj, 'El primo número ', jj, ' --> ', TBigint.Create(jj).PrimeProgression().ToString);
        WriteLn(jj, 'Primos hasta ', jj, ' --> ', TBigint.Create(jj).EulerPi().ToString);
        WriteLn(jj, 'primos menores que 2^', jj, ' --> ', prime_count(jj));
        ReadLn;
      End;
      ReadLn;
    End
    Else if (ParamCount = 1) or (ParamStr(1) = '-h') then
    Begin
      WriteLn('Sintax:');
      WriteLn;
      WriteLn('To deflate use:');
      WriteLn(ParamStr(0), ' -d <inputFileName> <outPutFileName>');
      WriteLn;
      WriteLn('To inflate (a previous deflated file) use:');
      WriteLn(ParamStr(0), ' -d <inputFileName> <outPutFileName>');
      WriteLn;
      WriteLn(' In both cases, use double quotation marks to wrap');
      WriteLn('multiple words as one parameter (such as long file');
      WriteLn('names containing spaces).');
      WriteLn;
      WriteLn('To test and benchmarks:');
      WriteLn(ParamStr(0), ' -t');
      WriteLn;
      WriteLn('To show this help:');
      WriteLn(ParamStr(0), ' -h');
    End
    Else
    Begin
      WriteLn('Unknown command, please use: ', ParamStr(0),
        ' -h, to show help.');
      ReadLn;
      halt;
    End;

    halt(0);

    degugTime := True;
    if degugTime then
    Begin
      WriteLn('Sección de depuración.');
      WriteLn;
      Write('Teclee el valor de un número entero a:');
      ReadLn(a);
      Write('Teclee el valor de un número entero b:');
      ReadLn(b);
      WriteLn('Ok.');
      WriteLn;
      WriteLn('Pass I, operaciones ariméticas básicas...');
      ba := TBigInt.Create(a);
      bb := TBigInt.Create(b);

      bc := TBigInt.Create(a);
      Write('adición ');
      bc := TBigInt.Create(a);
      bc.add(bb);
      WriteLn(bc.ToString);
      bc.Free;
      Write('multiplicación ');
      bc := TBigInt.Create(a);
      bc.mul(bb);
      WriteLn(bc.ToString);
      bc.Free;
      Write('división ');
      bc := TBigInt.Create(a);
      bc.div_(bb);
      WriteLn(bc.ToString);
      bc.Free;
      Write('substracción ');
      bc := TBigInt.Create(a);
      bc.sub(bb);
      WriteLn(bc.ToString);
      bc.Free;
    End;

    WriteLn('Fin de la aplicación.');
    ReadLn;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.

// Fórmula de expansión asintótica [Cipolla1902] https://t5k.org/references/refs.cgi/Cipolla1902
// pn = n (log n + log log n - 1 + (log log (n) - 2)/log n - ((log log (n))2 - 6 log log (n) + 11)/(2 log2 n)).

// Date: Wed, 19 Jun 1996 16:16:11 +0200
// From: Marc Deleglise
// To: Chris Caldwell
//
// [See the previous note of 18 Apr 1996]
//
// I am pleased to send you some new values of pi(x): ( 2e18 means 2.10^(18) and so on...)
//
// pi(2e18)                 =    48 645 161 281 738 535
// pi(3e18)                 =    72 254 704 797 687 083
// pi(4e18)                 =    95 676 260 903 887 607
// pi(4185296581467695669)  =   100 000 000 000 000 000
// pi(5e18)                 =   118 959 989 688 273 472
// pi(6e18)                 =   142 135 049 412 622 144
// pi(7e18)                 =   165 220 513 980 969 424
// pi(8e18)                 =   188 229 829 247 429 504
// pi(9e18)                 =   211 172 979 243 258 278
// pi(1e19)                 =   234 057 667 276 344 607
// pi(2e19)                 =   460 637 655 126 005 490
// pi(4e19)                 =   906 790 515 105 576 571
// pi(1e20)                 = 2 220 819 602 560 918 840
//
// These values have been checked
//
// by computing pi(x) and pi(x + 1e7) and checking that the number of primes in the short interval agrees with the two values of pi.
// or by computing them two times with different values of 2 parameters y and z used during the computation.
//
// Thanks to Paul Zimmermann from INRIA Nancy who lend me some days of computation on his machines, (and also some hours of his time to compile the program on these machines!), and between other values got the pi(418....) = 10^17.
//
// The method is presented in Math of Comp 1996 by Deleglise & Rivat: Computing Pi(x), the Meissel, Lehmer, Lagarias, Miller, Odlyzko method [DR96]. The program is an improved implementation of the precedent version. The asymptotic time and space complexity are unchanged (O(x^(2/3)/logx^2) for time and O(x^(1/3)logx^3) for space);
//
// pi(1e19) took 40 hours of computation on a DEC-Alpha 5/250 and needed about 80Mo memory. pi(1e20) took 13days of computation on a DEC-ALPHA 5/250 (because of lack of memory, we had to exchange space against time) and also 13days on a R8000.
//
// Marc Deleglise
//
/// ////////////////////
/// //
/// //  Email from Jens Franke [Thu 7/29/2010 2:47 PM]: (color added)
//
// Using an analytic method assuming (for the current calculation) the Riemann Hypthesis, we found that
// the number of primes below 10^24 is 18435599767349200867866. The analytic method used is similar to the one described by Lagarias and Odlyzko, but uses the Weil explicit formula instead of complex curve integrals. The actual value of the analytic approximation to π(10^24) found was 18435599767349200867866+3.3823e-08.
//
// For the current calculation, all zeros of the zeta function below 10^11 were calculated with an absolute precision of 64 bits.
//
// We also verified the known values of π(10^k) for k < 24, also using the analytic method and assuming the Riemann hypothesis.
//
// Other calculations of π(x) using the same method are (with the deviation of the analytic approximation from the closest integer included in
// parenthesis)
//
// π(2^76)=1462626667154509638735 (-6.60903e-09)
// π(2^77)=2886507381056867953916 (-1.72698e-08)
//
// Computations were carried out using resources at the Institute for Numerial Simulation and the Hausdorff Center at Bonn University. Among others, the programs used the GNU scientific library, the fftw3-library and mpfr and mpc, although many time critical floating point calculations were done using special purpose routines.
//
// J. Buethe
// J. Franke
// A. Jost
// T. Kleinjung

  / * Tomado de x π
(x)π(x)− x / log x li(x)− π(x)x / π(x)x / log x % Error 10 4 0 2 2.500 -
  8.57 % 102 25 3 5 4.000 13.14 % 103 168 23 10 5.952 13.83 % 104 1,
  229 143 17 8.137 11.66 % 105 9, 592 906 38 10.425 9.45 % 106 78, 498 6,
  116 130 12.739 7.79 % 107 664, 579 44, 158 339 15.047 6.64 % 108 5, 761,
  455 332, 774 754 17.357 5.78 % 109 50, 847, 534 2, 592, 592 1,
  701 19.667 5.10 % 1010 455, 052, 511 20, 758, 029 3, 104 21.975 4.56 % 1011 4,
  118, 054, 813 169, 923, 159 11, 588 24.283 4.13 % 1012 37, 607, 912, 018 1,
  416, 705, 193 38, 263 26.590 3.77 % 1013 346, 065, 536, 839 11, 992, 858,
  452 108, 971 28.896 3.47 % 1014 3, 204, 941, 750, 802 102, 838, 308, 636 314,
  890 31.202 3.21 % 1015 29, 844, 570, 422, 669 891, 604, 962, 452 1, 052,
  619 33.507 2.99 % 1016 279, 238, 341, 033, 925 7, 804, 289, 844, 393 3, 214,
  632 35.812 2.79 % 1017 2, 623, 557, 157, 654, 233 68, 883, 734, 693, 928 7,
  956, 589 38.116 2.63 % 1018 24, 739, 954, 287, 740, 860 612, 483, 070, 893,
  536 21, 949, 555 40.420 2.48 % 1019 234, 057, 667, 276, 344, 607 5, 481, 624,
  169, 369, 961 99, 877, 775 42.725 2.34 % 1020 2, 220, 819, 602, 560, 918,
  840 49, 347, 193, 044, 659, 702 222, 744, 644 45.028 2.22 % 1021 21, 127, 269,
  486, 018, 731, 928 46, 579, 871, 578, 168, 707 597, 394,
  254 47.332 2.11 % 1022 201, 467, 286, 689, 315, 906, 290 4, 060, 704, 006,
  019, 620, 994 1, 932, 355, 208 49.636 2.02 % 1023 1, 925, 320, 391, 606, 803,
  968, 923 37, 083, 513, 766, 578, 631, 309 7, 250, 186,
  216 51.939 1.93 % 1024 18, 435, 599, 767, 349, 200, 867, 866 339, 996, 354,
  713, 708, 049, 069 17, 146, 907, 278 54.243 1.84 % 1025 176, 846, 309, 399,
  143, 769, 411, 680 3, 128, 516, 637, 843, 038, 351, 228 55, 160, 980,
  939 56.546 1.77 % 1026 1, 699, 246, 750, 872, 437, 141, 327, 603 28, 883, 358,
  936, 853, 188, 823, 261 155, 891, 678, 121 58.850 1.70 % 1027 16, 352, 460,
  426, 841, 680, 446, 427, 399 267, 479, 615, 610, 131, 274, 163, 365 508, 666,
  658, 006 61.153 1.64 % 1028 157, 589, 269, 275, 973, 410, 412, 739, 598 2,
  484, 097, 167, 669, 186, 251, 622, 127 1, 427, 745, 660,
  374 63.456 1.58 % 1029 1, 520, 698, 109, 714, 272, 166, 094, 258, 063 23, 130,
  930, 737, 541, 725, 917, 951, 446 4, 551, 193, 622, 464 65.759 1.52 % * /



