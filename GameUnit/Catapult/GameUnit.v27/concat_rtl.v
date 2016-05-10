
//------> ./rtl_mgc_ioport.v 
//------------------------------------------------------------------
//                M G C _ I O P O R T _ C O M P S
//------------------------------------------------------------------

//------------------------------------------------------------------
//                       M O D U L E S
//------------------------------------------------------------------

//------------------------------------------------------------------
//-- INPUT ENTITIES
//------------------------------------------------------------------

module mgc_in_wire (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] d;
  input  [width-1:0] z;

  wire   [width-1:0] d;

  assign d = z;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output [width-1:0] d;
  output             lz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;

  wire               vd;
  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;

endmodule
//------------------------------------------------------------------

module mgc_chan_in (ld, vd, d, lz, vz, z, size, req_size, sizez, sizelz);

  parameter integer rscid = 1;
  parameter integer width = 8;
  parameter integer sz_width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;
  output [sz_width-1:0] size;
  input              req_size;
  input  [sz_width-1:0] sizez;
  output             sizelz;


  wire               vd;
  wire   [width-1:0] d;
  wire               lz;
  wire   [sz_width-1:0] size;
  wire               sizelz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;
  assign size = sizez;
  assign sizelz = req_size;

endmodule


//------------------------------------------------------------------
//-- OUTPUT ENTITIES
//------------------------------------------------------------------

module mgc_out_stdreg (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input    [width-1:0] d;
  output   [width-1:0] z;

  wire     [width-1:0] z;

  assign z = d;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  input  [width-1:0] d;
  output             lz;
  output [width-1:0] z;

  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  input  [width-1:0] d;
  output             lz;
  input              vz;
  output [width-1:0] z;

  wire               vd;
  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;
  assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_out_prereg_en (ld, d, lz, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    wire               lz;
    wire   [width-1:0] z;

    assign z = d;
    assign lz = ld;

endmodule

//------------------------------------------------------------------
//-- INOUT ENTITIES
//------------------------------------------------------------------

module mgc_inout_stdreg_en (ldin, din, ldout, dout, lzin, lzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output [width-1:0] din;
    input              ldout;
    input  [width-1:0] dout;
    output             lzin;
    output             lzout;
    inout  [width-1:0] z;

    wire   [width-1:0] din;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign z = ldout ? dout : {width{1'bz}};

endmodule

//------------------------------------------------------------------
module hid_tribuf( I_SIG, ENABLE, O_SIG);
  parameter integer width = 8;

  input [width-1:0] I_SIG;
  input ENABLE;
  inout [width-1:0] O_SIG;

  assign O_SIG = (ENABLE) ? I_SIG : { width{1'bz}};

endmodule
//------------------------------------------------------------------

module mgc_inout_stdreg_wait (ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;
    wire   ldout_and_vzout;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign vdout = vzout ;
    assign ldout_and_vzout = ldout && vzout ;

    hid_tribuf #(width) tb( .I_SIG(dout),
                            .ENABLE(ldout_and_vzout),
                            .O_SIG(z) );

endmodule

//------------------------------------------------------------------

module mgc_inout_buf_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    hid_tribuf #(width) tb( .I_SIG(z_buf),
                            .ENABLE((lzout_buf && (!ldin) && vzout) ),
                            .O_SIG(z)  );

    mgc_out_buf_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFF
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );


endmodule

module mgc_inout_fifo_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer ph_log2 = 3;     // log2(fifo_sz)
    parameter integer pwropt  = 0;     // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               comb;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    assign comb = (lzout_buf && (!ldin) && vzout);

    hid_tribuf #(width) tb2( .I_SIG(z_buf), .ENABLE(comb), .O_SIG(z)  );

    mgc_out_fifo_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
    )
    FIFO
    (
        .clk   (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );

endmodule

//------------------------------------------------------------------
//-- I/O SYNCHRONIZATION ENTITIES
//------------------------------------------------------------------

module mgc_io_sync (ld, lz);

    input  ld;
    output lz;

    assign lz = ld;

endmodule

module mgc_bsync_rdy (rd, rz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 0;

    input  rd;
    output rz;

    wire   rz;

    assign rz = rd;

endmodule

module mgc_bsync_vld (vd, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 0;
    parameter valid = 1;

    output vd;
    input  vz;

    wire   vd;

    assign vd = vz;

endmodule

module mgc_bsync_rv (rd, vd, rz, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 1;

    input  rd;
    output vd;
    output rz;
    input  vz;

    wire   vd;
    wire   rz;

    assign rz = rd;
    assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_sync (ldin, vdin, ldout, vdout);

  input  ldin;
  output vdin;
  input  ldout;
  output vdout;

  wire   vdin;
  wire   vdout;

  assign vdin = ldout;
  assign vdout = ldin;

endmodule

///////////////////////////////////////////////////////////////////////////////
// dummy function used to preserve funccalls for modulario
// it looks like a memory read to the caller
///////////////////////////////////////////////////////////////////////////////
module funccall_inout (d, ad, bd, z, az, bz);

  parameter integer ram_id = 1;
  parameter integer width = 8;
  parameter integer addr_width = 8;

  output [width-1:0]       d;
  input  [addr_width-1:0]  ad;
  input                    bd;
  input  [width-1:0]       z;
  output [addr_width-1:0]  az;
  output                   bz;

  wire   [width-1:0]       d;
  wire   [addr_width-1:0]  az;
  wire                     bz;

  assign d  = z;
  assign az = ad;
  assign bz = bd;

endmodule


///////////////////////////////////////////////////////////////////////////////
// inlinable modular io not otherwise found in mgc_ioport
///////////////////////////////////////////////////////////////////////////////

module modulario_en_in (vd, d, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output             vd;
  output [width-1:0] d;
  input              vz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               vd;

  assign d = z;
  assign vd = vz;

endmodule

//------> ./rtl_mgc_ioport_v2001.v 
//------------------------------------------------------------------

module mgc_out_reg_pos (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(posedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(posedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg_neg (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(negedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(negedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg (clk, en, arst, srst, ld, d, lz, z); // Not Supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;


    generate
    if (ph_clk == 1'b0)
    begin: NEG_EDGE

        mgc_out_reg_neg
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_neg_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    else
    begin: POS_EDGE

        mgc_out_reg_pos
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_pos_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    endgenerate

endmodule




//------------------------------------------------------------------

module mgc_out_buf_wait (clk, en, arst, srst, ld, vd, d, vz, lz, z); // Not supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    output             vd;
    input  [width-1:0] d;
    output             lz;
    input              vz;
    output [width-1:0] z;

    wire               filled;
    wire               filled_next;
    wire   [width-1:0] abuf;
    wire               lbuf;


    assign filled_next = (filled & (~vz)) | (filled & ld) | (ld & (~vz));

    assign lbuf = ld & ~(filled ^ vz);

    assign vd = vz | ~filled;

    assign lz = ld | filled;

    assign z = (filled) ? abuf : d;

    wire dummy;
    wire dummy_bufreg_lz;

    // Output registers:
    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (1'b1),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    STATREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (filled_next),
        .d       (1'b0),       // input d is unused
        .lz      (filled),
        .z       (dummy)            // output z is unused
    );

    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (lbuf),
        .d       (d),
        .lz      (dummy_bufreg_lz),
        .z       (abuf)
    );

endmodule

//------------------------------------------------------------------

module mgc_out_fifo_wait (clk, en, arst, srst, ld, vd, d, lz, vz,  z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1; // clock enable polarity
    parameter         ph_arst = 1'b1; // async reset polarity
    parameter         ph_srst = 1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt


    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;

    wire    [31:0]      size;


      // Output registers:
 mgc_out_fifo_wait_core#(
        .rscid   (rscid),
        .width   (width),
        .sz_width (32),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
        ) CORE (
        .clk (clk),
        .en (en),
        .arst (arst),
        .srst (srst),
        .ld (ld),
        .vd (vd),
        .d (d),
        .lz (lz),
        .vz (vz),
        .z (z),
        .size (size)
        );

endmodule



module mgc_out_fifo_wait_core (clk, en, arst, srst, ld, vd, d, lz, vz,  z, size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // size of port for elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt

   localparam integer  fifo_b = width * fifo_sz;

    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;
    output    [sz_width-1:0]      size;

    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat_pre;
    wire     [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat;
    reg      [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff_pre;
    wire     [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff;
    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] en_l;
    reg      [(((fifo_sz > 0) ? fifo_sz : 1)-1)/8:0] en_l_s;

    reg       [width-1:0] buff_nxt;

    reg                   stat_nxt;
    reg                   stat_before;
    reg                   stat_after;
    reg                   en_l_var;

    integer               i;
    genvar                eni;

    wire [32:0]           size_t;
    reg [31:0]            count;
    reg [31:0]            count_t;
    reg [32:0]            n_elem;
// pragma translate_off
    reg [31:0]            peak;
// pragma translate_on

    wire [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] dummy_statreg_lz;
    wire [( (fifo_b > 0) ? fifo_b : 1)-1:0] dummy_bufreg_lz;

    generate
    if ( fifo_sz > 0 )
    begin: FIFO_REG
      assign vd = vz | ~stat[0];
      assign lz = ld | stat[fifo_sz-1];
      assign size_t = (count - (vz && stat[fifo_sz-1])) + ld;
      assign size = size_t[sz_width-1:0];
      assign z = (stat[fifo_sz-1]) ? buff[fifo_b-1:width*(fifo_sz-1)] : d;

      always @(*)
      begin: FIFOPROC
        n_elem = 33'b0;
        for (i = fifo_sz-1; i >= 0; i = i - 1)
        begin
          if (i != 0)
            stat_before = stat[i-1];
          else
            stat_before = 1'b0;

          if (i != (fifo_sz-1))
            stat_after = stat[i+1];
          else
            stat_after = 1'b1;

          stat_nxt = stat_after &
                    (stat_before | (stat[i] & (~vz)) | (stat[i] & ld) | (ld & (~vz)));

          stat_pre[i] = stat_nxt;
          en_l_var = 1'b1;
          if (!stat_nxt)
            begin
              buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end
          else if (vz && stat_before)
            buff_nxt[0+:width] = buff[width*(i-1)+:width];
          else if (ld && !((vz && stat_before) || ((!vz) && stat[i])))
            buff_nxt = d;
          else
            begin
              if (pwropt == 0)
                buff_nxt[0+:width] = buff[width*i+:width];
              else
                buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end

          if (ph_en != 0)
            en_l[i] = en & en_l_var;
          else
            en_l[i] = en | ~en_l_var;

          buff_pre[width*i+:width] = buff_nxt[0+:width];

          if ((stat_after == 1'b1) && (stat[i] == 1'b0))
            n_elem = ($unsigned(fifo_sz) - 1) - i;
        end

        if (ph_en != 0)
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b1;
        else
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b0;

        for (i = fifo_sz-1; i >= 7; i = i - 1)
        begin
          if ((i%'d2) == 0)
          begin
            if (ph_en != 0)
              en_l_s[(i/8)-1] = en & (stat[i]|stat_pre[i-1]);
            else
              en_l_s[(i/8)-1] = en | ~(stat[i]|stat_pre[i-1]);
          end
        end

        if ( stat[fifo_sz-1] == 1'b0 )
          count_t = 32'b0;
        else if ( stat[0] == 1'b1 )
          count_t = { {(32-ph_log2){1'b0}}, fifo_sz};
        else
          count_t = n_elem[31:0];
        count = count_t;
// pragma translate_off
        if ( peak < count )
          peak = count;
// pragma translate_on
      end

      if (pwropt == 0)
      begin: NOCGFIFO
        // Output registers:
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        STATREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
        );
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_b),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        BUFREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre),
            .lz      (dummy_bufreg_lz[0]),
            .z       (buff)
        );
      end
      else
      begin: CGFIFO
        // Output registers:
        if ( pwropt > 1)
        begin: CGSTATFIFO2
          for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
          begin: pwroptGEN1
            mgc_out_reg
            #(
              .rscid   (rscid),
              .width   (1),
              .ph_clk  (ph_clk),
              .ph_en   (ph_en),
              .ph_arst (ph_arst),
              .ph_srst (ph_srst)
            )
            STATREG
            (
              .clk     (clk),
              .en      (en_l_s[eni/8]),
              .arst    (arst),
              .srst    (srst),
              .ld      (1'b1),
              .d       (stat_pre[eni]),
              .lz      (dummy_statreg_lz[eni]),
              .z       (stat[eni])
            );
          end
        end
        else
        begin: CGSTATFIFO
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          STATREG
          (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
          );
        end
        for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
        begin: pwroptGEN2
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (width),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          BUFREG
          (
            .clk     (clk),
            .en      (en_l[eni]),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre[width*eni+:width]),
            .lz      (dummy_bufreg_lz[eni]),
            .z       (buff[width*eni+:width])
          );
        end
      end
    end
    else
    begin: FEED_THRU
      assign vd = vz;
      assign lz = ld;
      assign z = d;
      assign size = ld && !vz;
    end
    endgenerate

endmodule

//------------------------------------------------------------------
//-- PIPE ENTITIES
//------------------------------------------------------------------
/*
 *
 *             _______________________________________________
 * WRITER    |                                               |          READER
 *           |           MGC_PIPE                            |
 *           |           __________________________          |
 *        --<| vdout  --<| vd ---------------  vz<|-----ldin<|---
 *           |           |      FIFO              |          |
 *        ---|>ldout  ---|>ld ---------------- lz |> ---vdin |>--
 *        ---|>dout -----|>d  ---------------- dz |> ----din |>--
 *           |           |________________________|          |
 *           |_______________________________________________|
 */
// two clock pipe
module mgc_pipe (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, size, req_size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // width of size of elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter integer log2_sz = 3; // log2(fifo_sz)
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer pwropt  = 0; // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output [sz_width-1:0]      size;
    input              req_size;


    mgc_out_fifo_wait_core
    #(
        .rscid    (rscid),
        .width    (width),
        .sz_width (sz_width),
        .fifo_sz  (fifo_sz),
        .ph_clk   (ph_clk),
        .ph_en    (ph_en),
        .ph_arst  (ph_arst),
        .ph_srst  (ph_srst),
        .ph_log2  (log2_sz),
        .pwropt   (pwropt)
    )
    FIFO
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (vdin),
        .vz      (ldin),
        .z       (din),
        .size    (size)
    );

endmodule


//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   apl115@EEWS104A-017
//  Generated date: Mon May 09 12:09:40 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    GameUnit_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module GameUnit_core_fsm (
  clk, rst, fsm_output
);
  input clk;
  input rst;
  output [9:0] fsm_output;
  reg [9:0] fsm_output;


  // FSM State Type Declaration for GameUnit_core_fsm_1
  parameter
    st_main = 4'd0,
    st_main_1 = 4'd1,
    st_main_2 = 4'd2,
    st_main_3 = 4'd3,
    st_main_4 = 4'd4,
    st_main_5 = 4'd5,
    st_main_6 = 4'd6,
    st_main_7 = 4'd7,
    st_main_8 = 4'd8,
    st_main_9 = 4'd9,
    state_x = 4'b0000;

  reg [3:0] state_var;
  reg [3:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : GameUnit_core_fsm_1
    case (state_var)
      st_main : begin
        fsm_output = 10'b1;
        state_var_NS = st_main_1;
      end
      st_main_1 : begin
        fsm_output = 10'b10;
        state_var_NS = st_main_2;
      end
      st_main_2 : begin
        fsm_output = 10'b100;
        state_var_NS = st_main_3;
      end
      st_main_3 : begin
        fsm_output = 10'b1000;
        state_var_NS = st_main_4;
      end
      st_main_4 : begin
        fsm_output = 10'b10000;
        state_var_NS = st_main_5;
      end
      st_main_5 : begin
        fsm_output = 10'b100000;
        state_var_NS = st_main_6;
      end
      st_main_6 : begin
        fsm_output = 10'b1000000;
        state_var_NS = st_main_7;
      end
      st_main_7 : begin
        fsm_output = 10'b10000000;
        state_var_NS = st_main_8;
      end
      st_main_8 : begin
        fsm_output = 10'b100000000;
        state_var_NS = st_main_9;
      end
      st_main_9 : begin
        fsm_output = 10'b1000000000;
        state_var_NS = st_main;
      end
      default : begin
        fsm_output = 10'b0000000000;
        state_var_NS = st_main;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= st_main;
    end
    else begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    GameUnit_core
// ------------------------------------------------------------------


module GameUnit_core (
  clk, rst, restart_rsc_mgc_in_wire_d, random_rsc_mgc_in_wire_d, redobjecty_rsc_mgc_in_wire_d,
      blueobjecty_rsc_mgc_in_wire_d, meteorpx_rsc_mgc_in_wire_d, meteorpy_rsc_mgc_in_wire_d,
      meteordirectionin_rsc_mgc_in_wire_d, p1planets_rsc_mgc_in_wire_d, p2planets_rsc_mgc_in_wire_d,
      meteordirectionout_rsc_mgc_out_stdreg_d, player1y_rsc_mgc_out_stdreg_d, player2y_rsc_mgc_out_stdreg_d,
      meteorpxout_rsc_mgc_out_stdreg_d, meteorpyout_rsc_mgc_out_stdreg_d, p1p1_rsc_mgc_out_stdreg_d,
      p1p2_rsc_mgc_out_stdreg_d, p1p3_rsc_mgc_out_stdreg_d, p1p4_rsc_mgc_out_stdreg_d,
      p1p5_rsc_mgc_out_stdreg_d, p1p6_rsc_mgc_out_stdreg_d, p1p7_rsc_mgc_out_stdreg_d,
      p1p8_rsc_mgc_out_stdreg_d, p2p1_rsc_mgc_out_stdreg_d, p2p2_rsc_mgc_out_stdreg_d,
      p2p3_rsc_mgc_out_stdreg_d, p2p4_rsc_mgc_out_stdreg_d, p2p5_rsc_mgc_out_stdreg_d,
      p2p6_rsc_mgc_out_stdreg_d, p2p7_rsc_mgc_out_stdreg_d, p2p8_rsc_mgc_out_stdreg_d,
      player1score_rsc_mgc_out_stdreg_d, player2score_rsc_mgc_out_stdreg_d
);
  input clk;
  input rst;
  input restart_rsc_mgc_in_wire_d;
  input [15:0] random_rsc_mgc_in_wire_d;
  input [10:0] redobjecty_rsc_mgc_in_wire_d;
  input [10:0] blueobjecty_rsc_mgc_in_wire_d;
  input [10:0] meteorpx_rsc_mgc_in_wire_d;
  input [10:0] meteorpy_rsc_mgc_in_wire_d;
  input [3:0] meteordirectionin_rsc_mgc_in_wire_d;
  input [7:0] p1planets_rsc_mgc_in_wire_d;
  input [7:0] p2planets_rsc_mgc_in_wire_d;
  output [3:0] meteordirectionout_rsc_mgc_out_stdreg_d;
  reg [3:0] meteordirectionout_rsc_mgc_out_stdreg_d;
  output [10:0] player1y_rsc_mgc_out_stdreg_d;
  reg [10:0] player1y_rsc_mgc_out_stdreg_d;
  output [10:0] player2y_rsc_mgc_out_stdreg_d;
  reg [10:0] player2y_rsc_mgc_out_stdreg_d;
  output [10:0] meteorpxout_rsc_mgc_out_stdreg_d;
  reg [10:0] meteorpxout_rsc_mgc_out_stdreg_d;
  output [10:0] meteorpyout_rsc_mgc_out_stdreg_d;
  reg [10:0] meteorpyout_rsc_mgc_out_stdreg_d;
  output p1p1_rsc_mgc_out_stdreg_d;
  reg p1p1_rsc_mgc_out_stdreg_d;
  output p1p2_rsc_mgc_out_stdreg_d;
  reg p1p2_rsc_mgc_out_stdreg_d;
  output p1p3_rsc_mgc_out_stdreg_d;
  reg p1p3_rsc_mgc_out_stdreg_d;
  output p1p4_rsc_mgc_out_stdreg_d;
  reg p1p4_rsc_mgc_out_stdreg_d;
  output p1p5_rsc_mgc_out_stdreg_d;
  reg p1p5_rsc_mgc_out_stdreg_d;
  output p1p6_rsc_mgc_out_stdreg_d;
  reg p1p6_rsc_mgc_out_stdreg_d;
  output p1p7_rsc_mgc_out_stdreg_d;
  reg p1p7_rsc_mgc_out_stdreg_d;
  output p1p8_rsc_mgc_out_stdreg_d;
  reg p1p8_rsc_mgc_out_stdreg_d;
  output p2p1_rsc_mgc_out_stdreg_d;
  reg p2p1_rsc_mgc_out_stdreg_d;
  output p2p2_rsc_mgc_out_stdreg_d;
  reg p2p2_rsc_mgc_out_stdreg_d;
  output p2p3_rsc_mgc_out_stdreg_d;
  reg p2p3_rsc_mgc_out_stdreg_d;
  output p2p4_rsc_mgc_out_stdreg_d;
  reg p2p4_rsc_mgc_out_stdreg_d;
  output p2p5_rsc_mgc_out_stdreg_d;
  reg p2p5_rsc_mgc_out_stdreg_d;
  output p2p6_rsc_mgc_out_stdreg_d;
  reg p2p6_rsc_mgc_out_stdreg_d;
  output p2p7_rsc_mgc_out_stdreg_d;
  reg p2p7_rsc_mgc_out_stdreg_d;
  output p2p8_rsc_mgc_out_stdreg_d;
  reg p2p8_rsc_mgc_out_stdreg_d;
  output player1score_rsc_mgc_out_stdreg_d;
  reg player1score_rsc_mgc_out_stdreg_d;
  output player2score_rsc_mgc_out_stdreg_d;
  reg player2score_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [9:0] fsm_output;
  wire else_else_1_else_else_else_else_and_tmp;
  wire else_else_1_else_else_else_and_tmp;
  wire else_else_1_else_else_and_tmp;
  wire else_else_1_else_and_tmp;
  wire else_else_1_and_tmp;
  wire else_nor_tmp;
  wire else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_nor_1_tmp;
  wire else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp;
  wire planet_meteor_collision_15_if_else_if_equal_tmp;
  wire planet_meteor_collision_14_if_else_if_equal_tmp;
  wire planet_meteor_collision_12_if_else_if_equal_tmp;
  wire [5:0] planet_meteor_collision_12_if_else_if_acc_tmp;
  wire [6:0] nl_planet_meteor_collision_12_if_else_if_acc_tmp;
  wire planet_meteor_collision_10_if_else_if_equal_tmp;
  wire planet_meteor_collision_8_if_else_if_equal_tmp;
  wire planet_meteor_collision_7_if_else_if_nor_tmp;
  wire planet_meteor_collision_5_if_else_if_nor_tmp;
  wire or_tmp_31;
  wire or_tmp_46;
  wire and_dcpl_20;
  wire or_dcpl_31;
  wire or_tmp_97;
  wire or_dcpl_75;
  wire and_dcpl_109;
  wire and_dcpl_126;
  wire or_dcpl_184;
  wire and_dcpl_179;
  wire and_dcpl_180;
  wire or_dcpl_243;
  wire or_dcpl_291;
  wire and_dcpl_387;
  wire or_dcpl_350;
  wire and_dcpl_530;
  wire and_dcpl_531;
  wire or_dcpl_446;
  wire and_dcpl_544;
  wire or_dcpl_480;
  wire and_dcpl_561;
  wire and_dcpl_565;
  wire and_dcpl_569;
  wire and_dcpl_571;
  wire and_dcpl_580;
  wire and_dcpl_585;
  wire and_dcpl_589;
  wire and_dcpl_634;
  wire and_dcpl_648;
  wire or_tmp_144;
  wire or_dcpl_513;
  wire or_dcpl_522;
  wire or_dcpl_541;
  wire or_dcpl_548;
  wire or_dcpl_551;
  wire or_dcpl_575;
  wire or_dcpl_579;
  wire and_dcpl_701;
  wire and_dcpl_704;
  wire and_dcpl_705;
  wire or_dcpl_605;
  wire or_dcpl_609;
  wire or_dcpl_615;
  wire and_dcpl_713;
  wire and_dcpl_716;
  wire and_dcpl_723;
  wire and_dcpl_724;
  wire and_dcpl_727;
  wire and_dcpl_737;
  wire and_dcpl_746;
  wire or_dcpl_642;
  reg C1_1_1_dfmergedata_lpi_1;
  reg C1_1_1_dfmergedata_1_lpi_1;
  reg player1_x_sg2_sva;
  reg player1_x_sg4_sva;
  reg player1_x_1_sva;
  reg player1_x_sg6_sva;
  reg player1_height_sg1_sva;
  reg player1_height_sg3_1_sva;
  reg player1_width_sg1_sva;
  reg player1_width_sg3_sva;
  reg player1_player_sva;
  reg player2_x_sg2_sva;
  reg player2_x_1_sva;
  reg player2_x_sg4_sva;
  reg player2_height_sg1_sva;
  reg player2_height_sg3_1_sva;
  reg player2_width_sg1_sva;
  reg player2_width_sg3_sva;
  reg ameteor_radius_2_sva;
  reg planet1_x_1_sva;
  reg planet1_x_sg2_1_sva;
  reg planet1_y_2_sva;
  reg planet1_player_sva;
  reg planet2_x_1_sva;
  reg planet2_x_sg2_1_sva;
  reg planet2_y_2_sva;
  reg planet2_y_sg2_sva;
  reg planet2_player_sva;
  reg planet3_x_1_sva;
  reg planet3_x_sg2_1_sva;
  reg planet3_y_2_sva;
  reg planet3_y_sg2_sva;
  reg planet3_player_sva;
  reg planet4_x_1_sva;
  reg planet4_x_sg2_1_sva;
  reg planet4_y_2_sva;
  reg planet4_y_sg2_1_sva;
  reg planet4_player_sva;
  reg planet5_x_1_sva;
  reg planet5_x_sg2_1_sva;
  reg planet5_y_2_sva;
  reg planet5_y_sg2_sva;
  reg planet5_player_sva;
  reg planet6_x_1_sva;
  reg planet6_x_sg2_1_sva;
  reg planet6_y_sg2_sva;
  reg planet6_y_2_sva;
  reg planet6_y_sg4_sva;
  reg planet6_player_sva;
  reg planet7_x_1_sva;
  reg planet7_x_sg2_1_sva;
  reg planet7_y_2_sva;
  reg planet7_y_sg2_1_sva;
  reg planet7_player_sva;
  reg planet8_x_1_sva;
  reg planet8_x_sg2_1_sva;
  reg planet8_y_2_sva;
  reg planet8_y_sg2_1_sva;
  reg planet8_player_sva;
  reg planet21_x_sg2_1_sva;
  reg planet21_x_sg4_1_sva;
  reg planet21_x_1_sva;
  reg planet21_x_sg6_sva;
  reg planet21_y_2_sva;
  reg planet22_x_sg2_1_sva;
  reg planet22_x_sg4_1_sva;
  reg planet22_x_1_sva;
  reg planet22_x_sg6_sva;
  reg planet22_y_2_sva;
  reg planet22_y_sg2_sva;
  reg planet23_x_sg2_1_sva;
  reg planet23_x_sg4_1_sva;
  reg planet23_x_1_sva;
  reg planet23_x_sg6_sva;
  reg planet23_y_2_sva;
  reg planet23_y_sg2_sva;
  reg planet24_x_sg2_1_sva;
  reg planet24_x_sg4_1_sva;
  reg planet24_x_1_sva;
  reg planet24_x_sg6_sva;
  reg planet24_y_2_sva;
  reg planet24_y_sg2_1_sva;
  reg planet25_x_sg2_1_sva;
  reg planet25_x_sg4_1_sva;
  reg planet25_x_1_sva;
  reg planet25_x_sg6_sva;
  reg planet25_y_2_sva;
  reg planet25_y_sg2_sva;
  reg planet26_x_sg2_1_sva;
  reg planet26_x_sg4_1_sva;
  reg planet26_x_1_sva;
  reg planet26_x_sg6_sva;
  reg planet26_y_sg2_sva;
  reg planet26_y_2_sva;
  reg planet26_y_sg4_sva;
  reg planet27_x_sg2_1_sva;
  reg planet27_x_sg4_1_sva;
  reg planet27_x_1_sva;
  reg planet27_x_sg6_sva;
  reg planet27_y_2_sva;
  reg planet27_y_sg2_1_sva;
  reg planet28_x_sg2_1_sva;
  reg planet28_x_sg4_1_sva;
  reg planet28_x_1_sva;
  reg planet28_x_sg6_sva;
  reg planet28_y_2_sva;
  reg planet28_y_sg2_1_sva;
  reg [19:0] count_sva;
  reg [15:0] random_1_sva;
  reg [10:0] redobjecty_1_sva;
  reg [10:0] blueobjecty_1_sva;
  reg [10:0] meteorpx_1_sva;
  reg [10:0] meteorpy_1_sva;
  reg [3:0] meteordirectionin_1_sva;
  reg [7:0] p2planets_1_sva;
  reg io_read_restart_rsc_d_svs;
  reg planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1;
  reg [1:0] else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1;
  reg [1:0] else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_2_if_if_land_1_lpi_1_dfm;
  reg planet_meteor_collision_2_if_else_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1;
  reg [1:0] else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1;
  reg [1:0] else_else_else_else_if_acc_3_psp_sva;
  reg [1:0] else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_4_if_if_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1;
  reg [1:0] else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1;
  reg planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1;
  reg [1:0] else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1;
  reg [1:0] else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_8_if_else_and_svs;
  reg planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm;
  reg [2:0] else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva;
  reg [1:0] else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_9_if_else_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm;
  reg [1:0] else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_10_if_else_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm;
  reg [1:0] else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_11_if_else_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm;
  reg [1:0] else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_12_if_else_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm;
  reg [1:0] else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_13_if_else_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm;
  reg [1:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  reg planet_meteor_collision_14_if_else_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm;
  reg planet_meteor_collision_15_if_else_land_1_lpi_1_dfm;
  reg planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm;
  reg [4:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva;
  reg equal_tmp;
  reg nor_tmp_49;
  reg nor_dfs;
  reg [10:0] ameteor_x_lpi_1_dfm_16;
  reg [10:0] ameteor_y_lpi_1_dfm_16;
  reg ameteor_direction_sg3_lpi_1_dfm_16;
  reg ameteor_direction_sg2_lpi_1_dfm_16;
  reg ameteor_direction_sg1_lpi_1_dfm_16;
  reg ameteor_direction_1_lpi_1_dfm_16;
  reg else_nor_svs;
  reg else_else_1_and_svs;
  reg ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm;
  reg else_else_1_else_and_svs;
  reg ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm;
  reg else_else_1_else_else_and_svs;
  reg else_else_1_else_else_else_and_svs;
  reg ship_meteor_collision_4_else_land_lpi_1_dfm;
  reg else_else_1_else_else_else_else_and_svs;
  reg ship_meteor_collision_5_else_land_lpi_1_dfm;
  reg and_6_m1c;
  reg else_else_1_else_nor_2_m1c;
  reg else_else_1_else_else_else_and_6_m1c;
  reg else_and_3_m1c;
  reg else_else_and_8_psp;
  reg else_else_and_9_psp;
  reg [2:0] else_else_if_slc_8_itm;
  reg planet3_y_asn_5_itm;
  reg planet3_y_asn_6_itm;
  reg planet_meteor_collision_2_if_asn_1_itm;
  reg [11:0] planet_meteor_collision_4_if_if_if_acc_7_itm;
  reg planet_meteor_collision_4_if_else_if_and_1_itm;
  reg planet_meteor_collision_4_if_asn_1_itm;
  reg planet_meteor_collision_7_if_if_if_asn_itm;
  reg planet_meteor_collision_7_if_if_if_asn_2_itm;
  reg planet_meteor_collision_7_if_asn_1_itm;
  reg planet22_y_asn_3_itm;
  reg planet22_y_asn_4_itm;
  reg [11:0] planet_meteor_collision_11_if_else_if_acc_5_itm;
  reg [2:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_5_itm;
  reg [2:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_6_itm;
  reg planet_meteor_collision_14_if_else_if_asn_3_itm;
  reg planet_meteor_collision_14_if_else_if_asn_4_itm;
  reg planet_meteor_collision_14_if_else_if_nor_itm;
  reg [1:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_7_itm;
  reg else_nand_itm;
  reg else_else_else_else_else_else_else_else_mux_37_itm;
  reg ship_meteor_collision_if_if_asn_9_itm;
  reg ship_meteor_collision_if_if_asn_10_itm;
  reg ship_meteor_collision_asn_4_itm;
  reg ship_meteor_collision_3_else_if_asn_7_itm;
  reg ship_meteor_collision_3_else_if_asn_8_itm;
  reg and_9_itm;
  reg else_else_else_else_else_else_mux_3_itm;
  reg else_else_else_else_else_else_else_else_else_else_mux_6_itm;
  reg else_else_else_else_else_else_mux_12_itm;
  reg else_else_else_else_else_else_else_mux_112_itm;
  reg else_else_else_else_else_else_else_mux_114_itm;
  reg [10:0] ship_meteor_collision_else_if_slc_2_itm_sg1;
  reg [10:0] ship_meteor_collision_3_else_if_slc_2_itm_sg1;
  wire and_578_cse;
  wire or_955_cse;
  wire or_975_cse;
  wire else_else_1_else_and_6_m1c;
  wire nor_4_m1c;
  wire ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0;
  wire [11:0] wall_meteor_collision_oelse_acc_sdt_sva;
  wire [12:0] nl_wall_meteor_collision_oelse_acc_sdt_sva;
  wire or_716_cse;
  wire or_727_cse;
  wire and_706_cse;
  wire or_786_cse;
  wire or_940_cse;
  wire or_475_cse;
  reg reg_ship_meteor_collision_if_land_1_lpi_1_dfm_cse;
  reg reg_ship_meteor_collision_else_land_1_lpi_1_dfm_cse;
  reg reg_ship_meteor_collision_3_else_land_1_lpi_1_dfm_cse;
  reg [1:0] reg_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva_cse;
  wire nand_13_cse;
  wire or_410_cse;
  wire unequal_tmp;
  wire wall_meteor_collision_lor_lpi_1_dfm;
  wire ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1;
  wire ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx3;
  wire ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx2;
  reg [5:0] reg_p1planets_1_sva_tmp;
  reg [10:0] reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1;
  wire nand_66_cse;
  wire nor_153_cse;
  wire or_892_cse;
  wire or_821_cse;
  wire mux_278_cse;
  wire [1:0] z_out;
  wire [2:0] nl_z_out;
  wire [1:0] z_out_1;
  wire [2:0] nl_z_out_1;
  wire or_tmp_177;
  wire [12:0] z_out_3;
  wire [12:0] z_out_4;
  wire [13:0] nl_z_out_4;
  wire [12:0] z_out_7;
  wire [13:0] nl_z_out_7;
  wire [12:0] z_out_8;
  wire [13:0] nl_z_out_8;
  wire [4:0] z_out_25;
  wire [5:0] nl_z_out_25;
  wire [2:0] z_out_26;
  wire [3:0] nl_z_out_26;
  wire [2:0] z_out_27;
  wire [3:0] nl_z_out_27;
  wire [2:0] z_out_28;
  wire [3:0] nl_z_out_28;
  wire or_tmp_189;
  wire [12:0] z_out_31;
  wire [13:0] nl_z_out_31;
  wire [2:0] z_out_33;
  wire [3:0] nl_z_out_33;
  wire [3:0] z_out_34;
  wire [4:0] nl_z_out_34;
  wire [5:0] z_out_35;
  wire [6:0] nl_z_out_35;
  wire [5:0] z_out_36;
  wire [6:0] nl_z_out_36;
  wire planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_2;
  wire else_else_and_8_psp_mx0w1;
  wire planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1_mx0w0;
  wire planet_meteor_collision_15_if_else_land_1_lpi_1_dfm_mx0w1;
  wire planet_meteor_collision_14_if_else_land_1_lpi_1_dfm_mx0w1;
  wire planet_meteor_collision_13_if_else_land_1_lpi_1_dfm_mx0w1;
  wire planet_meteor_collision_12_if_else_land_1_lpi_1_dfm_mx0w1;
  wire planet_meteor_collision_10_if_else_land_1_lpi_1_dfm_mx0w1;
  wire planet_meteor_collision_8_if_else_and_svs_mx0w1;
  wire nor_dfs_mx0w1;
  wire ship_meteor_collision_5_else_land_lpi_1_dfm_mx2;
  wire ship_meteor_collision_4_else_land_lpi_1_dfm_mx1;
  wire ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1;
  wire ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2;
  wire ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx1;
  wire ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx1;
  wire ameteor_direction_sg3_lpi_1_dfm_16_mx0w1;
  wire planet_meteor_collision_2_if_if_if_nor_3;
  wire planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_2;
  wire planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_2;
  wire planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1_mx0w0;
  wire planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_2;
  wire planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_2;
  wire planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm_1;
  wire planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_2;
  wire planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm_1;
  wire planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm_1;
  wire planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm_1;
  wire planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm_1;
  wire planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm_1;
  wire planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1;
  wire planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1;
  wire [4:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva;
  wire [5:0] nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva;
  wire C1_1_1_dfmergedata_1_lpi_1_dfm;
  wire C1_1_1_dfmergedata_lpi_1_dfm;
  wire ameteor_direction_sg2_lpi_1_dfm_16_mx0;
  wire ameteor_direction_sg1_lpi_1_dfm_16_mx0;
  wire ameteor_direction_1_lpi_1_dfm_16_mx0;
  wire [1:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  wire [2:0] nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva;
  wire [2:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva;
  wire [3:0] nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva;
  wire and_6_m1c_1;
  wire else_else_1_else_nor_2_m1c_1;
  wire else_else_1_else_else_else_else_and_1_tmp;
  wire else_else_1_else_else_else_and_2_m1c;
  wire else_else_1_else_and_2_m1c;
  wire ship_meteor_collision_3_else_nor_tmp;
  wire else_else_1_nor_m1c;
  wire else_else_1_and_2_m1c;
  wire or_126_m1c;
  wire and_17_m1c;
  wire else_else_1_else_else_else_else_and_4_cse;
  wire else_else_1_else_else_else_else_and_5_cse;
  wire else_else_1_else_else_else_and_7_cse;
  wire else_else_1_else_else_else_and_8_cse;
  wire else_else_1_else_and_13_cse;
  wire else_else_1_else_and_14_cse;
  wire else_else_1_and_5_cse;
  wire else_else_1_and_6_cse;
  wire else_else_1_and_13_cse;
  wire else_else_1_else_and_1_cse;
  wire wall_meteor_collision_1_and_1_cse;
  wire else_else_1_and_1_cse;
  wire wall_meteor_collision_and_1_cse;
  wire nor_2_m1c;
  wire or_125_m1c;
  wire and_16_m1c;
  wire and_7_m1c;
  wire else_if_1_nor_tmp;
  wire and_4_m1c;
  wire wall_meteor_collision_and_8;
  wire wall_meteor_collision_nor_2;
  wire wall_meteor_collision_and_10;
  wire wall_meteor_collision_or_2;
  wire wall_meteor_collision_1_and_8;
  wire ship_meteor_collision_4_else_nor_3;
  wire or_1037_cse;
  reg [2:0] reg_planet_meteor_collision_14_if_else_if_acc_sdt_sva_1_tmp;
  reg reg_planet_meteor_collision_14_if_else_if_acc_sdt_sva_1_tmp_2;
  wire planet_meteor_collision_9_if_else_if_nor_cse;
  wire planet_meteor_collision_14_if_else_if_nor_cse;
  wire planet_meteor_collision_4_if_if_if_nor_1_cse;
  wire planet_meteor_collision_3_if_if_if_nor_1_cse;
  wire planet_meteor_collision_6_if_if_if_and_1_cse;
  wire or_dcpl_707;
  wire or_dcpl_716;
  wire or_1038_cse;
  wire or_1044_cse;
  wire or_1022_tmp;
  wire or_1023_tmp;
  wire nor_157_m1c;
  reg xeq;
  reg xeq_1;
  reg xeq_2;
  reg xeq_3;
  wire [6:0] ship_meteor_collision_else_if_acc_9_sg1;
  wire [10:0] ship_meteor_collision_else_if_acc_11_sg1;
  wire [10:0] z_out_37;
  wire [11:0] nl_z_out_37;
  wire [11:0] z_out_38;
  wire [12:0] nl_z_out_38;
  wire [11:0] z_out_39;
  wire [12:0] nl_z_out_39;
  wire z_out_9_sg1;
  wire z_out_10_sg1;
  wire z_out_11_sg1;
  wire [1:0] z_out_12_sg1;
  wire [1:0] z_out_13_sg1;
  wire [1:0] z_out_15_sg1;
  wire [1:0] z_out_16_sg1;
  wire [2:0] z_out_17_sg1;
  wire [2:0] z_out_18_sg1;
  wire [2:0] z_out_40;
  wire [3:0] nl_z_out_40;
  wire [2:0] z_out_41;
  wire [3:0] nl_z_out_41;
  wire [2:0] z_out_21_sg1;
  wire [1:0] z_out_22_sg1;
  wire [2:0] z_out_42;
  wire [3:0] nl_z_out_42;
  wire z_out_29_sg1;
  wire z_out_30_sg1;
  wire z_out_32_sg1;
  wire [2:0] else_else_else_if_acc_24_itm_sg1;
  wire mux1h_184_cse;
  wire or_1026_cse;
  wire mux1h_193_cse;
  wire nor_161_cse;
  wire mux1h_201_cse;

  wire[0:0] planet_meteor_collision_1_if_mux_nl;
  wire[0:0] planet_meteor_collision_if_mux_nl;
  wire[0:0] planet_meteor_collision_3_if_mux_nl;
  wire[0:0] planet_meteor_collision_2_if_mux_nl;
  wire[0:0] planet_meteor_collision_6_if_mux_nl;
  wire[0:0] planet_meteor_collision_5_if_mux_nl;
  wire[0:0] planet_meteor_collision_4_if_mux_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] planet_meteor_collision_7_if_mux_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] mux_62_nl;
  wire[0:0] else_else_mux_176_nl;
  wire[0:0] else_else_else_mux_65_nl;
  wire[0:0] else_else_else_else_mux_59_nl;
  wire[0:0] else_else_else_else_else_mux_53_nl;
  wire[0:0] else_else_else_else_else_else_mux_47_nl;
  wire[0:0] else_else_else_else_else_else_else_mux_41_nl;
  wire[0:0] else_else_else_else_else_else_else_else_mux_35_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_mux_32_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_mux_28_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_mux_24_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_mux_20_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_mux_16_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_12_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_8_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_4_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_nl;
  wire[0:0] else_else_mux_177_nl;
  wire[0:0] else_else_else_mux_66_nl;
  wire[0:0] else_else_else_else_mux_60_nl;
  wire[0:0] else_else_else_else_else_mux_54_nl;
  wire[0:0] else_else_else_else_else_else_mux_48_nl;
  wire[0:0] else_else_else_else_else_else_else_mux_42_nl;
  wire[0:0] else_else_else_else_else_else_else_else_mux_36_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_mux_33_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_mux_29_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_mux_25_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_mux_21_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_mux_17_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_13_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_9_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_5_nl;
  wire[0:0] else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_10_nl;
  wire[0:0] else_else_mux_178_nl;
  wire[0:0] else_else_else_mux_67_nl;
  wire[0:0] else_else_else_else_mux_61_nl;
  wire[0:0] else_else_else_else_else_mux_55_nl;
  wire[0:0] else_else_else_else_else_else_mux_49_nl;
  wire[0:0] else_else_else_else_else_else_else_mux_43_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] mux1h_6_nl;
  wire[0:0] mux_346_nl;
  wire[0:0] mux_333_nl;
  wire[10:0] mux_317_nl;
  wire[10:0] mux1h_134_nl;
  wire[1:0] mux1h_135_nl;
  wire[10:0] mux1h_183_nl;
  wire[3:0] mux1h_137_nl;
  wire[0:0] mux1h_139_nl;
  wire[0:0] mux_337_nl;
  wire[0:0] mux1h_190_nl;
  wire[0:0] mux1h_191_nl;
  wire[0:0] mux_319_nl;
  wire[0:0] mux_338_nl;
  wire[10:0] mux1h_220_nl;
  wire[0:0] mux1h_141_nl;
  wire[0:0] mux1h_221_nl;
  wire[0:0] mux_339_nl;
  wire[0:0] mux1h_192_nl;
  wire[10:0] mux_353_nl;
  wire[0:0] mux1h_143_nl;
  wire[0:0] mux1h_199_nl;
  wire[0:0] mux1h_200_nl;
  wire[11:0] mux1h_218_nl;
  wire[11:0] mux1h_219_nl;
  wire[11:0] mux1h_146_nl;
  wire[0:0] mux1h_147_nl;
  wire[0:0] mux1h_148_nl;
  wire[0:0] mux1h_207_nl;
  wire[0:0] mux1h_149_nl;
  wire[0:0] mux1h_150_nl;
  wire[0:0] mux1h_208_nl;
  wire[0:0] mux1h_153_nl;
  wire[0:0] mux1h_154_nl;
  wire[0:0] mux_340_nl;
  wire[0:0] mux1h_156_nl;
  wire[1:0] mux1h_157_nl;
  wire[0:0] mux_341_nl;
  wire[0:0] mux1h_158_nl;
  wire[0:0] mux1h_210_nl;
  wire[0:0] mux1h_151_nl;
  wire[0:0] mux1h_152_nl;
  wire[0:0] mux1h_209_nl;
  wire[1:0] mux_355_nl;
  wire[0:0] mux1h_211_nl;
  wire[0:0] mux1h_161_nl;
  wire[0:0] mux_356_nl;
  wire[0:0] mux_347_nl;
  wire[2:0] mux1h_163_nl;
  wire[0:0] mux1h_164_nl;
  wire[0:0] mux1h_166_nl;
  wire[0:0] mux1h_213_nl;
  wire[0:0] mux_321_nl;
  wire[0:0] mux_342_nl;
  wire[0:0] mux_323_nl;
  wire[2:0] mux1h_167_nl;
  wire[2:0] mux_357_nl;
  wire[0:0] mux1h_214_nl;
  wire[0:0] mux1h_170_nl;
  wire[0:0] mux1h_171_nl;
  wire[0:0] mux1h_172_nl;
  wire[1:0] mux_324_nl;
  wire[10:0] mux_326_nl;
  wire[0:0] mux_327_nl;
  wire[0:0] mux_343_nl;
  wire[10:0] mux_328_nl;
  wire[0:0] mux_329_nl;
  wire[0:0] mux_344_nl;
  wire[10:0] mux1h_173_nl;
  wire[0:0] mux1h_174_nl;
  wire[0:0] mux_330_nl;
  wire[10:0] mux_331_nl;
  wire[0:0] mux1h_175_nl;
  wire[0:0] mux1h_176_nl;
  wire[0:0] mux_345_nl;
  wire[0:0] mux1h_215_nl;
  wire[0:0] mux1h_177_nl;
  wire[0:0] mux1h_216_nl;
  wire[0:0] mux1h_178_nl;
  wire[0:0] mux1h_217_nl;

  // Interconnect Declarations for Component Instantiations 
  GameUnit_core_fsm GameUnit_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output)
    );
  assign or_716_cse = or_dcpl_350 | (fsm_output[4]) | or_dcpl_446;
  assign or_727_cse = or_dcpl_350 | or_dcpl_31 | or_dcpl_446;
  assign planet_meteor_collision_9_if_else_if_nor_cse = ~((z_out_35[5]) | (z_out_3[4])
      | (z_out_3[11]));
  assign or_786_cse = (~ (p2planets_1_sva[6])) | z_out_9_sg1 | (z_out_8[12]) | (~((reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[5])
      & (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[1]) & (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[7])
      & planet_meteor_collision_14_if_else_if_equal_tmp & planet_meteor_collision_14_if_else_if_nor_itm));
  assign and_706_cse = or_tmp_144 & or_786_cse & and_dcpl_634 & (~(planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1)) &
      and_dcpl_180 & and_dcpl_179 & (~(planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm)) & and_dcpl_648
      & and_dcpl_580;
  assign nand_66_cse = ~(or_tmp_144 & or_786_cse);
  assign or_892_cse = nand_66_cse | or_dcpl_522 | planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1 | planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1 | or_dcpl_184
      | planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm | planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm
      | or_dcpl_541 | else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_nor_1_tmp
      | else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp;
  assign or_940_cse = (fsm_output[2]) | (fsm_output[4]) | (fsm_output[3]) | or_dcpl_642;
  assign planet_meteor_collision_4_if_if_if_nor_1_cse = ~((~ xeq) | (z_out_31[6]));
  assign or_410_cse = (~ planet_meteor_collision_9_if_else_land_1_lpi_1_dfm) | z_out_9_sg1
      | (~ (p2planets_1_sva[1]));
  assign or_475_cse = (~ planet_meteor_collision_11_if_else_land_1_lpi_1_dfm) | z_out_11_sg1
      | (~ (p2planets_1_sva[3]));
  assign planet_meteor_collision_14_if_else_if_nor_cse = ~((z_out_36[5]) | (z_out_3[4])
      | (z_out_3[11]));
  assign nor_153_cse = ~(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_nor_1_tmp
      | else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp);
  assign or_821_cse = nand_66_cse | or_dcpl_522 | planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1 | planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1
      | or_dcpl_184 | planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm
      | or_dcpl_513 | planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm;
  assign planet_meteor_collision_1_if_mux_nl = MUX_s_1_2_2({((~ z_out_10_sg1) & (~
      (z_out_7[12])) & (z_out_3[1]) & (({(z_out_3[4]) , (z_out_3[0])}) == ({planet2_x_sg2_1_sva
      , planet2_x_1_sva})) & (~((~ planet2_x_sg2_1_sva) | (z_out_3[3]) | (z_out_3[2])
      | (z_out_3[11]) | (z_out_3[10]) | (z_out_3[9]) | (z_out_3[8]) | (z_out_3[7])
      | (z_out_3[6]) | (z_out_3[5])))) , ((~ z_out_10_sg1) & (~ (z_out_7[12])) &
      (z_out_31[4]) & (z_out_31[3]) & (z_out_31[2]) & (~((({(z_out_31[7]) , (z_out_31[5])
      , (z_out_31[1])}) != ({(z_out_27[2]) , (z_out_27[0]) , planet2_x_1_sva})) |
      (z_out_31[6]))) & planet_meteor_collision_2_if_if_if_nor_3)}, planet2_player_sva);
  assign planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_2 = (planet_meteor_collision_1_if_mux_nl)
      & (p1planets_rsc_mgc_in_wire_d[1]);
  assign else_else_and_8_psp_mx0w1 = nor_153_cse & (~ planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1)
      & (~(planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm)) & (~(planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm | planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm)) & (~(planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1 | planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1 | planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1 | planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1));
  assign planet_meteor_collision_if_mux_nl = MUX_s_1_2_2({((~ z_out_32_sg1) & (z_out_3[1])
      & (({(z_out_3[4]) , (z_out_3[0])}) == ({planet1_x_sg2_1_sva , planet1_x_1_sva}))
      & (~((~ planet1_x_sg2_1_sva) | (z_out_3[3]) | (z_out_3[2]) | (z_out_3[11])
      | (z_out_3[10]) | (z_out_3[9]) | (z_out_3[8]) | (z_out_3[7]) | (z_out_3[6])
      | (z_out_3[5])))) , ((~ z_out_32_sg1) & (z_out_31[4]) & (z_out_31[3]) & (z_out_31[2])
      & (~((({(z_out_31[7]) , (z_out_31[5]) , (z_out_31[1])}) != ({(z_out_28[2])
      , (z_out_28[0]) , planet1_x_1_sva})) | (z_out_31[6]))) & planet_meteor_collision_2_if_if_if_nor_3)},
      planet1_player_sva);
  assign planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1_mx0w0
      = (planet_meteor_collision_if_mux_nl) & (p1planets_rsc_mgc_in_wire_d[0]);
  assign planet_meteor_collision_15_if_else_land_1_lpi_1_dfm_mx0w1 = (~ (z_out_7[12]))
      & (z_out_3[5]) & (z_out_3[1]) & (z_out_3[7]) & planet_meteor_collision_15_if_else_if_equal_tmp
      & planet_meteor_collision_9_if_else_if_nor_cse;
  assign planet_meteor_collision_14_if_else_land_1_lpi_1_dfm_mx0w1 = (~ (z_out_8[12]))
      & (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[5]) & (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[1])
      & (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[7]) & planet_meteor_collision_14_if_else_if_equal_tmp
      & planet_meteor_collision_14_if_else_if_nor_itm;
  assign planet_meteor_collision_13_if_else_land_1_lpi_1_dfm_mx0w1 = (~ (z_out_4[12]))
      & (z_out_3[5]) & (z_out_3[1]) & (z_out_3[7]) & (({(z_out_3[10:8]) , (z_out_3[6])
      , (z_out_3[3:2]) , (z_out_3[0])}) == ({(z_out_35[4:2]) , (z_out_35[0]) , ({{1{planet26_x_sg2_1_sva}},
      planet26_x_sg2_1_sva}) , planet26_x_1_sva})) & planet_meteor_collision_9_if_else_if_nor_cse;
  assign planet_meteor_collision_12_if_else_land_1_lpi_1_dfm_mx0w1 = (~ (z_out_8[12]))
      & (z_out_3[5]) & (z_out_3[1]) & (z_out_3[7]) & planet_meteor_collision_12_if_else_if_equal_tmp
      & (~((planet_meteor_collision_12_if_else_if_acc_tmp[5]) | (z_out_3[4]) | (z_out_3[11])));
  assign planet_meteor_collision_10_if_else_land_1_lpi_1_dfm_mx0w1 = (~ (z_out_8[12]))
      & (z_out_3[5]) & (z_out_3[1]) & (z_out_3[7]) & planet_meteor_collision_10_if_else_if_equal_tmp
      & planet_meteor_collision_14_if_else_if_nor_cse;
  assign planet_meteor_collision_8_if_else_if_equal_tmp = ({(z_out_3[10:8]) , (z_out_3[6])
      , (z_out_3[3:2]) , (z_out_3[0])}) == ({(z_out_36[4:2]) , (z_out_36[0]) , ({{1{planet21_x_sg2_1_sva}},
      planet21_x_sg2_1_sva}) , planet21_x_1_sva});
  assign planet_meteor_collision_8_if_else_and_svs_mx0w1 = (z_out_3[5]) & (z_out_3[1])
      & (z_out_3[7]) & planet_meteor_collision_8_if_else_if_equal_tmp & planet_meteor_collision_14_if_else_if_nor_cse;
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp
      = (meteorpx_1_sva[10]) & (meteorpx_1_sva[7]) & (meteorpx_1_sva[6]) & (meteorpx_1_sva[5])
      & (meteorpx_1_sva[4]) & (meteorpx_1_sva[3]) & (meteorpx_1_sva[2]) & (meteorpx_1_sva[1])
      & (meteorpx_1_sva[0]) & (~((meteorpx_1_sva[9]) | (meteorpx_1_sva[8])));
  assign nor_dfs_mx0w1 = ~(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp
      | nor_153_cse);
  assign ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1 = (~ z_out_29_sg1) & reg_ship_meteor_collision_3_else_land_1_lpi_1_dfm_cse;
  assign ship_meteor_collision_5_else_land_lpi_1_dfm_mx2 = MUX_s_1_2_2({ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1
      , ship_meteor_collision_5_else_land_lpi_1_dfm}, io_read_restart_rsc_d_svs);
  assign ship_meteor_collision_4_else_land_lpi_1_dfm_mx1 = MUX_s_1_2_2({ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1
      , ship_meteor_collision_4_else_land_lpi_1_dfm}, io_read_restart_rsc_d_svs);
  assign ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1 = (~
      z_out_30_sg1) & reg_ship_meteor_collision_if_land_1_lpi_1_dfm_cse;
  assign ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2 = (~
      (readslicef_12_1_11((conv_u2u_11_12(ship_meteor_collision_else_if_slc_2_itm_sg1)
      + conv_s2u_11_12({6'b100000 , (signext_5_4({ship_meteor_collision_if_if_asn_9_itm
      , 2'b0 , ship_meteor_collision_if_if_asn_10_itm}))}))))) & reg_ship_meteor_collision_else_land_1_lpi_1_dfm_cse;
  assign ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx1 = MUX1HOT_s_1_3_2({ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1
      , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2 , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm},
      {and_dcpl_723 , and_dcpl_724 , io_read_restart_rsc_d_svs});
  assign ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx3 = MUX1HOT_s_1_3_2({ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1
      , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2 , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm},
      {(else_else_1_else_and_svs & ship_meteor_collision_asn_4_itm) , (else_else_1_else_and_svs
      & (~ ship_meteor_collision_asn_4_itm)) , (~ else_else_1_else_and_svs)});
  assign ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx1 = MUX1HOT_s_1_3_2({ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1
      , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2 , ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm},
      {and_dcpl_723 , and_dcpl_724 , io_read_restart_rsc_d_svs});
  assign ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx2 = MUX1HOT_s_1_3_2({ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1
      , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2 , ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm},
      {(and_dcpl_746 & and_dcpl_723) , (and_dcpl_746 & and_dcpl_724) , (else_nor_svs
      | (~ else_else_1_and_svs) | io_read_restart_rsc_d_svs)});
  assign ameteor_direction_sg3_lpi_1_dfm_16_mx0w1 = ~(else_nand_itm | planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1 | planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1);
  assign planet_meteor_collision_2_if_if_if_nor_3 = ~((z_out_31[12]) | (z_out_31[11])
      | (z_out_31[10]) | (z_out_31[9]) | (z_out_31[8]));
  assign planet_meteor_collision_3_if_if_if_nor_1_cse = ~((~ xeq_1) | (z_out_31[6]));
  assign planet_meteor_collision_3_if_mux_nl = MUX_s_1_2_2({((~ z_out_10_sg1) & (~
      (z_out_4[12])) & (z_out_3[1]) & xeq_3 & (~((~ planet4_x_sg2_1_sva) | (z_out_3[3])
      | (z_out_3[2]) | (z_out_3[11]) | (z_out_3[10]) | (z_out_3[9]) | (z_out_3[8])
      | (z_out_3[7]) | (z_out_3[6]) | (z_out_3[5])))) , ((~ z_out_10_sg1) & (~ (z_out_4[12]))
      & (z_out_31[4]) & (z_out_31[3]) & (z_out_31[2]) & planet_meteor_collision_3_if_if_if_nor_1_cse
      & planet_meteor_collision_2_if_if_if_nor_3)}, planet4_player_sva);
  assign planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_2 = (planet_meteor_collision_3_if_mux_nl)
      & (reg_p1planets_1_sva_tmp[1]);
  assign planet_meteor_collision_2_if_mux_nl = MUX_s_1_2_2({((~ z_out_11_sg1) & planet_meteor_collision_2_if_else_land_1_lpi_1_dfm)
      , ((~ z_out_11_sg1) & planet_meteor_collision_2_if_if_land_1_lpi_1_dfm)}, planet_meteor_collision_2_if_asn_1_itm);
  assign planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_2 = (planet_meteor_collision_2_if_mux_nl)
      & (reg_p1planets_1_sva_tmp[0]);
  assign else_else_else_if_acc_24_itm_sg1 = readslicef_4_3_1((conv_u2u_3_4({z_out_12_sg1
      , 1'b1}) + conv_u2u_3_4({z_out_13_sg1 , (~ (random_1_sva[14]))})));
  assign planet_meteor_collision_6_if_if_if_and_1_cse = (~ z_out_10_sg1) & (~ (z_out_7[12]))
      & (z_out_31[4]) & (z_out_31[3]) & (z_out_31[2]) & planet_meteor_collision_4_if_if_if_nor_1_cse
      & planet_meteor_collision_2_if_if_if_nor_3;
  assign planet_meteor_collision_6_if_mux_nl = MUX_s_1_2_2({((~ z_out_10_sg1) & (~
      (z_out_7[12])) & (z_out_3[1]) & xeq_2 & (~((~ planet7_x_sg2_1_sva) | (z_out_3[3])
      | (z_out_3[2]) | (z_out_3[11]) | (z_out_3[10]) | (z_out_3[9]) | (z_out_3[8])
      | (z_out_3[7]) | (z_out_3[6]) | (z_out_3[5])))) , planet_meteor_collision_6_if_if_if_and_1_cse},
      planet7_player_sva);
  assign planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1_mx0w0
      = (planet_meteor_collision_6_if_mux_nl) & (reg_p1planets_1_sva_tmp[4]);
  assign planet_meteor_collision_5_if_mux_nl = MUX_s_1_2_2({((~ z_out_11_sg1) & (~
      (z_out_4[12])) & (z_out_3[1]) & xeq_3 & planet_meteor_collision_5_if_else_if_nor_tmp)
      , ((~ z_out_11_sg1) & (~ (z_out_4[12])) & (z_out_31[4]) & (z_out_31[3]) & (z_out_31[2])
      & planet_meteor_collision_3_if_if_if_nor_1_cse & planet_meteor_collision_2_if_if_if_nor_3)},
      planet6_player_sva);
  assign planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_2 = (planet_meteor_collision_5_if_mux_nl)
      & (reg_p1planets_1_sva_tmp[3]);
  assign planet_meteor_collision_4_if_mux_nl = MUX_s_1_2_2({planet_meteor_collision_4_if_else_if_and_1_itm
      , ((~ z_out_9_sg1) & planet_meteor_collision_4_if_if_land_1_lpi_1_dfm)}, planet_meteor_collision_4_if_asn_1_itm);
  assign planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_2 = (planet_meteor_collision_4_if_mux_nl)
      & (reg_p1planets_1_sva_tmp[2]);
  assign planet_meteor_collision_5_if_else_if_nor_tmp = ~((~ planet6_x_sg2_1_sva)
      | (z_out_3[3]) | (z_out_3[2]) | (z_out_3[11]) | (z_out_3[10]) | (z_out_3[9])
      | (z_out_3[8]) | (z_out_3[7]) | (z_out_3[6]) | (z_out_3[5]));
  assign mux_103_nl = MUX_s_1_2_2({planet_meteor_collision_8_if_else_and_svs , planet_meteor_collision_8_if_else_and_svs_mx0w1},
      p2planets_1_sva[0]);
  assign planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm_1 = (~
      z_out_32_sg1) & (mux_103_nl) & (p2planets_1_sva[0]);
  assign planet_meteor_collision_7_if_mux_nl = MUX_s_1_2_2({((~ z_out_10_sg1) & (~
      (z_out_7[12])) & (z_out_3[1]) & xeq_2 & planet_meteor_collision_7_if_else_if_nor_tmp)
      , planet_meteor_collision_6_if_if_if_and_1_cse}, planet_meteor_collision_7_if_asn_1_itm);
  assign planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_2 = (planet_meteor_collision_7_if_mux_nl)
      & (reg_p1planets_1_sva_tmp[5]);
  assign planet_meteor_collision_7_if_else_if_nor_tmp = ~((~ planet_meteor_collision_7_if_if_if_asn_itm)
      | (z_out_3[3]) | (z_out_3[2]) | (z_out_3[11]) | (z_out_3[10]) | (z_out_3[9])
      | (z_out_3[8]) | (z_out_3[7]) | (z_out_3[6]) | (z_out_3[5]));
  assign mux_89_nl = MUX_s_1_2_2({planet_meteor_collision_10_if_else_land_1_lpi_1_dfm
      , planet_meteor_collision_10_if_else_land_1_lpi_1_dfm_mx0w1}, p2planets_1_sva[2]);
  assign planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm_1 =
      (~ z_out_10_sg1) & (mux_89_nl) & (p2planets_1_sva[2]);
  assign planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm_1 = (~
      z_out_9_sg1) & planet_meteor_collision_9_if_else_land_1_lpi_1_dfm & (p2planets_1_sva[1]);
  assign planet_meteor_collision_10_if_else_if_equal_tmp = ({(z_out_3[10:8]) , (z_out_3[6])
      , (z_out_3[3:2]) , (z_out_3[0])}) == ({(z_out_36[4:2]) , (z_out_36[0]) , ({{1{planet23_x_sg2_1_sva}},
      planet23_x_sg2_1_sva}) , planet23_x_1_sva});
  assign mux_68_nl = MUX_s_1_2_2({planet_meteor_collision_13_if_else_land_1_lpi_1_dfm
      , planet_meteor_collision_13_if_else_land_1_lpi_1_dfm_mx0w1}, p2planets_1_sva[5]);
  assign planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm_1 =
      (~ z_out_10_sg1) & (mux_68_nl) & (p2planets_1_sva[5]);
  assign mux_77_nl = MUX_s_1_2_2({planet_meteor_collision_12_if_else_land_1_lpi_1_dfm
      , planet_meteor_collision_12_if_else_land_1_lpi_1_dfm_mx0w1}, p2planets_1_sva[4]);
  assign planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm_1 =
      (~ z_out_9_sg1) & (mux_77_nl) & (p2planets_1_sva[4]);
  assign planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm_1 =
      (~ z_out_11_sg1) & planet_meteor_collision_11_if_else_land_1_lpi_1_dfm & (p2planets_1_sva[3]);
  assign planet_meteor_collision_12_if_else_if_equal_tmp = ({(z_out_3[10:8]) , (z_out_3[6])
      , (z_out_3[3:2]) , (z_out_3[0])}) == ({(planet_meteor_collision_12_if_else_if_acc_tmp[4:2])
      , (planet_meteor_collision_12_if_else_if_acc_tmp[0]) , ({{1{planet25_x_sg2_1_sva}},
      planet25_x_sg2_1_sva}) , planet25_x_1_sva});
  assign nl_planet_meteor_collision_12_if_else_if_acc_tmp = conv_u2u_5_6({planet25_x_sg6_sva
      , 2'b0 , ({{1{planet25_x_sg4_1_sva}}, planet25_x_sg4_1_sva})}) + 6'b111111;
  assign planet_meteor_collision_12_if_else_if_acc_tmp = nl_planet_meteor_collision_12_if_else_if_acc_tmp[5:0];
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_nor_1_tmp
      = ~((meteorpx_1_sva[10]) | (meteorpx_1_sva[9]) | (meteorpx_1_sva[8]) | (meteorpx_1_sva[7])
      | (meteorpx_1_sva[6]) | (meteorpx_1_sva[5]) | (meteorpx_1_sva[4]) | (meteorpx_1_sva[3])
      | (meteorpx_1_sva[2]) | (meteorpx_1_sva[1]) | (meteorpx_1_sva[0]));
  assign mux_54_nl = MUX_s_1_2_2({planet_meteor_collision_15_if_else_land_1_lpi_1_dfm
      , planet_meteor_collision_15_if_else_land_1_lpi_1_dfm_mx0w1}, p2planets_1_sva[7]);
  assign planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1 =
      (~ z_out_10_sg1) & (mux_54_nl) & (p2planets_1_sva[7]);
  assign mux_62_nl = MUX_s_1_2_2({planet_meteor_collision_14_if_else_land_1_lpi_1_dfm
      , planet_meteor_collision_14_if_else_land_1_lpi_1_dfm_mx0w1}, p2planets_1_sva[6]);
  assign planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1 =
      (~ z_out_9_sg1) & (mux_62_nl) & (p2planets_1_sva[6]);
  assign nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva
      = conv_u2u_4_5(readslicef_5_4_1((conv_u2u_4_5({else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_5_itm
      , 1'b1}) + conv_u2u_4_5({else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_6_itm
      , (random_1_sva[15])})))) + conv_s2u_4_5({3'b100 , (random_1_sva[1])});
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva
      = nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[4:0];
  assign C1_1_1_dfmergedata_1_lpi_1_dfm = (C1_1_1_dfmergedata_1_lpi_1 & (~ nor_153_cse))
      | else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp;
  assign C1_1_1_dfmergedata_lpi_1_dfm = (C1_1_1_dfmergedata_lpi_1 & (~ nor_153_cse))
      | nor_dfs_mx0w1;
  assign planet_meteor_collision_15_if_else_if_equal_tmp = ({(z_out_3[10:8]) , (z_out_3[6])
      , (z_out_3[3:2]) , (z_out_3[0])}) == ({(z_out_35[4:2]) , (z_out_35[0]) , ({{1{planet28_x_sg2_1_sva}},
      planet28_x_sg2_1_sva}) , planet28_x_1_sva});
  assign planet_meteor_collision_14_if_else_if_equal_tmp = ({(reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[10:8])
      , (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[6]) , (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[3:2])
      , (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[0])}) == ({reg_planet_meteor_collision_14_if_else_if_acc_sdt_sva_1_tmp
      , reg_planet_meteor_collision_14_if_else_if_acc_sdt_sva_1_tmp_2 , ({{1{planet_meteor_collision_14_if_else_if_asn_3_itm}},
      planet_meteor_collision_14_if_else_if_asn_3_itm}) , planet_meteor_collision_14_if_else_if_asn_4_itm});
  assign else_else_1_else_else_else_else_and_tmp = ameteor_direction_sg2_lpi_1_dfm_16_mx0
      & ameteor_direction_1_lpi_1_dfm_16_mx0 & (~(ameteor_direction_sg3_lpi_1_dfm_16_mx0w1
      | ameteor_direction_sg1_lpi_1_dfm_16_mx0));
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])
      , (meteordirectionin_1_sva[2])}, nor_tmp_49);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_4_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_8_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_4_nl)
      , (reg_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva_cse[1])},
      planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_12_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_8_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_mux_16_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_12_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_else_mux_20_nl =
      MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_mux_16_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_mux_24_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_mux_20_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_mux_28_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_mux_24_nl)
      , (else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_mux_32_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_mux_28_nl)
      , (else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_mux_35_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_mux_32_nl)
      , (else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1);
  assign else_else_else_else_else_else_else_mux_41_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_mux_35_nl)
      , (else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1);
  assign else_else_else_else_else_else_mux_47_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_mux_41_nl)
      , (meteordirectionin_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1);
  assign else_else_else_else_else_mux_53_nl = MUX_s_1_2_2({(else_else_else_else_else_else_mux_47_nl)
      , (else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1);
  assign else_else_else_else_mux_59_nl = MUX_s_1_2_2({(else_else_else_else_else_mux_53_nl)
      , (else_else_else_else_if_ac_int_cctor_3_sg1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1);
  assign else_else_else_mux_65_nl = MUX_s_1_2_2({(else_else_else_else_mux_59_nl)
      , (else_else_else_if_ac_int_cctor_3_sg1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1);
  assign else_else_mux_176_nl = MUX_s_1_2_2({(else_else_else_mux_65_nl) , (else_else_if_ac_int_cctor_3_sg1_sva[1])},
      planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1);
  assign ameteor_direction_sg2_lpi_1_dfm_16_mx0 = MUX_s_1_2_2({(else_else_mux_176_nl)
      , (else_if_ac_int_cctor_3_sg1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_10_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])
      , (meteordirectionin_1_sva[1])}, nor_tmp_49);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_5_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_10_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_9_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_5_nl)
      , (reg_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva_cse[0])},
      planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_13_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_9_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_mux_17_nl
      = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_mux_13_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_else_mux_21_nl =
      MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_else_mux_17_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_else_mux_25_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_else_mux_21_nl)
      , (else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_else_mux_29_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_else_mux_25_nl)
      , (else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_else_mux_33_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_else_mux_29_nl)
      , (else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm);
  assign else_else_else_else_else_else_else_else_mux_36_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_else_mux_33_nl)
      , (else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1);
  assign else_else_else_else_else_else_else_mux_42_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_else_mux_36_nl)
      , (else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1);
  assign else_else_else_else_else_else_mux_48_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_mux_42_nl)
      , (meteordirectionin_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1);
  assign else_else_else_else_else_mux_54_nl = MUX_s_1_2_2({(else_else_else_else_else_else_mux_48_nl)
      , (else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1);
  assign else_else_else_else_mux_60_nl = MUX_s_1_2_2({(else_else_else_else_else_mux_54_nl)
      , (else_else_else_else_if_ac_int_cctor_3_sg1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1);
  assign else_else_else_mux_66_nl = MUX_s_1_2_2({(else_else_else_else_mux_60_nl)
      , (else_else_else_if_ac_int_cctor_3_sg1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1);
  assign else_else_mux_177_nl = MUX_s_1_2_2({(else_else_else_mux_66_nl) , (else_else_if_ac_int_cctor_3_sg1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1);
  assign ameteor_direction_sg1_lpi_1_dfm_16_mx0 = MUX_s_1_2_2({(else_else_mux_177_nl)
      , (else_if_ac_int_cctor_3_sg1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1);
  assign else_else_else_else_else_else_else_mux_43_nl = MUX_s_1_2_2({else_else_else_else_else_else_else_else_mux_37_itm
      , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1);
  assign else_else_else_else_else_else_mux_49_nl = MUX_s_1_2_2({(else_else_else_else_else_else_else_mux_43_nl)
      , (meteordirectionin_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1);
  assign else_else_else_else_else_mux_55_nl = MUX_s_1_2_2({(else_else_else_else_else_else_mux_49_nl)
      , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1);
  assign else_else_else_else_mux_61_nl = MUX_s_1_2_2({(else_else_else_else_else_mux_55_nl)
      , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1);
  assign else_else_else_mux_67_nl = MUX_s_1_2_2({(else_else_else_else_mux_61_nl)
      , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1);
  assign else_else_mux_178_nl = MUX_s_1_2_2({(else_else_else_mux_67_nl) , (random_1_sva[0])},
      planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1);
  assign ameteor_direction_1_lpi_1_dfm_16_mx0 = MUX_s_1_2_2({(else_else_mux_178_nl)
      , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1);
  assign else_else_1_else_else_else_and_tmp = ameteor_direction_sg2_lpi_1_dfm_16_mx0
      & (~(ameteor_direction_sg3_lpi_1_dfm_16_mx0w1 | ameteor_direction_sg1_lpi_1_dfm_16_mx0
      | ameteor_direction_1_lpi_1_dfm_16_mx0));
  assign else_else_1_else_else_and_tmp = ameteor_direction_sg1_lpi_1_dfm_16_mx0 &
      ameteor_direction_1_lpi_1_dfm_16_mx0 & (~(ameteor_direction_sg3_lpi_1_dfm_16_mx0w1
      | ameteor_direction_sg2_lpi_1_dfm_16_mx0));
  assign else_else_1_else_and_tmp = ameteor_direction_1_lpi_1_dfm_16_mx0 & (~(ameteor_direction_sg3_lpi_1_dfm_16_mx0w1
      | ameteor_direction_sg2_lpi_1_dfm_16_mx0 | ameteor_direction_sg1_lpi_1_dfm_16_mx0));
  assign else_else_1_and_tmp = ameteor_direction_sg1_lpi_1_dfm_16_mx0 & (~(ameteor_direction_sg3_lpi_1_dfm_16_mx0w1
      | ameteor_direction_sg2_lpi_1_dfm_16_mx0 | ameteor_direction_1_lpi_1_dfm_16_mx0));
  assign else_nor_tmp = ~(ameteor_direction_sg3_lpi_1_dfm_16_mx0w1 | ameteor_direction_sg2_lpi_1_dfm_16_mx0
      | ameteor_direction_sg1_lpi_1_dfm_16_mx0 | ameteor_direction_1_lpi_1_dfm_16_mx0);
  assign nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
      = conv_u2u_1_2(z_out_17_sg1[0]) + conv_u2u_1_2(z_out_17_sg1[1]);
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
      = nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva[1:0];
  assign nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva
      = (readslicef_4_3_1((conv_u2u_3_4({else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_7_itm
      , 1'b1}) + conv_u2u_2_4({(~ (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[1]))
      , (~ (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[4]))}))))
      + ({2'b10 , (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[0])});
  assign else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva
      = nl_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva[2:0];
  assign and_6_m1c_1 = else_nor_tmp & (~ io_read_restart_rsc_d_svs);
  assign else_else_1_else_nor_2_m1c_1 = ~(else_else_1_else_else_and_tmp | else_else_1_else_and_tmp);
  assign ship_meteor_collision_else_if_acc_9_sg1 = readslicef_8_7_1((conv_u2u_7_8({player1_x_sg6_sva
      , 2'b0 , player1_x_sg4_sva , 1'b0 , player1_x_sg2_sva , 1'b1}) + ({4'b1111
      , (~ player1_width_sg3_sva) , 1'b1 , (~ player1_width_sg1_sva) , 1'b1})));
  assign ship_meteor_collision_else_if_acc_11_sg1 = readslicef_13_11_2((conv_u2u_12_13({redobjecty_1_sva
      , 1'b1}) + conv_u2u_12_13({(~ ameteor_y_lpi_1_dfm_16) , 1'b1})));
  assign unequal_tmp = ~((count_sva[14]) & (count_sva[13]) & (count_sva[8]) & (count_sva[7])
      & (count_sva[5]) & (count_sva[3]) & (~((count_sva[19]) | (count_sva[18]) |
      (count_sva[17]) | (count_sva[16]) | (count_sva[15]) | (count_sva[12]) | (count_sva[11])
      | (count_sva[10]) | (count_sva[9]) | (count_sva[6]) | (count_sva[4]) | (count_sva[2])
      | (count_sva[1]) | (count_sva[0]))));
  assign ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0 = MUX_s_1_2_2({ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2
      , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1}, ship_meteor_collision_asn_4_itm);
  assign wall_meteor_collision_lor_lpi_1_dfm = ~((~((wall_meteor_collision_oelse_acc_sdt_sva[9])
      & (wall_meteor_collision_oelse_acc_sdt_sva[8]) & (wall_meteor_collision_oelse_acc_sdt_sva[7])
      & (wall_meteor_collision_oelse_acc_sdt_sva[6]) & (wall_meteor_collision_oelse_acc_sdt_sva[5])
      & (wall_meteor_collision_oelse_acc_sdt_sva[4]) & (wall_meteor_collision_oelse_acc_sdt_sva[3])
      & (wall_meteor_collision_oelse_acc_sdt_sva[2]) & (wall_meteor_collision_oelse_acc_sdt_sva[1])
      & (wall_meteor_collision_oelse_acc_sdt_sva[0]) & (~((wall_meteor_collision_oelse_acc_sdt_sva[11])
      | (wall_meteor_collision_oelse_acc_sdt_sva[10]))))) & ((z_out_31[12]) | (z_out_31[11])
      | (z_out_31[10]) | (z_out_31[9]) | (z_out_31[8]) | (z_out_31[7]) | (z_out_31[6])
      | (z_out_31[5]) | (z_out_31[4]) | (z_out_31[3]) | (z_out_31[2]) | (z_out_31[1])));
  assign else_else_1_else_else_else_else_and_1_tmp = (~ ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1)
      & else_else_1_else_else_else_else_and_svs;
  assign else_else_1_else_else_else_and_2_m1c = (~ ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1)
      & else_else_1_else_else_else_and_svs;
  assign else_else_1_else_and_2_m1c = (~ ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx3)
      & else_else_1_else_and_svs;
  assign else_else_1_else_and_6_m1c = else_else_1_else_else_and_svs & (~ else_else_1_else_and_svs);
  assign ship_meteor_collision_3_else_nor_tmp = ~(unequal_tmp | ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1);
  assign else_else_1_nor_m1c = ~(else_else_1_else_else_and_svs | else_else_1_else_and_svs
      | else_else_1_and_svs);
  assign else_else_1_and_2_m1c = (~ ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0)
      & else_else_1_and_svs;
  assign nl_wall_meteor_collision_oelse_acc_sdt_sva = conv_u2u_11_12(ameteor_y_lpi_1_dfm_16)
      + conv_u2u_4_12({{3{ameteor_radius_2_sva}}, ameteor_radius_2_sva});
  assign wall_meteor_collision_oelse_acc_sdt_sva = nl_wall_meteor_collision_oelse_acc_sdt_sva[11:0];
  assign or_126_m1c = ((~ planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1)
      & and_17_m1c) | and_9_itm;
  assign and_17_m1c = (else_else_1_and_13_cse | (~((~(else_else_1_else_and_6_m1c
      | else_else_1_else_and_1_cse | wall_meteor_collision_1_and_1_cse)) | else_else_1_and_svs))
      | else_else_1_and_1_cse | wall_meteor_collision_and_1_cse) & nor_2_m1c;
  assign else_else_1_else_else_else_else_and_4_cse = wall_meteor_collision_lor_lpi_1_dfm
      & else_else_1_else_else_else_else_and_1_tmp & (~ else_else_1_else_else_else_and_svs)
      & else_else_1_nor_m1c & nor_2_m1c;
  assign else_else_1_else_else_else_else_and_5_cse = wall_meteor_collision_nor_2
      & else_else_1_else_else_else_else_and_1_tmp & (~ else_else_1_else_else_else_and_svs)
      & else_else_1_nor_m1c & nor_2_m1c;
  assign else_else_1_else_else_else_and_7_cse = wall_meteor_collision_lor_lpi_1_dfm
      & else_else_1_else_else_else_and_2_m1c & else_else_1_nor_m1c & nor_2_m1c;
  assign else_else_1_else_else_else_and_8_cse = wall_meteor_collision_nor_2 & else_else_1_else_else_else_and_2_m1c
      & else_else_1_nor_m1c & nor_2_m1c;
  assign else_else_1_else_and_13_cse = wall_meteor_collision_lor_lpi_1_dfm & else_else_1_else_and_2_m1c
      & (~ else_else_1_and_svs) & nor_2_m1c;
  assign else_else_1_else_and_14_cse = wall_meteor_collision_nor_2 & else_else_1_else_and_2_m1c
      & (~ else_else_1_and_svs) & nor_2_m1c;
  assign else_else_1_and_5_cse = wall_meteor_collision_lor_lpi_1_dfm & else_else_1_and_2_m1c
      & nor_2_m1c;
  assign else_else_1_and_6_cse = wall_meteor_collision_nor_2 & else_else_1_and_2_m1c
      & nor_2_m1c;
  assign mux_132_nl = MUX_s_1_2_2({ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1
      , ship_meteor_collision_4_else_land_lpi_1_dfm}, or_dcpl_609 | else_else_1_else_and_svs
      | io_read_restart_rsc_d_svs | else_else_1_else_else_and_svs);
  assign else_else_1_and_13_cse = ((~((else_else_1_else_else_else_else_and_1_tmp
      & (~(unequal_tmp & (~ wall_meteor_collision_lor_lpi_1_dfm)))) | else_else_1_else_else_else_and_svs))
      | ((mux_132_nl) & else_else_1_else_else_else_and_svs) | (unequal_tmp & (~ wall_meteor_collision_lor_lpi_1_dfm)
      & else_else_1_else_else_else_and_2_m1c)) & else_else_1_nor_m1c;
  assign mux1h_6_nl = MUX1HOT_s_1_3_2({ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1
      , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2 , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm},
      {(and_dcpl_727 & and_dcpl_723) , (and_dcpl_727 & and_dcpl_724) , (or_dcpl_609
      | io_read_restart_rsc_d_svs)});
  assign else_else_1_else_and_1_cse = (mux1h_6_nl) & else_else_1_else_and_svs;
  assign wall_meteor_collision_1_and_1_cse = unequal_tmp & (~ wall_meteor_collision_lor_lpi_1_dfm)
      & else_else_1_else_and_2_m1c;
  assign else_else_1_and_1_cse = ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx2
      & else_else_1_and_svs;
  assign wall_meteor_collision_and_1_cse = unequal_tmp & (~ wall_meteor_collision_lor_lpi_1_dfm)
      & else_else_1_and_2_m1c;
  assign nor_2_m1c = ~(else_nor_svs | io_read_restart_rsc_d_svs);
  assign or_125_m1c = ((~ planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1)
      & and_16_m1c) | ((~ planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1)
      & and_7_m1c);
  assign and_16_m1c = (else_else_1_and_13_cse | (~((~(((~ ship_meteor_collision_3_else_nor_tmp)
      & else_else_1_else_and_6_m1c) | else_else_1_else_and_1_cse | wall_meteor_collision_1_and_1_cse))
      | else_else_1_and_svs)) | else_else_1_and_1_cse | wall_meteor_collision_and_1_cse)
      & nor_2_m1c;
  assign and_7_m1c = (~ else_if_1_nor_tmp) & and_4_m1c;
  assign else_if_1_nor_tmp = ~(unequal_tmp | ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0);
  assign and_4_m1c = else_nor_svs & (~ io_read_restart_rsc_d_svs);
  assign nor_4_m1c = ~(else_else_1_and_svs | else_nor_svs | io_read_restart_rsc_d_svs);
  assign wall_meteor_collision_and_8 = ameteor_direction_sg2_lpi_1_dfm_16 & (~ wall_meteor_collision_lor_lpi_1_dfm);
  assign wall_meteor_collision_nor_2 = ~(unequal_tmp | wall_meteor_collision_lor_lpi_1_dfm);
  assign wall_meteor_collision_and_10 = ameteor_direction_sg1_lpi_1_dfm_16 & (~ wall_meteor_collision_lor_lpi_1_dfm);
  assign wall_meteor_collision_or_2 = ameteor_direction_1_lpi_1_dfm_16 | wall_meteor_collision_lor_lpi_1_dfm;
  assign wall_meteor_collision_1_and_8 = ameteor_direction_1_lpi_1_dfm_16 & (~ wall_meteor_collision_lor_lpi_1_dfm);
  assign ship_meteor_collision_4_else_nor_3 = ~(ameteor_direction_sg2_lpi_1_dfm_16
      | wall_meteor_collision_lor_lpi_1_dfm);
  assign or_tmp_31 = planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1;
  assign nand_13_cse = ~((z_out_31[4]) & (z_out_31[3]) & (z_out_31[2]));
  assign or_tmp_46 = planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm;
  assign and_dcpl_20 = ~(planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1);
  assign or_dcpl_31 = (fsm_output[7]) | (fsm_output[4]);
  assign or_tmp_97 = (~ xeq) | (z_out_31[12]) | (z_out_31[11]) | (z_out_31[10]) |
      (z_out_31[9]) | (z_out_31[8]) | (z_out_31[6]) | nand_13_cse;
  assign or_dcpl_75 = planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1;
  assign mux_278_cse = MUX_s_1_2_2({(~(xeq_2 & planet_meteor_collision_7_if_else_if_nor_tmp
      & (z_out_3[1]))) , or_tmp_97}, planet_meteor_collision_7_if_asn_1_itm);
  assign and_dcpl_109 = ~(planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1);
  assign and_dcpl_126 = ~(planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1);
  assign or_dcpl_184 = planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm;
  assign and_dcpl_179 = ~(planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm);
  assign and_dcpl_180 = ~(planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1);
  assign or_dcpl_243 = (~ (z_out_3[7])) | (z_out_3[11]);
  assign or_dcpl_291 = (fsm_output[9]) | (fsm_output[1]);
  assign and_dcpl_387 = ~(planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm);
  assign or_dcpl_350 = (fsm_output[1]) | (fsm_output[2]);
  assign and_dcpl_530 = (fsm_output[0]) & restart_rsc_mgc_in_wire_d;
  assign and_dcpl_531 = (fsm_output[0]) & (~ restart_rsc_mgc_in_wire_d);
  assign or_dcpl_446 = (fsm_output[3]) | (fsm_output[6]) | (fsm_output[5]);
  assign and_578_cse = (~ planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1)
      & (fsm_output[6]) & (~ io_read_restart_rsc_d_svs);
  assign and_dcpl_544 = and_dcpl_20 & (~ planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1);
  assign or_dcpl_480 = (~ (z_out_3[1])) | (z_out_3[4]) | (~ (z_out_3[5]));
  assign and_dcpl_561 = (fsm_output[7]) & (~ io_read_restart_rsc_d_svs);
  assign and_dcpl_565 = ~(planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm);
  assign and_dcpl_569 = and_dcpl_179 & (~ planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm);
  assign and_dcpl_571 = and_dcpl_126 & (~ planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1);
  assign and_dcpl_580 = (fsm_output[6]) & (~ io_read_restart_rsc_d_svs);
  assign and_dcpl_585 = and_dcpl_387 & and_dcpl_565;
  assign and_dcpl_589 = and_dcpl_126 & (~(planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm));
  assign and_dcpl_634 = and_dcpl_20 & (~(planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1));
  assign and_dcpl_648 = ~(planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm);
  assign or_tmp_144 = (~ (p2planets_1_sva[7])) | z_out_10_sg1 | (z_out_7[12]) | (~
      planet_meteor_collision_15_if_else_if_equal_tmp) | (z_out_35[5]) | (~ (z_out_3[1]))
      | (z_out_3[11]) | (~ (z_out_3[7])) | (~ (z_out_3[5])) | (z_out_3[4]);
  assign or_dcpl_513 = planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm;
  assign or_dcpl_522 = or_tmp_31 | planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1;
  assign or_dcpl_541 = planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm
      | planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm;
  assign or_dcpl_548 = planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1 | planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1
      | planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm;
  assign or_dcpl_551 = or_tmp_31 | planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1;
  assign or_dcpl_575 = or_dcpl_31 | (fsm_output[3]);
  assign or_dcpl_579 = or_dcpl_291 | (fsm_output[0]);
  assign and_dcpl_701 = ~(io_read_restart_rsc_d_svs | else_else_1_else_else_and_svs);
  assign and_dcpl_704 = (fsm_output[8]) & (~ else_nor_svs);
  assign and_dcpl_705 = and_dcpl_704 & (~(else_else_1_and_svs | else_else_1_else_and_svs));
  assign or_dcpl_605 = else_else_1_else_and_svs | else_else_1_else_else_and_svs;
  assign or_dcpl_609 = else_nor_svs | else_else_1_and_svs;
  assign or_dcpl_615 = (fsm_output[6]) | io_read_restart_rsc_d_svs | (fsm_output[5]);
  assign and_dcpl_713 = else_else_1_else_and_svs & (~ io_read_restart_rsc_d_svs);
  assign and_dcpl_716 = and_dcpl_704 & (~ else_else_1_and_svs);
  assign and_dcpl_723 = (~ io_read_restart_rsc_d_svs) & ship_meteor_collision_asn_4_itm;
  assign and_dcpl_724 = ~(io_read_restart_rsc_d_svs | ship_meteor_collision_asn_4_itm);
  assign and_dcpl_727 = (~(else_nor_svs | else_else_1_and_svs)) & else_else_1_else_and_svs;
  assign and_dcpl_737 = and_dcpl_704 & else_else_1_and_svs;
  assign and_dcpl_746 = (~ else_nor_svs) & else_else_1_and_svs;
  assign or_dcpl_642 = (fsm_output[6]) | (fsm_output[5]);
  assign or_955_cse = (fsm_output[4]) | (fsm_output[3]) | or_dcpl_642;
  assign or_975_cse = (fsm_output[4]) | (fsm_output[6]) | (fsm_output[5]);
  assign or_1037_cse = (fsm_output[1]) | (fsm_output[2]) | (fsm_output[3]) | (fsm_output[4])
      | (fsm_output[5]) | (fsm_output[6]) | (fsm_output[7]);
  assign or_tmp_177 = (fsm_output[1]) | (fsm_output[2]) | (fsm_output[3]) | (fsm_output[4])
      | (fsm_output[5]) | (fsm_output[6]);
  assign or_tmp_189 = (fsm_output[1]) | (fsm_output[2]) | (fsm_output[3]);
  assign or_1038_cse = (fsm_output[4]) | (fsm_output[6]);
  assign or_dcpl_707 = (fsm_output[1]) | (fsm_output[5]);
  assign or_1044_cse = (fsm_output[2]) | (fsm_output[3]);
  assign or_dcpl_716 = or_1037_cse | (fsm_output[0]);
  assign nor_157_m1c = ~(or_dcpl_707 | or_1044_cse);
  assign or_1022_tmp = (fsm_output[1]) | (fsm_output[2]) | (fsm_output[3]) | (fsm_output[5]);
  assign or_1023_tmp = (fsm_output[2]) | (fsm_output[3]) | (fsm_output[4]) | (fsm_output[6]);
  always @(posedge clk) begin
    if ( rst ) begin
      player2y_rsc_mgc_out_stdreg_d <= 11'b0;
      player1y_rsc_mgc_out_stdreg_d <= 11'b0;
      else_if_ac_int_cctor_3_sg1_sva <= 2'b0;
      else_else_if_slc_8_itm <= 3'b0;
      planet3_y_asn_6_itm <= 1'b0;
      planet3_y_asn_5_itm <= 1'b0;
      planet_meteor_collision_2_if_if_land_1_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_2_if_else_land_1_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_2_if_asn_1_itm <= 1'b0;
      planet7_y_sg2_1_sva <= 1'b0;
      planet7_y_2_sva <= 1'b0;
      planet7_x_1_sva <= 1'b0;
      planet7_x_sg2_1_sva <= 1'b0;
      planet7_player_sva <= 1'b0;
      planet6_y_sg4_sva <= 1'b0;
      planet6_y_sg2_sva <= 1'b0;
      planet6_y_2_sva <= 1'b0;
      planet6_x_1_sva <= 1'b0;
      planet6_x_sg2_1_sva <= 1'b0;
      planet6_player_sva <= 1'b0;
      planet5_y_sg2_sva <= 1'b0;
      planet5_y_2_sva <= 1'b0;
      planet5_x_1_sva <= 1'b0;
      planet5_x_sg2_1_sva <= 1'b0;
      planet5_player_sva <= 1'b0;
      planet4_y_sg2_1_sva <= 1'b0;
      planet4_y_2_sva <= 1'b0;
      planet4_x_1_sva <= 1'b0;
      planet4_x_sg2_1_sva <= 1'b0;
      planet4_player_sva <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1 <= 1'b0;
      else_else_and_9_psp <= 1'b0;
      else_else_and_8_psp <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1 <= 1'b0;
      random_1_sva <= 16'b0;
      planet3_y_2_sva <= 1'b0;
      planet3_y_sg2_sva <= 1'b0;
      meteorpy_1_sva <= 11'b0;
      planet3_x_1_sva <= 1'b0;
      planet3_x_sg2_1_sva <= 1'b0;
      meteorpx_1_sva <= 11'b0;
      ameteor_radius_2_sva <= 1'b0;
      planet3_player_sva <= 1'b0;
      planet2_y_sg2_sva <= 1'b0;
      planet2_y_2_sva <= 1'b0;
      planet2_x_1_sva <= 1'b0;
      planet2_x_sg2_1_sva <= 1'b0;
      planet2_player_sva <= 1'b0;
      planet1_y_2_sva <= 1'b0;
      planet1_x_1_sva <= 1'b0;
      planet1_x_sg2_1_sva <= 1'b0;
      planet1_player_sva <= 1'b0;
      blueobjecty_1_sva <= 11'b0;
      redobjecty_1_sva <= 11'b0;
      planet_meteor_collision_9_if_else_land_1_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_11_if_else_land_1_lpi_1_dfm <= 1'b0;
      planet27_y_sg2_1_sva <= 1'b0;
      planet27_y_2_sva <= 1'b0;
      C1_1_1_dfmergedata_1_lpi_1 <= 1'b0;
      C1_1_1_dfmergedata_lpi_1 <= 1'b0;
      planet_meteor_collision_15_if_else_land_1_lpi_1_dfm <= 1'b0;
      planet28_y_sg2_1_sva <= 1'b0;
      planet28_y_2_sva <= 1'b0;
      planet28_x_sg2_1_sva <= 1'b0;
      planet28_x_1_sva <= 1'b0;
      planet28_x_sg6_sva <= 1'b0;
      planet28_x_sg4_1_sva <= 1'b0;
      planet_meteor_collision_14_if_else_land_1_lpi_1_dfm <= 1'b0;
      planet27_x_1_sva <= 1'b0;
      planet27_x_sg2_1_sva <= 1'b0;
      planet27_x_sg6_sva <= 1'b0;
      planet27_x_sg4_1_sva <= 1'b0;
      planet_meteor_collision_13_if_else_land_1_lpi_1_dfm <= 1'b0;
      planet26_y_sg4_sva <= 1'b0;
      planet26_y_sg2_sva <= 1'b0;
      planet26_y_2_sva <= 1'b0;
      planet26_x_sg2_1_sva <= 1'b0;
      planet26_x_1_sva <= 1'b0;
      planet26_x_sg6_sva <= 1'b0;
      planet26_x_sg4_1_sva <= 1'b0;
      planet_meteor_collision_12_if_else_land_1_lpi_1_dfm <= 1'b0;
      planet25_y_sg2_sva <= 1'b0;
      planet25_y_2_sva <= 1'b0;
      planet25_x_sg2_1_sva <= 1'b0;
      planet25_x_1_sva <= 1'b0;
      planet25_x_sg6_sva <= 1'b0;
      planet25_x_sg4_1_sva <= 1'b0;
      planet24_x_sg2_1_sva <= 1'b0;
      planet24_x_1_sva <= 1'b0;
      planet24_x_sg6_sva <= 1'b0;
      planet24_x_sg4_1_sva <= 1'b0;
      planet_meteor_collision_10_if_else_land_1_lpi_1_dfm <= 1'b0;
      planet23_y_sg2_sva <= 1'b0;
      planet23_y_2_sva <= 1'b0;
      planet23_x_sg2_1_sva <= 1'b0;
      planet23_x_1_sva <= 1'b0;
      planet23_x_sg6_sva <= 1'b0;
      planet23_x_sg4_1_sva <= 1'b0;
      planet22_y_2_sva <= 1'b0;
      planet22_y_sg2_sva <= 1'b0;
      planet22_x_sg2_1_sva <= 1'b0;
      planet22_x_1_sva <= 1'b0;
      planet22_x_sg6_sva <= 1'b0;
      planet22_x_sg4_1_sva <= 1'b0;
      planet_meteor_collision_8_if_else_and_svs <= 1'b0;
      planet21_y_2_sva <= 1'b0;
      planet21_x_sg2_1_sva <= 1'b0;
      planet21_x_1_sva <= 1'b0;
      planet21_x_sg6_sva <= 1'b0;
      planet21_x_sg4_1_sva <= 1'b0;
      planet8_y_sg2_1_sva <= 1'b0;
      planet8_y_2_sva <= 1'b0;
      planet8_x_1_sva <= 1'b0;
      planet8_x_sg2_1_sva <= 1'b0;
      planet8_player_sva <= 1'b0;
      p2planets_1_sva <= 8'b0;
      equal_tmp <= 1'b0;
      nor_dfs <= 1'b0;
      planet24_y_sg2_1_sva <= 1'b0;
      planet24_y_2_sva <= 1'b0;
      player2score_rsc_mgc_out_stdreg_d <= 1'b0;
      player1score_rsc_mgc_out_stdreg_d <= 1'b0;
      ameteor_x_lpi_1_dfm_16 <= 11'b0;
      meteordirectionin_1_sva <= 4'b0;
      ship_meteor_collision_5_else_land_lpi_1_dfm <= 1'b0;
      count_sva <= 20'b0;
      ship_meteor_collision_4_else_land_lpi_1_dfm <= 1'b0;
      ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm <= 1'b0;
      ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm <= 1'b0;
      ameteor_direction_sg3_lpi_1_dfm_16 <= 1'b0;
      player1_height_sg1_sva <= 1'b0;
      player1_height_sg3_1_sva <= 1'b0;
      player1_x_sg6_sva <= 1'b0;
      player1_x_sg4_sva <= 1'b0;
      player1_width_sg3_sva <= 1'b0;
      player1_x_sg2_sva <= 1'b0;
      player1_width_sg1_sva <= 1'b0;
      player1_x_1_sva <= 1'b0;
      player1_player_sva <= 1'b0;
      player2_height_sg1_sva <= 1'b0;
      player2_height_sg3_1_sva <= 1'b0;
      player2_x_1_sva <= 1'b0;
      player2_x_sg4_sva <= 1'b0;
      player2_x_sg2_sva <= 1'b0;
      player2_width_sg3_sva <= 1'b0;
      player2_width_sg1_sva <= 1'b0;
      p1p2_rsc_mgc_out_stdreg_d <= 1'b0;
      p1p1_rsc_mgc_out_stdreg_d <= 1'b0;
      io_read_restart_rsc_d_svs <= 1'b0;
      meteorpyout_rsc_mgc_out_stdreg_d <= 11'b0;
      meteorpxout_rsc_mgc_out_stdreg_d <= 11'b0;
      meteordirectionout_rsc_mgc_out_stdreg_d <= 4'b0;
      p2p8_rsc_mgc_out_stdreg_d <= 1'b0;
      p2p7_rsc_mgc_out_stdreg_d <= 1'b0;
      p2p6_rsc_mgc_out_stdreg_d <= 1'b0;
      p2p5_rsc_mgc_out_stdreg_d <= 1'b0;
      p2p4_rsc_mgc_out_stdreg_d <= 1'b0;
      p2p3_rsc_mgc_out_stdreg_d <= 1'b0;
      p2p2_rsc_mgc_out_stdreg_d <= 1'b0;
      p2p1_rsc_mgc_out_stdreg_d <= 1'b0;
      p1p8_rsc_mgc_out_stdreg_d <= 1'b0;
      p1p7_rsc_mgc_out_stdreg_d <= 1'b0;
      p1p6_rsc_mgc_out_stdreg_d <= 1'b0;
      p1p5_rsc_mgc_out_stdreg_d <= 1'b0;
      p1p4_rsc_mgc_out_stdreg_d <= 1'b0;
      p1p3_rsc_mgc_out_stdreg_d <= 1'b0;
      else_else_if_ac_int_cctor_3_sg1_sva <= 2'b0;
      else_else_else_if_ac_int_cctor_3_sg1_sva <= 2'b0;
      else_else_else_else_if_acc_3_psp_sva <= 2'b0;
      planet_meteor_collision_4_if_if_if_acc_7_itm <= 12'b0;
      planet_meteor_collision_4_if_if_land_1_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_4_if_else_if_and_1_itm <= 1'b0;
      planet_meteor_collision_4_if_asn_1_itm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1 <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1 <= 1'b0;
      else_else_else_else_if_ac_int_cctor_3_sg1_sva <= 2'b0;
      else_else_else_else_else_if_ac_int_cctor_3_sg1_sva <= 2'b0;
      planet_meteor_collision_7_if_if_if_asn_2_itm <= 1'b0;
      planet_meteor_collision_7_if_if_if_asn_itm <= 1'b0;
      planet_meteor_collision_7_if_asn_1_itm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1 <= 1'b0;
      else_else_else_else_else_else_mux_3_itm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1 <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1 <= 1'b0;
      else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva <= 2'b0;
      else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva <= 2'b0;
      else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva <= 3'b0;
      planet22_y_asn_4_itm <= 1'b0;
      planet22_y_asn_3_itm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1 <= 1'b0;
      else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva <= 2'b0;
      else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= 2'b0;
      else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= 2'b0;
      planet_meteor_collision_11_if_else_if_acc_5_itm <= 12'b0;
      planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm <= 1'b0;
      else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= 2'b0;
      else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= 2'b0;
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_6_itm
          <= 3'b0;
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_5_itm
          <= 3'b0;
      planet_meteor_collision_14_if_else_if_nor_itm <= 1'b0;
      planet_meteor_collision_14_if_else_if_asn_4_itm <= 1'b0;
      planet_meteor_collision_14_if_else_if_asn_3_itm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm <= 1'b0;
      else_else_else_else_else_else_else_else_else_else_mux_6_itm <= 1'b0;
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= 2'b0;
      reg_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva_cse
          <= 2'b0;
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_7_itm
          <= 2'b0;
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva
          <= 5'b0;
      nor_tmp_49 <= 1'b0;
      ameteor_y_lpi_1_dfm_16 <= 11'b0;
      planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm <= 1'b0;
      planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm <= 1'b0;
      else_else_else_else_else_else_else_else_mux_37_itm <= 1'b0;
      else_nand_itm <= 1'b0;
      else_else_else_else_else_else_mux_12_itm <= 1'b0;
      else_else_else_else_else_else_else_mux_114_itm <= 1'b0;
      else_else_else_else_else_else_else_mux_112_itm <= 1'b0;
      ship_meteor_collision_if_if_asn_10_itm <= 1'b0;
      ship_meteor_collision_if_if_asn_9_itm <= 1'b0;
      reg_ship_meteor_collision_if_land_1_lpi_1_dfm_cse <= 1'b0;
      ship_meteor_collision_else_if_slc_2_itm_sg1 <= 11'b0;
      reg_ship_meteor_collision_else_land_1_lpi_1_dfm_cse <= 1'b0;
      ship_meteor_collision_asn_4_itm <= 1'b0;
      ship_meteor_collision_3_else_if_asn_8_itm <= 1'b0;
      ship_meteor_collision_3_else_if_asn_7_itm <= 1'b0;
      ship_meteor_collision_3_else_if_slc_2_itm_sg1 <= 11'b0;
      reg_ship_meteor_collision_3_else_land_1_lpi_1_dfm_cse <= 1'b0;
      else_else_1_else_else_else_else_and_svs <= 1'b0;
      ameteor_direction_sg2_lpi_1_dfm_16 <= 1'b0;
      ameteor_direction_sg1_lpi_1_dfm_16 <= 1'b0;
      ameteor_direction_1_lpi_1_dfm_16 <= 1'b0;
      else_else_1_else_else_else_and_svs <= 1'b0;
      else_else_1_else_else_and_svs <= 1'b0;
      else_else_1_else_and_svs <= 1'b0;
      else_else_1_and_svs <= 1'b0;
      else_nor_svs <= 1'b0;
      and_6_m1c <= 1'b0;
      and_9_itm <= 1'b0;
      else_else_1_else_else_else_and_6_m1c <= 1'b0;
      else_else_1_else_nor_2_m1c <= 1'b0;
      else_and_3_m1c <= 1'b0;
      reg_p1planets_1_sva_tmp <= 6'b0;
      reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1 <= 11'b0;
      reg_planet_meteor_collision_14_if_else_if_acc_sdt_sva_1_tmp <= 3'b0;
      reg_planet_meteor_collision_14_if_else_if_acc_sdt_sva_1_tmp_2 <= 1'b0;
    end
    else begin
      player2y_rsc_mgc_out_stdreg_d <= MUX1HOT_v_11_3_2({11'b111111111 , blueobjecty_rsc_mgc_in_wire_d
          , player2y_rsc_mgc_out_stdreg_d}, {and_dcpl_530 , and_dcpl_531 , (~ (fsm_output[0]))});
      player1y_rsc_mgc_out_stdreg_d <= MUX1HOT_v_11_3_2({11'b111111111 , redobjecty_rsc_mgc_in_wire_d
          , player1y_rsc_mgc_out_stdreg_d}, {and_dcpl_530 , and_dcpl_531 , (~ (fsm_output[0]))});
      else_if_ac_int_cctor_3_sg1_sva <= MUX_v_2_2_2({z_out , else_if_ac_int_cctor_3_sg1_sva},
          or_716_cse);
      else_else_if_slc_8_itm <= z_out_21_sg1;
      planet3_y_asn_6_itm <= planet3_y_2_sva;
      planet3_y_asn_5_itm <= planet3_y_sg2_sva;
      planet_meteor_collision_2_if_if_land_1_lpi_1_dfm <= (~ (z_out_4[12])) & (z_out_31[4])
          & (z_out_31[3]) & (z_out_31[2]) & (~((({(z_out_31[7]) , (z_out_31[5]) ,
          (z_out_31[1])}) != ({(z_out_26[2]) , (z_out_26[0]) , planet3_x_1_sva}))
          | (z_out_31[6]))) & planet_meteor_collision_2_if_if_if_nor_3;
      planet_meteor_collision_2_if_else_land_1_lpi_1_dfm <= (~ (z_out_4[12])) & (z_out_3[1])
          & (({(z_out_3[4]) , (z_out_3[0])}) == ({planet3_x_sg2_1_sva , planet3_x_1_sva}))
          & (~((~ planet3_x_sg2_1_sva) | (z_out_3[3]) | (z_out_3[2]) | (z_out_3[11])
          | (z_out_3[10]) | (z_out_3[9]) | (z_out_3[8]) | (z_out_3[7]) | (z_out_3[6])
          | (z_out_3[5])));
      planet_meteor_collision_2_if_asn_1_itm <= planet3_player_sva;
      planet7_y_sg2_1_sva <= MUX_s_1_2_2({planet7_y_sg2_1_sva , (planet7_y_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      planet7_y_2_sva <= MUX_s_1_2_2({planet7_y_2_sva , (planet7_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[2]);
      planet7_x_1_sva <= MUX_s_1_2_2({planet7_x_1_sva , (planet7_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[2]);
      planet7_x_sg2_1_sva <= MUX_s_1_2_2({planet7_x_sg2_1_sva , (planet7_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      planet7_player_sva <= MUX_s_1_2_2({planet7_player_sva , (planet7_player_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      planet6_y_sg4_sva <= MUX_s_1_2_2({planet6_y_sg4_sva , (planet6_y_sg4_sva |
          io_read_restart_rsc_d_svs)}, fsm_output[2]);
      planet6_y_sg2_sva <= MUX_s_1_2_2({planet6_y_sg2_sva , (planet6_y_sg2_sva |
          io_read_restart_rsc_d_svs)}, fsm_output[2]);
      planet6_y_2_sva <= MUX_s_1_2_2({planet6_y_2_sva , (planet6_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[2]);
      planet6_x_1_sva <= MUX_s_1_2_2({planet6_x_1_sva , (planet6_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[2]);
      planet6_x_sg2_1_sva <= MUX_s_1_2_2({planet6_x_sg2_1_sva , (planet6_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      planet6_player_sva <= MUX_s_1_2_2({planet6_player_sva , (planet6_player_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      planet5_y_sg2_sva <= MUX_s_1_2_2({planet5_y_sg2_sva , (planet5_y_sg2_sva |
          io_read_restart_rsc_d_svs)}, fsm_output[1]);
      planet5_y_2_sva <= MUX_s_1_2_2({planet5_y_2_sva , (planet5_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[1]);
      planet5_x_1_sva <= MUX_s_1_2_2({planet5_x_1_sva , (planet5_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[1]);
      planet5_x_sg2_1_sva <= MUX_s_1_2_2({planet5_x_sg2_1_sva , (planet5_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[1]);
      planet5_player_sva <= MUX_s_1_2_2({planet5_player_sva , (planet5_player_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[1]);
      planet4_y_sg2_1_sva <= MUX_s_1_2_2({planet4_y_sg2_1_sva , (planet4_y_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[1]);
      planet4_y_2_sva <= MUX_s_1_2_2({planet4_y_2_sva , (planet4_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[1]);
      planet4_x_1_sva <= MUX_s_1_2_2({planet4_x_1_sva , (planet4_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[1]);
      planet4_x_sg2_1_sva <= MUX_s_1_2_2({planet4_x_sg2_1_sva , (planet4_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[1]);
      planet4_player_sva <= MUX_s_1_2_2({planet4_player_sva , (planet4_player_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[1]);
      planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1 <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_2
          , planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1},
          or_716_cse);
      else_else_and_9_psp <= MUX_s_1_2_2({else_else_and_9_psp , else_else_and_8_psp_mx0w1},
          and_578_cse);
      else_else_and_8_psp <= MUX_s_1_2_2({else_else_and_8_psp , else_else_and_8_psp_mx0w1},
          and_578_cse);
      planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1 <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1
          , planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1_mx0w0},
          fsm_output[0]);
      random_1_sva <= MUX_v_16_2_2({random_rsc_mgc_in_wire_d , random_1_sva}, or_727_cse);
      planet3_y_2_sva <= MUX_s_1_2_2({planet3_y_2_sva , (planet3_y_2_sva | restart_rsc_mgc_in_wire_d)},
          fsm_output[0]);
      planet3_y_sg2_sva <= MUX_s_1_2_2({planet3_y_sg2_sva , (planet3_y_sg2_sva |
          restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      meteorpy_1_sva <= MUX_v_11_2_2({meteorpy_1_sva , meteorpy_rsc_mgc_in_wire_d},
          fsm_output[0]);
      planet3_x_1_sva <= MUX_s_1_2_2({planet3_x_1_sva , (planet3_x_1_sva | restart_rsc_mgc_in_wire_d)},
          fsm_output[0]);
      planet3_x_sg2_1_sva <= MUX_s_1_2_2({planet3_x_sg2_1_sva , (planet3_x_sg2_1_sva
          | restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      meteorpx_1_sva <= MUX_v_11_2_2({meteorpx_1_sva , meteorpx_rsc_mgc_in_wire_d},
          fsm_output[0]);
      ameteor_radius_2_sva <= MUX_s_1_2_2({ameteor_radius_2_sva , (ameteor_radius_2_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[8]);
      planet3_player_sva <= MUX_s_1_2_2({planet3_player_sva , (planet3_player_sva
          | restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      planet2_y_sg2_sva <= MUX_s_1_2_2({planet2_y_sg2_sva , (planet2_y_sg2_sva |
          restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      planet2_y_2_sva <= MUX_s_1_2_2({planet2_y_2_sva , (planet2_y_2_sva | restart_rsc_mgc_in_wire_d)},
          fsm_output[0]);
      planet2_x_1_sva <= MUX_s_1_2_2({planet2_x_1_sva , (planet2_x_1_sva | restart_rsc_mgc_in_wire_d)},
          fsm_output[0]);
      planet2_x_sg2_1_sva <= MUX_s_1_2_2({planet2_x_sg2_1_sva , (planet2_x_sg2_1_sva
          | restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      planet2_player_sva <= MUX_s_1_2_2({planet2_player_sva , (planet2_player_sva
          | restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      planet1_y_2_sva <= MUX_s_1_2_2({planet1_y_2_sva , (planet1_y_2_sva | restart_rsc_mgc_in_wire_d)},
          fsm_output[0]);
      planet1_x_1_sva <= MUX_s_1_2_2({planet1_x_1_sva , (planet1_x_1_sva | restart_rsc_mgc_in_wire_d)},
          fsm_output[0]);
      planet1_x_sg2_1_sva <= MUX_s_1_2_2({planet1_x_sg2_1_sva , (planet1_x_sg2_1_sva
          | restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      planet1_player_sva <= MUX_s_1_2_2({planet1_player_sva , (planet1_player_sva
          | restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      blueobjecty_1_sva <= MUX_v_11_2_2({blueobjecty_rsc_mgc_in_wire_d , blueobjecty_1_sva},
          or_716_cse);
      redobjecty_1_sva <= MUX_v_11_2_2({redobjecty_rsc_mgc_in_wire_d , redobjecty_1_sva},
          or_727_cse);
      planet_meteor_collision_9_if_else_land_1_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_9_if_else_land_1_lpi_1_dfm
          , ((~ (z_out_4[12])) & (z_out_3[5]) & (z_out_3[1]) & (z_out_3[7]) & (({(z_out_3[10:8])
          , (z_out_3[6]) , (z_out_3[3:2]) , (z_out_3[0])}) == ({(z_out_35[4:2]) ,
          (z_out_35[0]) , ({{1{planet22_x_sg2_1_sva}}, planet22_x_sg2_1_sva}) , planet22_x_1_sva}))
          & planet_meteor_collision_9_if_else_if_nor_cse)}, (MUX_s_1_2_2({(~ (MUX_s_1_2_2({(z_out_3[1])
          , ((z_out_3[1]) | (~ or_tmp_97))}, ~(z_out_10_sg1 | (z_out_7[12]) | (~
          (reg_p1planets_1_sva_tmp[5])) | (~ planet_meteor_collision_7_if_asn_1_itm)))))
          , (z_out_10_sg1 | (z_out_7[12]) | (~ (reg_p1planets_1_sva_tmp[5])) | mux_278_cse)},
          z_out_32_sg1 | (~ planet_meteor_collision_8_if_else_if_equal_tmp) | (z_out_36[5])
          | (~ (p2planets_1_sva[0])) | (z_out_3[11]) | (~ (z_out_3[7])) | (~ (z_out_3[5]))
          | (z_out_3[4]))) & and_dcpl_544 & and_dcpl_109 & and_dcpl_126 & (fsm_output[3])
          & (p2planets_1_sva[1]) & (~ io_read_restart_rsc_d_svs));
      planet_meteor_collision_11_if_else_land_1_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_11_if_else_land_1_lpi_1_dfm
          , ((~ (z_out_7[12])) & (z_out_3[5]) & (z_out_3[1]) & (z_out_3[7]) & (({(z_out_3[10:8])
          , (z_out_3[6]) , (z_out_3[3:2]) , (z_out_3[0])}) == ({(z_out_35[4:2]) ,
          (z_out_35[0]) , ({{1{planet24_x_sg2_1_sva}}, planet24_x_sg2_1_sva}) , planet24_x_1_sva}))
          & planet_meteor_collision_9_if_else_if_nor_cse)}, (or_dcpl_480 | or_dcpl_243
          | (~((p2planets_1_sva[2]) & planet_meteor_collision_10_if_else_if_equal_tmp))
          | (z_out_36[5]) | (z_out_8[12]) | z_out_10_sg1) & or_410_cse & and_dcpl_544
          & and_dcpl_109 & (~ planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1)
          & and_dcpl_180 & (~ planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm)
          & (fsm_output[4]) & (p2planets_1_sva[3]) & (~ io_read_restart_rsc_d_svs));
      planet27_y_sg2_1_sva <= MUX_s_1_2_2({planet27_y_sg2_1_sva , (planet27_y_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[6]);
      planet27_y_2_sva <= MUX_s_1_2_2({planet27_y_2_sva , (planet27_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[6]);
      C1_1_1_dfmergedata_1_lpi_1 <= MUX_s_1_2_2({C1_1_1_dfmergedata_1_lpi_1 , (MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({else_else_else_else_else_else_else_mux_114_itm
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))},
          and_dcpl_561);
      C1_1_1_dfmergedata_lpi_1 <= MUX_s_1_2_2({C1_1_1_dfmergedata_lpi_1 , (MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({else_else_else_else_else_else_else_mux_112_itm
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))},
          and_dcpl_561);
      planet_meteor_collision_15_if_else_land_1_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_15_if_else_land_1_lpi_1_dfm
          , planet_meteor_collision_15_if_else_land_1_lpi_1_dfm_mx0w1}, ((~((reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[5])
          & (reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[1]))) | (~((reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1[7])
          & planet_meteor_collision_14_if_else_if_nor_itm)) | (~ planet_meteor_collision_14_if_else_if_equal_tmp)
          | (z_out_8[12]) | z_out_9_sg1 | (~ (p2planets_1_sva[6]))) & and_dcpl_544
          & and_dcpl_109 & and_dcpl_571 & and_dcpl_569 & and_dcpl_565 & (~ planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm)
          & (p2planets_1_sva[7]) & (fsm_output[6]) & (~ io_read_restart_rsc_d_svs));
      planet28_y_sg2_1_sva <= MUX_s_1_2_2({planet28_y_sg2_1_sva , (planet28_y_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[6]);
      planet28_y_2_sva <= MUX_s_1_2_2({planet28_y_2_sva , (planet28_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[6]);
      planet28_x_sg2_1_sva <= MUX_s_1_2_2({planet28_x_sg2_1_sva , (planet28_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[6]);
      planet28_x_1_sva <= MUX_s_1_2_2({planet28_x_1_sva , (planet28_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[6]);
      planet28_x_sg6_sva <= MUX_s_1_2_2({planet28_x_sg6_sva , (planet28_x_sg6_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[6]);
      planet28_x_sg4_1_sva <= MUX_s_1_2_2({planet28_x_sg4_1_sva , (planet28_x_sg4_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[6]);
      planet_meteor_collision_14_if_else_land_1_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_14_if_else_land_1_lpi_1_dfm
          , planet_meteor_collision_14_if_else_land_1_lpi_1_dfm_mx0w1}, and_dcpl_544
          & and_dcpl_109 & and_dcpl_589 & and_dcpl_585 & (p2planets_1_sva[6]) & (~
          planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm) &
          and_dcpl_580);
      planet27_x_1_sva <= MUX_s_1_2_2({planet27_x_1_sva , (planet27_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[5]);
      planet27_x_sg2_1_sva <= MUX_s_1_2_2({planet27_x_sg2_1_sva , (planet27_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet27_x_sg6_sva <= MUX_s_1_2_2({planet27_x_sg6_sva , (planet27_x_sg6_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet27_x_sg4_1_sva <= MUX_s_1_2_2({planet27_x_sg4_1_sva , (planet27_x_sg4_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet_meteor_collision_13_if_else_land_1_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_13_if_else_land_1_lpi_1_dfm
          , planet_meteor_collision_13_if_else_land_1_lpi_1_dfm_mx0w1}, (or_dcpl_480
          | or_dcpl_243 | (~ (p2planets_1_sva[4])) | (planet_meteor_collision_12_if_else_if_acc_tmp[5])
          | (~ planet_meteor_collision_12_if_else_if_equal_tmp) | (z_out_8[12]) |
          z_out_9_sg1) & or_475_cse & (~ planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1)
          & (~(planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1
          | planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          & and_dcpl_109 & and_dcpl_571 & and_dcpl_569 & (p2planets_1_sva[5]) & (~
          io_read_restart_rsc_d_svs) & (fsm_output[5]));
      planet26_y_sg4_sva <= MUX_s_1_2_2({planet26_y_sg4_sva , (planet26_y_sg4_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet26_y_sg2_sva <= MUX_s_1_2_2({planet26_y_sg2_sva , (planet26_y_sg2_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet26_y_2_sva <= MUX_s_1_2_2({planet26_y_2_sva , (planet26_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[5]);
      planet26_x_sg2_1_sva <= MUX_s_1_2_2({planet26_x_sg2_1_sva , (planet26_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet26_x_1_sva <= MUX_s_1_2_2({planet26_x_1_sva , (planet26_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[5]);
      planet26_x_sg6_sva <= MUX_s_1_2_2({planet26_x_sg6_sva , (planet26_x_sg6_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet26_x_sg4_1_sva <= MUX_s_1_2_2({planet26_x_sg4_1_sva , (planet26_x_sg4_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet_meteor_collision_12_if_else_land_1_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_12_if_else_land_1_lpi_1_dfm
          , planet_meteor_collision_12_if_else_land_1_lpi_1_dfm_mx0w1}, and_dcpl_544
          & and_dcpl_109 & or_475_cse & (~ planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1)
          & and_dcpl_180 & and_dcpl_179 & (~ planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm)
          & (p2planets_1_sva[4]) & (~ io_read_restart_rsc_d_svs) & (fsm_output[5]));
      planet25_y_sg2_sva <= MUX_s_1_2_2({planet25_y_sg2_sva , (planet25_y_sg2_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet25_y_2_sva <= MUX_s_1_2_2({planet25_y_2_sva , (planet25_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[5]);
      planet25_x_sg2_1_sva <= MUX_s_1_2_2({planet25_x_sg2_1_sva , (planet25_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet25_x_1_sva <= MUX_s_1_2_2({planet25_x_1_sva , (planet25_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[5]);
      planet25_x_sg6_sva <= MUX_s_1_2_2({planet25_x_sg6_sva , (planet25_x_sg6_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet25_x_sg4_1_sva <= MUX_s_1_2_2({planet25_x_sg4_1_sva , (planet25_x_sg4_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      planet24_x_sg2_1_sva <= MUX_s_1_2_2({planet24_x_sg2_1_sva , (planet24_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      planet24_x_1_sva <= MUX_s_1_2_2({planet24_x_1_sva , (planet24_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[4]);
      planet24_x_sg6_sva <= MUX_s_1_2_2({planet24_x_sg6_sva , (planet24_x_sg6_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      planet24_x_sg4_1_sva <= MUX_s_1_2_2({planet24_x_sg4_1_sva , (planet24_x_sg4_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      planet_meteor_collision_10_if_else_land_1_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_10_if_else_land_1_lpi_1_dfm
          , planet_meteor_collision_10_if_else_land_1_lpi_1_dfm_mx0w1}, and_dcpl_634
          & or_410_cse & (~ planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1)
          & and_dcpl_589 & (fsm_output[4]) & (p2planets_1_sva[2]) & (~ io_read_restart_rsc_d_svs));
      planet23_y_sg2_sva <= MUX_s_1_2_2({planet23_y_sg2_sva , (planet23_y_sg2_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      planet23_y_2_sva <= MUX_s_1_2_2({planet23_y_2_sva , (planet23_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[4]);
      planet23_x_sg2_1_sva <= MUX_s_1_2_2({planet23_x_sg2_1_sva , (planet23_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      planet23_x_1_sva <= MUX_s_1_2_2({planet23_x_1_sva , (planet23_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[4]);
      planet23_x_sg6_sva <= MUX_s_1_2_2({planet23_x_sg6_sva , (planet23_x_sg6_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      planet23_x_sg4_1_sva <= MUX_s_1_2_2({planet23_x_sg4_1_sva , (planet23_x_sg4_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      planet22_y_2_sva <= MUX_s_1_2_2({planet22_y_2_sva , (planet22_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[3]);
      planet22_y_sg2_sva <= MUX_s_1_2_2({planet22_y_sg2_sva , (planet22_y_sg2_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      planet22_x_sg2_1_sva <= MUX_s_1_2_2({planet22_x_sg2_1_sva , (planet22_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      planet22_x_1_sva <= MUX_s_1_2_2({planet22_x_1_sva , (planet22_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[3]);
      planet22_x_sg6_sva <= MUX_s_1_2_2({planet22_x_sg6_sva , (planet22_x_sg6_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      planet22_x_sg4_1_sva <= MUX_s_1_2_2({planet22_x_sg4_1_sva , (planet22_x_sg4_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      planet_meteor_collision_8_if_else_and_svs <= MUX_s_1_2_2({planet_meteor_collision_8_if_else_and_svs
          , planet_meteor_collision_8_if_else_and_svs_mx0w1}, (mux_278_cse | (~ (reg_p1planets_1_sva_tmp[5]))
          | (z_out_7[12]) | z_out_10_sg1) & and_dcpl_544 & and_dcpl_109 & and_dcpl_126
          & (p2planets_1_sva[0]) & (fsm_output[3]) & (~ io_read_restart_rsc_d_svs));
      planet21_y_2_sva <= MUX_s_1_2_2({planet21_y_2_sva , (planet21_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[3]);
      planet21_x_sg2_1_sva <= MUX_s_1_2_2({planet21_x_sg2_1_sva , (planet21_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      planet21_x_1_sva <= MUX_s_1_2_2({planet21_x_1_sva , (planet21_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[3]);
      planet21_x_sg6_sva <= MUX_s_1_2_2({planet21_x_sg6_sva , (planet21_x_sg6_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      planet21_x_sg4_1_sva <= MUX_s_1_2_2({planet21_x_sg4_1_sva , (planet21_x_sg4_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      planet8_y_sg2_1_sva <= MUX_s_1_2_2({planet8_y_sg2_1_sva , (planet8_y_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      planet8_y_2_sva <= MUX_s_1_2_2({planet8_y_2_sva , (planet8_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[3]);
      planet8_x_1_sva <= MUX_s_1_2_2({planet8_x_1_sva , (planet8_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[2]);
      planet8_x_sg2_1_sva <= MUX_s_1_2_2({planet8_x_sg2_1_sva , (planet8_x_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      planet8_player_sva <= MUX_s_1_2_2({planet8_player_sva , (planet8_player_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      p2planets_1_sva <= MUX_v_8_2_2({p2planets_rsc_mgc_in_wire_d , p2planets_1_sva},
          or_716_cse);
      equal_tmp <= MUX_s_1_2_2({equal_tmp , else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp},
          and_706_cse);
      nor_dfs <= MUX_s_1_2_2({nor_dfs , nor_dfs_mx0w1}, and_706_cse);
      planet24_y_sg2_1_sva <= MUX_s_1_2_2({planet24_y_sg2_1_sva , (planet24_y_sg2_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      planet24_y_2_sva <= MUX_s_1_2_2({planet24_y_2_sva , (planet24_y_2_sva | io_read_restart_rsc_d_svs)},
          fsm_output[4]);
      player2score_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({C1_1_1_dfmergedata_1_lpi_1_dfm
          , player2score_rsc_mgc_out_stdreg_d}, nand_66_cse | or_dcpl_551 | or_dcpl_75
          | or_dcpl_548 | or_tmp_46 | planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm
          | or_dcpl_541 | (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_nor_1_tmp
          & (~ else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp))
          | (~ (fsm_output[6])) | io_read_restart_rsc_d_svs);
      player1score_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({C1_1_1_dfmergedata_lpi_1_dfm
          , player1score_rsc_mgc_out_stdreg_d}, nand_66_cse | or_dcpl_551 | or_dcpl_75
          | or_dcpl_548 | or_tmp_46 | or_dcpl_513 | planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm
          | (~ (fsm_output[6])) | else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp
          | io_read_restart_rsc_d_svs);
      ameteor_x_lpi_1_dfm_16 <= MUX1HOT_v_11_3_2({ameteor_x_lpi_1_dfm_16 , meteorpx_1_sva
          , 11'b1001111111}, {(or_dcpl_579 | (fsm_output[8]) | (fsm_output[2]) |
          or_dcpl_575 | io_read_restart_rsc_d_svs | (fsm_output[5])) , (or_tmp_144
          & or_786_cse & and_dcpl_544 & and_dcpl_109 & and_dcpl_589 & and_dcpl_387
          & (~ planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm)
          & and_dcpl_648 & (fsm_output[6]) & (~ else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_nor_1_tmp)
          & (~(else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp
          | io_read_restart_rsc_d_svs))) , (or_892_cse & and_dcpl_580)});
      meteordirectionin_1_sva <= MUX_v_4_2_2({meteordirectionin_rsc_mgc_in_wire_d
          , meteordirectionin_1_sva}, or_716_cse);
      ship_meteor_collision_5_else_land_lpi_1_dfm <= MUX_s_1_2_2({ship_meteor_collision_5_else_land_lpi_1_dfm
          , ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1}, and_dcpl_705 & and_dcpl_701
          & (~ else_else_1_else_else_else_and_svs) & else_else_1_else_else_else_else_and_svs);
      count_sva <= MUX_v_20_2_2({count_sva , ((count_sva + 20'b1) & ({{19{unequal_tmp}},
          unequal_tmp}))}, (((~(wall_meteor_collision_lor_lpi_1_dfm | (MUX_s_1_2_2({ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1
          , ship_meteor_collision_5_else_land_lpi_1_dfm}, or_dcpl_605 | else_else_1_else_else_else_and_svs
          | (~ else_else_1_else_else_else_else_and_svs))))) & else_else_1_else_else_else_and_6_m1c
          & nor_4_m1c) | ((~(wall_meteor_collision_lor_lpi_1_dfm | (MUX_s_1_2_2({ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1
          , ship_meteor_collision_4_else_land_lpi_1_dfm}, or_dcpl_605)))) & else_else_1_else_else_else_and_svs
          & else_else_1_else_nor_2_m1c & nor_4_m1c) | ((~ ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1)
          & else_else_1_else_and_6_m1c & nor_4_m1c) | ((~(wall_meteor_collision_lor_lpi_1_dfm
          | ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx3))
          & else_else_1_else_and_svs & nor_4_m1c) | ((~(wall_meteor_collision_lor_lpi_1_dfm
          | ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx2))
          & else_and_3_m1c) | ((~ ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0)
          & else_nor_svs & (~ io_read_restart_rsc_d_svs))) & (fsm_output[8]));
      ship_meteor_collision_4_else_land_lpi_1_dfm <= MUX_s_1_2_2({ship_meteor_collision_4_else_land_lpi_1_dfm
          , ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1}, and_dcpl_705 & and_dcpl_701
          & else_else_1_else_else_else_and_svs);
      ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm <= MUX1HOT_s_1_3_2({ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm
          , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1
          , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2},
          {(or_dcpl_291 | (fsm_output[0]) | (fsm_output[2]) | or_dcpl_609 | (~ else_else_1_else_and_svs)
          | or_dcpl_575 | or_dcpl_615) , (and_dcpl_716 & and_dcpl_713 & ship_meteor_collision_asn_4_itm)
          , (and_dcpl_716 & and_dcpl_713 & (~ ship_meteor_collision_asn_4_itm))});
      ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm <= MUX1HOT_s_1_3_2({ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm
          , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w1
          , ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx0w2},
          {(or_dcpl_579 | (fsm_output[2]) | else_nor_svs | (~ else_else_1_and_svs)
          | or_dcpl_575 | or_dcpl_615) , (and_dcpl_737 & and_dcpl_723) , (and_dcpl_737
          & and_dcpl_724)});
      ameteor_direction_sg3_lpi_1_dfm_16 <= MUX_s_1_2_2({ameteor_direction_sg3_lpi_1_dfm_16
          , ameteor_direction_sg3_lpi_1_dfm_16_mx0w1}, and_dcpl_561);
      player1_height_sg1_sva <= MUX_s_1_2_2({player1_height_sg1_sva , (player1_height_sg1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player1_height_sg3_1_sva <= MUX_s_1_2_2({player1_height_sg3_1_sva , (player1_height_sg3_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player1_x_sg6_sva <= MUX_s_1_2_2({player1_x_sg6_sva , (player1_x_sg6_sva |
          io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player1_x_sg4_sva <= MUX_s_1_2_2({player1_x_sg4_sva , (player1_x_sg4_sva |
          io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player1_width_sg3_sva <= MUX_s_1_2_2({player1_width_sg3_sva , (player1_width_sg3_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player1_x_sg2_sva <= MUX_s_1_2_2({player1_x_sg2_sva , (player1_x_sg2_sva |
          io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player1_width_sg1_sva <= MUX_s_1_2_2({player1_width_sg1_sva , (player1_width_sg1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player1_x_1_sva <= MUX_s_1_2_2({player1_x_1_sva , (player1_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[7]);
      player1_player_sva <= MUX_s_1_2_2({player1_player_sva , (player1_player_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player2_height_sg1_sva <= MUX_s_1_2_2({player2_height_sg1_sva , (player2_height_sg1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player2_height_sg3_1_sva <= MUX_s_1_2_2({player2_height_sg3_1_sva , (player2_height_sg3_1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player2_x_1_sva <= MUX_s_1_2_2({player2_x_1_sva , (player2_x_1_sva | io_read_restart_rsc_d_svs)},
          fsm_output[7]);
      player2_x_sg4_sva <= MUX_s_1_2_2({player2_x_sg4_sva , (player2_x_sg4_sva |
          io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player2_x_sg2_sva <= MUX_s_1_2_2({player2_x_sg2_sva , (player2_x_sg2_sva |
          io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player2_width_sg3_sva <= MUX_s_1_2_2({player2_width_sg3_sva , (player2_width_sg3_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      player2_width_sg1_sva <= MUX_s_1_2_2({player2_width_sg1_sva , (player2_width_sg1_sva
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      p1p2_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p1p2_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({((p1planets_rsc_mgc_in_wire_d[1])
          & (~ planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_2))
          , (p1planets_rsc_mgc_in_wire_d[1])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1_mx0w0))
          | restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      p1p1_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p1p1_rsc_mgc_out_stdreg_d , (((p1planets_rsc_mgc_in_wire_d[0])
          & (~ planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1_mx0w0))
          | restart_rsc_mgc_in_wire_d)}, fsm_output[0]);
      io_read_restart_rsc_d_svs <= MUX_s_1_2_2({io_read_restart_rsc_d_svs , restart_rsc_mgc_in_wire_d},
          fsm_output[0]);
      meteorpyout_rsc_mgc_out_stdreg_d <= MUX1HOT_v_11_5_2({meteorpyout_rsc_mgc_out_stdreg_d
          , 11'b111111111 , meteorpy_1_sva , z_out_37 , (ameteor_y_lpi_1_dfm_16 +
          11'b1)}, {(~ (fsm_output[8])) , ((((~ else_else_and_9_psp) & or_126_m1c)
          | (planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1 &
          and_17_m1c) | (planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1
          & and_6_m1c) | io_read_restart_rsc_d_svs) & (fsm_output[8])) , (else_else_and_9_psp
          & or_126_m1c & (fsm_output[8])) , ((else_else_1_else_else_else_else_and_4_cse
          | else_else_1_else_else_else_and_8_cse | else_else_1_else_and_14_cse |
          else_else_1_and_5_cse) & (fsm_output[8])) , ((else_else_1_else_else_else_else_and_5_cse
          | else_else_1_else_else_else_and_7_cse | else_else_1_else_and_13_cse |
          else_else_1_and_6_cse) & (fsm_output[8]))});
      meteorpxout_rsc_mgc_out_stdreg_d <= MUX1HOT_v_11_5_2({meteorpxout_rsc_mgc_out_stdreg_d
          , 11'b1001111111 , meteorpx_1_sva , (z_out_3[10:0]) , (ameteor_x_lpi_1_dfm_16
          + 11'b11111111111)}, {(~ (fsm_output[8])) , ((((~ else_else_and_8_psp)
          & or_125_m1c) | (planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1
          & and_16_m1c) | (planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1
          & and_7_m1c) | io_read_restart_rsc_d_svs) & (fsm_output[8])) , (else_else_and_8_psp
          & or_125_m1c & (fsm_output[8])) , ((else_else_1_else_else_else_else_and_4_cse
          | else_else_1_else_else_else_else_and_5_cse | else_else_1_else_else_else_and_7_cse
          | else_else_1_else_else_else_and_8_cse | (ship_meteor_collision_3_else_nor_tmp
          & else_else_1_else_and_6_m1c & (~ else_else_1_and_svs) & nor_2_m1c)) &
          (fsm_output[8])) , ((else_else_1_else_and_13_cse | else_else_1_else_and_14_cse
          | else_else_1_and_5_cse | else_else_1_and_6_cse | (else_if_1_nor_tmp &
          and_4_m1c)) & (fsm_output[8]))});
      meteordirectionout_rsc_mgc_out_stdreg_d <= MUX_v_4_2_2({meteordirectionout_rsc_mgc_out_stdreg_d
          , ({((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(ameteor_direction_sg3_lpi_1_dfm_16
          & (~ wall_meteor_collision_lor_lpi_1_dfm) & (~ ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1)
          & else_else_1_else_else_else_else_and_svs) , (ameteor_direction_sg3_lpi_1_dfm_16
          & (~ wall_meteor_collision_lor_lpi_1_dfm) & (~ ship_meteor_collision_4_else_land_lpi_1_dfm_mx1))},
          else_else_1_else_else_else_and_svs)) , (ameteor_direction_sg3_lpi_1_dfm_16
          & (~ ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1))}, else_else_1_else_else_and_svs))
          , (ameteor_direction_sg3_lpi_1_dfm_16 & (~ wall_meteor_collision_lor_lpi_1_dfm)
          & (~ ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx1))},
          else_else_1_else_and_svs)) , (ameteor_direction_sg3_lpi_1_dfm_16 & (~ wall_meteor_collision_lor_lpi_1_dfm)
          & (~ ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx1))},
          else_else_1_and_svs)) , (ameteor_direction_sg3_lpi_1_dfm_16 & (~ ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0))},
          else_nor_svs)) | io_read_restart_rsc_d_svs) , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(reg_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva_cse[1])
          , (~(ship_meteor_collision_4_else_nor_3 | ship_meteor_collision_5_else_land_lpi_1_dfm_mx2))},
          else_else_1_else_else_else_else_and_svs)) , (~(ship_meteor_collision_4_else_nor_3
          | ship_meteor_collision_4_else_land_lpi_1_dfm_mx1))}, else_else_1_else_else_else_and_svs))
          , (ameteor_direction_sg2_lpi_1_dfm_16 & (~ ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1))},
          else_else_1_else_else_and_svs)) , (MUX_s_1_2_2({wall_meteor_collision_and_8
          , (z_out_40[2])}, ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx1))},
          else_else_1_else_and_svs)) , (MUX_s_1_2_2({wall_meteor_collision_and_8
          , (z_out_40[2])}, ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx1))},
          else_else_1_and_svs)) , (MUX_s_1_2_2({ameteor_direction_sg2_lpi_1_dfm_16
          , (z_out_40[2])}, ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0))},
          else_nor_svs)) & (~ io_read_restart_rsc_d_svs)) , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(reg_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva_cse[0])
          , (MUX_s_1_2_2({wall_meteor_collision_and_10 , (z_out_1[1])}, ship_meteor_collision_5_else_land_lpi_1_dfm_mx2))},
          else_else_1_else_else_else_else_and_svs)) , (MUX_s_1_2_2({wall_meteor_collision_and_10
          , (z_out_1[1])}, ship_meteor_collision_4_else_land_lpi_1_dfm_mx1))}, else_else_1_else_else_else_and_svs))
          , (MUX_s_1_2_2({ameteor_direction_sg1_lpi_1_dfm_16 , (z_out_1[1])}, ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1))},
          else_else_1_else_else_and_svs)) , (MUX_s_1_2_2({(ameteor_direction_sg1_lpi_1_dfm_16
          | wall_meteor_collision_lor_lpi_1_dfm) , (z_out_40[1])}, ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx1))},
          else_else_1_else_and_svs)) , (MUX_s_1_2_2({wall_meteor_collision_and_10
          , (z_out_40[1])}, ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx1))},
          else_else_1_and_svs)) , (MUX_s_1_2_2({ameteor_direction_sg1_lpi_1_dfm_16
          , (z_out_40[1])}, ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0))},
          else_nor_svs)) & (~ io_read_restart_rsc_d_svs)) , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(random_1_sva[0])
          , (MUX_s_1_2_2({wall_meteor_collision_1_and_8 , (z_out_1[0])}, ship_meteor_collision_5_else_land_lpi_1_dfm_mx2))},
          else_else_1_else_else_else_else_and_svs)) , (MUX_s_1_2_2({wall_meteor_collision_or_2
          , (z_out_1[0])}, ship_meteor_collision_4_else_land_lpi_1_dfm_mx1))}, else_else_1_else_else_else_and_svs))
          , (MUX_s_1_2_2({ameteor_direction_1_lpi_1_dfm_16 , (z_out_1[0])}, ship_meteor_collision_5_else_land_lpi_1_dfm_mx0w1))},
          else_else_1_else_else_and_svs)) , (MUX_s_1_2_2({wall_meteor_collision_1_and_8
          , (z_out_40[0])}, ship_meteor_collision_ship_meteor_collision_return_2_lpi_1_dfm_mx1))},
          else_else_1_else_and_svs)) , (MUX_s_1_2_2({wall_meteor_collision_or_2 ,
          (z_out_40[0])}, ship_meteor_collision_ship_meteor_collision_return_1_lpi_1_dfm_mx1))},
          else_else_1_and_svs)) , (MUX_s_1_2_2({ameteor_direction_1_lpi_1_dfm_16
          , (z_out_40[0])}, ship_meteor_collision_ship_meteor_collision_return_lpi_1_dfm_mx0))},
          else_nor_svs)) & (~ io_read_restart_rsc_d_svs))})}, fsm_output[8]);
      p2p8_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p2p8_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({else_else_else_else_else_else_mux_12_itm
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[7]);
      p2p7_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p2p7_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((p2planets_1_sva[6])
          & (~ planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (p2planets_1_sva[6])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[6]);
      p2p6_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p2p6_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({else_else_else_else_else_else_else_else_else_else_mux_6_itm
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[6]);
      p2p5_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p2p5_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((p2planets_1_sva[4])
          & (~ planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (p2planets_1_sva[4])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      p2p4_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p2p4_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((p2planets_1_sva[3])
          & (~ planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm_1))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (p2planets_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[5]);
      p2p3_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p2p3_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((p2planets_1_sva[2])
          & (~ planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (p2planets_1_sva[2])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      p2p2_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p2p2_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((p2planets_1_sva[1])
          & (~ planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm_1))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (p2planets_1_sva[1])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[4]);
      p2p1_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p2p1_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((p2planets_1_sva[0])
          & (~ planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm_1))
          , (p2planets_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_2))
          , (p2planets_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (p2planets_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , (p2planets_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (p2planets_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (p2planets_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (p2planets_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (p2planets_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      p1p8_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p1p8_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((reg_p1planets_1_sva_tmp[5])
          & (~ planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_2))
          , (reg_p1planets_1_sva_tmp[5])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[5])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[5])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[5])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[5])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[5])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[5])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      p1p7_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p1p7_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({else_else_else_else_else_else_mux_3_itm
          , (reg_p1planets_1_sva_tmp[4])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[4])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[4])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[4])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[4])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[3]);
      p1p6_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p1p6_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((reg_p1planets_1_sva_tmp[3])
          & (~ planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_2))
          , (reg_p1planets_1_sva_tmp[3])}, planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_2))
          , (reg_p1planets_1_sva_tmp[3])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[3])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[3])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[3])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      p1p5_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p1p5_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((reg_p1planets_1_sva_tmp[2])
          & (~ planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_2))
          , (reg_p1planets_1_sva_tmp[2])}, planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[2])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[2])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[2])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[2]);
      p1p4_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p1p4_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((reg_p1planets_1_sva_tmp[1])
          & (~ planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_2))
          , (reg_p1planets_1_sva_tmp[1])}, planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_2))
          , (reg_p1planets_1_sva_tmp[1])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[1])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[1]);
      p1p3_rsc_mgc_out_stdreg_d <= MUX_s_1_2_2({p1p3_rsc_mgc_out_stdreg_d , ((MUX_s_1_2_2({(MUX_s_1_2_2({((reg_p1planets_1_sva_tmp[0])
          & (~ planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_2))
          , (reg_p1planets_1_sva_tmp[0])}, planet_meteor_collision_planet_meteor_collision_return_1_lpi_1_dfm_1))
          , (reg_p1planets_1_sva_tmp[0])}, planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1))
          | io_read_restart_rsc_d_svs)}, fsm_output[1]);
      else_else_if_ac_int_cctor_3_sg1_sva <= MUX_v_2_2_2({z_out , else_else_if_ac_int_cctor_3_sg1_sva},
          or_940_cse);
      else_else_else_if_ac_int_cctor_3_sg1_sva <= MUX_v_2_2_2({z_out_1 , else_else_else_if_ac_int_cctor_3_sg1_sva},
          or_940_cse);
      else_else_else_else_if_acc_3_psp_sva <= z_out_22_sg1;
      planet_meteor_collision_4_if_if_if_acc_7_itm <= z_out_7[11:0];
      planet_meteor_collision_4_if_if_land_1_lpi_1_dfm <= (~ (z_out_8[12])) & (z_out_31[4])
          & (z_out_31[3]) & (z_out_31[2]) & planet_meteor_collision_4_if_if_if_nor_1_cse
          & planet_meteor_collision_2_if_if_if_nor_3;
      planet_meteor_collision_4_if_else_if_and_1_itm <= (~ z_out_9_sg1) & (~ (z_out_8[12]))
          & (z_out_3[1]) & xeq_2 & (~((~ planet5_x_sg2_1_sva) | (z_out_3[3]) | (z_out_3[2])
          | (z_out_3[11]) | (z_out_3[10]) | (z_out_3[9]) | (z_out_3[8]) | (z_out_3[7])
          | (z_out_3[6]) | (z_out_3[5])));
      planet_meteor_collision_4_if_asn_1_itm <= planet5_player_sva;
      planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1 <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_2
          , planet_meteor_collision_planet_meteor_collision_return_3_lpi_1_dfm_1},
          or_940_cse);
      planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1 <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_2
          , planet_meteor_collision_planet_meteor_collision_return_2_lpi_1_dfm_1},
          or_940_cse);
      else_else_else_else_if_ac_int_cctor_3_sg1_sva <= MUX_v_2_2_2({z_out , else_else_else_else_if_ac_int_cctor_3_sg1_sva},
          or_955_cse);
      else_else_else_else_else_if_ac_int_cctor_3_sg1_sva <= MUX_v_2_2_2({z_out_1
          , else_else_else_else_else_if_ac_int_cctor_3_sg1_sva}, or_955_cse);
      planet_meteor_collision_7_if_if_if_asn_2_itm <= planet8_x_1_sva;
      planet_meteor_collision_7_if_if_if_asn_itm <= planet8_x_sg2_1_sva;
      planet_meteor_collision_7_if_asn_1_itm <= planet8_player_sva;
      planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1 <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1_mx0w0
          , planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1},
          or_955_cse);
      else_else_else_else_else_else_mux_3_itm <= MUX_s_1_2_2({(reg_p1planets_1_sva_tmp[4])
          , ((reg_p1planets_1_sva_tmp[4]) & (~ planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1_mx0w0))},
          (MUX_s_1_2_2({(~(xeq_3 & planet_meteor_collision_5_if_else_if_nor_tmp &
          (z_out_3[1]))) , ((~ xeq_1) | (z_out_31[12]) | (z_out_31[11]) | (z_out_31[10])
          | (z_out_31[9]) | (z_out_31[8]) | (z_out_31[6]) | nand_13_cse)}, planet6_player_sva))
          | (~ (reg_p1planets_1_sva_tmp[3])) | (z_out_4[12]) | z_out_11_sg1 | io_read_restart_rsc_d_svs);
      planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1 <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_2
          , planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1},
          or_955_cse);
      planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1 <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_2
          , planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1},
          or_955_cse);
      else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva <= MUX_v_2_2_2({z_out_1
          , else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva}, or_975_cse);
      else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva <= MUX_v_2_2_2({z_out_1
          , else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva}, or_975_cse);
      else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva <= z_out_42;
      planet22_y_asn_4_itm <= planet22_y_2_sva;
      planet22_y_asn_3_itm <= planet22_y_sg2_sva;
      planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm_1
          , planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm},
          or_975_cse);
      planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1 <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_2
          , planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1},
          or_975_cse);
      else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva <= MUX_v_2_2_2({z_out
          , else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva},
          or_dcpl_642);
      else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= MUX_v_2_2_2({z_out_1 , else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva},
          or_dcpl_642);
      else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= MUX_v_2_2_2({z_out_1 , else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva},
          or_dcpl_642);
      planet_meteor_collision_11_if_else_if_acc_5_itm <= z_out_4[11:0];
      planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm_1
          , planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm},
          or_dcpl_642);
      planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm_1
          , planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm},
          or_dcpl_642);
      else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= MUX_v_2_2_2({z_out_1 , else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva},
          fsm_output[6]);
      else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= MUX_v_2_2_2({z_out_1 , else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva},
          fsm_output[6]);
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_6_itm
          <= z_out_18_sg1;
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_5_itm
          <= else_else_else_if_acc_24_itm_sg1;
      planet_meteor_collision_14_if_else_if_nor_itm <= planet_meteor_collision_14_if_else_if_nor_cse;
      planet_meteor_collision_14_if_else_if_asn_4_itm <= planet27_x_1_sva;
      planet_meteor_collision_14_if_else_if_asn_3_itm <= planet27_x_sg2_1_sva;
      planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm_1
          , planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm},
          fsm_output[6]);
      planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm_1
          , planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm},
          fsm_output[6]);
      planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm <= MUX_s_1_2_2({planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm_1
          , planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm},
          fsm_output[6]);
      else_else_else_else_else_else_else_else_else_else_mux_6_itm <= MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((p2planets_1_sva[5])
          & (~ planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm_1))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm))
          , (p2planets_1_sva[5])}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm);
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva
          <= z_out;
      reg_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_ac_int_cctor_3_sg1_sva_cse
          <= z_out_1;
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_slc_7_itm
          <= z_out_16_sg1;
      else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva
          <= z_out_25;
      nor_tmp_49 <= nor_153_cse;
      ameteor_y_lpi_1_dfm_16 <= MUX1HOT_v_11_3_2({meteorpy_1_sva , 11'b111111111
          , ameteor_y_lpi_1_dfm_16}, {(or_tmp_144 & or_786_cse & and_dcpl_544 & and_dcpl_109
          & and_dcpl_589 & and_dcpl_585 & (~ planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm)
          & (fsm_output[6]) & nor_153_cse) , (or_892_cse & (fsm_output[6])) , (fsm_output[7])});
      planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm <= planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1;
      planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm <= planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1;
      else_else_else_else_else_else_else_else_mux_37_itm <= MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(random_1_sva[0])
          , (meteordirectionin_1_sva[0])}, nor_153_cse)) , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1))
          , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1))
          , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm))
          , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm))
          , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm))
          , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm))
          , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm))
          , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , (random_1_sva[0])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1);
      else_nand_itm <= ~((MUX_s_1_2_2({(~((~ (meteordirectionin_1_sva[3])) | (MUX_s_1_2_2({nor_dfs_mx0w1
          , nor_dfs}, or_821_cse)) | (MUX_s_1_2_2({else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_and_tmp
          , equal_tmp}, or_821_cse)) | planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1
          | planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1
          | planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm |
          planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm | planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm
          | planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm |
          planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm | planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm
          | planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1
          | planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (meteordirectionin_1_sva[3])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1))
          & (~ planet_meteor_collision_planet_meteor_collision_return_4_lpi_1_dfm_1));
      else_else_else_else_else_else_mux_12_itm <= MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({((p2planets_1_sva[7])
          & (~ planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1))
          , (p2planets_1_sva[7])}, planet_meteor_collision_planet_meteor_collision_return_5_lpi_1_dfm_1);
      else_else_else_else_else_else_else_mux_114_itm <= MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({C1_1_1_dfmergedata_1_lpi_1_dfm
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_1_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1);
      else_else_else_else_else_else_else_mux_112_itm <= MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({(MUX_s_1_2_2({C1_1_1_dfmergedata_lpi_1_dfm
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_15_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_14_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_13_lpi_1_dfm))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_12_lpi_1_dfm))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_11_lpi_1_dfm))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_10_lpi_1_dfm))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_9_lpi_1_dfm))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_8_lpi_1_dfm))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_7_lpi_1_dfm_1))
          , C1_1_1_dfmergedata_lpi_1}, planet_meteor_collision_planet_meteor_collision_return_6_lpi_1_dfm_1);
      ship_meteor_collision_if_if_asn_10_itm <= player1_height_sg1_sva;
      ship_meteor_collision_if_if_asn_9_itm <= player1_height_sg3_1_sva;
      reg_ship_meteor_collision_if_land_1_lpi_1_dfm_cse <= ~(z_out_30_sg1 | (({(z_out_31[8])
          , (z_out_31[6:3]) , (z_out_31[1])}) != ({player1_x_sg6_sva , (conv_u2u_1_2(player1_x_sg4_sva)
          + conv_u2u_1_2(player1_width_sg3_sva)) , (conv_u2u_1_2(player1_x_sg2_sva)
          + conv_u2u_1_2(player1_width_sg1_sva)) , player1_x_1_sva})) | (z_out_31[12])
          | (z_out_31[11]) | (z_out_31[10]) | (z_out_31[9]) | (z_out_31[7]) | (z_out_31[2]));
      ship_meteor_collision_else_if_slc_2_itm_sg1 <= ship_meteor_collision_else_if_acc_11_sg1;
      reg_ship_meteor_collision_else_land_1_lpi_1_dfm_cse <= ~(z_out_30_sg1 | (({(z_out_3[7:2])
          , (z_out_3[0])}) != ({(ship_meteor_collision_else_if_acc_9_sg1[5:0]) ,
          player1_x_1_sva})) | (ship_meteor_collision_else_if_acc_9_sg1[6]) | (z_out_3[1])
          | (z_out_3[11]) | (z_out_3[10]) | (z_out_3[9]) | (z_out_3[8]));
      ship_meteor_collision_asn_4_itm <= player1_player_sva;
      ship_meteor_collision_3_else_if_asn_8_itm <= player2_height_sg1_sva;
      ship_meteor_collision_3_else_if_asn_7_itm <= player2_height_sg3_1_sva;
      ship_meteor_collision_3_else_if_slc_2_itm_sg1 <= readslicef_13_11_2((conv_u2u_12_13({blueobjecty_1_sva
          , 1'b1}) + conv_u2u_12_13({(~ ameteor_y_lpi_1_dfm_16) , 1'b1})));
      reg_ship_meteor_collision_3_else_land_1_lpi_1_dfm_cse <= ~(z_out_29_sg1 | (({(z_out_3[10:2])
          , (z_out_3[0])}) != ({(z_out_37[9:1]) , player2_x_1_sva})) | (z_out_37[10])
          | (z_out_3[1]) | (z_out_3[11]));
      else_else_1_else_else_else_else_and_svs <= else_else_1_else_else_else_else_and_tmp;
      ameteor_direction_sg2_lpi_1_dfm_16 <= ameteor_direction_sg2_lpi_1_dfm_16_mx0;
      ameteor_direction_sg1_lpi_1_dfm_16 <= ameteor_direction_sg1_lpi_1_dfm_16_mx0;
      ameteor_direction_1_lpi_1_dfm_16 <= ameteor_direction_1_lpi_1_dfm_16_mx0;
      else_else_1_else_else_else_and_svs <= else_else_1_else_else_else_and_tmp;
      else_else_1_else_else_and_svs <= else_else_1_else_else_and_tmp;
      else_else_1_else_and_svs <= else_else_1_else_and_tmp;
      else_else_1_and_svs <= else_else_1_and_tmp;
      else_nor_svs <= else_nor_tmp;
      and_6_m1c <= and_6_m1c_1;
      and_9_itm <= (~ planet_meteor_collision_planet_meteor_collision_return_lpi_1_dfm_1)
          & and_6_m1c_1;
      else_else_1_else_else_else_and_6_m1c <= else_else_1_else_else_else_else_and_tmp
          & (~ else_else_1_else_else_else_and_tmp) & else_else_1_else_nor_2_m1c_1;
      else_else_1_else_nor_2_m1c <= else_else_1_else_nor_2_m1c_1;
      else_and_3_m1c <= else_else_1_and_tmp & (~ else_nor_tmp) & (~ io_read_restart_rsc_d_svs);
      reg_p1planets_1_sva_tmp <= MUX_v_6_2_2({reg_p1planets_1_sva_tmp , (p1planets_rsc_mgc_in_wire_d[7:2])},
          fsm_output[0]);
      reg_planet_meteor_collision_14_if_else_acc_sdt_sva_tmp_1 <= z_out_3[10:0];
      reg_planet_meteor_collision_14_if_else_if_acc_sdt_sva_1_tmp <= z_out_36[4:2];
      reg_planet_meteor_collision_14_if_else_if_acc_sdt_sva_1_tmp_2 <= z_out_36[0];
    end
  end
  assign mux_346_nl = MUX_s_1_2_2({(z_out_40[1]) , (else_else_else_else_if_acc_3_psp_sva[0])},
      fsm_output[2]);
  assign mux_333_nl = MUX_s_1_2_2({(z_out_40[2]) , (else_else_else_else_if_acc_3_psp_sva[1])},
      fsm_output[2]);
  assign nl_z_out = conv_u2u_1_2(mux_346_nl) + conv_u2u_1_2(mux_333_nl);
  assign z_out = nl_z_out[1:0];
  assign nl_z_out_1 = conv_u2u_1_2(z_out_22_sg1[0]) + conv_u2u_1_2(z_out_22_sg1[1]);
  assign z_out_1 = nl_z_out_1[1:0];
  always @(z_out_31 or fsm_output or z_out_26 or planet5_x_1_sva or planet7_x_1_sva
      or planet_meteor_collision_7_if_if_if_asn_2_itm)
  begin : b0_line_24
    reg[0:0] mux1h_181_nl;
    reg[0:0] mux1h_131_nl;
    reg[0:0] mux1h_180_nl;
    reg[0:0] mux1h_130_nl;
    mux1h_181_nl = MUX1HOT_s_1_3_2({(z_out_31[1]) , (z_out_31[1]) , (z_out_31[1])},
        {(fsm_output[1]) , (fsm_output[2]) , (fsm_output[3])});
    mux1h_131_nl = MUX1HOT_s_1_3_2({planet5_x_1_sva , planet7_x_1_sva , planet_meteor_collision_7_if_if_if_asn_2_itm},
        {(fsm_output[1]) , (fsm_output[2]) , (fsm_output[3])});
    mux1h_180_nl = MUX1HOT_s_1_3_2({(z_out_31[5]) , (z_out_31[5]) , (z_out_31[5])},
        {(fsm_output[1]) , (fsm_output[2]) , (fsm_output[3])});
    mux1h_130_nl = MUX1HOT_s_1_3_2({(z_out_31[7]) , (z_out_31[7]) , (z_out_31[7])},
        {(fsm_output[1]) , (fsm_output[2]) , (fsm_output[3])});
    xeq = ~(((mux1h_181_nl) ^ (mux1h_131_nl)) | ((mux1h_180_nl) ^ (z_out_26[0]))
        | ((mux1h_130_nl) ^ (z_out_26[2])));
  end

  always @(z_out_31 or fsm_output or z_out_27 or planet6_x_1_sva or planet4_x_1_sva)
  begin : b0_line_24_1
    reg[0:0] mux_335_nl;
    reg[0:0] mux_314_nl;
    reg[0:0] mux_334_nl;
    reg[0:0] mux_313_nl;
    mux_335_nl = MUX_s_1_2_2({(z_out_31[1]) , (z_out_31[1])}, fsm_output[2]);
    mux_314_nl = MUX_s_1_2_2({planet4_x_1_sva , planet6_x_1_sva}, fsm_output[2]);
    mux_334_nl = MUX_s_1_2_2({(z_out_31[5]) , (z_out_31[5])}, fsm_output[2]);
    mux_313_nl = MUX_s_1_2_2({(z_out_31[7]) , (z_out_31[7])}, fsm_output[2]);
    xeq_1 = ~(((mux_335_nl) ^ (mux_314_nl)) | ((mux_334_nl) ^ (z_out_27[0])) | ((mux_313_nl)
        ^ (z_out_27[2])));
  end

  always @(z_out_3 or planet5_x_sg2_1_sva or planet7_x_sg2_1_sva or planet_meteor_collision_7_if_if_if_asn_itm
      or fsm_output or planet5_x_1_sva or planet7_x_1_sva or planet_meteor_collision_7_if_if_if_asn_2_itm)
  begin : b0_line_24_2
    reg[0:0] mux1h_182_nl;
    reg[0:0] mux1h_133_nl;
    mux1h_182_nl = MUX1HOT_s_1_3_2({planet5_x_1_sva , planet7_x_1_sva , planet_meteor_collision_7_if_if_if_asn_2_itm},
        {(fsm_output[1]) , (fsm_output[2]) , (fsm_output[3])});
    mux1h_133_nl = MUX1HOT_s_1_3_2({planet5_x_sg2_1_sva , planet7_x_sg2_1_sva , planet_meteor_collision_7_if_if_if_asn_itm},
        {(fsm_output[1]) , (fsm_output[2]) , (fsm_output[3])});
    xeq_2 = ~(((z_out_3[0]) ^ (mux1h_182_nl)) | ((z_out_3[4]) ^ (mux1h_133_nl)));
  end

  always @(z_out_3 or planet6_x_sg2_1_sva or planet4_x_sg2_1_sva or fsm_output or
      planet6_x_1_sva or planet4_x_1_sva)
  begin : b0_line_24_3
    reg[0:0] mux_336_nl;
    reg[0:0] mux_316_nl;
    mux_336_nl = MUX_s_1_2_2({planet4_x_1_sva , planet6_x_1_sva}, fsm_output[2]);
    mux_316_nl = MUX_s_1_2_2({planet4_x_sg2_1_sva , planet6_x_sg2_1_sva}, fsm_output[2]);
    xeq_3 = ~(((z_out_3[0]) ^ (mux_336_nl)) | ((z_out_3[4]) ^ (mux_316_nl)));
  end

  assign mux_317_nl = MUX_v_11_2_2({ameteor_y_lpi_1_dfm_16 , ({1'b1 , player2_x_sg4_sva
      , 3'b0 , player2_x_sg2_sva , 5'b1})}, fsm_output[7]);
  assign nl_z_out_37 = (mux_317_nl) + ({(fsm_output[8]) , 6'b111111 , ((~ player2_width_sg3_sva)
      | (fsm_output[8])) , 1'b1 , ((~ player2_width_sg1_sva) | (fsm_output[8])) ,
      1'b1});
  assign z_out_37 = nl_z_out_37[10:0];
  assign mux1h_134_nl = MUX1HOT_v_11_3_2({ameteor_x_lpi_1_dfm_16 , meteorpx_rsc_mgc_in_wire_d
      , meteorpx_1_sva}, {((fsm_output[8]) | (fsm_output[7])) , (fsm_output[0]) ,
      or_tmp_177});
  assign mux1h_135_nl = MUX1HOT_v_2_4_2({2'b1 , ({{1{ameteor_radius_2_sva}}, ameteor_radius_2_sva})
      , ({{1{ameteor_radius_2_sva}}, ameteor_radius_2_sva}) , ({{1{ameteor_radius_2_sva}},
      ameteor_radius_2_sva})}, {(fsm_output[8]) , (fsm_output[0]) , or_tmp_177 ,
      (fsm_output[7])});
  assign z_out_3 = {1'b0, conv_u2u_11_12(mux1h_134_nl) + conv_u2u_4_12(signext_4_2(mux1h_135_nl))};
  assign mux1h_184_cse = MUX1HOT_s_1_7_2({planet24_y_2_sva , (~ planet3_y_2_sva)
      , (~ planet4_y_2_sva) , (~ planet6_y_2_sva) , (~ planet22_y_2_sva) , (~ planet26_y_2_sva)
      , planet28_y_2_sva}, {(fsm_output[4]) , (fsm_output[0]) , (fsm_output[1]) ,
      (fsm_output[2]) , (fsm_output[3]) , (fsm_output[5]) , (fsm_output[6])});
  assign mux1h_183_nl = MUX1HOT_v_11_3_2({meteorpy_rsc_mgc_in_wire_d , meteorpy_1_sva
      , (~ meteorpy_1_sva)}, {(~(or_1022_tmp | or_1038_cse)) , (or_1022_tmp & (~
      or_1038_cse)) , or_1038_cse});
  assign mux1h_137_nl = MUX1HOT_v_4_6_2({({2'b0 , ({{1{planet24_y_sg2_1_sva}}, planet24_y_sg2_1_sva})})
      , ({({{2{planet3_y_sg2_sva}}, planet3_y_sg2_sva}) , 1'b0}) , ({(signext_2_1(z_out_33[2]))
      , 1'b0 , (z_out_33[0])}) , z_out_34 , ({{3{planet22_y_sg2_sva}}, planet22_y_sg2_sva})
      , ({1'b0 , ({{2{planet28_y_sg2_1_sva}}, planet28_y_sg2_1_sva})})}, {(fsm_output[4])
      , (fsm_output[0]) , (fsm_output[1]) , ((fsm_output[2]) | (fsm_output[5])) ,
      (fsm_output[3]) , (fsm_output[6])});
  assign nl_z_out_4 = conv_u2u_11_13(mux1h_183_nl) + conv_s2u_11_13({(mux1h_137_nl)
      , 1'b0 , mux1h_184_cse , mux1h_184_cse , mux1h_184_cse , mux1h_184_cse , mux1h_184_cse
      , mux1h_184_cse});
  assign z_out_4 = nl_z_out_4[12:0];
  assign mux1h_139_nl = MUX1HOT_s_1_3_2({planet6_y_sg4_sva , planet26_y_sg4_sva ,
      planet27_y_sg2_1_sva}, {(fsm_output[2]) , (fsm_output[5]) , (fsm_output[6])});
  assign mux_337_nl = MUX_s_1_2_2({planet4_y_sg2_1_sva , planet27_y_sg2_1_sva}, fsm_output[6]);
  assign mux1h_190_nl = MUX1HOT_s_1_4_2({planet4_y_sg2_1_sva , planet6_y_sg2_sva
      , planet22_y_asn_3_itm , planet26_y_sg2_sva}, {(fsm_output[1]) , (fsm_output[2])
      , (fsm_output[4]) , (fsm_output[5])});
  assign mux1h_191_nl = MUX1HOT_s_1_5_2({planet4_y_2_sva , planet6_y_2_sva , planet22_y_asn_4_itm
      , planet26_y_2_sva , planet27_y_2_sva}, {(fsm_output[1]) , (fsm_output[2])
      , (fsm_output[4]) , (fsm_output[5]) , (fsm_output[6])});
  assign nl_z_out_38 = conv_u2u_11_12(~ meteorpy_1_sva) + conv_u2u_10_12({((mux1h_139_nl)
      & (~((fsm_output[1]) | (fsm_output[4])))) , ((mux_337_nl) & (~((fsm_output[2])
      | (fsm_output[4]) | (fsm_output[5])))) , ((mux1h_190_nl) & (~ (fsm_output[6])))
      , 1'b0 , (signext_6_1(mux1h_191_nl))});
  assign z_out_38 = nl_z_out_38[11:0];
  assign mux_319_nl = MUX_s_1_2_2({planet3_y_asn_5_itm , planet23_y_sg2_sva}, fsm_output[4]);
  assign mux_338_nl = MUX_s_1_2_2({planet3_y_asn_6_itm , planet23_y_2_sva}, fsm_output[4]);
  assign nl_z_out_39 = conv_u2u_11_12(~ meteorpy_1_sva) + conv_u2u_9_12({(mux_319_nl)
      , 2'b0 , (signext_6_1(mux_338_nl))});
  assign z_out_39 = nl_z_out_39[11:0];
  assign or_1026_cse = (fsm_output[3]) | (fsm_output[6]);
  assign mux1h_193_cse = MUX1HOT_s_1_7_2({(~ planet2_y_2_sva) , planet5_y_2_sva ,
      (~ planet7_y_2_sva) , (~ planet8_y_2_sva) , (~ planet24_y_2_sva) , planet25_y_2_sva
      , (~ planet28_y_2_sva)}, {(fsm_output[0]) , (fsm_output[1]) , (fsm_output[2])
      , (fsm_output[3]) , (fsm_output[4]) , (fsm_output[5]) , (fsm_output[6])});
  assign nor_161_cse = ~((fsm_output[1]) | (fsm_output[5]));
  assign mux1h_220_nl = MUX1HOT_v_11_3_2({meteorpy_rsc_mgc_in_wire_d , meteorpy_1_sva
      , (~ meteorpy_1_sva)}, {(~(or_1023_tmp | or_dcpl_707)) , (or_1023_tmp & (~
      or_dcpl_707)) , or_dcpl_707});
  assign mux1h_141_nl = MUX1HOT_s_1_4_2({planet2_y_sg2_sva , (z_out_33[2]) , (z_out_34[3])
      , (z_out_33[2])}, {(fsm_output[0]) , (fsm_output[2]) , or_1026_cse , (fsm_output[4])});
  assign mux1h_221_nl = MUX1HOT_s_1_4_2({planet2_y_sg2_sva , planet5_y_sg2_sva ,
      (z_out_33[2]) , planet25_y_sg2_sva}, {(fsm_output[0]) , (fsm_output[1]) , (fsm_output[4])
      , (fsm_output[5])});
  assign mux_339_nl = MUX_s_1_2_2({planet2_y_sg2_sva , (z_out_33[0])}, fsm_output[2]);
  assign mux1h_192_nl = MUX1HOT_s_1_3_2({planet2_y_sg2_sva , (z_out_34[0]) , (z_out_33[0])},
      {(fsm_output[0]) , or_1026_cse , (fsm_output[4])});
  assign nl_z_out_7 = conv_u2u_11_13(mux1h_220_nl) + conv_s2u_11_13({((mux1h_141_nl)
      & nor_161_cse) , ((mux1h_221_nl) & (~((fsm_output[2]) | (fsm_output[3]) | (fsm_output[6]))))
      , ((mux_339_nl) & (~((fsm_output[1]) | (fsm_output[3]) | (fsm_output[4]) |
      (fsm_output[5]) | (fsm_output[6])))) , ((mux1h_192_nl) & (~((fsm_output[1])
      | (fsm_output[2]) | (fsm_output[5])))) , 1'b0 , mux1h_193_cse , mux1h_193_cse
      , mux1h_193_cse , mux1h_193_cse , mux1h_193_cse , mux1h_193_cse});
  assign z_out_7 = nl_z_out_7[12:0];
  assign mux1h_201_cse = MUX1HOT_s_1_6_2({(~ planet5_y_2_sva) , planet7_y_2_sva ,
      planet8_y_2_sva , (~ planet23_y_2_sva) , (~ planet25_y_2_sva) , (~ planet27_y_2_sva)},
      {(fsm_output[1]) , (fsm_output[2]) , (fsm_output[3]) , (fsm_output[4]) , (fsm_output[5])
      , (fsm_output[6])});
  assign mux_353_nl = MUX_v_11_2_2({meteorpy_1_sva , (~ meteorpy_1_sva)}, or_1044_cse);
  assign mux1h_143_nl = MUX1HOT_s_1_4_2({planet5_y_sg2_sva , planet23_y_sg2_sva ,
      planet25_y_sg2_sva , (z_out_33[2])}, {(fsm_output[1]) , (fsm_output[4]) , (fsm_output[5])
      , (fsm_output[6])});
  assign mux1h_199_nl = MUX1HOT_s_1_5_2({planet5_y_sg2_sva , planet7_y_sg2_1_sva
      , planet8_y_sg2_1_sva , planet23_y_sg2_sva , planet25_y_sg2_sva}, {(fsm_output[1])
      , (fsm_output[2]) , (fsm_output[3]) , (fsm_output[4]) , (fsm_output[5])});
  assign mux1h_200_nl = MUX1HOT_s_1_4_2({planet7_y_sg2_1_sva , planet8_y_sg2_1_sva
      , planet23_y_sg2_sva , (z_out_33[0])}, {(fsm_output[2]) , (fsm_output[3]) ,
      (fsm_output[4]) , (fsm_output[6])});
  assign nl_z_out_8 = conv_u2u_11_13(mux_353_nl) + conv_s2u_11_13({((mux1h_143_nl)
      & (~((fsm_output[2]) | (fsm_output[3])))) , ((mux1h_199_nl) & (~ (fsm_output[6])))
      , ((mux1h_200_nl) & nor_161_cse) , (planet8_y_sg2_1_sva & (~((fsm_output[1])
      | (fsm_output[2]) | (fsm_output[4]) | (fsm_output[5]) | (fsm_output[6]))))
      , 1'b0 , mux1h_201_cse , mux1h_201_cse , mux1h_201_cse , mux1h_201_cse , mux1h_201_cse
      , mux1h_201_cse});
  assign z_out_8 = nl_z_out_8[12:0];
  assign mux1h_218_nl = MUX1HOT_v_12_3_2({planet_meteor_collision_4_if_if_if_acc_7_itm
      , (z_out_7[11:0]) , z_out_38}, {(~(or_dcpl_707 | or_1038_cse)) , or_dcpl_707
      , or_1038_cse});
  assign z_out_9_sg1 = readslicef_12_1_11(((mux1h_218_nl) + 12'b100001000001));
  assign mux1h_219_nl = MUX1HOT_v_12_5_2({(conv_u2u_11_12(~ meteorpy_rsc_mgc_in_wire_d)
      + conv_u2u_8_12({planet2_y_sg2_sva , 1'b0 , ({{5{planet2_y_2_sva}}, planet2_y_2_sva})}))
      , z_out_39 , (z_out_4[11:0]) , z_out_38 , (z_out_8[11:0])}, {((fsm_output[0])
      & nor_157_m1c) , ((fsm_output[4]) & nor_157_m1c) , ((fsm_output[6]) & nor_157_m1c)
      , or_dcpl_707 , or_1044_cse});
  assign z_out_10_sg1 = readslicef_12_1_11(((mux1h_219_nl) + 12'b100001000001));
  assign mux1h_146_nl = MUX1HOT_v_12_3_2({z_out_39 , z_out_38 , planet_meteor_collision_11_if_else_if_acc_5_itm},
      {(fsm_output[1]) , (fsm_output[2]) , (fsm_output[5])});
  assign z_out_11_sg1 = readslicef_12_1_11(((mux1h_146_nl) + 12'b100001000001));
  assign mux1h_147_nl = MUX1HOT_s_1_3_2({(~ (random_rsc_mgc_in_wire_d[2])) , (~ (random_1_sva[2]))
      , (~ (random_1_sva[3]))}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_148_nl = MUX1HOT_s_1_3_2({(random_rsc_mgc_in_wire_d[3]) , (random_1_sva[3])
      , (random_1_sva[4])}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_207_nl = MUX1HOT_s_1_3_2({(~ (random_rsc_mgc_in_wire_d[12])) , (~
      (random_1_sva[12])) , (~ (random_1_sva[11]))}, {(fsm_output[0]) , or_1037_cse
      , (fsm_output[8])});
  assign z_out_12_sg1 = readslicef_3_2_1((conv_u2u_2_3({(mux1h_147_nl) , 1'b1}) +
      conv_u2u_2_3({(mux1h_148_nl) , (mux1h_207_nl)})));
  assign mux1h_149_nl = MUX1HOT_s_1_3_2({(~ (random_rsc_mgc_in_wire_d[4])) , (~ (random_1_sva[4]))
      , (~ (random_1_sva[5]))}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_150_nl = MUX1HOT_s_1_3_2({(random_rsc_mgc_in_wire_d[5]) , (random_1_sva[5])
      , (random_1_sva[6])}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_208_nl = MUX1HOT_s_1_3_2({(random_rsc_mgc_in_wire_d[11]) , (random_1_sva[11])
      , (random_1_sva[10])}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign z_out_13_sg1 = readslicef_3_2_1((conv_u2u_2_3({(mux1h_149_nl) , 1'b1}) +
      conv_u2u_2_3({(mux1h_150_nl) , (mux1h_208_nl)})));
  assign mux1h_153_nl = MUX1HOT_s_1_3_2({(~ (random_rsc_mgc_in_wire_d[8])) , (~ (random_1_sva[8]))
      , (~ (random_1_sva[7]))}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_154_nl = MUX1HOT_s_1_3_2({(random_rsc_mgc_in_wire_d[9]) , (random_1_sva[9])
      , (random_1_sva[8])}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign z_out_15_sg1 = readslicef_3_2_1((conv_u2u_2_3({(mux1h_153_nl) , 1'b1}) +
      conv_u2u_2_3({(mux1h_154_nl) , ((~ (random_1_sva[9])) | (fsm_output[0]) | or_1037_cse)})));
  assign mux_340_nl = MUX_s_1_2_2({(z_out_25[2]) , (z_out_25[2])}, fsm_output[8]);
  assign mux1h_156_nl = MUX1HOT_s_1_3_2({(~ (z_out_25[3])) , (~ (z_out_25[3])) ,
      (~ (z_out_25[3]))}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign z_out_16_sg1 = readslicef_3_2_1((conv_u2u_2_3({(mux_340_nl) , 1'b1}) + conv_u2u_2_3({(mux1h_156_nl)
      , 1'b1})));
  assign mux1h_157_nl = MUX1HOT_v_2_4_2({z_out_12_sg1 , (readslicef_3_2_1((conv_u2u_2_3({(else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[2])
      , 1'b1}) + conv_u2u_2_3({(~ (else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[3]))
      , 1'b1})))) , ({1'b1 , (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva[0])})
      , z_out_13_sg1}, {(fsm_output[0]) , (fsm_output[6]) , (fsm_output[7]) , (fsm_output[8])});
  assign mux_341_nl = MUX_s_1_2_2({(z_out_13_sg1[1]) , (z_out_15_sg1[1])}, fsm_output[8]);
  assign mux1h_158_nl = MUX1HOT_s_1_4_2({(z_out_13_sg1[0]) , (~ (else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[1]))
      , (~ (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva[1]))
      , (z_out_15_sg1[0])}, {(fsm_output[0]) , (fsm_output[6]) , (fsm_output[7])
      , (fsm_output[8])});
  assign mux1h_210_nl = MUX1HOT_s_1_4_2({(~ (random_rsc_mgc_in_wire_d[14])) , (~
      (else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[4]))
      , (~ (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva[2]))
      , (~ (random_1_sva[13]))}, {(fsm_output[0]) , (fsm_output[6]) , (fsm_output[7])
      , (fsm_output[8])});
  assign z_out_17_sg1 = readslicef_4_3_1((conv_u2u_3_4({(mux1h_157_nl) , 1'b1}) +
      conv_u2u_3_4({((mux_341_nl) & (~((fsm_output[6]) | (fsm_output[7])))) , (mux1h_158_nl)
      , (mux1h_210_nl)})));
  assign mux1h_151_nl = MUX1HOT_s_1_3_2({(~ (random_rsc_mgc_in_wire_d[6])) , (~ (random_1_sva[6]))
      , (~ (random_1_sva[1]))}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_152_nl = MUX1HOT_s_1_3_2({(random_rsc_mgc_in_wire_d[7]) , (random_1_sva[7])
      , (random_1_sva[2])}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_209_nl = MUX1HOT_s_1_3_2({(~ (random_rsc_mgc_in_wire_d[10])) , (~
      (random_1_sva[10])) , (random_1_sva[12])}, {(fsm_output[0]) , or_1037_cse ,
      (fsm_output[8])});
  assign mux_355_nl = MUX_v_2_2_2({z_out_12_sg1 , z_out_15_sg1}, or_dcpl_716);
  assign mux1h_211_nl = MUX1HOT_s_1_3_2({(random_rsc_mgc_in_wire_d[13]) , (random_1_sva[13])
      , (random_1_sva[14])}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign z_out_18_sg1 = readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(mux1h_151_nl)
      , 1'b1}) + conv_u2u_2_3({(mux1h_152_nl) , (mux1h_209_nl)})))) , 1'b1}) + conv_u2u_3_4({(mux_355_nl)
      , (mux1h_211_nl)})));
  assign mux1h_161_nl = MUX1HOT_s_1_3_2({(z_out_41[0]) , (else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva[0])
      , (z_out_28[1])}, {((fsm_output[0]) | (fsm_output[1]) | (fsm_output[6])) ,
      (fsm_output[4]) , (fsm_output[8])});
  assign mux_356_nl = MUX_s_1_2_2({(z_out_41[1]) , (else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva[1])},
      fsm_output[4]);
  assign mux_347_nl = MUX_s_1_2_2({(z_out_41[2]) , (else_else_else_else_else_else_else_else_else_if_acc_2_psp_sva[2])},
      fsm_output[4]);
  assign nl_z_out_40 = ({((~ (fsm_output[8])) | (fsm_output[0]) | (fsm_output[1])
      | (fsm_output[4]) | (fsm_output[6])) , (mux1h_161_nl) , ((z_out_28[0]) | (fsm_output[0])
      | (fsm_output[1]) | (fsm_output[4]) | (fsm_output[6]))}) + conv_u2u_2_3({(~((mux_356_nl)
      & (~ (fsm_output[8])))) , (~((mux_347_nl) & (~ (fsm_output[8]))))});
  assign z_out_40 = nl_z_out_40[2:0];
  assign mux1h_163_nl = MUX1HOT_v_3_3_2({z_out_21_sg1 , else_else_if_slc_8_itm ,
      z_out_17_sg1}, {(fsm_output[0]) , (fsm_output[1]) , (fsm_output[6])});
  assign mux1h_164_nl = MUX1HOT_s_1_3_2({(z_out_25[0]) , (else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[0])
      , (else_else_else_else_else_else_else_else_else_else_else_else_else_else_if_acc_1_psp_sva[0])},
      {(fsm_output[0]) , (fsm_output[1]) , (fsm_output[6])});
  assign nl_z_out_41 = (mux1h_163_nl) + ({2'b10 , (mux1h_164_nl)});
  assign z_out_41 = nl_z_out_41[2:0];
  assign mux1h_166_nl = MUX1HOT_s_1_3_2({(~ (z_out_25[1])) , (~ (z_out_25[1])) ,
      (~ (z_out_25[1]))}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_213_nl = MUX1HOT_s_1_3_2({(~ (z_out_25[4])) , (~ (z_out_25[4])) ,
      (~ (z_out_25[4]))}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign z_out_21_sg1 = readslicef_4_3_1((conv_u2u_3_4({z_out_16_sg1 , 1'b1}) + conv_u2u_2_4({(mux1h_166_nl)
      , (mux1h_213_nl)})));
  assign mux_321_nl = MUX_s_1_2_2({(~ (z_out_42[1])) , (~ (z_out_42[1]))}, fsm_output[8]);
  assign mux_342_nl = MUX_s_1_2_2({(~ (z_out_42[2])) , (~ (z_out_42[2]))}, fsm_output[8]);
  assign z_out_22_sg1 = readslicef_3_2_1((({1'b1 , (z_out_42[0]) , 1'b1}) + conv_u2u_2_3({(mux_321_nl)
      , (mux_342_nl)})));
  assign mux_323_nl = MUX_s_1_2_2({(z_out_25[0]) , (z_out_25[0])}, fsm_output[8]);
  assign nl_z_out_42 = z_out_21_sg1 + ({2'b10 , (mux_323_nl)});
  assign z_out_42 = nl_z_out_42[2:0];
  assign mux1h_167_nl = MUX1HOT_v_3_3_2({z_out_17_sg1 , else_else_else_if_acc_24_itm_sg1
      , z_out_18_sg1}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux_357_nl = MUX_v_3_2_2({z_out_17_sg1 , z_out_18_sg1}, or_dcpl_716);
  assign mux1h_214_nl = MUX1HOT_s_1_3_2({(random_rsc_mgc_in_wire_d[15]) , (random_1_sva[15])
      , (~ (random_1_sva[15]))}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign mux1h_170_nl = MUX1HOT_s_1_3_2({(random_rsc_mgc_in_wire_d[1]) , (random_1_sva[1])
      , (random_1_sva[0])}, {(fsm_output[0]) , or_1037_cse , (fsm_output[8])});
  assign nl_z_out_25 = conv_u2u_4_5(readslicef_5_4_1((conv_u2u_4_5({(mux1h_167_nl)
      , 1'b1}) + conv_u2u_4_5({(mux_357_nl) , (mux1h_214_nl)})))) + conv_s2u_4_5({3'b100
      , (mux1h_170_nl)});
  assign z_out_25 = nl_z_out_25[4:0];
  assign mux1h_171_nl = MUX1HOT_s_1_4_2({planet3_x_sg2_1_sva , planet5_x_sg2_1_sva
      , planet7_x_sg2_1_sva , planet_meteor_collision_7_if_if_if_asn_itm}, {(fsm_output[0])
      , (fsm_output[1]) , (fsm_output[2]) , (fsm_output[3])});
  assign nl_z_out_26 = conv_u2u_2_3(signext_2_1(mux1h_171_nl)) + 3'b1;
  assign z_out_26 = nl_z_out_26[2:0];
  assign mux1h_172_nl = MUX1HOT_s_1_3_2({planet2_x_sg2_1_sva , planet4_x_sg2_1_sva
      , planet6_x_sg2_1_sva}, {(fsm_output[0]) , (fsm_output[1]) , (fsm_output[2])});
  assign nl_z_out_27 = conv_u2u_2_3(signext_2_1(mux1h_172_nl)) + 3'b1;
  assign z_out_27 = nl_z_out_27[2:0];
  assign mux_324_nl = MUX_v_2_2_2({({{1{planet1_x_sg2_1_sva}}, planet1_x_sg2_1_sva})
      , z_out_22_sg1}, fsm_output[8]);
  assign nl_z_out_28 = conv_u2u_2_3(mux_324_nl) + conv_s2u_2_3({((z_out_22_sg1[1])
      & (fsm_output[8])) , ((z_out_22_sg1[1]) | (~ (fsm_output[8])))});
  assign z_out_28 = nl_z_out_28[2:0];
  assign mux_326_nl = MUX_v_11_2_2({ship_meteor_collision_3_else_if_slc_2_itm_sg1
      , (readslicef_13_11_2((conv_u2u_12_13({ameteor_y_lpi_1_dfm_16 , 1'b1}) + conv_u2u_12_13({(~
      blueobjecty_1_sva) , 1'b1}))))}, fsm_output[7]);
  assign mux_327_nl = MUX_s_1_2_2({ship_meteor_collision_3_else_if_asn_7_itm , player2_height_sg3_1_sva},
      fsm_output[7]);
  assign mux_343_nl = MUX_s_1_2_2({ship_meteor_collision_3_else_if_asn_8_itm , player2_height_sg1_sva},
      fsm_output[7]);
  assign z_out_29_sg1 = readslicef_12_1_11((conv_u2u_11_12(mux_326_nl) + conv_s2u_11_12({6'b100000
      , (signext_2_1(mux_327_nl)) , 2'b0 , (mux_343_nl)})));
  assign mux_328_nl = MUX_v_11_2_2({ship_meteor_collision_else_if_acc_11_sg1 , (readslicef_13_11_2((conv_u2u_12_13({ameteor_y_lpi_1_dfm_16
      , 1'b1}) + conv_u2u_12_13({(~ redobjecty_1_sva) , 1'b1}))))}, fsm_output[7]);
  assign mux_329_nl = MUX_s_1_2_2({ship_meteor_collision_if_if_asn_9_itm , player1_height_sg3_1_sva},
      fsm_output[7]);
  assign mux_344_nl = MUX_s_1_2_2({ship_meteor_collision_if_if_asn_10_itm , player1_height_sg1_sva},
      fsm_output[7]);
  assign z_out_30_sg1 = readslicef_12_1_11((conv_u2u_11_12(mux_328_nl) + conv_s2u_11_12({6'b100000
      , (signext_2_1(mux_329_nl)) , 2'b0 , (mux_344_nl)})));
  assign mux1h_173_nl = MUX1HOT_v_11_4_2({meteorpx_rsc_mgc_in_wire_d , meteorpx_1_sva
      , ameteor_x_lpi_1_dfm_16 , ameteor_y_lpi_1_dfm_16}, {(fsm_output[0]) , or_tmp_189
      , (fsm_output[7]) , (fsm_output[8])});
  assign mux1h_174_nl = MUX1HOT_s_1_4_2({(~ ameteor_radius_2_sva) , (~ ameteor_radius_2_sva)
      , (~ ameteor_radius_2_sva) , (~ ameteor_radius_2_sva)}, {(fsm_output[0]) ,
      or_tmp_189 , (fsm_output[7]) , (fsm_output[8])});
  assign nl_z_out_31 = ({1'b1 , (mux1h_173_nl) , 1'b1}) + conv_u2u_12_13({7'b1111111
      , (signext_4_1(mux1h_174_nl)) , 1'b1});
  assign z_out_31 = nl_z_out_31[12:0];
  assign mux_330_nl = MUX_s_1_2_2({planet1_y_2_sva , planet21_y_2_sva}, fsm_output[3]);
  assign mux_331_nl = MUX_v_11_2_2({(~ meteorpy_rsc_mgc_in_wire_d) , (~ meteorpy_1_sva)},
      fsm_output[3]);
  assign z_out_32_sg1 = readslicef_13_1_12((({6'b100001 , (signext_6_1(mux_330_nl))
      , 1'b1}) + conv_u2u_12_13({(mux_331_nl) , 1'b1})));
  assign mux1h_175_nl = MUX1HOT_s_1_4_2({(~ planet4_y_sg2_1_sva) , (~ planet7_y_sg2_1_sva)
      , (~ planet24_y_sg2_1_sva) , (~ planet27_y_sg2_1_sva)}, {(fsm_output[1]) ,
      (fsm_output[2]) , (fsm_output[4]) , (fsm_output[6])});
  assign nl_z_out_33 = ({1'b1 , (signext_2_1(mux1h_175_nl))}) + 3'b1;
  assign z_out_33 = nl_z_out_33[2:0];
  assign mux1h_176_nl = MUX1HOT_s_1_4_2({(~ planet6_y_sg4_sva) , (~ planet8_y_sg2_1_sva)
      , (~ planet26_y_sg4_sva) , (~ planet28_y_sg2_1_sva)}, {(fsm_output[2]) , (fsm_output[3])
      , (fsm_output[5]) , (fsm_output[6])});
  assign mux_345_nl = MUX_s_1_2_2({(~ planet8_y_sg2_1_sva) , (~ planet28_y_sg2_1_sva)},
      fsm_output[6]);
  assign mux1h_215_nl = MUX1HOT_s_1_4_2({(~ planet6_y_sg2_sva) , (~ planet8_y_sg2_1_sva)
      , (~ planet26_y_sg2_sva) , (~ planet28_y_sg2_1_sva)}, {(fsm_output[2]) , (fsm_output[3])
      , (fsm_output[5]) , (fsm_output[6])});
  assign nl_z_out_34 = ({1'b1 , (mux1h_176_nl) , ((mux_345_nl) | (fsm_output[2])
      | (fsm_output[5])) , (mux1h_215_nl)}) + 4'b1;
  assign z_out_34 = nl_z_out_34[3:0];
  assign mux1h_177_nl = MUX1HOT_s_1_4_2({planet22_x_sg6_sva , planet24_x_sg6_sva
      , planet26_x_sg6_sva , planet28_x_sg6_sva}, {(fsm_output[3]) , (fsm_output[4])
      , (fsm_output[5]) , (fsm_output[6])});
  assign mux1h_216_nl = MUX1HOT_s_1_4_2({planet22_x_sg4_1_sva , planet24_x_sg4_1_sva
      , planet26_x_sg4_1_sva , planet28_x_sg4_1_sva}, {(fsm_output[3]) , (fsm_output[4])
      , (fsm_output[5]) , (fsm_output[6])});
  assign nl_z_out_35 = conv_u2u_5_6({(mux1h_177_nl) , 2'b0 , (signext_2_1(mux1h_216_nl))})
      + 6'b111111;
  assign z_out_35 = nl_z_out_35[5:0];
  assign mux1h_178_nl = MUX1HOT_s_1_3_2({planet21_x_sg6_sva , planet23_x_sg6_sva
      , planet27_x_sg6_sva}, {(fsm_output[3]) , (fsm_output[4]) , (fsm_output[5])});
  assign mux1h_217_nl = MUX1HOT_s_1_3_2({planet21_x_sg4_1_sva , planet23_x_sg4_1_sva
      , planet27_x_sg4_1_sva}, {(fsm_output[3]) , (fsm_output[4]) , (fsm_output[5])});
  assign nl_z_out_36 = conv_u2u_5_6({(mux1h_178_nl) , 2'b0 , (signext_2_1(mux1h_217_nl))})
      + 6'b111111;
  assign z_out_36 = nl_z_out_36[5:0];

  function [0:0] MUX_s_1_2_2;
    input [1:0] inputs;
    input [0:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[1:1];
      end
      1'b1 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[1:1];
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
  end
  endfunction


  function [4:0] signext_5_4;
    input [3:0] vector;
  begin
    signext_5_4= {{1{vector[3]}}, vector};
  end
  endfunction


  function [0:0] MUX1HOT_s_1_3_2;
    input [2:0] inputs;
    input [2:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_3_2 = result;
  end
  endfunction


  function [2:0] readslicef_4_3_1;
    input [3:0] vector;
    reg [3:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_4_3_1 = tmp[2:0];
  end
  endfunction


  function [3:0] readslicef_5_4_1;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_5_4_1 = tmp[3:0];
  end
  endfunction


  function [6:0] readslicef_8_7_1;
    input [7:0] vector;
    reg [7:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_8_7_1 = tmp[6:0];
  end
  endfunction


  function [10:0] readslicef_13_11_2;
    input [12:0] vector;
    reg [12:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_13_11_2 = tmp[10:0];
  end
  endfunction


  function [10:0] MUX1HOT_v_11_3_2;
    input [32:0] inputs;
    input [2:0] sel;
    reg [10:0] result;
    integer i;
  begin
    result = inputs[0+:11] & {11{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*11+:11] & {11{sel[i]}});
    MUX1HOT_v_11_3_2 = result;
  end
  endfunction


  function [1:0] MUX_v_2_2_2;
    input [3:0] inputs;
    input [0:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[3:2];
      end
      1'b1 : begin
        result = inputs[1:0];
      end
      default : begin
        result = inputs[3:2];
      end
    endcase
    MUX_v_2_2_2 = result;
  end
  endfunction


  function [15:0] MUX_v_16_2_2;
    input [31:0] inputs;
    input [0:0] sel;
    reg [15:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[31:16];
      end
      1'b1 : begin
        result = inputs[15:0];
      end
      default : begin
        result = inputs[31:16];
      end
    endcase
    MUX_v_16_2_2 = result;
  end
  endfunction


  function [10:0] MUX_v_11_2_2;
    input [21:0] inputs;
    input [0:0] sel;
    reg [10:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[21:11];
      end
      1'b1 : begin
        result = inputs[10:0];
      end
      default : begin
        result = inputs[21:11];
      end
    endcase
    MUX_v_11_2_2 = result;
  end
  endfunction


  function [7:0] MUX_v_8_2_2;
    input [15:0] inputs;
    input [0:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[15:8];
      end
      1'b1 : begin
        result = inputs[7:0];
      end
      default : begin
        result = inputs[15:8];
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function [3:0] MUX_v_4_2_2;
    input [7:0] inputs;
    input [0:0] sel;
    reg [3:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[7:4];
      end
      1'b1 : begin
        result = inputs[3:0];
      end
      default : begin
        result = inputs[7:4];
      end
    endcase
    MUX_v_4_2_2 = result;
  end
  endfunction


  function [19:0] MUX_v_20_2_2;
    input [39:0] inputs;
    input [0:0] sel;
    reg [19:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[39:20];
      end
      1'b1 : begin
        result = inputs[19:0];
      end
      default : begin
        result = inputs[39:20];
      end
    endcase
    MUX_v_20_2_2 = result;
  end
  endfunction


  function [10:0] MUX1HOT_v_11_5_2;
    input [54:0] inputs;
    input [4:0] sel;
    reg [10:0] result;
    integer i;
  begin
    result = inputs[0+:11] & {11{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*11+:11] & {11{sel[i]}});
    MUX1HOT_v_11_5_2 = result;
  end
  endfunction


  function [5:0] MUX_v_6_2_2;
    input [11:0] inputs;
    input [0:0] sel;
    reg [5:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[11:6];
      end
      1'b1 : begin
        result = inputs[5:0];
      end
      default : begin
        result = inputs[11:6];
      end
    endcase
    MUX_v_6_2_2 = result;
  end
  endfunction


  function [1:0] MUX1HOT_v_2_4_2;
    input [7:0] inputs;
    input [3:0] sel;
    reg [1:0] result;
    integer i;
  begin
    result = inputs[0+:2] & {2{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*2+:2] & {2{sel[i]}});
    MUX1HOT_v_2_4_2 = result;
  end
  endfunction


  function [3:0] signext_4_2;
    input [1:0] vector;
  begin
    signext_4_2= {{2{vector[1]}}, vector};
  end
  endfunction


  function [0:0] MUX1HOT_s_1_7_2;
    input [6:0] inputs;
    input [6:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 7; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_7_2 = result;
  end
  endfunction


  function [3:0] MUX1HOT_v_4_6_2;
    input [23:0] inputs;
    input [5:0] sel;
    reg [3:0] result;
    integer i;
  begin
    result = inputs[0+:4] & {4{sel[0]}};
    for( i = 1; i < 6; i = i + 1 )
      result = result | (inputs[i*4+:4] & {4{sel[i]}});
    MUX1HOT_v_4_6_2 = result;
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [0:0] MUX1HOT_s_1_4_2;
    input [3:0] inputs;
    input [3:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_4_2 = result;
  end
  endfunction


  function [0:0] MUX1HOT_s_1_5_2;
    input [4:0] inputs;
    input [4:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_5_2 = result;
  end
  endfunction


  function [5:0] signext_6_1;
    input [0:0] vector;
  begin
    signext_6_1= {{5{vector[0]}}, vector};
  end
  endfunction


  function [0:0] MUX1HOT_s_1_6_2;
    input [5:0] inputs;
    input [5:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 6; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_6_2 = result;
  end
  endfunction


  function [11:0] MUX1HOT_v_12_3_2;
    input [35:0] inputs;
    input [2:0] sel;
    reg [11:0] result;
    integer i;
  begin
    result = inputs[0+:12] & {12{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*12+:12] & {12{sel[i]}});
    MUX1HOT_v_12_3_2 = result;
  end
  endfunction


  function [11:0] MUX1HOT_v_12_5_2;
    input [59:0] inputs;
    input [4:0] sel;
    reg [11:0] result;
    integer i;
  begin
    result = inputs[0+:12] & {12{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*12+:12] & {12{sel[i]}});
    MUX1HOT_v_12_5_2 = result;
  end
  endfunction


  function [1:0] readslicef_3_2_1;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_3_2_1 = tmp[1:0];
  end
  endfunction


  function [2:0] MUX1HOT_v_3_3_2;
    input [8:0] inputs;
    input [2:0] sel;
    reg [2:0] result;
    integer i;
  begin
    result = inputs[0+:3] & {3{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*3+:3] & {3{sel[i]}});
    MUX1HOT_v_3_3_2 = result;
  end
  endfunction


  function [2:0] MUX_v_3_2_2;
    input [5:0] inputs;
    input [0:0] sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[5:3];
      end
      1'b1 : begin
        result = inputs[2:0];
      end
      default : begin
        result = inputs[5:3];
      end
    endcase
    MUX_v_3_2_2 = result;
  end
  endfunction


  function [10:0] MUX1HOT_v_11_4_2;
    input [43:0] inputs;
    input [3:0] sel;
    reg [10:0] result;
    integer i;
  begin
    result = inputs[0+:11] & {11{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*11+:11] & {11{sel[i]}});
    MUX1HOT_v_11_4_2 = result;
  end
  endfunction


  function [3:0] signext_4_1;
    input [0:0] vector;
  begin
    signext_4_1= {{3{vector[0]}}, vector};
  end
  endfunction


  function [0:0] readslicef_13_1_12;
    input [12:0] vector;
    reg [12:0] tmp;
  begin
    tmp = vector >> 12;
    readslicef_13_1_12 = tmp[0:0];
  end
  endfunction


  function  [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_s2u_11_12 ;
    input signed [10:0]  vector ;
  begin
    conv_s2u_11_12 = {vector[10], vector};
  end
  endfunction


  function  [3:0] conv_u2u_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_4 = {1'b0, vector};
  end
  endfunction


  function  [5:0] conv_u2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_6 = {1'b0, vector};
  end
  endfunction


  function  [4:0] conv_u2u_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_5 = {1'b0, vector};
  end
  endfunction


  function  [4:0] conv_s2u_4_5 ;
    input signed [3:0]  vector ;
  begin
    conv_s2u_4_5 = {vector[3], vector};
  end
  endfunction


  function  [1:0] conv_u2u_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_2 = {1'b0, vector};
  end
  endfunction


  function  [3:0] conv_u2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_4 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
  end
  endfunction


  function  [12:0] conv_u2u_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2u_12_13 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_u2u_4_12 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_12 = {{8{1'b0}}, vector};
  end
  endfunction


  function  [12:0] conv_u2u_11_13 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_13 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [12:0] conv_s2u_11_13 ;
    input signed [10:0]  vector ;
  begin
    conv_s2u_11_13 = {{2{vector[10]}}, vector};
  end
  endfunction


  function  [11:0] conv_u2u_10_12 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_12 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [11:0] conv_u2u_9_12 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_12 = {{3{1'b0}}, vector};
  end
  endfunction


  function  [11:0] conv_u2u_8_12 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_12 = {{4{1'b0}}, vector};
  end
  endfunction


  function  [2:0] conv_u2u_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_3 = {1'b0, vector};
  end
  endfunction


  function  [2:0] conv_s2u_2_3 ;
    input signed [1:0]  vector ;
  begin
    conv_s2u_2_3 = {vector[1], vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    GameUnit
//  Generated from file(s):
//    2) $PROJECT_HOME/gameengine.c
// ------------------------------------------------------------------


module GameUnit (
  restart_rsc_z, random_rsc_z, redobjecty_rsc_z, blueobjecty_rsc_z, meteorpx_rsc_z,
      meteorpy_rsc_z, meteordirectionin_rsc_z, p1planets_rsc_z, p2planets_rsc_z,
      meteordirectionout_rsc_z, player1y_rsc_z, player2y_rsc_z, meteorpxout_rsc_z,
      meteorpyout_rsc_z, p1p1_rsc_z, p1p2_rsc_z, p1p3_rsc_z, p1p4_rsc_z, p1p5_rsc_z,
      p1p6_rsc_z, p1p7_rsc_z, p1p8_rsc_z, p2p1_rsc_z, p2p2_rsc_z, p2p3_rsc_z, p2p4_rsc_z,
      p2p5_rsc_z, p2p6_rsc_z, p2p7_rsc_z, p2p8_rsc_z, player1score_rsc_z, player2score_rsc_z,
      clk, rst
);
  input restart_rsc_z;
  input [15:0] random_rsc_z;
  input [10:0] redobjecty_rsc_z;
  input [10:0] blueobjecty_rsc_z;
  input [10:0] meteorpx_rsc_z;
  input [10:0] meteorpy_rsc_z;
  input [3:0] meteordirectionin_rsc_z;
  input [7:0] p1planets_rsc_z;
  input [7:0] p2planets_rsc_z;
  output [3:0] meteordirectionout_rsc_z;
  output [10:0] player1y_rsc_z;
  output [10:0] player2y_rsc_z;
  output [10:0] meteorpxout_rsc_z;
  output [10:0] meteorpyout_rsc_z;
  output p1p1_rsc_z;
  output p1p2_rsc_z;
  output p1p3_rsc_z;
  output p1p4_rsc_z;
  output p1p5_rsc_z;
  output p1p6_rsc_z;
  output p1p7_rsc_z;
  output p1p8_rsc_z;
  output p2p1_rsc_z;
  output p2p2_rsc_z;
  output p2p3_rsc_z;
  output p2p4_rsc_z;
  output p2p5_rsc_z;
  output p2p6_rsc_z;
  output p2p7_rsc_z;
  output p2p8_rsc_z;
  output player1score_rsc_z;
  output player2score_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire restart_rsc_mgc_in_wire_d;
  wire [15:0] random_rsc_mgc_in_wire_d;
  wire [10:0] redobjecty_rsc_mgc_in_wire_d;
  wire [10:0] blueobjecty_rsc_mgc_in_wire_d;
  wire [10:0] meteorpx_rsc_mgc_in_wire_d;
  wire [10:0] meteorpy_rsc_mgc_in_wire_d;
  wire [3:0] meteordirectionin_rsc_mgc_in_wire_d;
  wire [7:0] p1planets_rsc_mgc_in_wire_d;
  wire [7:0] p2planets_rsc_mgc_in_wire_d;
  wire [3:0] meteordirectionout_rsc_mgc_out_stdreg_d;
  wire [10:0] player1y_rsc_mgc_out_stdreg_d;
  wire [10:0] player2y_rsc_mgc_out_stdreg_d;
  wire [10:0] meteorpxout_rsc_mgc_out_stdreg_d;
  wire [10:0] meteorpyout_rsc_mgc_out_stdreg_d;
  wire p1p1_rsc_mgc_out_stdreg_d;
  wire p1p2_rsc_mgc_out_stdreg_d;
  wire p1p3_rsc_mgc_out_stdreg_d;
  wire p1p4_rsc_mgc_out_stdreg_d;
  wire p1p5_rsc_mgc_out_stdreg_d;
  wire p1p6_rsc_mgc_out_stdreg_d;
  wire p1p7_rsc_mgc_out_stdreg_d;
  wire p1p8_rsc_mgc_out_stdreg_d;
  wire p2p1_rsc_mgc_out_stdreg_d;
  wire p2p2_rsc_mgc_out_stdreg_d;
  wire p2p3_rsc_mgc_out_stdreg_d;
  wire p2p4_rsc_mgc_out_stdreg_d;
  wire p2p5_rsc_mgc_out_stdreg_d;
  wire p2p6_rsc_mgc_out_stdreg_d;
  wire p2p7_rsc_mgc_out_stdreg_d;
  wire p2p8_rsc_mgc_out_stdreg_d;
  wire player1score_rsc_mgc_out_stdreg_d;
  wire player2score_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(1)) restart_rsc_mgc_in_wire (
      .d(restart_rsc_mgc_in_wire_d),
      .z(restart_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(16)) random_rsc_mgc_in_wire (
      .d(random_rsc_mgc_in_wire_d),
      .z(random_rsc_z)
    );
  mgc_in_wire #(.rscid(3),
  .width(11)) redobjecty_rsc_mgc_in_wire (
      .d(redobjecty_rsc_mgc_in_wire_d),
      .z(redobjecty_rsc_z)
    );
  mgc_in_wire #(.rscid(4),
  .width(11)) blueobjecty_rsc_mgc_in_wire (
      .d(blueobjecty_rsc_mgc_in_wire_d),
      .z(blueobjecty_rsc_z)
    );
  mgc_in_wire #(.rscid(5),
  .width(11)) meteorpx_rsc_mgc_in_wire (
      .d(meteorpx_rsc_mgc_in_wire_d),
      .z(meteorpx_rsc_z)
    );
  mgc_in_wire #(.rscid(6),
  .width(11)) meteorpy_rsc_mgc_in_wire (
      .d(meteorpy_rsc_mgc_in_wire_d),
      .z(meteorpy_rsc_z)
    );
  mgc_in_wire #(.rscid(7),
  .width(4)) meteordirectionin_rsc_mgc_in_wire (
      .d(meteordirectionin_rsc_mgc_in_wire_d),
      .z(meteordirectionin_rsc_z)
    );
  mgc_in_wire #(.rscid(8),
  .width(8)) p1planets_rsc_mgc_in_wire (
      .d(p1planets_rsc_mgc_in_wire_d),
      .z(p1planets_rsc_z)
    );
  mgc_in_wire #(.rscid(9),
  .width(8)) p2planets_rsc_mgc_in_wire (
      .d(p2planets_rsc_mgc_in_wire_d),
      .z(p2planets_rsc_z)
    );
  mgc_out_stdreg #(.rscid(10),
  .width(4)) meteordirectionout_rsc_mgc_out_stdreg (
      .d(meteordirectionout_rsc_mgc_out_stdreg_d),
      .z(meteordirectionout_rsc_z)
    );
  mgc_out_stdreg #(.rscid(11),
  .width(11)) player1y_rsc_mgc_out_stdreg (
      .d(player1y_rsc_mgc_out_stdreg_d),
      .z(player1y_rsc_z)
    );
  mgc_out_stdreg #(.rscid(12),
  .width(11)) player2y_rsc_mgc_out_stdreg (
      .d(player2y_rsc_mgc_out_stdreg_d),
      .z(player2y_rsc_z)
    );
  mgc_out_stdreg #(.rscid(13),
  .width(11)) meteorpxout_rsc_mgc_out_stdreg (
      .d(meteorpxout_rsc_mgc_out_stdreg_d),
      .z(meteorpxout_rsc_z)
    );
  mgc_out_stdreg #(.rscid(14),
  .width(11)) meteorpyout_rsc_mgc_out_stdreg (
      .d(meteorpyout_rsc_mgc_out_stdreg_d),
      .z(meteorpyout_rsc_z)
    );
  mgc_out_stdreg #(.rscid(15),
  .width(1)) p1p1_rsc_mgc_out_stdreg (
      .d(p1p1_rsc_mgc_out_stdreg_d),
      .z(p1p1_rsc_z)
    );
  mgc_out_stdreg #(.rscid(16),
  .width(1)) p1p2_rsc_mgc_out_stdreg (
      .d(p1p2_rsc_mgc_out_stdreg_d),
      .z(p1p2_rsc_z)
    );
  mgc_out_stdreg #(.rscid(17),
  .width(1)) p1p3_rsc_mgc_out_stdreg (
      .d(p1p3_rsc_mgc_out_stdreg_d),
      .z(p1p3_rsc_z)
    );
  mgc_out_stdreg #(.rscid(18),
  .width(1)) p1p4_rsc_mgc_out_stdreg (
      .d(p1p4_rsc_mgc_out_stdreg_d),
      .z(p1p4_rsc_z)
    );
  mgc_out_stdreg #(.rscid(19),
  .width(1)) p1p5_rsc_mgc_out_stdreg (
      .d(p1p5_rsc_mgc_out_stdreg_d),
      .z(p1p5_rsc_z)
    );
  mgc_out_stdreg #(.rscid(20),
  .width(1)) p1p6_rsc_mgc_out_stdreg (
      .d(p1p6_rsc_mgc_out_stdreg_d),
      .z(p1p6_rsc_z)
    );
  mgc_out_stdreg #(.rscid(21),
  .width(1)) p1p7_rsc_mgc_out_stdreg (
      .d(p1p7_rsc_mgc_out_stdreg_d),
      .z(p1p7_rsc_z)
    );
  mgc_out_stdreg #(.rscid(22),
  .width(1)) p1p8_rsc_mgc_out_stdreg (
      .d(p1p8_rsc_mgc_out_stdreg_d),
      .z(p1p8_rsc_z)
    );
  mgc_out_stdreg #(.rscid(23),
  .width(1)) p2p1_rsc_mgc_out_stdreg (
      .d(p2p1_rsc_mgc_out_stdreg_d),
      .z(p2p1_rsc_z)
    );
  mgc_out_stdreg #(.rscid(24),
  .width(1)) p2p2_rsc_mgc_out_stdreg (
      .d(p2p2_rsc_mgc_out_stdreg_d),
      .z(p2p2_rsc_z)
    );
  mgc_out_stdreg #(.rscid(25),
  .width(1)) p2p3_rsc_mgc_out_stdreg (
      .d(p2p3_rsc_mgc_out_stdreg_d),
      .z(p2p3_rsc_z)
    );
  mgc_out_stdreg #(.rscid(26),
  .width(1)) p2p4_rsc_mgc_out_stdreg (
      .d(p2p4_rsc_mgc_out_stdreg_d),
      .z(p2p4_rsc_z)
    );
  mgc_out_stdreg #(.rscid(27),
  .width(1)) p2p5_rsc_mgc_out_stdreg (
      .d(p2p5_rsc_mgc_out_stdreg_d),
      .z(p2p5_rsc_z)
    );
  mgc_out_stdreg #(.rscid(28),
  .width(1)) p2p6_rsc_mgc_out_stdreg (
      .d(p2p6_rsc_mgc_out_stdreg_d),
      .z(p2p6_rsc_z)
    );
  mgc_out_stdreg #(.rscid(29),
  .width(1)) p2p7_rsc_mgc_out_stdreg (
      .d(p2p7_rsc_mgc_out_stdreg_d),
      .z(p2p7_rsc_z)
    );
  mgc_out_stdreg #(.rscid(30),
  .width(1)) p2p8_rsc_mgc_out_stdreg (
      .d(p2p8_rsc_mgc_out_stdreg_d),
      .z(p2p8_rsc_z)
    );
  mgc_out_stdreg #(.rscid(31),
  .width(1)) player1score_rsc_mgc_out_stdreg (
      .d(player1score_rsc_mgc_out_stdreg_d),
      .z(player1score_rsc_z)
    );
  mgc_out_stdreg #(.rscid(32),
  .width(1)) player2score_rsc_mgc_out_stdreg (
      .d(player2score_rsc_mgc_out_stdreg_d),
      .z(player2score_rsc_z)
    );
  GameUnit_core GameUnit_core_inst (
      .clk(clk),
      .rst(rst),
      .restart_rsc_mgc_in_wire_d(restart_rsc_mgc_in_wire_d),
      .random_rsc_mgc_in_wire_d(random_rsc_mgc_in_wire_d),
      .redobjecty_rsc_mgc_in_wire_d(redobjecty_rsc_mgc_in_wire_d),
      .blueobjecty_rsc_mgc_in_wire_d(blueobjecty_rsc_mgc_in_wire_d),
      .meteorpx_rsc_mgc_in_wire_d(meteorpx_rsc_mgc_in_wire_d),
      .meteorpy_rsc_mgc_in_wire_d(meteorpy_rsc_mgc_in_wire_d),
      .meteordirectionin_rsc_mgc_in_wire_d(meteordirectionin_rsc_mgc_in_wire_d),
      .p1planets_rsc_mgc_in_wire_d(p1planets_rsc_mgc_in_wire_d),
      .p2planets_rsc_mgc_in_wire_d(p2planets_rsc_mgc_in_wire_d),
      .meteordirectionout_rsc_mgc_out_stdreg_d(meteordirectionout_rsc_mgc_out_stdreg_d),
      .player1y_rsc_mgc_out_stdreg_d(player1y_rsc_mgc_out_stdreg_d),
      .player2y_rsc_mgc_out_stdreg_d(player2y_rsc_mgc_out_stdreg_d),
      .meteorpxout_rsc_mgc_out_stdreg_d(meteorpxout_rsc_mgc_out_stdreg_d),
      .meteorpyout_rsc_mgc_out_stdreg_d(meteorpyout_rsc_mgc_out_stdreg_d),
      .p1p1_rsc_mgc_out_stdreg_d(p1p1_rsc_mgc_out_stdreg_d),
      .p1p2_rsc_mgc_out_stdreg_d(p1p2_rsc_mgc_out_stdreg_d),
      .p1p3_rsc_mgc_out_stdreg_d(p1p3_rsc_mgc_out_stdreg_d),
      .p1p4_rsc_mgc_out_stdreg_d(p1p4_rsc_mgc_out_stdreg_d),
      .p1p5_rsc_mgc_out_stdreg_d(p1p5_rsc_mgc_out_stdreg_d),
      .p1p6_rsc_mgc_out_stdreg_d(p1p6_rsc_mgc_out_stdreg_d),
      .p1p7_rsc_mgc_out_stdreg_d(p1p7_rsc_mgc_out_stdreg_d),
      .p1p8_rsc_mgc_out_stdreg_d(p1p8_rsc_mgc_out_stdreg_d),
      .p2p1_rsc_mgc_out_stdreg_d(p2p1_rsc_mgc_out_stdreg_d),
      .p2p2_rsc_mgc_out_stdreg_d(p2p2_rsc_mgc_out_stdreg_d),
      .p2p3_rsc_mgc_out_stdreg_d(p2p3_rsc_mgc_out_stdreg_d),
      .p2p4_rsc_mgc_out_stdreg_d(p2p4_rsc_mgc_out_stdreg_d),
      .p2p5_rsc_mgc_out_stdreg_d(p2p5_rsc_mgc_out_stdreg_d),
      .p2p6_rsc_mgc_out_stdreg_d(p2p6_rsc_mgc_out_stdreg_d),
      .p2p7_rsc_mgc_out_stdreg_d(p2p7_rsc_mgc_out_stdreg_d),
      .p2p8_rsc_mgc_out_stdreg_d(p2p8_rsc_mgc_out_stdreg_d),
      .player1score_rsc_mgc_out_stdreg_d(player1score_rsc_mgc_out_stdreg_d),
      .player2score_rsc_mgc_out_stdreg_d(player2score_rsc_mgc_out_stdreg_d)
    );
endmodule



