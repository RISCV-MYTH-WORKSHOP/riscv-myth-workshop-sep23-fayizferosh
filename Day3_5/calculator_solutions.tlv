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
         $out3[31:0] = $reset ? 32'b0 : ($op1 == 2'b00) ? $sum1 : ($op1 == 2'b01) ? $diff1 : ($op1 == 2'b10) ? $prod1 : $quot1;
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
   // Sequential Calculator with Validity 
   |calc_validity
      @1
         $valid = $reset ? 0 : >>1$valid + 1 ;
         $valid_or_reset = $reset || $valid ;
      ?$valid_or_reset
         @1
            $reset = *reset;
            $op3[1:0] = $rand8[1:0];
            $vaaaal1[31:0] = $reset ? 32'b0 : >>2$out5;
            $vaaaal2[31:0] = $rand9[3:0];
            $sum3[31:0] = $vaaaal1 + $vaaaal2;
            $diff3[31:0] = $vaaaal1 - $vaaaal2;
            $prod3[31:0] = $vaaaal1 * $vaaaal2;
            $quot3[31:0] = $vaaaal1 / $vaaaal2;
         @2
            $out5[31:0] = $reset ? 32'b0 : ($op3 == 2'b00) ? $sum3 : ($op3 == 2'b01) ? $diff3 : ($op3 == 2'b10) ? $prod3 : $quot3;
   // Single Value Memory Calculator 
   |calc_svm
      @1
         $valid1 = $reset ? 0 : >>1$valid1 + 1 ;
         $valid_or_reset1 = $valid1 || $reset;
      ?$valid_or_reset1
         @1
            $reset = *reset;
            $op4[2:0] = $rand10[3:0];
            $valu1[31:0] = $reset ? 32'b0 : >>2$out6;
            $valu2[31:0] = $rand11[3:0];
            $sum4[31:0] = $valu1 + $valu2;
            $diff4[31:0] = $valu1 - $valu2;
            $prod4[31:0] = $valu1 * $valu2;
            $quot4[31:0] = $valu1 / $valu2;
         @2               
            $out6[31:0] = $reset | (~$valid1) ? 32'b0 : ($op4 == 3'b000) ? $sum4 : ($op4 == 3'b001) ? $diff4 : ($op4 == 3'b010) ? $prod4 : ($op4 == 3'b011) ? $quot4 : ($op4== 3'b100) ? $mem : ($op4 == 3'b101) ? $RETAIN : 0;
      @2
          $mem[31:0] = $reset ? 32'b0 : $op4 == 3'b101 ? >>2$out6 : $mem ;
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
