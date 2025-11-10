module manager #(parameter STABLE_TIME = 20'd10, parameter WIDTH = 1)(

    input clk, rst, [WIDTH-1:0]btn,output reg [WIDTH-1:0]btn_trig);

    

    reg [WIDTH-1:0]btn_clear, btn_reg;

    reg [WIDTH-1:0]intermediate;

    reg [19:0] counter;

    

    always @(posedge clk or negedge rst) begin

        if (!rst) begin

            intermediate <= {WIDTH{1'b0}};

            counter <= 0;

            btn_clear <= {WIDTH{1'b0}};

        end

        else if (intermediate != btn) begin

            intermediate <= btn;

            counter <= 0;

        end

        else if(counter < STABLE_TIME) begin

            counter <= counter + 1;

        end

        else begin

            btn_clear <= intermediate;

        end

    end

    

    always @(negedge rst or posedge clk) begin

        if(!rst) begin

            btn_reg <= {WIDTH{1'b0}};

            btn_trig <= {WIDTH{1'b0}};

        end

        else begin

             btn_reg <= btn_clear;

             btn_trig <= btn_clear & ~btn_reg;

        end

    end

endmodule