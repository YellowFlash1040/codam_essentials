/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   file.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akovtune <akovtune@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/08 17:35:29 by akovtune          #+#    #+#             */
/*   Updated: 2025/01/09 14:32:39 by akovtune         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FILE_H
# define FILE_H

# include "ft_string.h"
# include "get_next_line.h"
# include "list.h"
# include <fcntl.h>  // for open()
# include <stdio.h>  // for perror()
# include <stdlib.h> // for malloc()

char	*get_file_extension(char *filepath);
char	**read_all_lines(char *filepath, int *lines_count);
bool	file_exists(const char *filepath);

#endif