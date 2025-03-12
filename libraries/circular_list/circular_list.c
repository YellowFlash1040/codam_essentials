/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   circular_list.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akovtune <akovtune@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/12/15 17:58:24 by akovtune          #+#    #+#             */
/*   Updated: 2025/01/26 16:32:25 by akovtune         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "circular_list.h"

t_circular_list_node	*pop(t_circular_list *list)
{
	t_circular_list_node	*prev;
	t_circular_list_node	*node;
	t_circular_list_node	*next;

	if (!list || !list->head)
		return (NULL);
	node = list->head;
	prev = node->prev;
	next = node->next;
	if (prev == node && next == node)
		list->head = NULL;
	else
	{
		next->prev = prev;
		prev->next = next;
		list->head = next;
	}
	node->next = NULL;
	node->prev = NULL;
	list->count--;
	return (node);
}

void	push(t_circular_list_node *node, t_circular_list *list)
{
	t_circular_list_node	*head;
	t_circular_list_node	*tail;

	if (!list)
		return ;
	head = list->head;
	if (head)
	{
		if (head->prev)
			tail = head->prev;
		else
			tail = head;
		node->next = head;
		node->prev = tail;
		head->prev = node;
		tail->next = node;
		list->count++;
	}
	else
	{
		list->head = node;
		list->count = 1;
	}
}

t_circular_list_node	*create_node(void *value)
{
	t_circular_list_node	*node;

	node = (t_circular_list_node *)malloc(sizeof(t_circular_list_node));
	if (!node)
		return (NULL);
	node->value = value;
	node->next = NULL;
	node->prev = NULL;
	return (node);
}

void	clear_list(t_circular_list *list, void (*free_value)(void *))
{
	t_circular_list_node	*temp;

	if (!list || !list->head)
		return ;
	while (list->count--)
	{
		temp = list->head->next;
		if (list->head->value && free_value)
			free_value(list->head->value);
		free(list->head);
		list->head = temp;
	}
	free(list);
}

t_circular_list	*init_circular_list(void)
{
	t_circular_list	*list;

	list = (t_circular_list *)malloc(sizeof(t_circular_list));
	if (!list)
		return (NULL);
	return (list);
}
