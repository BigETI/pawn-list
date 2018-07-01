#include <a_samp>
#include <list>

// Required by assert() and assertf()
#pragma tabsize 0

#define assert%2(%0,%1)%3; \
if (!(%0)) \
{ \
    print(%1); \
    return -1; \
}

#define assertf%3(%0,%1,%2)%4; \
if (!(%0)) \
{ \
    printf(%1,%2); \
    return -1; \
}

// Print list
PrintList(List:list)
{
    new v_sz, i;
    printf("[LISTTEST] List (0x%x):", _:list);
    LIST_foreach(v : list)
    {
        v_sz = MEM_get_size(v);
        printf("\tValue pointer: 0x%x; Value size: %d:", _:v, v_sz);
        for (i = 0; i < v_sz; i++)
        {
            printf("\t\t%d => %d", i, MEM_get_val(v, i));
        }
    }
}

// Print list (reverse)
PrintListReverse(List:list)
{
    new v_sz, i;
    printf("[LISTTEST] List (0x%x) (reverse):", _:list);
    LIST_foreach_rev(v : list)
    {
        v_sz = MEM_get_size(v);
        printf("\tValue pointer: 0x%x; Value size: %d:", _:v, v_sz);
        for (i = 0; i < v_sz; i++)
        {
            printf("\t\t%d => %d", i, MEM_get_val(v, i));
        }
    }
}

// Print lists in list
PrintListsInList(List:list)
{
    new vx_sz, vy_sz, i, List:l;
    printf("[LISTTEST] List (0x%x):", _:list);
    LIST_foreach(vx : list)
    {
        vx_sz = MEM_get_size(vx);
        if (vx_sz == 1)
        {
            l = List:MEM_get_val(vx, 0);
            if (l != LIST_NULL)
            {
                if (MEM_get_size(Pointer:l) == LIST_struct)
                {
                    printf("\t[LISTTEST] List (0x%x):", _:l);
                    LIST_foreach(vy : l)
                    {
                        vy_sz = MEM_get_size(vy);
                        printf("\t\tValue pointer: 0x%x; Value size: %d:", _:vy, vy_sz);
                        for (i = 0; i < vy_sz; i++)
                        {
                            printf("\t\t\t%d => %d", i, MEM_get_val(vy, i));
                        }
                    }
                }
                else
                {
                    printf("\tValue pointer: 0x%x; Value size: %d:", _:vx, vx_sz);
                    for (i = 0; i < vx_sz; i++)
                    {
                        printf("\t\t%d => %d", i, MEM_get_val(vx, i));
                    }
                }
            }
            else
            {
                printf("\tValue pointer: 0x%x; Value size: %d:", _:vx, vx_sz);
                for (i = 0; i < vx_sz; i++)
                {
                    printf("\t\t%d => %d", i, MEM_get_val(vx, i));
                }
            }
        }
        else
        {
            printf("\tValue pointer: 0x%x; Value size: %d:", _:vx, vx_sz);
            for (i = 0; i < vx_sz; i++)
            {
                printf("\t\t%d => %d", i, MEM_get_val(vx, i));
            }
        }
    }
}

// Entry point
main()
{
    new List:list, List:list_a, List:list_b, size, arr[10] = { 100, ... }, arr2[10] = { 200, ... };
    print("\r\n==========================");
    print("= List unit test =");
    print("= Made by BigETI =");
    print("= Loaded!        =");
    print("==========================\r\n");
    print("[LISTTEST] Test 1");
    size = LIST_count(list);
    assertf(size == 0, "[LISTTEST] List (0x%x) size is %d, instead of 0.", _:list, size);
    LIST_push_back_val(list, 1);
    LIST_push_back_val(list, 2);
    LIST_push_back_val(list, 3);
    LIST_push_back_val(list, 3);
    LIST_push_back_arr(list, arr);
    LIST_push_back_str(list, "This is a test");
    PrintList(list);
    size = LIST_count(list);
    assertf(size == 6, "[LISTTEST] List (0x%x) size is %d, instead of 6.", _:list, size);
    LIST_push_front_val(list, 4);
    LIST_push_front_val(list, 4);
    LIST_push_front_val(list, 4);
    LIST_push_front_val(list, 4);
    LIST_push_front_arr(list, arr2);
    LIST_push_front_str(list, "This is another test");
    PrintListReverse(list);
    size = LIST_count(list);
    assertf(size == 12, "[LISTTEST] List (0x%x) size is %d, instead of 12.", _:list, size);
    print("[LISTTEST] Test 2");
    LIST_remove_val(list, 4);
    LIST_remove_arr(list, arr2);
    LIST_remove_str(list, "This is another test");
    PrintList(list);
    size = LIST_count(list);
    assertf(size == 6, "[LISTTEST] List (0x%x) size is %d, instead of 6.", _:list, size);
    size = LIST_contains_val(list, 1);
    assertf(size == 1, "[LISTTEST] List (0x%x) contains value 1 %d times, instead of 0 times.", _:list, size);
    size = LIST_contains_val(list, 2);
    assertf(size == 1, "[LISTTEST] List (0x%x) contains value 2 %d times, instead of once.", _:list, size);
    size = LIST_contains_val(list, 3);
    assertf(size == 2, "[LISTTEST] List (0x%x) contains value 3 %d times, instead of 2 times.", _:list, size);
    size = LIST_contains_val(list, 4);
    assertf(size == 0, "[LISTTEST] List (0x%x) contains value 4 %d times, instead of 0 times.", _:list, size);
    size = LIST_contains_arr(list, arr);
    assertf(size == 1, "[LISTTEST] List (0x%x) contains \"arr\" %d times, instead of once.", _:list, size);
    size = LIST_contains_arr(list, arr2);
    assertf(size == 0, "[LISTTEST] List (0x%x) contains \"arr2\" %d times, instead of 0 times.", _:list, size);
    size = LIST_contains_str(list, "This is a test");
    assertf(size == 1, "[LISTTEST] List (0x%x) contains \"This is a test\" %d times, instead of once.", _:list, size);
    size = LIST_contains_str(list, "Foo");
    assertf(size == 0, "[LISTTEST] List (0x%x) contains \"Foo\" %d times, instead of 0 times.", _:list, size);
    print("[LISTTEST] Test 3");
    LIST_clear(list);
    size = LIST_count(list);
    assertf(size == 0, "[LISTTEST] List (0x%x) size is %d, instead of 0.", _:list, size);
    print("[LISTTEST] Test 4");
    LIST_push_back_val(list_a, 1);
    LIST_push_back_val(list_a, 2);
    LIST_push_back_val(list_a, 3);
    LIST_push_back_val(list_b, 4);
    LIST_push_back_val(list_b, 5);
    LIST_push_back_val(list_b, 6);
    LIST_push_back_val(list, _:list_a);
    LIST_push_back_val(list, _:list_b);
    PrintListsInList(list);
    size = LIST_count(list);
    assertf(size == 2, "[LISTTEST] List (0x%x) size is %d, instead of 2.", _:list, size);
    size = LIST_count(list_a);
    assertf(size == 3, "[LISTTEST] List a (0x%x) size is %d, instead of 3.", _:list_a, size);
    size = LIST_count(list_b);
    assertf(size == 3, "[LISTTEST] List b (0x%x) size is %d, instead of 3.", _:list_b, size);
    LIST_clear(list_a);
    LIST_clear(list_b);
    LIST_clear(list);
    print("[LISTTEST] Test 5");
    size = LIST_count(list);
    assertf(size == 0, "[LISTTEST] List (0x%x) size is %d, instead of 0.", _:list, size);
    size = LIST_count(list_a);
    assertf(size == 0, "[LISTTEST] List a (0x%x) size is %d, instead of 0.", _:list_a, size);
    size = LIST_count(list_b);
    assertf(size == 0, "[LISTTEST] List b (0x%x) size is %d, instead of 0.", _:list_b, size);
    print("[LISTTEST] Test completed.");
    return 1;
}
