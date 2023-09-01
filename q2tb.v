module tes_fsm_tb();
reg [7:0] speed_limit,car_speed;
reg [6:0] leading_distance;
reg clk,rst;
wire unlock_doors,accelerate_car;
tes_fsm dut(speed_limit,car_speed,leading_distance,clk,rst,unlock_doors,accelerate_car);
initial begin
    clk=0;
    forever begin
        #30 clk=~clk;
    end
end
initial begin
rst=1;
repeat(150) begin
    speed_limit=$random;
    car_speed=$random;
    leading_distance=$random;
    @(negedge clk);
end
rst=0;
repeat(100) begin
    speed_limit=$urandom_range(50,100);
    car_speed=$urandom_range(150,200);
    leading_distance=$urandom_range(0,40);
    @(negedge clk);
end
repeat(100) begin
    speed_limit=$urandom_range(160,300);
    car_speed=$urandom_range(100,150);
    leading_distance=$urandom_range(40,80);
    @(negedge clk);
end
repeat(100) begin
    speed_limit=$urandom_range(60,100);
    car_speed=$urandom_range(100,150);
    leading_distance=$urandom_range(40,80);
    @(negedge clk);
end
repeat(10) begin
    speed_limit=150;
    car_speed=0;
    leading_distance=$urandom_range(40,60);
    @(negedge clk);
end
repeat(300) begin
    speed_limit=$random;
    car_speed=$random;
    leading_distance=$random;
    @(negedge clk);
end
$stop;
end
endmodule