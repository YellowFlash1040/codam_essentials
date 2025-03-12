# Compiler and Flags
CC						:= cc
CFLAGS					 = -Wall -Wextra -Werror $(INCLUDES)

# Output Files
NAME					:= file.a

# Directories
OBJ_DIR					:= obj
LIB_GET_NEXT_LINE_DIR	:= ../get_next_line
LIB_LIST_DIR			:= ../list
LIB_STRING_DIR			:= ../ft_string
TMP_DIR					:= tmp_lib_objs

# Files
FILES					:= file.c

# Sources, Objects
OBJ     				:= $(addprefix $(OBJ_DIR)/, $(FILES:.c=.o))

# Includes
INCLUDES				:= -I$(LIB_GET_NEXT_LINE_DIR) \
							-I$(LIB_LIST_DIR) \
							-I$(LIB_STRING_DIR)

# External Libraries
LIB_GET_NEXT_LINE		:= $(LIB_GET_NEXT_LINE_DIR)/get_next_line.a
LIB_LIST				:= $(LIB_LIST_DIR)/list.a
LIB_STRING				:= $(LIB_STRING_DIR)/ft_string.a

LIBRARIES		:= $(LIB_GET_NEXT_LINE) \
					$(LIB_LIST) \
					$(LIB_STRING)

# Colors for Output
GREEN					:= \033[0;32m
RED						:= \033[31m
RESET					:= \033[0m

# Default Target
all: $(NAME)

# Build the Executable
$(NAME): $(OBJ) $(LIBRARIES)
	@mkdir -p $(TMP_DIR)
	@for lib in $(LIBRARIES); do \
		ar x $$lib; \
		mv *.o $(TMP_DIR); \
	done
	@ar src $@ $(OBJ) $(TMP_DIR)/*.o
	@rm -rf $(TMP_DIR)
	@echo "$(GREEN)Created combined archive $@ successfully!$(RESET)"

#Compile Object Files
$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	@$(CC) $(CFLAGS) -c $< -o $@

%.a:
	@cd $(dir $@); $(MAKE); $(MAKE) clean > /dev/null

# Clean up Object Files
clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(RED)Removed object files$(RESET)"

# Clean up All Generated Files
fclean: clean
	@rm -rf $(NAME)
	@echo "$(RED)Removed $(NAME)$(RESET)"

# Rebuild the Project
re: fclean all

# Phony Targets
.PHONY: all clean fclean re