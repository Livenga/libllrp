EABI   = ../../../octane_etk-6.0.0.240/arm-toolchain/bin/arm-none-linux-gnueabi
#CC     = $(EABI)-gcc
CC     = gcc
FLAGS  = -g -Wall
OBJDIR = objs
PRJC   = libllrp.so

SRC     = $(shell find src/ -name \*.c)
OBJS    = $(addprefix $(OBJDIR)/,$(patsubst %.c,%.o,$(SRC)))
OBJSDIR = $(sort $(dir $(OBJS)))


default:
	[ -d $(OBJDIR) ] || mkdir -v $(OBJDIR)
	[ -d "$(OBJSDIR)" ] || mkdir -pv $(OBJSDIR)
	make $(PRJC)

$(PRJC):$(OBJS)
	$(CC) -o $@ $^ \
		-fPIC \
		-shared \
		$(FLAGS)

$(OBJDIR)/%.o:%.c
	$(CC) -o $@ -c $< $(FLAGS)

clean:
	[ ! -d $(OBJDIR) ] || rm -rv $(OBJDIR)
	[ ! -e $(PRJC) ] || rm -v $(PRJC)

all:
	make clean default
