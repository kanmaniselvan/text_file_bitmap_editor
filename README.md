# Bitmap editor

Produces bitmaps represented as an M x N matrix of pixels with each element representing a colour.

# Commands
* I M N - Create a new M x N image with all pixels coloured white (O).
* C - Clears the table, setting all pixels to white (O).
* L X Y C - Colours the pixel (X,Y) with colour C.
* V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
* H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
* S - Show the contents of the current image

# Running

`>bin/bitmap_editor examples/show.txt`

# Sample

<strong>Input: examples/show.txt</strong>

I 10 10<br>
V 4 1 10 T<br>
V 5 1 10 T<br>
V 6 1 10 T<br>
H 1 10 4 Z<br>
H 1 10 5 Z<br>
H 1 10 6 Z<br>
L 5 5 A<br>
S

<strong>Output:</strong>

OOOTTTOOOO<br>
OOOTTTOOOO<br>
OOOTTTOOOO<br>
ZZZZZZZZZZ<br>
ZZZZAZZZZZ<br>
ZZZZZZZZZZ<br>
OOOTTTOOOO<br>
OOOTTTOOOO<br>
OOOTTTOOOO<br>
OOOTTTOOOO

# Test

`>rspec --format doc`
