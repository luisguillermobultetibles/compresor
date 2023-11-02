unit BigIntegers;

interface

Type
  // Definición del tipo BigInt básico, en las descendentes varía solamente
  // la forma de acceder a contenido de la estructura.

  CustomBigInt = class
  private
    function get256Digit(position: LongWord): byte; virtual; abstract;
    procedure set256Digit(position: LongWord; value: byte); virtual; abstract;

    function getAsString(): String; virtual; abstract;
    // nota puede implementarse una sola vez aquí...
    procedure setAsString(value: String); virtual; abstract; // idem

    function getLen(): LongWord; virtual; abstract;
    procedure setLen(value: LongWord); virtual; abstract;

  public
    constructor create(s: string);

    property byte[position: LongWord]: byte read get256Digit write set256Digit;
    property len: LongWord read getLen write setLen;

    property asString: String read getAsString write setAsString;

    // todas se pueden implementar aquí
    function add(a: CustomBigInt; b: CustomBigInt): CustomBigInt;
    function substract(a: CustomBigInt; b: CustomBigInt): CustomBigInt;
    function multiply(a: CustomBigInt; b: CustomBigInt): CustomBigInt;
    function divide(a: CustomBigInt; b: CustomBigInt): CustomBigInt;
    function pow(a: CustomBigInt; b: CustomBigInt): CustomBigInt;
    function raiz(a: CustomBigInt; b: CustomBigInt): CustomBigInt;
    function ln(a: CustomBigInt): CustomBigInt;
    function exp(a: CustomBigInt): CustomBigInt;
  end;

Type
  // Implementación del BigInt de memoria

  BigInt = class(CustomBigInt)
  private
    fdata: array of byte;
    function get256Digit(position: LongWord): byte;
    procedure set256Digit(position: LongWord; value: byte);

    function getLen(): LongWord;
    procedure setLen(value: LongWord);
  public

  end;

Type
  // Implementación del BigInt de disco
  // El archivo en disco se considera un dato sólido
  // desde el primero de sus bytes de la posición 1,
  // hasta el último de sus bytes en la posición LONGITUDDEARCHIVO
  // la posición 0 queda reservada para una respuesta automática de
  // 1 (00000001) para garantizar que no se pierdan los ceros a la
  // izquierda del archivo.

  FileBigInt = class(CustomBigInt)
  private
    FArchivo: File of byte;
    fsize: LongWord;

    function get256Digit(position: LongWord): byte;

    function getLen(): LongWord; virtual; abstract;
    procedure setLen(value: LongWord); virtual; abstract;

  public
    procedure open(filename: string);
    procedure close;

  end;

type
  TRegistro64Bits = class
  private
    FArchivo: File of LongWord;
    FNombreArchivo: string;
    procedure AbrirArchivo(filename: string; escritura: Boolean = false);
    procedure CerrarArchivo;
  public
    constructor create(const ANombreArchivo: string);
    destructor Destroy; override;
    procedure EscribirRegistro(const ARegistro: LongWord;
      posicion: Integer = -1);
    function LeerRegistro(posicion: Integer = -1): LongWord;
  end;

constructor TRegistro64Bits.create(const ANombreArchivo: string);
begin
  FNombreArchivo := ANombreArchivo;
  AbrirArchivo;
end;

procedure TRegistro64Bits.AbrirArchivo(filename: string;
  escritura: Boolean = false);
begin
  FNombreArchivo := filename;
  Assign(FArchivo, FNombreArchivo);
  if escritura then
    Rewrite(FArchivo)
  else
  Begin
    if not fileExist(FNombreArchivo) then
      raise Exception.create('File not found');
    Reset(FArchivo);
  End;
end;

destructor TRegistro64Bits.Destroy;
begin
  CerrarArchivo;
  inherited;
end;

procedure TRegistro64Bits.CerrarArchivo;
begin
  if FileExists(FNombreArchivo) then
    CloseFile(FArchivo);
end;

procedure TRegistro64Bits.EscribirRegistro(const ARegistro: LongWord;
  posicion: Integer = -1);
begin
  if posicion = -1 then
    posicion := FileSize(FArchivo);
  Seek(FArchivo, posicion);
  Write(FArchivo, ARegistro);
end;

function TRegistro64Bits.LeerRegistro(posicion: Integer = -1): LongWord;

var
  Registro: LongWord;
begin
  if posicion = -1 then
    posicion := FileSize(FArchivo);
  Seek(FArchivo, posicion);
  Read(FArchivo, Registro);
  Result := Registro;
end;

implementation

{ FileBigInt }

procedure FileBigInt.close;
begin
  CloseFile(Self.fdata);
end;

function FileBigInt.get256Digit(position: LongWord): byte;
begin
  if position = 0 then
  begin
    Result := 1;
  end
  else
  begin
    Seek(Self.fdata, position);
    read(Self.fdata, Result);
  end;
end;

procedure FileBigInt.open(filename: string);
begin
  AssignFile(Self.fdata, filename);
  Reset(Self.fdata);
  Self.fsize := FileSize(Self.fdata);
end;

{ CustomBigInt }

constructor CustomBigInt.create(s: string);
begin
  inherited create();

end;

function CustomBigInt.add(a, b: CustomBigInt): CustomBigInt;
begin
  Result := CustomBigInt.create('0');
  // ...
end;

function CustomBigInt.divide(a, b: CustomBigInt): CustomBigInt;
begin

end;

function CustomBigInt.exp(a: CustomBigInt): CustomBigInt;
begin

end;

function CustomBigInt.ln(a: CustomBigInt): CustomBigInt;
begin

end;

function CustomBigInt.multiply(a, b: CustomBigInt): CustomBigInt;
begin

end;

function CustomBigInt.pow(a, b: CustomBigInt): CustomBigInt;
begin

end;

function CustomBigInt.raiz(a, b: CustomBigInt): CustomBigInt;
begin

end;

function CustomBigInt.substract(a, b: CustomBigInt): CustomBigInt;
begin

end;

{ BigInt }

function BigInt.get256Digit(position: LongWord): byte;
begin
  Result := Self.fdata[position];
end;

function BigInt.getLen: LongWord;
begin
  Result := Length(Self.fdata);
end;

procedure BigInt.set256Digit(position: LongWord; value: byte);
begin
  Self.fdata[position] := value;
end;

procedure BigInt.setLen(value: LongWord);
begin
  SetLength(Self.fdata, value);
end;

end.
