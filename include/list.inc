#if defined __LIST_INCLUDED__
    #endinput
#endif
    #define __LIST_INCLUDED__

    #include <memory>

    #define LIST_NULL                   List:MEM_NULLPTR
    #define LIST_IT_NULL                ListIt:MEM_NULLPTR
    #define LIST_foreach%2(%0:%1)       for (new Pointer:%0, ListIt:__lit__ = LIST_iter_begin(%1, %0); __lit__ != LIST_IT_NULL; __lit__ = LIST_iter_next(__lit__, %0))
    #define LIST_foreach_rev%2(%0:%1)   for (new Pointer:%0, ListIt:__lit__ = LIST_iter_end(%1, %0); __lit__ != LIST_IT_NULL; __lit__ = LIST_iter_previous(__lit__, %0))

// List structure
MEM_struct LIST_struct
{
    ListIt:LIST_struct_begin,
    ListIt:LIST_struct_end
}

// List iterator structure
MEM_struct LIST_iter_struct
{
    ListIt:LIST_iter_struct_previous,
    ListIt:LIST_iter_struct_next,
    Pointer:LIST_iter_struct_data
}

// Get first iterator
stock ListIt:LIST_iter_begin(List:list, &Pointer:value_ptr)
{
    new ListIt:ret = LIST_IT_NULL;
    if (list != LIST_NULL)
    {
        ret = ListIt:MEM_get_val(Pointer:list, _:LIST_struct_begin);
        value_ptr = Pointer:MEM_get_val(Pointer:ret, _:LIST_iter_struct_data);
    }
    return ret;
}

// Get last iterator
stock ListIt:LIST_iter_end(List:list, &Pointer:value_ptr)
{
    new ListIt:ret = LIST_IT_NULL;
    if (list != LIST_NULL)
    {
        ret = ListIt:MEM_get_val(Pointer:list, _:LIST_struct_end);
        value_ptr = Pointer:MEM_get_val(Pointer:ret, _:LIST_iter_struct_data);
    }
    return ret;
}

// Get next iterator
stock ListIt:LIST_iter_next(ListIt:list_iterator, &Pointer:value_ptr)
{
    new ListIt:ret = LIST_IT_NULL;
    if (list_iterator != LIST_IT_NULL)
    {
        ret = ListIt:MEM_get_val(Pointer:list_iterator, _:LIST_iter_struct_next);
        if (ret != LIST_IT_NULL)
        {
            value_ptr = Pointer:MEM_get_val(Pointer:ret, _:LIST_iter_struct_data);
        }
    }
    return ret;
}

// Get previous iterator
stock ListIt:LIST_iter_previous(ListIt:list_iterator, &Pointer:value_ptr)
{
    new ListIt:ret = LIST_IT_NULL;
    if (list_iterator != LIST_IT_NULL)
    {
        ret = ListIt:MEM_get_val(Pointer:list_iterator, _:LIST_iter_struct_previous);
        if (ret != LIST_IT_NULL)
        {
            value_ptr = Pointer:MEM_get_val(Pointer:ret, _:LIST_iter_struct_data);
        }
    }
    return ret;
}

// List push back
static stock ListIt:LIST_push_back(&List:list, Pointer:value_ptr)
{
    new ListIt:ret = LIST_IT_NULL, lit[LIST_iter_struct];
    lit[LIST_iter_struct_data] = MEM_clone(value_ptr);
    if (lit[LIST_iter_struct_data])
    {
        ret = ListIt:MEM_new_arr(lit);
        if (ret)
        {
            new l[LIST_struct];
            if (list == LIST_NULL)
            {
                l[LIST_struct_begin] = ret;
                l[LIST_struct_end] = ret;
                list = List:MEM_new_arr(l);
                if (list == LIST_NULL)
                {
                    MEM_delete(Pointer:ret);
                    ret = LIST_IT_NULL;
                }
            }
            else
            {
                MEM_get_arr(Pointer:list, _, l);
                MEM_set_val(Pointer:ret, _:LIST_iter_struct_previous, _:l[LIST_struct_end]);
                MEM_set_val(Pointer:l[LIST_struct_end], _:LIST_iter_struct_next, _:ret);
                MEM_set_val(Pointer:list, _:LIST_struct_end, _:ret);
            }
        }
        else
        {
            MEM_delete(lit[LIST_iter_struct_data]);
        }
    }
    return ret;
}

// List push front
static stock ListIt:LIST_push_front(&List:list, Pointer:value_ptr)
{
    new ListIt:ret = LIST_IT_NULL, lit[LIST_iter_struct];
    lit[LIST_iter_struct_data] = MEM_clone(value_ptr);
    if (lit[LIST_iter_struct_data])
    {
        ret = ListIt:MEM_new_arr(lit);
        if (ret)
        {
            new l[LIST_struct];
            if (list == LIST_NULL)
            {
                l[LIST_struct_begin] = ret;
                l[LIST_struct_end] = ret;
                list = List:MEM_new_arr(l);
                if (list == LIST_NULL)
                {
                    MEM_delete(Pointer:ret);
                    ret = LIST_IT_NULL;
                }
            }
            else
            {
                MEM_get_arr(Pointer:list, _, l);
                MEM_set_val(Pointer:ret, _:LIST_iter_struct_next, _:l[LIST_struct_begin]);
                MEM_set_val(Pointer:l[LIST_struct_begin], _:LIST_iter_struct_previous, _:ret);
                MEM_set_val(Pointer:list, _:LIST_struct_begin, _:ret);
            }
        }
        else
        {
            MEM_delete(lit[LIST_iter_struct_data]);
        }
    }
    return ret;
}

// List remove
static stock LIST_remove(&List:list, Pointer:value_ptr)
{
    new value_size = MEM_get_size(value_ptr), v_sz, i, bool:success;
    for (new Pointer:v, ListIt:it = LIST_iter_begin(list, v); it != LIST_IT_NULL; it = LIST_iter_next(it, v))
    {
        v_sz = MEM_get_size(v);
        if (value_size == v_sz)
        {
            success = true;
            for (i = 0; i < v_sz; i++)
            {
                if (MEM_get_val(value_ptr, i) != MEM_get_val(v, i))
                {
                    success = false;
                    break;
                }
            }
            if (success)
            {
                // Remove item
                new lit[LIST_iter_struct];
                MEM_get_arr(Pointer:it, _, lit);
                if (lit[LIST_iter_struct_previous] != LIST_IT_NULL)
                {
                    if (lit[LIST_iter_struct_next] != LIST_IT_NULL)
                    {
                        // Both available
                        MEM_set_val(Pointer:lit[LIST_iter_struct_previous], _:LIST_iter_struct_next, _:lit[LIST_iter_struct_next]);
                        MEM_set_val(Pointer:lit[LIST_iter_struct_next], _:LIST_iter_struct_previous, _:lit[LIST_iter_struct_previous]);
                    }
                    else
                    {
                        // Left available
                        MEM_set_val(Pointer:lit[LIST_iter_struct_previous], _:LIST_iter_struct_next, _:LIST_IT_NULL);
                        MEM_set_val(Pointer:list, _:LIST_struct_end, _:lit[LIST_iter_struct_previous]);
                    }
                }
                else
                {
                    if (lit[LIST_iter_struct_next] != LIST_IT_NULL)
                    {
                        // Right available
                        MEM_set_val(Pointer:lit[LIST_iter_struct_next], _:LIST_iter_struct_previous, _:LIST_IT_NULL);
                        MEM_set_val(Pointer:list, _:LIST_struct_begin, _:lit[LIST_iter_struct_next]);
                    }
                    else
                    {
                        // None available
                        MEM_delete(Pointer:list);
                        list = LIST_NULL;
                    }
                }
                MEM_delete(Pointer:it);
                LIST_remove(list, value_ptr);
                break;
            }
        }
    }
}

// List contains
static stock LIST_contains(List:list, Pointer:value_ptr)
{
    new ret, value_size = MEM_get_size(value_ptr), v_sz, i, bool:success;
    LIST_foreach(v : list)
    {
        v_sz = MEM_get_size(v);
        if (value_size == v_sz)
        {
            success = true;
            for (i = 0; i < v_sz; i++)
            {
                if (MEM_get_val(value_ptr, i) != MEM_get_val(v, i))
                {
                    success = false;
                    break;
                }
            }
            if (success)
            {
                ++ret;
            }
        }
    }
    return ret;
}

// List push back (value)
stock ListIt:LIST_push_back_val(&List:list, value)
{
    new ListIt:ret = LIST_IT_NULL, Pointer:v = MEM_new_val(value);
    if (v)
    {
        LIST_push_back(list, v);
        MEM_delete(v);
    }
    return ret;
}

// List push back (value[])
stock ListIt:LIST_push_back_arr(&List:list, const value[], value_size = sizeof value)
{
    new ListIt:ret = LIST_IT_NULL, Pointer:v = MEM_new_arr(value, value_size);
    if (v)
    {
        LIST_push_back(list, v);
        MEM_delete(v);
    }
    return ret;
}

// List push back (value[] as string)
stock ListIt:LIST_push_back_str(&List:list, const value[])
{
    return LIST_push_back_arr(list, value, strlen(value) + 1);
}

// List push front (value)
stock ListIt:LIST_push_front_val(&List:list, value)
{
    new ListIt:ret = LIST_IT_NULL, Pointer:v = MEM_new_val(value);
    if (v)
    {
        LIST_push_front(list, v);
        MEM_delete(v);
    }
    return ret;
}

// List push front (value[])
stock ListIt:LIST_push_front_arr(&List:list, const value[], value_size = sizeof value)
{
    new ListIt:ret = LIST_IT_NULL, Pointer:v = MEM_new_arr(value, value_size);
    if (v)
    {
        LIST_push_front(list, v);
        MEM_delete(v);
    }
    return ret;
}

// List push front (value[] as string)
stock ListIt:LIST_push_front_str(&List:list, const value[])
{
    return LIST_push_front_arr(list, value, strlen(value) + 1);
}

// List remove (value)
stock LIST_remove_val(&List:list, value)
{
    new Pointer:v = MEM_new_val(value);
    if (v)
    {
        LIST_remove(list, v);
        MEM_delete(v);
    }
}

// List remove (value[])
stock LIST_remove_arr(&List:list, const value[], value_size = sizeof value)
{
    new Pointer:v = MEM_new_arr(value, value_size);
    if (v)
    {
        LIST_remove(list, v);
        MEM_delete(v);
    }
}

// List remove (value[] as string)
stock LIST_remove_str(&List:list, const value[])
{
    LIST_remove_arr(list, value, strlen(value) + 1);
}

// List contains (value)
stock LIST_contains_val(List:list, value)
{
    new ret, Pointer:v = MEM_new_val(value);
    if (v)
    {
        ret = LIST_contains(list, v);
        MEM_delete(v);
    }
    return ret;
}

// List contains (value[])
stock LIST_contains_arr(List:list, const value[], value_size = sizeof value)
{
    new ret, Pointer:v = MEM_new_arr(value, value_size);
    if (v)
    {
        ret = LIST_contains(list, v);
        MEM_delete(v);
    }
    return ret;
}

// List contains (value[] as string)
stock LIST_contains_str(List:list, const value[])
{
    return LIST_contains_arr(list, value, strlen(value) + 1);
}

// List count
stock LIST_count(List:list)
{
    new ret;
    LIST_foreach (v : list)
    {
        ++ret;
    }
    return ret;
}

// List clear
stock LIST_clear(&List:list)
{
    if (list != LIST_NULL)
    {
        new ListIt:it = ListIt:MEM_get_val(Pointer:list, _:LIST_struct_begin), ListIt:nit;
        while (it != LIST_IT_NULL)
        {
            nit = ListIt:MEM_get_val(Pointer:it, _:LIST_iter_struct_next);
            MEM_delete(Pointer:it);
            it = nit;
        }
    }
    MEM_delete(Pointer:list);
    list = LIST_NULL;
}
