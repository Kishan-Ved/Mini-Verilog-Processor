`timescale 1ns / 1ps

module final_lab(clk,i1,i2,i3,i4,i5,i6,out1,out2);
parameter n=8, m=16;
input clk,i1,i2,i3,i4,i5,i6;
reg [n-1:0]inst[6:0]; // This is the instruction register

reg Cy=0;

reg  [n-1:0] Q[m-1:0]; // This is the memory
integer pc=0; // This is the program counter
reg [n-1:0]acc=0; // This is the accumulator
reg [n-1:0]ext=0; // This is for mult and div
reg cb=0; // This is the carry borrow register
reg [7:0] temp_a, count;
reg [3:0]idx;

wire slow_clk;
integer j;
output reg [7:0]out1,out2;
initial
begin
    Q[0] = 2;
    Q[1] = 43;
    Q[2] = 5;
    Q[3] = 3;
    Q[4] = 4;
    Q[5] = 8'b10000000;
    Q[6] = 8'b10001111;
    Q[7] = 7;
    Q[8] = 8;
    Q[9] = 9;
    Q[10] = 10;
    Q[11] = 11;
    Q[12] = 12;
    Q[13] = 13;
    Q[14] = 14;
    Q[15] = 15;
// Addition
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b00010001;
//    inst[2] = 8'b11111111;
//// Multiplication
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b00110001;
//    inst[2] = 8'b11111111;
    // Circular right shift
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b00000011;
//    inst[2] = 8'b00000011;
//    inst[3] = 8'b11111111;
    // Circular left shift
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b00000100;
//    inst[2] = 8'b00000100;
//    inst[3] = 8'b11111111;
    // Arithematic right shift
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b00000101;
//    inst[2] = 8'b00000101;
//    inst[3] = 8'b11111111;
// And
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b01010001;
//    inst[2] = 8'b11111111;
// Increment ACC
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b00000110;
//    inst[2] = 8'b00000110;
//    inst[3] = 8'b11111111;
    
//testcase for division 
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b01000001;
//    inst[2] = 8'b11111111;
//testcase for comparison
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b01110001;
//    inst[2] = 8'b11111111;
//testcase for moving contents of acc to Ri and no operation
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b00000000;
//    inst[2] = 8'b10100001;
//    inst[3] = 8'b11111111;
//testcase for branching
//    cb = 1;
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b10000000;
//    inst[2] = 8'b10100001;
//    inst[3] = 8'b11111111;
//    inst[4] = 8'b00000010;
//    inst[5] = 8'b00000010;
//    inst[6] = 8'b11111111;
//testcase for subtraction
//    inst[0] = 8'b10010000;
//    inst[1] = 8'b00000111;
//    inst[2] = 8'b11111111;
// Testcase given by Ma'am
//      inst[0] = 8'b10010001;
//      inst[1] = 8'b01100001;
//      inst[2] = 8'b00010101;
//      inst[3] = 8'b00010110;
//      inst[4] = 8'b10100111;
//      inst[5] = 8'b11111111;
      inst[0] = 8'b10010001; // Load ACC
      inst[1] = 8'b01000010; // Divide operation
      inst[2] = 8'b10000101; // cb (carry borrow) is 0 here, hence, no branching takes place
      inst[3] = 8'b00000111; // Decrement ACC
      inst[4] = 8'b11111111; // HLT
      inst[5] = 8'b00000101;
      inst[6] = 8'b10110011;
end

clock_divider obj(clk, slow_clk);
  
always@(posedge clk) begin
    if(inst[pc]==8'b11111111) 
        $finish();
    else if(inst[pc][7:4]==4'b0001) begin
        {cb,acc} = acc + Q[inst[pc][3:0]];
        pc = pc+1;
    end
    else if(inst[pc][7:4]==4'b1001) begin
        acc = Q[inst[pc][3:0]]; // Load the acc
        pc = pc+1;
    end
    else if(inst[pc][7:4]==4'b0110) begin
        acc = acc^Q[inst[pc][3:0]]; // xor acc's contents with register's contents
        pc = pc+1;
    end
    else if(inst[pc][7:4]==4'b0011) begin
        {ext,acc} = acc * Q[inst[pc][3:0]];
        pc = pc+1;
    end
    else if(inst[pc]==8'b00000001) begin
        acc <= acc << 1;
        pc = pc+1;
    end
    else if(inst[pc]==8'b00000010) begin
        acc <= acc >> 1;
        pc = pc+1;
    end
    else if(inst[pc]==8'b00000011) begin
        acc <= {acc[0], acc[7:1]}; // Circular right shift
        pc = pc + 1;
    end
    else if(inst[pc]==8'b00000100) begin
        acc <= {acc[6:0],acc[7]}; // Circular left shift
        pc = pc + 1;
    end
    else if(inst[pc]==8'b00000101) begin
        acc <= {acc[7], acc[7:1]};
        pc = pc+1;
    end
    else if(inst[pc][7:4]==4'b0101) begin
        acc = acc & Q[inst[pc][3:0]]; // xor acc's contents with register's contents
        pc = pc+1;
    end
    else if(inst[pc]==8'b00000110) begin
        if(acc==8'b11111111) begin
            cb <= 1;
            acc <= 0;
        end
        else begin
            acc <= acc + 1;
        end
        pc = pc+1;
    end
    // Lavanya
    else if(inst[pc][7:4]==4'b0100)begin
         temp_a = acc;
         count = 8'b00000000;
         for(j=0; j<256; j=j+1) begin 
            if(temp_a >= Q[inst[pc][3:0]]) begin
                 temp_a = temp_a - Q[inst[pc][3:0]]; 
                 count = count + 1;
            end
         end
         
     acc = count;
     ext = temp_a;
     pc = pc + 1;
    end
    else if(inst[pc][7:4]==4'b0111)begin
        if(acc>=Q[inst[pc][3:0]])
         cb = 0;  
        else cb = 1;
        pc = pc + 1;
    end 
    else if(inst[pc]==8'b00000000)
        pc = pc + 1;
    else if(inst[pc][7:4]==4'b1010)begin
        Q[inst[pc][3:0]]= acc;
        pc = pc + 1;
    end
    else if(inst[pc][7:4] == 4'b1000)begin
        if(cb==1) 
        pc <= inst[pc][3:0];
        else 
        pc <= pc + 1;
        
    end
    else if(inst[pc][7:4] == 4'b1011)begin 
        pc <= inst[pc][3:0];
    end 
    else if(inst[pc][7:4] == 4'b0010)begin
        {cb,acc} = acc - Q[inst[pc][3:0]];
        pc <= pc + 1;
    end
    else if(inst[pc]==8'b00000111)begin
        {cb,acc} = acc - 1;
        pc <= pc + 1;
    end
    else begin
        pc <= pc+1;
    end
    
    if(i1==0 && i2==0 && i3==0 && i4==0) out1 = Q[0];
    else if(i1==0 && i2==0 && i3==0 && i4==1) out1 = Q[1];
    else if(i1==0 && i2==0 && i3==1 && i4==0) out1 = Q[2];
    else if(i1==0 && i2==0 && i3==1 && i4==1) out1 = Q[3];
    else if(i1==0 && i2==1 && i3==0 && i4==0) out1 = Q[4];
    else if(i1==0 && i2==1 && i3==0 && i4==1) out1 = Q[5];
    else if(i1==0 && i2==1 && i3==1 && i4==0) out1 = Q[6];
    else if(i1==0 && i2==1 && i3==1 && i4==1) out1 = Q[7];
    else if(i1==1 && i2==0 && i3==0 && i4==0) out1 = Q[8];
    else if(i1==1 && i2==0 && i3==0 && i4==1) out1 = Q[9];
    else if(i1==1 && i2==0 && i3==1 && i4==0) out1 = Q[10];
    else if(i1==1 && i2==0 && i3==1 && i4==1) out1 = Q[11];
    else if(i1==1 && i2==1 && i3==0 && i4==0) out1 = Q[12];
    else if(i1==1 && i2==1 && i3==0 && i4==1) out1 = Q[13];
    else if(i1==1 && i2==1 && i3==1 && i4==0) out1 = Q[14];
    else out1 = Q[15];
    
    if(i5==0 && i6==0) out2 <= acc;
    else if(i5==1 && i6==0) out2 <= cb;
    else if(i5==1 && i6==1) out2 <= ext;
end

endmodule
