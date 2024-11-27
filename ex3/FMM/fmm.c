/* 211788625 evyatar paz */
#include "fmm.h"

 void fmm(int n, int *m1, int *m2, int *result)
 {
     int i, j, k, r;
     int sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10;
     for (i = 0; i < n; i++)
     {
        int in = i*n;
         for (j = 0; j < n - 9; j += 10)
         {
             result[in + j] = 0;
             result[in + j + 1] = 0;
             result[in + j + 2] = 0;
             result[in + j + 3] = 0;
             result[in + j + 4] = 0;
             result[in + j + 5] = 0;
             result[in + j + 6] = 0;
             result[in + j + 7] = 0;
             result[in + j + 8] = 0;
             result[in + j + 9] = 0;
         }
         for (; j < n; j++)
         {
             result[in + j] = 0;
         }
         for (k = 0; k < n; k++)
         {
            int kn = k*n;
             r = m1[in + k]; // r = m1[i][k]
             // Unroll the inner loop by a factor of 10
             for (j = 0; j < n - 9; j += 10)
             {
                 sum1 = r * m2[kn + j];
                 sum2 = r * m2[kn + j + 1];
                 sum3 = r * m2[kn + j + 2];
                 sum4 = r * m2[kn + j + 3];
                 sum5 = r * m2[kn + j + 4];
                 sum6 = r * m2[kn + j + 5];
                 sum7 = r * m2[kn + j + 6];
                 sum8 = r * m2[kn + j + 7];
                 sum9 = r * m2[kn + j + 8];
                 sum10 = r * m2[kn + j + 9];

                result[in + j] += sum1;
                result[in + j + 1] += sum2;
                result[in + j + 2] += sum3;
                result[in + j + 3] += sum4;
                result[in + j + 4] += sum5;
                result[in + j + 5] += sum6;
                result[in + j + 6] += sum7;
                result[in + j + 7] += sum8;
                result[in + j + 8] += sum9;
                result[in + j + 9] += sum10;
            }
            for (; j < n; j++)
            {
                sum1 = r * m2[kn + j];
                result[in + j] += sum1;
            }
        }
    }
}