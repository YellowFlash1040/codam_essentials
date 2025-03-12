/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   string_array.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akovtune <akovtune@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/07 14:19:52 by akovtune          #+#    #+#             */
/*   Updated: 2025/03/07 14:42:01 by akovtune         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "string_array.h"

t_string_array	*init_string_array(int size)
{
    t_string_array	*string_array;
    int              i;

    string_array = (t_string_array *)malloc(sizeof(t_string_array));
    if (!string_array)
        return (NULL);
    string_array->values = (char**)malloc(sizeof(char*) * (size + 1));
    if (!string_array->values)
        return (free(string_array), NULL);
    i = -1;
    while (++i < size)
        string_array->values[i] = NULL;
    string_array->values[size] = NULL;
    string_array->length = size;
    return (string_array);
}

void	destroy_string_array(t_string_array **string_array_ref)
{
    t_string_array* string_array;
    int i;
    if (!string_array_ref || !*string_array_ref)
        return ;
    string_array = *string_array_ref;
    i = -1;
    while (string_array->values[++i])
        free(string_array->values[i]);
    free(string_array->values);
    free(string_array);
    *string_array_ref = NULL;
}
