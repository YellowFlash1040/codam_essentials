/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   circular_list_node.h                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akovtune <akovtune@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/25 17:02:27 by akovtune          #+#    #+#             */
/*   Updated: 2025/01/25 17:24:28 by akovtune         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef CIRCULAR_LIST_NODE_H
# define CIRCULAR_LIST_NODE_H

typedef struct circular_list_node
{
	void						*value;
	struct circular_list_node	*next;
	struct circular_list_node	*prev;

}								t_circular_list_node;

#endif