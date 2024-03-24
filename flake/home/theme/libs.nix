lib:
with lib; rec {
  # convert rrggbb hex to #rrggbb
  x = c: "#${c}";

  # convert rrggbb to hsl hue
  #FIXME: probably seems ot work but says value coersion error as the c seems to passed in as a function
  hue = c:
    let
      r = toString (hexToDec (__substring 0 2 c));
      g = toString (hexToDec (__substring 2 2 c));
      b = toString (hexToDec (__substring 4 2 c));
      cmax = lib.max [ r g b ];
      cmin = lib.min [ r g b ];
      delta = cmax - cmin;

      calc = if delta == 0 then
        0
      else if cmax == r then
        let d = g - b; in if d == 0 then 0 else d * 6 / delta
      else if cmax == g then
        (b - r) / delta + 2
      else
        (r - g) / delta + 4;

      res = toString (if calc < 0 then calc * 60 + 360 else calc * 60);
    in res;

  # convert rrggbb hex to rgba(r, g, b, a) css
  rgba = c: a:
    let
      r = toString (hexToDec (__substring 0 2 c));
      g = toString (hexToDec (__substring 2 2 c));
      b = toString (hexToDec (__substring 4 2 c));
      alphaStr = toString (a);
      res = "rgba(${r}, ${g}, ${b}, ${alphaStr})";
    in res;

  # functions copied from https://gist.github.com/corpix/f761c82c9d6fdbc1b3846b37e1020e11
  # convert a hex value to an integer
  hexToDec = v:
    let
      hexToInt = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "a" = 10;
        "b" = 11;
        "c" = 12;
        "d" = 13;
        "e" = 14;
        "f" = 15;
        "A" = 10;
        "B" = 11;
        "C" = 12;
        "D" = 13;
        "E" = 14;
        "F" = 15;
      };
      chars = stringToCharacters v;
      charsLen = length chars;
    in foldl (a: v: a + v) 0
    (imap0 (k: v: hexToInt."${v}" * (pow 16 (charsLen - k - 1))) chars);

  pow = let
    pow' = base: exponent: value:
      # FIXME: It will silently overflow on values > 2**62 :(
      # The value will become negative or zero in this case
      if exponent == 0 then
        1
      else if exponent <= 1 then
        value
      else
        (pow' base (exponent - 1) (value * base));
  in base: exponent: pow' base exponent base;
}
