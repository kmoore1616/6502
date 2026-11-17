# 6502

## Description

This project involves constructing a fully functional retro computer using the
6502 CPU, a classic yet straightforward microprocessor. Over several months, I
built the computer from the ground up, learning key concepts in low-level
computing and hardware design. The computer is capable of communicating with a
terminal to display text. This project has allowed me to explore the
fundamentals of computer architecture while developing hands-on skills in
system design and troubleshooting.

The kit is based on [Ben Eater's 6502 computer series](https://eater.net/6502).

Written by [Kyle Moore](https://www.linkedin.com/in/moore-kyle-r/).

## Running the project

Without the specific hardware, running the files is tricky. To do so, download
the [Symon emulator](https://github.com/sethm/symon). The prebuilt machine code
is located at [`dist/6502.bin`](dist/6502.bin).

Change the emulator settings using:

1. **Simulator → Switch emulated machine → Beneater**
2. **Simulator → CPU → 65C02**
3. **File → Load ROM**, then select `dist/6502.bin`

![Moniter](https://github.com/user-attachments/assets/322d4855-9151-4271-8007-4724e68f98eb)
![BBoard](https://github.com/user-attachments/assets/da5c72e0-e38a-4d2f-9732-108b72cee35d)
![PCB](https://github.com/user-attachments/assets/b6a86ed6-6c36-4667-bbdf-844a3c4bc272)
![Cassette](https://github.com/user-attachments/assets/57b08568-40e7-42c2-8647-6d3640ccd513)

## Building the ROM

The ROM can also be built from source using the `ca65` and `ld65` tools from
[cc65](https://cc65.github.io/):

```sh
make
```

Build output is written to `build/`. The main BIOS source is
[`src/bios/wozmon.s`](src/bios/wozmon.s), with the cassette and math routines
included from the same directory.

## Cassette tools

The Python scripts in [`tools/kcs`](tools/kcs) encode hexadecimal machine code
as Kansas City Standard cassette audio and decode KCS WAV recordings.

```sh
python3 tools/kcs/kcs_encode.py examples/kcs/fibonacci.hex build/fibonacci.wav
python3 tools/kcs/kcs_decode.py --binary examples/kcs/audio/fibonacci.wav > program.bin
```

See [`tools/kcs/README.md`](tools/kcs/README.md) for usage details and
attribution.

## Repository layout

```text
assets/images/       Project photographs
dist/                 Prebuilt ROM image
examples/kcs/         Example cassette data and WAV files
src/bios/             Monitor, cassette, math, and linker sources
src/programs/         Standalone 6502 example programs
tools/kcs/            Kansas City Standard encode/decode utilities
```
