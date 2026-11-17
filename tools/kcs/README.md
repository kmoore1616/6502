# Kansas City Standard tools

These scripts convert between hexadecimal machine-code files and Kansas City
Standard (KCS) WAV audio.

## Encode

The input file is whitespace-separated hexadecimal bytes:

```sh
python3 tools/kcs/kcs_encode.py input.hex output.wav
```

The output is 8-bit mono audio at 9600 Hz with five-second leaders and
trailers.

## Decode

Print decoded text:

```sh
python3 tools/kcs/kcs_decode.py input.wav
```

Write the raw decoded bytes:

```sh
python3 tools/kcs/kcs_decode.py --binary input.wav > output.bin
```

## Attribution

The encoder and decoder are based on **py-kcs** by David Beazley:

- Author: David Beazley (<https://www.dabeaz.com/>)
- Copyright © 2010 David Beazley
- Original project: <https://www.dabeaz.com/py-kcs/>

The original code permits reuse with attribution.
