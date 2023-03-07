/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Young Yang/Desktop/22nm_5_6_v1_11_00/DFF_TEST_NEW_TOP_tb.v";
static unsigned int ng1[] = {0U, 0U};
static int ng2[] = {0, 0};
static int ng3[] = {8, 0};
static int ng4[] = {1, 0};
static unsigned int ng5[] = {1U, 0U};
static int ng6[] = {43, 0};
static int ng7[] = {6, 0};
static unsigned int ng8[] = {171U, 0U};
static unsigned int ng9[] = {205U, 0U};



static int sp_uart_write(char *t1, char *t2)
{
    char t8[8];
    char t18[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 984);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(90, ng0);

LAB5:    xsi_set_current_line(92, ng0);
    t5 = ((char*)((ng1)));
    t6 = (t1 + 6768);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 1);
    xsi_set_current_line(93, ng0);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 4330000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(96, ng0);
    xsi_set_current_line(96, ng0);
    t4 = ((char*)((ng2)));
    t5 = (t1 + 7088);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 32);

LAB7:    t4 = (t1 + 7088);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng3)));
    memset(t8, 0, 8);
    xsi_vlog_signed_less(t8, 32, t6, 32, t7, 32);
    t9 = (t8 + 4);
    t10 = *((unsigned int *)t9);
    t11 = (~(t10));
    t12 = *((unsigned int *)t8);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(101, ng0);
    t4 = ((char*)((ng5)));
    t5 = (t1 + 6768);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(102, ng0);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 4330000LL);
    *((char **)t3) = &&LAB12;
    t0 = 1;
    goto LAB1;

LAB8:    xsi_set_current_line(96, ng0);

LAB10:    xsi_set_current_line(97, ng0);
    t15 = (t1 + 6928);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t19 = (t1 + 6928);
    t20 = (t19 + 72U);
    t21 = *((char **)t20);
    t22 = (t1 + 7088);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    xsi_vlog_generic_get_index_select_value(t18, 1, t17, t21, 2, t24, 32, 1);
    t25 = (t1 + 6768);
    xsi_vlogvar_assign_value(t25, t18, 0, 0, 1);
    xsi_set_current_line(98, ng0);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 4330000LL);
    *((char **)t3) = &&LAB11;
    t0 = 1;
    goto LAB1;

LAB11:    xsi_set_current_line(96, ng0);
    t4 = (t1 + 7088);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng4)));
    memset(t8, 0, 8);
    xsi_vlog_signed_add(t8, 32, t6, 32, t7, 32);
    t9 = (t1 + 7088);
    xsi_vlogvar_assign_value(t9, t8, 0, 0, 32);
    goto LAB7;

LAB12:    goto LAB4;

}

static int sp_rst_gen(char *t1, char *t2)
{
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    int t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1416);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(107, ng0);

LAB5:    xsi_set_current_line(108, ng0);
    t5 = ((char*)((ng4)));
    t6 = (t1 + 4208);
    xsi_vlogvar_wait_assign_value(t6, t5, 0, 0, 1, 0LL);
    xsi_set_current_line(110, ng0);
    t4 = ((char*)((ng6)));
    t5 = (t4 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t6 = (t1 + 12012);
    *((int *)t6) = t10;

LAB6:    t11 = (t1 + 12012);
    if (*((int *)t11) > 0)
        goto LAB7;

LAB8:    xsi_set_current_line(111, ng0);
    t4 = ((char*)((ng2)));
    t5 = (t1 + 4208);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB7:    xsi_set_current_line(110, ng0);
    t12 = (t2 + 88U);
    t13 = *((char **)t12);
    t14 = (t13 + 0U);
    xsi_wp_set_status(t14, 1);
    *((char **)t3) = &&LAB9;
    goto LAB1;

LAB9:    t4 = (t1 + 12012);
    t10 = *((int *)t4);
    *((int *)t4) = (t10 - 1);
    goto LAB6;

}

static void Initial_63_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(64, ng0);
    t1 = ((char*)((ng4)));
    t2 = (t0 + 4048);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);

LAB1:    return;
}

static void Always_65_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;

LAB0:    t1 = (t0 + 8256U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 8064);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(66, ng0);
    t4 = (t0 + 4048);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t3 + 4);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t6);
    t17 = (~(t16));
    *((unsigned int *)t3) = t17;
    *((unsigned int *)t14) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB10;

LAB9:    t22 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t22 & 1U);
    t23 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t23 & 1U);
    t24 = (t0 + 4048);
    xsi_vlogvar_assign_value(t24, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

LAB10:    t18 = *((unsigned int *)t3);
    t19 = *((unsigned int *)t15);
    *((unsigned int *)t3) = (t18 | t19);
    t20 = *((unsigned int *)t14);
    t21 = *((unsigned int *)t15);
    *((unsigned int *)t14) = (t20 | t21);
    goto LAB9;

}

static void Initial_68_2(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(68, ng0);

LAB2:    xsi_set_current_line(69, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 4368);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(70, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 4528);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(71, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 4688);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(72, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 4848);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(73, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 5008);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(74, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 5168);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(75, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 5328);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(76, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 5488);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(77, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 5648);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(78, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 5808);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(79, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 5968);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(80, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 6128);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(81, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 6288);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(82, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 6448);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(84, ng0);
    t1 = ((char*)((ng5)));
    t2 = (t0 + 6768);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);

LAB1:    return;
}

static void Initial_115_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    t1 = (t0 + 8752U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(115, ng0);

LAB4:    xsi_set_current_line(116, ng0);
    t2 = (t0 + 8560);
    t3 = (t0 + 1416);
    t4 = xsi_create_subprogram_invocation(t2, 0, t0, t3, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t3, t4);

LAB7:    t5 = (t0 + 8656);
    t6 = *((char **)t5);
    t7 = (t6 + 80U);
    t8 = *((char **)t7);
    t9 = (t8 + 272U);
    t10 = *((char **)t9);
    t11 = (t10 + 0U);
    t12 = *((char **)t11);
    t13 = ((int  (*)(char *, char *))t12)(t0, t6);

LAB9:    if (t13 != 0)
        goto LAB10;

LAB5:    t6 = (t0 + 1416);
    xsi_vlog_subprogram_popinvocation(t6);

LAB6:    t14 = (t0 + 8656);
    t15 = *((char **)t14);
    t14 = (t0 + 1416);
    t16 = (t0 + 8560);
    t17 = 0;
    xsi_delete_subprogram_invocation(t14, t15, t0, t16, t17);

LAB1:    return;
LAB8:;
LAB10:    t5 = (t0 + 8752U);
    *((char **)t5) = &&LAB7;
    goto LAB1;

}

static void Initial_119_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    t1 = (t0 + 9000U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(119, ng0);

LAB4:    xsi_set_current_line(120, ng0);
    t2 = (t0 + 8808);
    xsi_process_wait(t2, 1250000000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(120, ng0);
    t3 = (t0 + 8808);
    t4 = (t0 + 1416);
    t5 = xsi_create_subprogram_invocation(t3, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);

LAB8:    t6 = (t0 + 8904);
    t7 = *((char **)t6);
    t8 = (t7 + 80U);
    t9 = *((char **)t8);
    t10 = (t9 + 272U);
    t11 = *((char **)t10);
    t12 = (t11 + 0U);
    t13 = *((char **)t12);
    t14 = ((int  (*)(char *, char *))t13)(t0, t7);

LAB10:    if (t14 != 0)
        goto LAB11;

LAB6:    t7 = (t0 + 1416);
    xsi_vlog_subprogram_popinvocation(t7);

LAB7:    t15 = (t0 + 8904);
    t16 = *((char **)t15);
    t15 = (t0 + 1416);
    t17 = (t0 + 8808);
    t18 = 0;
    xsi_delete_subprogram_invocation(t15, t16, t0, t17, t18);
    goto LAB1;

LAB9:;
LAB11:    t6 = (t0 + 9000U);
    *((char **)t6) = &&LAB8;
    goto LAB1;

}

static void Initial_125_5(char *t0)
{
    char t6[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    char *t30;
    int t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    t1 = (t0 + 9248U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(125, ng0);

LAB4:    xsi_set_current_line(129, ng0);

LAB5:    t2 = (t0 + 4208);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng2)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    t8 = (t5 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t5);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB9;

LAB6:    if (t18 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t6) = 1;

LAB9:    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB11;

LAB10:    t28 = (t0 + 9584);
    *((int *)t28) = 1;
    t29 = (t0 + 9248U);
    *((char **)t29) = &&LAB5;

LAB1:    return;
LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB11:    t30 = (t0 + 9584);
    *((int *)t30) = 0;
    xsi_set_current_line(130, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = (~(t9));
    t11 = *((unsigned int *)t2);
    t31 = (t11 & t10);
    t4 = (t0 + 12016);
    *((int *)t4) = t31;

LAB12:    t5 = (t0 + 12016);
    if (*((int *)t5) > 0)
        goto LAB13;

LAB14:    xsi_set_current_line(131, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 6608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(132, ng0);
    t2 = ((char*)((ng8)));
    t3 = (t0 + 9056);
    t4 = (t0 + 984);
    t5 = xsi_create_subprogram_invocation(t3, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);
    t7 = (t0 + 6928);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 8);

LAB18:    t8 = (t0 + 9152);
    t21 = *((char **)t8);
    t22 = (t21 + 80U);
    t28 = *((char **)t22);
    t29 = (t28 + 272U);
    t30 = *((char **)t29);
    t32 = (t30 + 0U);
    t33 = *((char **)t32);
    t31 = ((int  (*)(char *, char *))t33)(t0, t21);

LAB20:    if (t31 != 0)
        goto LAB21;

LAB16:    t21 = (t0 + 984);
    xsi_vlog_subprogram_popinvocation(t21);

LAB17:    t34 = (t0 + 9152);
    t35 = *((char **)t34);
    t34 = (t0 + 984);
    t36 = (t0 + 9056);
    t37 = 0;
    xsi_delete_subprogram_invocation(t34, t35, t0, t36, t37);
    xsi_set_current_line(133, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 9056);
    t4 = (t0 + 984);
    t5 = xsi_create_subprogram_invocation(t3, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);
    t7 = (t0 + 6928);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 8);

LAB24:    t8 = (t0 + 9152);
    t21 = *((char **)t8);
    t22 = (t21 + 80U);
    t28 = *((char **)t22);
    t29 = (t28 + 272U);
    t30 = *((char **)t29);
    t32 = (t30 + 0U);
    t33 = *((char **)t32);
    t31 = ((int  (*)(char *, char *))t33)(t0, t21);

LAB26:    if (t31 != 0)
        goto LAB27;

LAB22:    t21 = (t0 + 984);
    xsi_vlog_subprogram_popinvocation(t21);

LAB23:    t34 = (t0 + 9152);
    t35 = *((char **)t34);
    t34 = (t0 + 984);
    t36 = (t0 + 9056);
    t37 = 0;
    xsi_delete_subprogram_invocation(t34, t35, t0, t36, t37);
    goto LAB1;

LAB13:    xsi_set_current_line(130, ng0);
    t7 = (t0 + 9600);
    *((int *)t7) = 1;
    t8 = (t0 + 9280);
    *((char **)t8) = t7;
    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB15:    t2 = (t0 + 12016);
    t31 = *((int *)t2);
    *((int *)t2) = (t31 - 1);
    goto LAB12;

LAB19:;
LAB21:    t8 = (t0 + 9248U);
    *((char **)t8) = &&LAB18;
    goto LAB1;

LAB25:;
LAB27:    t8 = (t0 + 9248U);
    *((char **)t8) = &&LAB24;
    goto LAB1;

}


extern void work_m_00000000000855776369_0712420295_init()
{
	static char *pe[] = {(void *)Initial_63_0,(void *)Always_65_1,(void *)Initial_68_2,(void *)Initial_115_3,(void *)Initial_119_4,(void *)Initial_125_5};
	static char *se[] = {(void *)sp_uart_write,(void *)sp_rst_gen};
	xsi_register_didat("work_m_00000000000855776369_0712420295", "isim/DFF_TEST_NEW_TOP_tb_isim_beh.exe.sim/work/m_00000000000855776369_0712420295.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
