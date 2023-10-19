unit MyUtils;

interface

procedure inflate(inputFileName: String; outPutFileName: String);
procedure deflate(inputFileName: String; outPutFileName: String);

implementation

uses BigInt;

procedure inflate(inputFileName: String; outPutFileName: String);
begin
end;

procedure deflate(inputFileName: String; outPutFileName: String);
begin
end;

end.

// Versi�n vieja del compresor Infoclub

// Codificar n�mero
Function xPrimeEncode(a: BigInt): BigInt;
// agregar un parÄ† metro base relativa, para agregarlo o restarlo al Ä†Ā­ndice.
var
  p, pws, I, laPiltrafa, pdi, dummyRest: TBigInt;
Begin

  If a = Zero Then
  Begin
    Result := Zero;
    Exit
  End
  Else If a = One Then
  Begin
    Result := Eight;
    Exit
  End;

  p := PrimerFactorPrimo(a, pws);
  // Obtener el primerfactor primo en p y su exponente en pws...

  // Singular...
  If a = Potencia(p, pws) Then
  Begin // Es la potencia de un Primo, codificaciÄ†Ā³n 10 indicedelprimo exponente.
    If (p = Two) Then
    // En prefijo 10 si el primo es 2 el exponente va Ä†Ā­dem.
    Begin
      Result := Concatenate(Two, Zero);
      Result := Concatenate(Result, xPrimeEncode(pws))
    End
    Else // y si no es 2 al exponente se le resta 1. SegÄ†Å—n especificaciÄ†Ā³n 181.TXT (2017).
    Begin
      // En este de arriba si se le resta la base.
      Result := Concatenate(Two, xPrimeEncode(Indicedelprimo(p)));
      // En este de abajo la codificaciÄ†Ā³n se reinicia a cero pues es un nuevo No.
      Result := Concatenate(Result, xPrimeEncode(Restar(pws, One)))
    End;
    // This work is done...
    Exit
  End;

  // Plural...
  laPiltrafa := Zero;
  // En realidad laPiltrafa es el Ä†Ā­ndice del primo anterior...

  Begin // Es compuesto, codificaciÄ†Ā³n 11 factor factor...
    Result := Three;
    While MayorQue(a, Zero) And (Not IgualQue(a, One)) Do
    Begin
      pdi := PrimerFactorPrimo(a, pws);
      laPiltrafa := Restar(pdi, laPiltrafa);
      laPiltrafa := pdi;
      Result := Concatenate(Result, xPrimeEncode(Potencia(pdi, pws)));
      a := Dividir(a, Potencia(pdi, pws), dummyRest)
    End;

    Result := Concatenate(Result, Zero);
    // TerminaciÄ†Ā³n de la serie de factores...
    // This work is done.
    Exit
  End
End;

// Convertir a binario...
Function Binary(a: BigInt): BigInt;
Var
  I: Cardinal;
Begin
  Result := '';
  For I := StrToInt64(bitsLen(a)) - 1 DownTo 0 Do
    Result := Result + GetBit(a, IntToStr(I))
End;

// Estirar...
Function Stretch(a: TBits): BigInt;
Var
  I: Cardinal;
Begin
  Result := Zero;
  For I := Pred(a.Size) DownTo 0 Do
    Result := Sumar(Multiplicar(Result, Two), IntToStr(a[I]))
End;

// Encoger...
Function Shrink(a: BigInt): TBits;
Var
  I: Cardinal;
Begin
  Result := TBits.Create;
  I := 0;
  Repeat
    Result[I] := 1 - Byte(EsPar(a));
    a := DIVIDE(a, Two);
    INC(I)
  Until a = Zero End;

  // Codificar nÄ†Å—mero...
  Function xPrimeDecode(a: BigInt; baseRelativa: BigInt): BigInt;
  // aÄ†Ā±adir un parÄ† metro primo base relativa, para agregarlo o restarlo al Ä†Ā­ndice.
  // no usarlo como parÄ† metro en las funciones de decodificaciÄ†Ā³n internas.
  //
  Var
    B: TBits;

    function getAnything: BigInt;
    Var
      base, exponente, codec, baseAnterior: BigInt;
    Begin
      If B.LastBit = 0 Then
      Begin
        B.Size := B.Size - 1;
        Result := Zero
      End
      Else // desde entonces era 1, ya ves no hay otra opciÄ†Ā³n... sigo.
      Begin
        B.Size := B.Size - 1;
        If B.LastBit = 0 Then // Es un factor.
        Begin
          B.Size := B.Size - 1;
          base := Primodeindice(Sumar(baseRelativa, getAnything));
          // baseRelativa := Sumar(base, One);
          baseAnterior := baseRelativa; // Like a push.
          baseRelativa := Zero;
          exponente := getAnything;
          // En el exponente se reinicia eso, es al propio nivel.
          baseRelativa := baseAnterior; // As a pop.
          If base <> Two Then
            Increment(exponente);
          Result := Potencia(base, exponente)
        End
        Else If B.LastBit = 1 Then
        Begin
          B.Size := B.Size - 1;
          Result := getAnything;
          codec := getAnything;
          While Not(codec = Zero) Do
          Begin
            Result := Multiplicar(Result, codec);
            codec := getAnything
          End
        End
      End
    End;

  Begin
    B := Shrink(a);
    Result := getAnything
  End;
