/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   file.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akovtune <akovtune@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/08 17:37:24 by akovtune          #+#    #+#             */
/*   Updated: 2025/01/18 17:00:43 by akovtune         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "file.h"

static char	**move_from_list_to_array(t_list *lines, int lines_count);

char	*get_file_extension(char *filepath)
{
	int		filepath_len;
	int		dot_index;
	char	*extension;
	int		i;
	int		j;

	filepath_len = ft_strlen(filepath);
	dot_index = last_index_of('.', filepath);
	extension = (char *)malloc(sizeof(char) * (filepath_len - dot_index + 1));
	if (!extension)
		return (NULL);
	i = dot_index;
	j = 0;
	while (filepath[i])
		extension[j++] = filepath[i++];
	extension[j] = '\0';
	return (extension);
}

char	**read_all_lines(char *filepath, int *lines_count)
{
	t_list	*lines;
	char	*line;
	int		fd;

	fd = open(filepath, O_RDONLY);
	if (fd == -1)
		return (NULL);
	lines = NULL;
	*lines_count = 0;
	line = get_next_line(fd);
	while (line)
	{
		if (!add_node(line, &lines))
			return (clear_list(&lines), NULL);
		(*lines_count)++;
		line = get_next_line(fd);
	}
	close(fd);
	if (*lines_count < 1)
		return (clear_list(&lines), NULL);
	return (move_from_list_to_array(lines, *lines_count));
}

static char	**move_from_list_to_array(t_list *lines, int lines_count)
{
	char	**result;
	int		i;
	t_list	*next_line;
	t_list	*line;

	result = (char **)malloc(sizeof(char *) * (lines_count + 1));
	if (!result)
		return (NULL);
	line = lines;
	i = -1;
	while (++i < lines_count)
	{
		result[i] = line->value;
		next_line = line->next;
		free(line);
		line = next_line;
	}
	result[i] = NULL;
	return (result);
}

bool	file_exists(const char *filepath)
{
	int	fd;

	fd = open(filepath, O_RDONLY);
	if (fd == -1)
	{
		perror("Error opening file");
		return (false);
	}
	close(fd);
	return (true);
}
