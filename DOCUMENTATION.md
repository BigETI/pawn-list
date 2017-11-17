# Linked list implementation in PAWN

## Important
Use `LIST_clear` if you don't need your list anymore, to prevent memory leaks!

## Documentation (Functions)

### LIST_iter_begin
#### Description
Get first iterator
#### Returns
First iterator if available, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_iter_begin(List:list, &Pointer:value_ptr)
```
#### Example
```C
new List:list, ListIt:it, Pointer:ptr;
LIST_insert_val(list, 1);
LIST_insert_val(list, 2);
LIST_insert_val(list, 3);
it = LIST_iter_begin(list, ptr);
printf("The first value (0x%x) at iterator (0x%x) is: %d", _:ptr, _:it, MEM_get_val(ptr));
```

### LIST_iter_end
#### Description
Get last iterator
#### Returns
Last iterator if available, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_iter_end(List:list, &Pointer:value_ptr)
```
#### Example
```C
new List:list, ListIt:it, Pointer:ptr;
LIST_insert_val(list, 1);
LIST_insert_val(list, 2);
LIST_insert_val(list, 3);
it = LIST_iter_end(list, ptr);
printf("The last value (0x%x) at iterator (0x%x) is: %d", _:ptr, _:it, MEM_get_val(ptr));
```

### LIST_iter_next
#### Description
Get next iterator
#### Returns
Next iterator if available, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_iter_next(ListIt:list_iterator, &Pointer:value_ptr)
```
#### Example
```C
new List:list, ListIt:it, Pointer:ptr;
LIST_insert_val(list, 1);
LIST_insert_val(list, 2);
LIST_insert_val(list, 3);
for (new Pointer:ptr, Listit:it = LIST_iter_begin(list, ptr); it != LIST_IT_NULL; it = LIST_iter_next(it, ptr))
{
	//
}
```

### LIST_iter_previous
#### Description
Get previous iterator
#### Returns
Previous iterator if available, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_iter_previous(ListIt:list_iterator, &Pointer:value_ptr)
```
#### Example
```C
new List:list, ListIt:it, Pointer:ptr;
LIST_insert_val(list, 1);
LIST_insert_val(list, 2);
LIST_insert_val(list, 3);
for (new Pointer:ptr, Listit:it = LIST_iter_end(list, ptr); it != LIST_IT_NULL; it = LIST_iter_previous(it, ptr))
{
	//
}
```

### LIST_push_back_val
#### Description
List push back (value)
#### Returns
Associated iterator if successful, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_push_back_val(&List:list, value)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
```

### LIST_push_back_arr
#### Description
List push back (value[])
#### Returns
Associated iterator if successful, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_push_back_arr(&List:list, const value[], value_size = sizeof value)
```
#### Example
```C
new List:list, arr[10] = { 100, ... };
LIST_push_back_arr(list, arr);
```

### LIST_push_back_str
#### Description
List push back (value[] as string)
#### Returns
Associated iterator if successful, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_push_back_str(&List:list, const value[])
```
#### Example
```C
new List:list;
LIST_push_back_str(list, "This is a test");
```

### LIST_push_front_val
#### Description
List push front (value)
#### Returns
Associated iterator if successful, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_push_front_val(&List:list, value)
```
#### Example
```C
new List:list;
LIST_push_front_val(list, 1);
```

### LIST_push_front_arr
#### Description
List push front (value[])
#### Returns
Associated iterator if successful, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_push_front_arr(&List:list, const value[], value_size = sizeof value)
```
#### Example
```C
new List:list, arr[10] = { 100, ... };
LIST_push_front_arr(list, arr);
```

### LIST_push_front_str
#### Description
List push front (value[] as string)
#### Returns
Associated iterator if successful, otherwise `LIST_IT_NULL`
#### Syntax
```C
ListIt:LIST_push_front_str(&List:list, const value[])
```
#### Example
```C
new List:list;
LIST_push_front_str(list, "This is a test");
```

### LIST_pop_back
#### Description
List pop back
#### Syntax
```C
ListIt:LIST_pop_back(&List:list)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_pop_back(list);
```

### LIST_pop_front
#### Description
List pop front
#### Syntax
```C
ListIt:LIST_pop_front(&List:list)
```
#### Example
```C
new List:list;
LIST_push_front_val(list, 1);
LIST_pop_front(list);
```

### LIST_remove_val
#### Description
List remove (value)
#### Syntax
```C
LIST_remove_val(&List:list, value)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 1);
LIST_remove_val(list, 1);
```

### LIST_remove_arr
#### Description
List remove (value[])
#### Syntax
```C
LIST_remove_arr(&List:list, const value[], value_size = sizeof value)
```
#### Example
```C
new List:list, arr[10] = { 100, ... };
LIST_push_back_arr(list, arr);
LIST_push_back_arr(list, arr);
LIST_push_back_arr(list, arr);
LIST_remove_arr(list, arr);
```

### LIST_remove_str
#### Description
List remove (value[] as string)
#### Returns

#### Syntax
```C
LIST_remove_str(&List:list, const value[])
```
#### Example
```C
new List:list;
LIST_push_back_str(list, "This is a test");
LIST_push_back_str(list, "This is a test");
LIST_push_back_str(list, "This is a test");
LIST_remove_str(list, "This is a test");
```

### LIST_contains_val
#### Description
List contains (value)
#### Returns
Number of occurence
#### Syntax
```C
LIST_contains_val(List:list, value)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 2);
LIST_push_back_val(list, 3);
printf("Value 1 is contained %d times", LIST_contains_val(list, 1));
```

### LIST_contains_arr
#### Description
List contains (value[])
#### Returns
Number of occurence
#### Syntax
```C
LIST_contains_arr(List:list, const value[], value_size = sizeof value)
```
#### Example
```C
new List:list, arr1[10] = { 100, ... }, arr2[20] = { 200, ... }, arr3[30] = { 300, ... };
LIST_push_back_arr(list, arr1);
LIST_push_back_arr(list, arr1);
LIST_push_back_arr(list, arr1);
LIST_push_back_arr(list, arr2);
LIST_push_back_arr(list, arr3);
printf("\"arr1\" is contained %d times", LIST_contains_arr(list, arr1));
```

### LIST_contains_str
#### Description
List contains (value[] as string)
#### Returns
Number of occurence
#### Syntax
```C
LIST_contains_str(List:list, const value[])
```
#### Example
```C
new List:list;
LIST_push_back_str(list, "This is a test");
LIST_push_back_str(list, "This is a test");
LIST_push_back_str(list, "This is a test");
LIST_push_back_str(list, "Foo");
LIST_push_back_str(list, "Bar");
printf("\"This is a test\" is contained %d times", LIST_contains_str(list, "This is a test"));
```

### LIST_count
#### Description
List count
#### Returns
Number of elements
#### Syntax
```C
LIST_count(List:list)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 2);
LIST_push_back_val(list, 3);
printf("Number of elements: %d", LIST_count(list));
```

### LIST_clear
#### Description
List clear
#### Syntax
```C
LIST_clear(&List:list)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 2);
LIST_push_back_val(list, 3);
LIST_clear(list);
```

## Documentation (Definitions)

### LIST_NULL
#### Description
Empty list (null pointer)

### LIST_IT_NULL
#### Description
No list iterator (null pointer)

### LIST_foreach
#### Description
Method to traverse through a list
#### Syntax
```C
LIST_foreach(Pointer:value : List:list)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 2);
LIST_push_back_val(list, 3);
LIST_foreach(v : map)
{
	printf("0x%x, %d, \"%d\"", _:v, MEM_get_size(v), MEM_get_val(v, _));
}
```
or
```C
new List:list, arr1[10] = { 100, ... }, arr2[20] = { 200, ... }, arr3[30] = { 300, ... }, value[30], m_v_sz, v_sz;
LIST_push_back_arr(list, arr1);
LIST_push_back_arr(list, arr2);
LIST_push_back_arr(list, arr3);
LIST_foreach(v : map)
{
	v_sz = MEM_get_size(v);
	m_v_sz = ((v_sz < sizeof value) ? v_sz : sizeof value);
	MEM_zero(UnmanagedPointer:MEM_get_addr(value[0]), sizeof value);
	MEM_get_arr(v, _, value, m_v_sz);
	printf("0x%x, %d", _:v, v_sz);
	print("\tValue:");
	for (new i = 0; i < m_v_sz; i++)
	{
		printf("\t\t0x%x", value[i]);
	}
}
```
or
```C
new List:list, value[16], m_v_sz, v_sz;
LIST_push_back_str(map, "This is a test);
LIST_push_back_str(map, "foo");
LIST_push_back_str(map, "bar");
LIST_foreach(v : list)
{
	v_sz = MEM_get_size(v);
	m_v_sz = ((v_sz < sizeof value) ? v_sz : sizeof value);
	MEM_zero(UnmanagedPointer:MEM_get_addr(value[0]), sizeof value);
	MEM_get_arr(v, _, value, m_v_sz);
	printf("0x%x, %d, \"%s\"", _:v, v_sz, value);
}
```

### LIST_foreach_rev
#### Description
Method to traverse through a list in reverse
#### Syntax
```C
LIST_foreach_rev(Pointer:value : List:list)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 2);
LIST_push_back_val(list, 3);
LIST_foreach_rev(v : map)
{
	printf("0x%x, %d, \"%d\"", _:v, MEM_get_size(v), MEM_get_val(v, _));
}
```
or
```C
new List:list, arr1[10] = { 100, ... }, arr2[20] = { 200, ... }, arr3[30] = { 300, ... }, value[30], m_v_sz, v_sz;
LIST_push_back_arr(list, arr1);
LIST_push_back_arr(list, arr2);
LIST_push_back_arr(list, arr3);
LIST_foreach_rev(v : map)
{
	v_sz = MEM_get_size(v);
	m_v_sz = ((v_sz < sizeof value) ? v_sz : sizeof value);
	MEM_zero(UnmanagedPointer:MEM_get_addr(value[0]), sizeof value);
	MEM_get_arr(v, _, value, m_v_sz);
	printf("0x%x, %d", _:v, v_sz);
	print("\tValue:");
	for (new i = 0; i < m_v_sz; i++)
	{
		printf("\t\t0x%x", value[i]);
	}
}
```
or
```C
new List:list, value[16], m_v_sz, v_sz;
LIST_push_back_str(map, "This is a test);
LIST_push_back_str(map, "foo");
LIST_push_back_str(map, "bar");
LIST_foreach_rev(v : list)
{
	v_sz = MEM_get_size(v);
	m_v_sz = ((v_sz < sizeof value) ? v_sz : sizeof value);
	MEM_zero(UnmanagedPointer:MEM_get_addr(value[0]), sizeof value);
	MEM_get_arr(v, _, value, m_v_sz);
	printf("0x%x, %d, \"%s\"", _:v, v_sz, value);
}
```

### LIST_foreach_ex
#### Description
Method to traverse through a list
#### Syntax
```C
LIST_foreach_ex(Pointer:value, ListIt:iterator : List:list)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 2);
LIST_push_back_val(list, 3);
LIST_foreach(v, it : list)
{
	printf("0x%x, 0x%x, %d, \"%d\"", _:v, _:it, MEM_get_size(v), MEM_get_val(v, _));
}
```
or
```C
new List:list, arr1[10] = { 100, ... }, arr2[20] = { 200, ... }, arr3[30] = { 300, ... }, value[30], m_v_sz, v_sz;
LIST_push_back_arr(list, arr1);
LIST_push_back_arr(list, arr2);
LIST_push_back_arr(list, arr3);
LIST_foreach_ex(v, it : list)
{
	v_sz = MEM_get_size(v);
	m_v_sz = ((v_sz < sizeof value) ? v_sz : sizeof value);
	MEM_zero(UnmanagedPointer:MEM_get_addr(value[0]), sizeof value);
	MEM_get_arr(v, _, value, m_v_sz);
	printf("0x%x, 0x%x, %d", _:v, _:it, v_sz);
	print("\tValue:");
	for (new i = 0; i < m_v_sz; i++)
	{
		printf("\t\t0x%x", value[i]);
	}
}
```
or
```C
new List:list, value[16], m_v_sz, v_sz;
LIST_push_back_str(map, "This is a test);
LIST_push_back_str(map, "foo");
LIST_push_back_str(map, "bar");
LIST_foreach_ex(v, it : list)
{
	v_sz = MEM_get_size(v);
	m_v_sz = ((v_sz < sizeof value) ? v_sz : sizeof value);
	MEM_zero(UnmanagedPointer:MEM_get_addr(value[0]), sizeof value);
	MEM_get_arr(v, _, value, m_v_sz);
	printf("0x%x, 0x%x, %d, \"%s\"", _:v, _:it, v_sz, value);
}
```

### LIST_foreach_rev
#### Description
Method to traverse through a list in reverse
#### Syntax
```C
MAP_foreach_rev(Pointer:value, ListIt:iterator : List:list)
```
#### Example
```C
new List:list;
LIST_push_back_val(list, 1);
LIST_push_back_val(list, 2);
LIST_push_back_val(list, 3);
LIST_foreach_rev_ex(v, it : map)
{
	printf("0x%x, 0x%x, %d, \"%d\"", _:v, _:it, MEM_get_size(v), MEM_get_val(v, _));
}
```
or
```C
new List:list, arr1[10] = { 100, ... }, arr2[20] = { 200, ... }, arr3[30] = { 300, ... }, value[30], m_v_sz, v_sz;
LIST_push_back_arr(list, arr1);
LIST_push_back_arr(list, arr2);
LIST_push_back_arr(list, arr3);
LIST_foreach_rev_ex(v, it : map)
{
	v_sz = MEM_get_size(v);
	m_v_sz = ((v_sz < sizeof value) ? v_sz : sizeof value);
	MEM_zero(UnmanagedPointer:MEM_get_addr(value[0]), sizeof value);
	MEM_get_arr(v, _, value, m_v_sz);
	printf("0x%x, 0x%x, %d", _:v, _:it, v_sz);
	print("\tValue:");
	for (new i = 0; i < m_v_sz; i++)
	{
		printf("\t\t0x%x", value[i]);
	}
}
```
or
```C
new List:list, value[16], m_v_sz, v_sz;
LIST_push_back_str(map, "This is a test);
LIST_push_back_str(map, "foo");
LIST_push_back_str(map, "bar");
LIST_foreach_rev_ex(v, it : list)
{
	v_sz = MEM_get_size(v);
	m_v_sz = ((v_sz < sizeof value) ? v_sz : sizeof value);
	MEM_zero(UnmanagedPointer:MEM_get_addr(value[0]), sizeof value);
	MEM_get_arr(v, _, value, m_v_sz);
	printf("0x%x, 0x%x, %d, \"%s\"", _:v, _:it, v_sz, value);
}
```
