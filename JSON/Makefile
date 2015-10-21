PATSHOMEQ="$(PATSHOME)"

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

PATSCCFLAGS=-O3 -flto

# '-flto' enables link-time optimization such as inlining lib functions

etaggen : etaggen.dats parson.c ; \
	  $(PATSCC) $(PATSCCFLAGS) -o $@ $^ -DATS_MEMALLOC_LIBC || echo $@ ": ERROR!!!"

cleanall:: ; $(RMF) foo

# %_sats.o: %.sats ; $(ATSCC) $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"
# %_dats.o: %.dats ; $(ATSCC) $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"

RMF=rm -f

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

