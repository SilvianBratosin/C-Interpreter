generate:
	bison -dv Proiect.y
	flex -o Proiect.yy.c Proiect.l
	gcc -o ProiectA.exe Proiect.tab.c Proiect.yy.c ProiectA.c -lm -lfl
	gcc -o ProiectC.exe Proiect.tab.c Proiect.yy.c ProiectC.c -lm -lfl

clean:
	rm -f Proiect.tab.c Proiect.tab.h Proiect.yy.c ProiectA.exe ProiectC.exe
