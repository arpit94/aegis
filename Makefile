TARGET=i686-elf

NO_COLOR=\x1b[0m
OK_COLOR=\x1b[32;01m
ERROR_COLOR=\x1b[31;01m
WARN_COLOR=\x1b[33;01m

OK_STRING=$(OK_COLOR)[OK]$(NO_COLOR)
ERROR_STRING=$(ERROR_COLOR)[ERRORS]$(NO_COLOR)
WARN_STRING=$(WARN_COLOR)[WARNINGS]$(NO_COLOR)

ECHO=echo
CAT=cat
RM=rm

bootloader: boot.o

boot.o: boot.s
	@$(ECHO) -n Assembling the bootloader...
	@$(TARGET)-as $^ -o $@ 2> temp.log || touch temp.errors
	@if test -e temp.errors; then $(ECHO) "$(ERROR_STRING)" && $(CAT) temp.log && false; elif test -s temp.log; then $(ECHO) "$(WARN_STRING)" && $(CAT) temp.log; else $(ECHO) "$(OK_STRING)"; fi;
	@$(RM) -f temp.errors temp.log

.PHONY : clean
clean:
	@$(ECHO) -n Cleaning object files...
	@$(RM) -f *.o temp.log temp.errors
	@$(ECHO) "$(OK_STRING)"