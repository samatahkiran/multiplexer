`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2024 16:47:50
// Design Name: 
// Module Name: mux_axi
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_axi(

    input wire clk,
    input wire reset_n,
    
    input wire [7:0] s_axis_data_1,
    input wire s_axis_valid_1,
    output reg s_axis_ready_1,
    input wire s_axis_last_1,
    
    input wire [7:0] s_axis_data_2,
    input wire s_axis_valid_2,
    output reg s_axis_ready_2,
    input wire s_axis_last_2,
    
    output reg [7:0] m_axis_data,
    output reg m_axis_valid,
    input wire m_axis_ready,
    output reg m_axis_last,
    
    input wire sel
);

  //reg data_last;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        m_axis_data <= 8'h00;
        s_axis_ready_1 <= 1'b0;
        s_axis_ready_2 <= 1'b0;
        m_axis_last <= 1'b0;
        m_axis_valid <= 1'b0;
       // data_last <= 1'b0;
    end else begin
        if (sel) begin
            if (s_axis_valid_2 && m_axis_ready) begin
                m_axis_data <= s_axis_data_2;
                m_axis_valid <= s_axis_valid_2;
                s_axis_ready_2 <= m_axis_ready;
                m_axis_last <= s_axis_last_2;  // Select input_b
               
            end
        end else begin
            if (s_axis_valid_1 && m_axis_ready) begin
                m_axis_data <= s_axis_data_1;
                m_axis_valid <= s_axis_valid_1;
                s_axis_ready_1 <= m_axis_ready;
                m_axis_last <= s_axis_last_1;  // Select input_a
             
            end
        end
    end
end
  
   //assign m_axis_last = data_last;
endmodule