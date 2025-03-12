/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_2.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akovtune <akovtune@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/25 18:48:23 by akovtune          #+#    #+#             */
/*   Updated: 2025/02/14 13:33:02 by akovtune         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "list.h"

bool	add_to_list(t_list *list, void *value)
{
	t_list_node	*node;

	node = create_node(value);
	if (!node)
		return (false);
	push(node, list);
	return (true);
}

t_list_node	*get_node(int index, t_list *list)
{
	int			i;
	t_list_node	*node;

	if (!list || !list->head)
		return (NULL);
	i = -1;
	node = list->head;
	while (++i < index)
		node = node->next;
	return (node);
}
