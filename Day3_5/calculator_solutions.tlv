\m4_TLV_version 1d: tl-x.org
\SV
//Calculator labs solutions here
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
