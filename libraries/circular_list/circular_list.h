/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   circular_list.h                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akovtune <akovtune@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/12/10 14:15:50 by akovtune          #+#    #+#             */
/*   Updated: 2025/01/26 16:38:17 by akovtune         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef CIRCULAR_LIST_H
# define CIRCULAR_LIST_H

# include "circular_list_node.h"
# include <stdbool.h>
# include <stdlib.h>

typedef struct cirular_list
{
	int						count;
	t_circular_list_node	*head;

}							t_circular_list;

t_circular_list				*init_circular_list(void);
t_circular_list_node		*create_node(void *value);
void						clear_list(t_circular_list *list,
								void (*free_value)(void *));
t_circular_list_node		*pop(t_circular_list *list);
void						push(t_circular_list_node *node,
								t_circular_list *list);
bool						add_to_list(t_circular_list *list, void *value);
t_circular_list_node		*get_node(int index, t_circular_list *list);

#endif