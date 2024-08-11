#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sat Aug 10 21:40:31 -04 2024
# SW Build 2188600 on Wed Apr  4 18:39:19 MDT 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep xelab -wto cbfca7616b9144cb9a3fe48eb4491381 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip -L xpm --snapshot ALU_tb_behav xil_defaultlib.ALU_tb -log elaborate.log
