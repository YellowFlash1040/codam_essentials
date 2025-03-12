/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   circular_list_2.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akovtune <akovtune@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/25 18:48:23 by akovtune          #+#    #+#             */
/*   Updated: 2025/01/26 14:02:57 by akovtune         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "circular_list.h"

bool	add_to_list(t_circular_list *list, void *value)
{
	t_circular_list_node	*node;

	node = create_node(value);
	if (!node)
		return (false);
	push(node, list);
	return (true);
}

t_circular_list_node	*get_node(int index, t_circular_list *list)
{
	int						i;
	t_circular_list_node	*node;

	if (!list || !list->head)
		return (NULL);
	i = -1;
	node = list->head;
	while (++i < index)
		node = node->next;
	return (node);
}
