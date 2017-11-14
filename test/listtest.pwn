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

// On filter script init
public OnFilterScriptInit()
{
    new List:list, size, arr[10] = { 100, ... }, arr2[10] = { 200, ... };
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
    print("[LISTTEST] Test completed.");
    print("\r\n==========================");
    print("= List test filterscript =");
    print("=         Made by BigETI =");
    print("= Loaded!                =");
    print("==========================\r\n");
    return 1;
}

// On filter script exit
public OnFilterScriptExit()
{
    print("\r\n==========================");
    print("= List test filterscript =");
    print("=         Made by BigETI =");
    print("= Unloaded!              =");
    print("==========================\r\n");
    return 1;
}
