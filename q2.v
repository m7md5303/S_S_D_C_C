module tes_fsm (speed_limit,car_speed,leading_distance,clk,rst,unlock_doors,accelerate_car);
parameter MIN_DISTANCE=7'd40;
parameter STOP=2'b00;
parameter DECELERATE=2'b01;
parameter ACCELERATE=2'b10;
input [7:0] speed_limit,car_speed;
input [6:0] leading_distance;
input clk,rst;
output unlock_doors,accelerate_car;
reg unlock_doors_tmp,accelerate_car_tmp;
reg [1:0] cs,ns;
always @(posedge clk or posedge rst) begin
    if(rst) begin
        cs<=STOP;
    end
    else begin
        cs<=ns;
    end
end
always @(cs or speed_limit or car_speed or leading_distance) begin
    case(cs)
    STOP:begin
        if(leading_distance<MIN_DISTANCE) begin
            ns=STOP;
        end
        else begin
            ns=ACCELERATE;
        end
    end
    DECELERATE:begin
        if((leading_distance<MIN_DISTANCE)||(car_speed>speed_limit)) begin
            ns=DECELERATE;
        end
        else if(car_speed==0) begin
            ns=STOP;
        end
         else
        begin
            ns=ACCELERATE;
        end
    end
    ACCELERATE:begin
        if((leading_distance>=MIN_DISTANCE)&&(car_speed<speed_limit)) begin
            ns=ACCELERATE;
        end
        else 
           begin
            ns=DECELERATE;
           end
    end
    default:begin
        ns=STOP;
    end
    endcase
end
always@(*) begin
    case(cs)
    STOP:begin
        unlock_doors_tmp=1;
        accelerate_car_tmp=0;
    end
    DECELERATE:begin
        unlock_doors_tmp=0;
        accelerate_car_tmp=0;
    end
    ACCELERATE:begin
        unlock_doors_tmp=0;
        accelerate_car_tmp=1;
    end
    default:begin
        unlock_doors_tmp=1;
        accelerate_car_tmp=0;
    end
    endcase
end
assign unlock_doors=unlock_doors_tmp;
assign accelerate_car=accelerate_car_tmp;
endmodule 