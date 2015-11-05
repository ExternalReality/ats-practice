PATSHOMEQ="$(PATSHOME)"

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

PATSCCFLAGS=-O3 -flto

sdl : main.dats; \
	  $(PATSCC) $(PATSCCFLAGS) -o $@ $^ -DATS_MEMALLOC_LIBC -lSDL2 || echo $@ ": ERROR!!!"

cleanall:: ; $(RMF) sdl

RMF=rm -f

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
