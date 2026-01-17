compile with dmd, run by providing bust file

```
dmd goon.d
./goon <input.bust> # you can also specify output path, but default is bustOut.asm
nasm -felf64 bustOut.asm
ld bustOut.o
./a.out
```



