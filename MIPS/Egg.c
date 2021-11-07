#include <stdio.h>

inline int max(int a, int b)
{
    return a > b ? a : b;
}

inline int min(int a, int b)
{
    return a < b ? a : b;
}

int main()
{
    // dp_array[k][n] 代表有k + 1个鸡蛋，测试n层楼的最坏情况（尝试次数）
    int egg_sum, floor_sum;
    int** dp_array;

#ifdef EMBEDDED

    // input from embedded I/O
    // Memory mapping : 
    // 0x00  egg_sum
    // 0x04  floor_sum
    // 0x08  result
    // 0x0c  addr of dp_array[0]
    __asm__ volatile (
        "lw %[egg_sum_reg], 0($0)\t\n"
        "lw %[floor_sum_reg], 4($0)\t\n"
        "addi %[dp_array_reg], $0, 0xc\t\n"

        // initial memory from 0xc to 0xc + (egg_sum - 1) * 4
        "addi $1, $0, 0\t\n" // $1 + 0xc is &dp_array[i]
        "sll $3, %[egg_sum_reg], 2\t\n" // $3 is egg_sum_reg * 4
        "sll $4, %[floor_sum_reg], 2\t\n"
        "addi $4, $4, 0x4\t\n" // $4 is sizeof(dp_array[i])
        "addi $2, $3, 0xc\t\n" // $2 is dp_array[i]
        "COMPARE:\t\n"
        "beq $1, $3, FINISH\t\n"
        "nop\t\n"
        "sw $2, 0xc($1)\t\n"
        "addiu $1, $1, 0x4\t\n"
        "addu $2, $2, $4\t\n"
        "j COMPARE\t\n"
        "nop"
        "FINISH:\t\n"
        : // output
        [egg_sum_reg]"=r"(egg_sum),
        [floor_sum_reg]"=r"(floor_sum),
        [dp_array_reg]"=r"(dp_array)
        : // input
        :
        "memory", "$1", "$2" // destroy
    );
#else
    scanf("%d %d", &egg_sum, &floor_sum);

    dp_array = new int*[egg_sum];
    for (int i = 0; i < egg_sum; ++i) {
        dp_array[i] = new int[floor_sum + 1];
    }

#endif

    // DP start
    for (int i = 0; i <= floor_sum; ++i) {
        dp_array[0][i] = i;
    }

    for (int i = 0; i < egg_sum; ++i) {
        dp_array[i][0] = 0;
    }

    for (int egg_idx = 1; egg_idx < egg_sum; ++egg_idx) {
        for (int floor_idx = 1; floor_idx <= floor_sum; ++floor_idx) {

            int lo = 1;
            int hi = floor_idx;

            while (lo + 1 < hi) {
                int middle = (lo + hi) / 2;
                int t1 = dp_array[egg_idx - 1][middle - 1];
                int t2 = dp_array[egg_idx][floor_idx - middle];

                if (t1 < t2) {
                    lo = middle;
                }
                else if (t1 > t2) {
                    hi = middle;
                }
                else {
                    lo = middle;
                    hi = middle;
                }
            }

            dp_array[egg_idx][floor_idx] = 1 + min(max(dp_array[egg_idx - 1][lo - 1], dp_array[egg_idx][floor_idx - lo]),
                                                   max(dp_array[egg_idx - 1][hi - 1], dp_array[egg_idx][floor_idx - hi]));
        }
    }

#ifdef EMBEDDED
    // output to I/O
    __asm__ volatile (
        "sw %[result], 8($0)\t\n"
        :
        : // input
        [result]"r"(dp_array[egg_sum - 1][floor_sum])
        : // destroy
    );
#else
    printf("%d\n", dp_array[egg_sum - 1][floor_sum]);
#endif

    return 0;
}