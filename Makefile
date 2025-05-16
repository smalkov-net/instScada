T = i
S = src
C = gcc
F = -Wall

a: r

$(T): $(S)/input.c
	@$(C) $(F) -o $(T) $(S)/input.c

r: $(T)
	@chmod +x $(S)/inst.sh > /dev/null 2>&1
	@./$(T) | $(S)/inst.sh