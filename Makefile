#  ____________________________________________________________________________
# | File: makefile - Amiga 3D Demo                                             |
# | Author: skywalker aka J.Karlsson <j.karlsson@retrocoder.se>                |
# | Copyright: (C) 2018 skywalker. All rights reserved.                        |
# |____________________________________________________________________________|

# Target configuration (uncomment applicable config part).
# Target system: Amiga 500 (AmigaOS 1.3 - version 34.5)
# VBCC compiler config file (default vc.cfg)
#VCCONF=+vc.cfg

# Tools
CC=vc $(VCCONF)
AS=vc $(VCCONF)
LD=vc $(VCCONF)
JOIN=cat
RM=rm -rf
MKDIR=mkdir -p

# Directory structure
SRC=src/
INC=inc/
BLD=build/
OBJ=$(BLD)obj/
BIN=$(BLD)bin/

# Flags
CPPFLAGS=-I$(INC) -DNO_PRAGMAS
CFLAGS=
ASFLAGS=

# Source files (anything in the src directory)
SOURCES=$(wildcard $(SRC)*)

# Binary files (lib/objs)
LIB=3d_graphics.lib
OBJS=$(subst $(SRC),$(OBJ),$(addsuffix .o,$(basename $(SOURCES))))

.phony: all clean $(LIB)
all: $(LIB)

clean:
	$(RM) $(BLD) *~ $(SRC)*~ $(INC)*~

$(LIB): $(BIN)$(LIB)

$(BIN)$(LIB): $(OBJS) | $(BIN)
	$(JOIN) $^ > $@

$(OBJ)%.o: $(SRC)%.c | $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

$(OBJ)%.o: $(SRC)%.s | $(OBJ)
	$(AS) $(ASFLAGS) $(CPPFLAGS) -c -o $@ $<

$(OBJ)%.o: $(SRC)%.S | $(OBJ)
	$(AS) $(ASFLAGS) $(CPPFLAGS) -c -o $@ $<

$(OBJ)%.o: $(SRC)%.asm | $(OBJ)
	$(AS) $(ASFLAGS) $(CPPFLAGS) -c -o $@ $<

$(OBJ)%.o: $(SRC)%.a | $(OBJ)
	$(AS) $(ASFLAGS) $(CPPFLAGS) -c -o $@ $<

# Create directory structure
$(OBJ):
	$(MKDIR) $(OBJ)

$(BIN):
	$(MKDIR) $(BIN)

#  ____________________________________________________________________________
# | License:                                                                   |
# | This program is free software: you can redistribute it and/or modify       |
# | it under the terms of the GNU General Public License version 2 as          |
# | published by the Free Software Foundation.                                 |
# |                                                                            |
# | This program is distributed in the hope that it will be useful,            |
# | but WITHOUT ANY WARRANTY; without even the implied warranty of             |
# | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              |
# | GNU General Public License for more details.                               |
# |                                                                            |
# | You should have received a copy of the GNU General Public License          |
# | along with this program. If not, see <http://www.gnu.org/licenses/>        |
# | or write to the Free Software Foundation, Inc.,                            |
# | 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.                |
# |____________________________________________________________________________|
