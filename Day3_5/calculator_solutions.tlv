\m5_TLV_version 1d: tl-x.org
\m5
\SV
//Calculator labs solutions here
   m5_makerchip_module
\TLV
   // Simple logics
   |inv_and_or_gate
      @0
         $reset = *reset;
         $out = ! $in1;
         $out1[4:0] = $in2[3:0] + $in3[3:0];
   // Combinational Calculator
   |combination_calculator
      @0
         $reset = *reset;
         $val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];
         $op[1:0] = $rand3[1:0];
      @1
         $sum[31:0] = $val1 + $val2;
         $diff[31:0] = $val1 - $val2;
         $prod[31:0] = $val1 * $val2;
         $quot[31:0] = $val1 / $val2;
      @2
         $out2[31:0] = $reset ? 0 : ($op[1:0] ? $sum : $diff : $prod : $quot);
   // Fibonacci Sequence
   |fibonacci
      @0
         $reset = *reset;
         $num[31:0] = $reset ? 1 : (>>1$num + >>2$num);
   // 1 Incremental counter
   |counter
      @0
         $reset = *reset;
         $num1[31:0] = $reset ? 0 : (>>1$num1 + 1);
   // Sequential Calculator
   |sequential_calculator
      @0
         $reset = *reset;
         $op1[1:0] = $rand4[1:0];
         $vaal1[31:0] = $reset ? 32'b0 : >>1$out3;
         $vaal2[31:0] = $rand5[3:0];
      @1
         $sum1[31:0] = $vaal1 + $vaal2;
         $diff1[31:0] = $vaal1 - $vaal2;
         $prod1[31:0] = $vaal1 * $vaal2;
         $quot1[31:0] = $vaal1 / $vaal2;
      @2
         $out3[31:0] = $reset ? 32'b0 :
                         ($op1 == 2'b00) ? $sum1 :
                            ($op1 == 2'b01) ? $diff1 :
                               ($op1 == 2'b10) ? $prod1 : $quot1;
   // Pipeline Error Condition
   |pipeline
      @1
         $err1 = $bad_input | $illegal_op;
      @3
         $err2 = $err1 | $over_flow;
      @6
         $err3 = $err2 | $div_by_zero;
   // Sequential Calculator with Counter
   |calc
      @1
         $reset = *reset;
         $cnt = $reset ? 0 : >>1$cnt + 1;
         $op2[1:0] = $rand6[1:0];
         $vaaal1[31:0] = $reset ? 32'b0 : >>1$out4;
         $vaaal2[31:0] = $rand7[3:0];
         $sum2[31:0] = $vaaal1 + $vaaal2;
         $diff2[31:0] = $vaaal1 - $vaaal2;
         $prod2[31:0] = $vaaal1 * $vaaal2;
         $quot2[31:0] = $vaaal1 / $vaaal2;
         $out4[31:0] = $reset ? 0 : ($op2[1:0] ? $sum2 : $diff2 : $prod2 : $quot2);
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
