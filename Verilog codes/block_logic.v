`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2025 13:09:03
// Design Name: 
// Module Name: block_logic
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


module block_logic(
    input clk, reset, 
    input [2:0] movement, //  000 clockwise, 001 anti-clockwise, 010 down, 011 left, 100 right, 101 nothing
    input [2:0] block_type,
    output reg [3:0] x1,x2,x3,x4,
    output reg [4:0] y1,y2,y3,y4
    );
    
    //1: line, 2: square, 3: inverted T, 4: S, 5: Z, 6: J, 7: L;
    // config 00, 01 are 0 and 180 degree configurations
    // config 10 and 11 are 90 and 270 degree configurations
    reg [1:0] config_current, config_next;    
    
    reg [3:0] x1_next,x2_next,x3_next,x4_next; 
    reg [4:0] y1_next,y2_next,y3_next,y4_next;
    
    
    always @(*) begin
        case(block_type)
            3'd1: begin // line
                casex(movement)
                    3'b00x: begin 
                        casex(config_current)
                            2'b0x: begin
                                x1_next = x1 + 4'd2;
                                x2_next = x2 + 4'd1;
                                x3_next = x3;
                                x4_next = x4 - 4'd1;
                                
                                y1_next = y1 - 5'd2;
                                y2_next = y2 - 5'd1;
                                y3_next = y3;
                                y4_next = y4 + 5'd1;
                            end
                            
                            2'b1x: begin
                                x1_next = x1 + 4'd2;
                                x2_next = x2 + 4'd1;
                                x3_next = x3;
                                x4_next = x4 - 4'd1;
                                
                                y1_next = y1 + 5'd2;
                                y2_next = y2 + 5'd1;
                                y3_next = y3;
                                y4_next = y4 - 5'd1;
                            end
                            
                            default: begin
                                x1_next = x1;
                                x2_next = x2;
                                x3_next = x3;
                                x4_next = x4;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3;
                                y4_next = y4;
                            end
                        endcase  
                    end
                    
                    3'b010: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1 + 5'd1;
                        y2_next = y2 + 5'd1;
                        y3_next = y3 + 5'd1;
                        y4_next = y4 + 5'd1; 
                    end
                    
                    3'b011: begin
                        x1_next = x1 - 4'd1;
                        x2_next = x2 - 4'd1;
                        x3_next = x3 - 4'd1;
                        x4_next = x4 - 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b100: begin
                        x1_next = x1 + 4'd1;
                        x2_next = x2 + 4'd1;
                        x3_next = x3 + 4'd1;
                        x4_next = x4 + 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b101: begin // No input case
                    end                  
                endcase
            end
           // end for line
           // start for square 
            3'd2: begin // square
                case(movement)
                    
                    3'b00x: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b010: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1 + 5'd1;
                        y2_next = y2 + 5'd1;
                        y3_next = y3 + 5'd1;
                        y4_next = y4 + 5'd1; 
                    end
                    
                    3'b011: begin
                        x1_next = x1 - 4'd1;
                        x2_next = x2 - 4'd1;
                        x3_next = x3 - 4'd1;
                        x4_next = x4 - 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b011: begin
                        x1_next = x1 + 4'd1;
                        x2_next = x2 + 4'd1;
                        x3_next = x3 + 4'd1;
                        x4_next = x4 + 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b101: begin
                        // no input case
                    end
                    
                    default: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                     end
                endcase
            end
            
            // end of square
            // start of inverted T
            
            3'd3: begin // inverted T
                case(movement)
                    3'b000: begin // clockwise
                        case(config_current)
                            2'b00: begin 
                                x1_next = x1;
                                y1_next = y1;
                                
                                x2_next = x2 + 4'd1;
                                y2_next = y2;
                                
                                x3_next = x3 + 4'd1;
                                y3_next = y3;
                                
                                x4_next = x4 - 4'd1;
                                y4_next = y4 + 5'd1;
                            end
                            2'b01: begin
                                x1_next = x1 + 4'd1;
                                y1_next = y1 - 5'd1;
                                
                                x2_next = x2 - 4'd1;
                                y2_next = y2;
                                
                                x3_next = x3 - 4'd1;
                                y3_next = y3;
                                
                                x4_next = x4;
                                y4_next = y4;
                            end
                            2'b10: begin
                                x1_next = x1 - 4'd1;
                                y1_next = y1 + 5'd1;
                                
                                x2_next = x2;
                                y2_next = y2;
                                
                                x3_next = x3;
                                y3_next = y3;
                                
                                x4_next = x4;
                                y4_next = y4;
                            end
                            2'b11: begin
                                x1_next = x1;
                                y1_next = y1;
                                
                                x2_next = x2;
                                y2_next = y2;
                                
                                x3_next = x3;
                                y3_next = y3;
                                
                                x4_next = x4 + 4'd1;
                                y4_next = y4 - 5'd1;
                            end
                        endcase
                    end
                    3'b001: begin // anticlockwise
                        case(config_current)
                            2'b00: begin 
                                x1_next = x1;
                                y1_next = y1;
                                
                                x2_next = x2;
                                y2_next = y2;
                                
                                x3_next = x3;
                                y3_next = y3;
                                
                                x4_next = x4 - 4'd1;
                                y4_next = y4 + 5'd1;
                            end
                            2'b01: begin
                                x1_next = x1 + 4'd1;
                                y1_next = y1 - 5'd1;
                                
                                x2_next = x2;
                                y2_next = y2;
                                
                                x3_next = x3;
                                y3_next = y3;
                                
                                x4_next = x4;
                                y4_next = y4;
                            end
                            2'b10: begin
                                x1_next = x1;
                                y1_next = y1;
                                
                                x2_next = x2 - 4'd1;
                                y2_next = y2;
                                
                                x3_next = x3 - 4'd1;
                                y3_next = y3;
                                
                                x4_next = x4 + 4'd1;
                                y4_next = y4 - 5'd1;
                            end
                            2'b11: begin
                                x1_next = x1 - 4'd1;
                                y1_next = y1 + 5'd1;
                                
                                x2_next = x2 + 4'd1;
                                y2_next = y2;
                                
                                x3_next = x3 + 4'd1;
                                y3_next = y3;
                                
                                x4_next = x4;
                                y4_next = y4;
                            end
                        endcase
                    end
                    3'b010: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1 + 5'd1;
                        y2_next = y2 + 5'd1;
                        y3_next = y3 + 5'd1;
                        y4_next = y4 + 5'd1;
                    end
                    3'b011: begin
                        x1_next = x1 - 4'd1;
                        x2_next = x2 - 4'd1;
                        x3_next = x3 - 4'd1;
                        x4_next = x4 - 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b100: begin
                        x1_next = x1 + 4'd1;
                        x2_next = x2 + 4'd1;
                        x3_next = x3 + 4'd1;
                        x4_next = x4 + 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b101: begin
                    end
                endcase
            end
            
            // end of inverted T
            // start of S
            3'd4: begin // S
                case(movement)
                    3'b00x: begin // clockwise and anticlockwise
                        case(config_current)
                            2'b0x: begin 
                                x1_next = x1;
                                y1_next = y1;
                                
                                x2_next = x2 - 4'd1;
                                y2_next = y2 + 5'd1;
                                
                                x3_next = x3 + 4'd2;
                                y3_next = y3;
                                
                                x4_next = x4 + 4'd1;
                                y4_next = y4 + 5'd1;
                            end
                            
                            2'b1x: begin
                                x1_next = x1;
                                y1_next = y1;
                                
                                x2_next = x2 + 4'd1;
                                y2_next = y2 - 5'd1;
                                
                                x3_next = x3 - 4'd2;
                                y3_next = y3;
                                
                                x4_next = x4 - 4'd1;
                                y4_next = y4 - 5'd1;
                            end
                           
                        endcase
                    end
                    3'b010: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1 + 5'd1;
                        y2_next = y2 + 5'd1;
                        y3_next = y3 + 5'd1;
                        y4_next = y4 + 5'd1;
                    end
                    3'b011: begin
                        x1_next = x1 - 4'd1;
                        x2_next = x2 - 4'd1;
                        x3_next = x3 - 4'd1;
                        x4_next = x4 - 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b100: begin
                        x1_next = x1 + 4'd1;
                        x2_next = x2 + 4'd1;
                        x3_next = x3 + 4'd1;
                        x4_next = x4 + 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b101: begin
                    end
                endcase
            end
            
            // end of S
            // start of Z
            3'd5: begin // z
                case(movement)
                    3'b00x: begin // clockwise and anticlockwise
                        case(config_current)
                            2'b0x: begin 
                                x1_next = x1 + 4'd2;
                                y1_next = y1;
                                
                                x2_next = x2;
                                y2_next = y2 + 5'd1;
                                
                                x3_next = x3 + 4'd1;
                                y3_next = y3;
                                
                                x4_next = x4 - 4'd1;
                                y4_next = y4 + 5'd1;
                            end
                            
                            2'b1x: begin
                                x1_next = x1 - 4'd2;
                                y1_next = y1;
                                
                                x2_next = x2;
                                y2_next = y2 - 5'd1;
                                
                                x3_next = x3 - 4'd1;
                                y3_next = y3;
                                
                                x4_next = x4 + 4'd1;
                                y4_next = y4 - 5'd1;
                            end
                           
                        endcase
                    end
                    3'b010: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1 + 5'd1;
                        y2_next = y2 + 5'd1;
                        y3_next = y3 + 5'd1;
                        y4_next = y4 + 5'd1;
                    end
                    3'b011: begin
                        x1_next = x1 - 4'd1;
                        x2_next = x2 - 4'd1;
                        x3_next = x3 - 4'd1;
                        x4_next = x4 - 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b100: begin
                        x1_next = x1 + 4'd1;
                        x2_next = x2 + 4'd1;
                        x3_next = x3 + 4'd1;
                        x4_next = x4 + 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b101: begin
                    end
                endcase
            end
            
            // end of Z
            // start of J
            
            3'd6: begin // J
                casex(movement)
                    3'b000: begin // clockwise
                        casex(config_current)
                            2'b00: begin
                                x1_next = x1 - 4'd1;
                                x2_next = x2 + 4'd1;
                                x3_next = x3;
                                x4_next = x4;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3 + 5'd1;
                                y4_next = y4 + 5'd1;
                            end
                            
                            2'b01: begin
                                x1_next = x1;
                                x2_next = x2;
                                x3_next = x3 - 4'd1;
                                x4_next = x4 + 4'd1;
                                
                                y1_next = y1 - 5'd1;
                                y2_next = y2 - 5'd1;
                                y3_next = y3;
                                y4_next = y4;
                            end
                            
                            2'b10: begin
                                x1_next = x1 - 4'd1;
                                x2_next = x2;
                                x3_next = x3 + 4'd1;
                                x4_next = x4 - 4'd2;
                                
                                y1_next = y1 + 5'd1;
                                y2_next = y2;
                                y3_next = y3 - 5'd1;
                                y4_next = y4;
                            end
                            
                            2'b11: begin
                                x1_next = x1 + 4'd2;
                                x2_next = x2 - 4'd1;
                                x3_next = x3;
                                x4_next = x4 + 4'd1;
                                
                                y1_next = y1;
                                y2_next = y2 + 5'd1;
                                y3_next = y3;
                                y4_next = y4 - 5'd1;
                            end
                            
                            default: begin
                                x1_next = x1;
                                x2_next = x2;
                                x3_next = x3;
                                x4_next = x4;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3;
                                y4_next = y4;
                            end
                        endcase  
                    end
                    
                    3'b001: begin // anticlockwise
                        casex(config_current)
                            2'b00: begin
                                x1_next = x1 - 4'd2;
                                x2_next = x2 + 4'd1;
                                x3_next = x3;
                                x4_next = x4 - 4'd1;
                                
                                y1_next = y1;
                                y2_next = y2 - 5'd1;
                                y3_next = y3;
                                y4_next = y4 + 5'd1;
                            end
                            
                            2'b01: begin
                                x1_next = x1 + 4'b1;
                                x2_next = x2;
                                x3_next = x3 - 4'd1;
                                x4_next = x4 + 4'd2;
                                
                                y1_next = y1 - 5'd1;
                                y2_next = y2;
                                y3_next = y3 + 5'd1;
                                y4_next = y4;
                            end
                            
                            2'b10: begin
                                x1_next = x1 + 4'd1;
                                x2_next = x2 - 4'd1;
                                x3_next = x3;
                                x4_next = x4;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3 - 5'd1;
                                y4_next = y4 - 5'd1;
                            end
                            
                            2'b11: begin
                                x1_next = x1;
                                x2_next = x2;
                                x3_next = x3 + 4'd1;
                                x4_next = x4 - 4'd1;
                                
                                y1_next = y1 + 5'd1;
                                y2_next = y2 + 5'd1;
                                y3_next = y3;
                                y4_next = y4;
                            end
                            
                            default: begin
                                x1_next = x1;
                                x2_next = x2;
                                x3_next = x3;
                                x4_next = x4;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3;
                                y4_next = y4;
                            end
                        endcase  
                    end
                    
                    3'b010: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1 + 5'd1;
                        y2_next = y2 + 5'd1;
                        y3_next = y3 + 5'd1;
                        y4_next = y4 + 5'd1; 
                    end
                    
                    3'b011: begin
                        x1_next = x1 - 4'd1;
                        x2_next = x2 - 4'd1;
                        x3_next = x3 - 4'd1;
                        x4_next = x4 - 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b100: begin
                        x1_next = x1 + 4'd1;
                        x2_next = x2 + 4'd1;
                        x3_next = x3 + 4'd1;
                        x4_next = x4 + 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b101: begin // No input case
                    end                  
                endcase
            end
            
            // end of J
            // start of L
            
            3'd7: begin // L
                casex(movement)
                    3'b000: begin // clockwise
                        casex(config_current)
                            2'b00: begin
                                x1_next = x1 + 4'd1;
                                x2_next = x2 + 4'd2;
                                x3_next = x3;
                                x4_next = x4 - 4'd1;
                                
                                y1_next = y1;
                                y2_next = y2 - 5'd1;
                                y3_next = y3;
                                y4_next = y4 + 5'd1;
                            end
                            
                            2'b01: begin
                                x1_next = x1 + 4'd1;
                                x2_next = x2;
                                x3_next = x3 - 4'd1;
                                x4_next = x4 - 4'd2;
                                
                                y1_next = y1 - 5'd1;
                                y2_next = y2;
                                y3_next = y3 + 5'd1;
                                y4_next = y4;
                            end
                            
                            2'b10: begin
                                x1_next = x1 - 4'd1;
                                x2_next = x2 - 4'd1;
                                x3_next = x3 + 4'd1;
                                x4_next = x4 + 4'd1;
                                
                                y1_next = y1 + 5'd1;
                                y2_next = y2 + 5'd1;
                                y3_next = y3;
                                y4_next = y4 - 5'd1;
                            end
                            
                            2'b11: begin
                                x1_next = x1 - 4'd1;
                                x2_next = x2 - 4'd1;
                                x3_next = x3 + 4'd1;
                                x4_next = x4 + 4'd1;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3 - 5'd1;
                                y4_next = y4 - 5'd1;
                            end
                            
                            default: begin
                                x1_next = x1;
                                x2_next = x2;
                                x3_next = x3;
                                x4_next = x4;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3;
                                y4_next = y4;
                            end
                        endcase  
                    end
                    
                    3'b001: begin // anticlockwise
                        casex(config_current)
                            2'b00: begin
                                x1_next = x1 + 4'd1;
                                x2_next = x2 + 4'd1;
                                x3_next = x3 - 4'd1;
                                x4_next = x4 - 4'd1;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3 + 5'd1;
                                y4_next = y4 + 5'd1;
                            end
                            
                            2'b01: begin
                                x1_next = x1 + 4'b1;
                                x2_next = x2 + 4'b1;
                                x3_next = x3 - 4'd1;
                                x4_next = x4 + 4'd1;
                                
                                y1_next = y1 - 5'd1;
                                y2_next = y2 - 5'd1;
                                y3_next = y3;
                                y4_next = y4;
                            end
                            
                            2'b10: begin
                                x1_next = x1 - 4'd1;
                                x2_next = x2 - 4'd2;
                                x3_next = x3;
                                x4_next = x4 + 4'd1;
                                
                                y1_next = y1;
                                y2_next = y2 + 5'd1;
                                y3_next = y3;
                                y4_next = y4 - 5'd1;
                            end
                            
                            2'b11: begin
                                x1_next = x1 - 4'd1;
                                x2_next = x2;
                                x3_next = x3 + 4'd2;
                                x4_next = x4 + 4'd1;
                                
                                y1_next = y1 + 5'd1;
                                y2_next = y2;
                                y3_next = y3 - 5'd1;
                                y4_next = y4;
                            end
                            
                            default: begin
                                x1_next = x1;
                                x2_next = x2;
                                x3_next = x3;
                                x4_next = x4;
                                
                                y1_next = y1;
                                y2_next = y2;
                                y3_next = y3;
                                y4_next = y4;
                            end
                        endcase  
                    end
                    
                    3'b010: begin
                        x1_next = x1;
                        x2_next = x2;
                        x3_next = x3;
                        x4_next = x4;
                        
                        y1_next = y1 + 5'd1;
                        y2_next = y2 + 5'd1;
                        y3_next = y3 + 5'd1;
                        y4_next = y4 + 5'd1; 
                    end
                    
                    3'b011: begin
                        x1_next = x1 - 4'd1;
                        x2_next = x2 - 4'd1;
                        x3_next = x3 - 4'd1;
                        x4_next = x4 - 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b100: begin
                        x1_next = x1 + 4'd1;
                        x2_next = x2 + 4'd1;
                        x3_next = x3 + 4'd1;
                        x4_next = x4 + 4'd1;
                        
                        y1_next = y1;
                        y2_next = y2;
                        y3_next = y3;
                        y4_next = y4; 
                    end
                    
                    3'b101: begin // No input case
                    end                  
                endcase
            end
        endcase
    end
    
   localparam sq1_initial = {4'd4,5'd0}, sq2_initial = {4'd5, 5'd0};
    localparam sq3_initial = {4'd4, 5'd1}, sq4_initial = {4'd5, 5'd1};
    
    localparam invT1_initial = {4'd4, 5'd0}, invT2_initial = {4'd3, 5'd1};
    localparam invT3_initial = {4'd4, 5'd1}, invT4_initial = {4'd5, 5'd1};
    
    localparam line1_initial = {4'd3, 5'd0}, line2_initial = {4'd4, 5'd0};
    localparam line3_initial = {4'd5, 5'd0}, line4_initial = {4'd6, 5'd0};
    
    localparam z1_initial = {4'd4,5'd0}, z2_initial = {4'd5, 5'd0};
    localparam z3_initial = {4'd5, 5'd1}, z4_initial = {4'd6, 5'd1};
    
    localparam s1_initial = {4'd5,5'd0}, s2_initial = {4'd6, 5'd0};
    localparam s3_initial = {4'd4, 5'd1}, s4_initial = {4'd5, 5'd1};
    
    localparam l1_initial = {4'd3, 5'd0}, l2_initial = {4'd3, 5'd1};
    localparam l3_initial = {4'd4, 5'd1}, l4_initial = {4'd5, 5'd1};
    
    localparam j1_initial = {4'd6, 5'd0}, j2_initial = {4'd4, 5'd1};
    localparam j3_initial = {4'd5, 5'd1}, j4_initial = {4'd6, 5'd1};
    
    //1: line, 2: square, 3: inverted T, 4: S, 5: Z, 6: J, 7: L
    always @(posedge clk) begin
        if (reset) begin
            case(block_type)
                3'd1: {x1,y1,x2,y2,x3,y3,x4,y4} <= {line1_initial, line2_initial, line3_initial, line4_initial};
                3'd2: {x1,y1,x2,y2,x3,y3,x4,y4} <= {sq1_initial, sq2_initial, sq3_initial, sq4_initial};
                3'd3: {x1,y1,x2,y2,x3,y3,x4,y4} <= {invT1_initial, invT2_initial, invT3_initial, invT4_initial};
                3'd4: {x1,y1,x2,y2,x3,y3,x4,y4} <= {s1_initial, s2_initial, s3_initial, s4_initial};
                3'd5: {x1,y1,x2,y2,x3,y3,x4,y4} <= {z1_initial, z2_initial, z3_initial, z4_initial};
                3'd6: {x1,y1,x2,y2,x3,y3,x4,y4} <= {j1_initial, j2_initial, j3_initial, j4_initial};
                3'd7: {x1,y1,x2,y2,x3,y3,x4,y4} <= {l1_initial, l2_initial, l3_initial, l4_initial};
            endcase
        end
        else begin
            x1 <= x1_next;
            x2 <= x2_next;
            x3 <= x3_next;
            x4 <= x4_next;
            y1 <= y1_next;
            y2 <= y2_next;
            y3 <= y3_next;
            y4 <= y4_next;
        end
    end    
endmodule
