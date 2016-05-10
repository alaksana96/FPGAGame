
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
//  Generated by:   apl115@EEWS104A-012
//  Generated date: Fri May 06 12:24:59 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    ImageUnit_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module ImageUnit_core_fsm (
  clk, en, arst_n, fsm_output
);
  input clk;
  input en;
  input arst_n;
  output [4:0] fsm_output;
  reg [4:0] fsm_output;


  // FSM State Type Declaration for ImageUnit_core_fsm_1
  parameter
    st_main = 3'd0,
    st_main_1 = 3'd1,
    st_main_2 = 3'd2,
    st_main_3 = 3'd3,
    st_main_4 = 3'd4,
    state_x = 3'b000;

  reg [2:0] state_var;
  reg [2:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : ImageUnit_core_fsm_1
    case (state_var)
      st_main : begin
        fsm_output = 5'b1;
        state_var_NS = st_main_1;
      end
      st_main_1 : begin
        fsm_output = 5'b10;
        state_var_NS = st_main_2;
      end
      st_main_2 : begin
        fsm_output = 5'b100;
        state_var_NS = st_main_3;
      end
      st_main_3 : begin
        fsm_output = 5'b1000;
        state_var_NS = st_main_4;
      end
      st_main_4 : begin
        fsm_output = 5'b10000;
        state_var_NS = st_main;
      end
      default : begin
        fsm_output = 5'b00000;
        state_var_NS = st_main;
      end
    endcase
  end

  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      state_var <= st_main;
    end
    else if ( en ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    ImageUnit_core
// ------------------------------------------------------------------


module ImageUnit_core (
  clk, en, arst_n, vga_x_rsc_mgc_in_wire_d, vga_y_rsc_mgc_in_wire_d, p1y_rsc_mgc_in_wire_d,
      p2y_rsc_mgc_in_wire_d, bx_rsc_mgc_in_wire_d, by_rsc_mgc_in_wire_d, p1planets_rsc_mgc_in_wire_d,
      p2planets_rsc_mgc_in_wire_d, RGB_rsc_mgc_in_wire_d, RGB_o_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [10:0] vga_x_rsc_mgc_in_wire_d;
  input [10:0] vga_y_rsc_mgc_in_wire_d;
  input [10:0] p1y_rsc_mgc_in_wire_d;
  input [10:0] p2y_rsc_mgc_in_wire_d;
  input [10:0] bx_rsc_mgc_in_wire_d;
  input [10:0] by_rsc_mgc_in_wire_d;
  input [7:0] p1planets_rsc_mgc_in_wire_d;
  input [7:0] p2planets_rsc_mgc_in_wire_d;
  input [29:0] RGB_rsc_mgc_in_wire_d;
  output [29:0] RGB_o_rsc_mgc_out_stdreg_d;
  reg [29:0] RGB_o_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [4:0] fsm_output;
  wire and_dcpl_19;
  wire or_dcpl_132;
  wire and_dcpl_95;
  wire or_dcpl_156;
  wire and_dcpl_107;
  wire and_dcpl_109;
  wire or_dcpl_182;
  wire or_dcpl_184;
  wire and_dcpl_142;
  reg [10:0] vga_x_1_sva;
  reg [10:0] vga_y_1_sva;
  reg [7:0] p2planets_1_sva;
  reg land_lpi_dfm;
  reg else_land_lpi_dfm;
  reg else_else_land_lpi_dfm;
  reg else_else_else_land_lpi_dfm;
  reg else_else_else_if_land_lpi_dfm;
  reg else_else_else_if_else_land_lpi_dfm;
  reg else_else_else_if_else_else_land_lpi_dfm;
  reg else_else_else_if_else_else_else_land_lpi_dfm;
  reg else_else_else_if_else_else_else_else_land_lpi_dfm;
  reg else_else_else_if_else_else_else_else_else_land_lpi_dfm;
  reg else_else_else_if_else_else_else_else_else_else_land_lpi_dfm;
  reg else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm;
  reg else_else_else_else_land_lpi_dfm;
  reg else_else_else_else_if_land_lpi_dfm;
  reg else_else_else_else_if_else_land_lpi_dfm;
  reg else_else_else_else_if_else_else_land_lpi_dfm;
  reg else_else_else_else_if_else_else_else_land_lpi_dfm;
  reg else_else_else_else_if_else_else_else_else_land_lpi_dfm;
  reg else_else_else_else_if_else_else_else_else_else_land_lpi_dfm;
  reg else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm;
  reg [29:0] C1047552_30_dfmergedata_lpi_dfm_20;
  reg nor_m1c;
  reg else_else_and_m1c;
  reg else_else_else_and_m1c;
  reg and_itm;
  wire else_else_else_if_or_4_tmp;
  wire else_else_else_else_if_else_else_else_else_else_else_else_land_lpi_dfm;
  wire [9:0] else_else_else_if_else_else_else_else_else_else_if_acc_2;
  wire [10:0] nl_else_else_else_if_else_else_else_else_else_else_if_acc_2;
  wire [11:0] else_else_else_if_else_else_else_else_else_else_aif_acc_2;
  wire [12:0] nl_else_else_else_if_else_else_else_else_else_else_aif_acc_2;
  wire [9:0] else_else_else_if_else_else_else_else_else_if_acc_2;
  wire [10:0] nl_else_else_else_if_else_else_else_else_else_if_acc_2;
  wire [11:0] else_else_else_if_else_else_else_else_else_aif_acc_2;
  wire [12:0] nl_else_else_else_if_else_else_else_else_else_aif_acc_2;
  wire [9:0] else_else_else_if_else_else_else_else_if_acc_2;
  wire [10:0] nl_else_else_else_if_else_else_else_else_if_acc_2;
  wire [11:0] else_else_else_if_else_else_else_else_aif_acc_2;
  wire [12:0] nl_else_else_else_if_else_else_else_else_aif_acc_2;
  wire [9:0] else_else_else_if_else_else_else_if_acc_2;
  wire [10:0] nl_else_else_else_if_else_else_else_if_acc_2;
  wire [11:0] else_else_else_if_else_else_else_aif_acc_2;
  wire [12:0] nl_else_else_else_if_else_else_else_aif_acc_2;
  wire [9:0] else_else_else_if_else_else_if_acc_2;
  wire [10:0] nl_else_else_else_if_else_else_if_acc_2;
  wire [11:0] else_else_else_if_else_else_aif_acc_2;
  wire [12:0] nl_else_else_else_if_else_else_aif_acc_2;
  wire [9:0] else_else_else_if_else_if_acc_2;
  wire [10:0] nl_else_else_else_if_else_if_acc_2;
  wire [11:0] else_else_else_if_else_aif_acc_2;
  wire [12:0] nl_else_else_else_if_else_aif_acc_2;
  wire else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm_mx0w1;
  wire and_24_cse;
  wire or_159_cse;
  wire or_161_cse;
  wire or_163_cse;
  wire or_173_cse;
  wire or_175_cse;
  wire nor_m1c_mx0w0;
  reg [6:0] reg_p1planets_1_sva_tmp;
  wire [12:0] if_acc_4_itm;
  wire [13:0] nl_if_acc_4_itm;
  wire [12:0] if_acc_2_itm;
  wire [13:0] nl_if_acc_2_itm;
  wire [11:0] acc_itm;
  wire [12:0] nl_acc_itm;
  wire [7:0] else_else_else_if_acc_itm;
  wire [8:0] nl_else_else_else_if_acc_itm;
  wire [11:0] else_else_else_acc_itm;
  wire [12:0] nl_else_else_else_acc_itm;
  wire [8:0] else_else_if_acc_10_itm;
  wire [9:0] nl_else_else_if_acc_10_itm;
  wire [8:0] else_else_if_acc_9_itm;
  wire [9:0] nl_else_else_if_acc_9_itm;
  wire [8:0] else_else_if_acc_8_itm;
  wire [9:0] nl_else_else_if_acc_8_itm;
  wire [8:0] else_else_if_acc_itm;
  wire [9:0] nl_else_else_if_acc_itm;
  wire [11:0] z_out;
  wire [12:0] nl_z_out;
  wire [9:0] z_out_1;
  wire [10:0] nl_z_out_1;
  wire else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm_mx0w1;
  wire else_else_else_else_land_lpi_dfm_mx0w0;
  wire else_else_else_else_land_lpi_dfm_mx1;
  wire [29:0] C1047552_30_dfmergedata_lpi_dfm_20_mx0w0;
  wire else_else_else_land_lpi_dfm_mx0w0;
  wire else_else_land_lpi_dfm_mx0w0;
  wire else_else_else_else_if_or_tmp;
  wire or_249_cse;
  wire or_177_cse;

  wire[0:0] mux_3_nl;
  wire[0:0] mux_9_nl;
  wire[10:0] mux_50_nl;
  wire[8:0] mux_49_nl;

  // Interconnect Declarations for Component Instantiations 
  ImageUnit_core_fsm ImageUnit_core_fsm_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .fsm_output(fsm_output)
    );
  assign or_177_cse = (fsm_output[1]) | (fsm_output[2]);
  assign and_24_cse = (~((else_else_if_acc_itm[8]) | (else_else_if_acc_8_itm[8])))
      & (~((else_else_if_acc_9_itm[8]) | (else_else_if_acc_10_itm[8])));
  assign or_159_cse = (~ (reg_p1planets_1_sva_tmp[2])) | (else_else_else_if_else_else_else_aif_acc_2[11])
      | (else_else_else_if_else_else_else_if_acc_2[9]);
  assign or_161_cse = or_dcpl_132 | (~ (reg_p1planets_1_sva_tmp[1]));
  assign or_163_cse = (~ (reg_p1planets_1_sva_tmp[0])) | (else_else_else_if_else_aif_acc_2[11])
      | (else_else_else_if_else_if_acc_2[9]);
  assign or_173_cse = (else_else_else_if_else_aif_acc_2[11]) | (else_else_else_if_else_if_acc_2[9])
      | (~ (p2planets_1_sva[1]));
  assign or_175_cse = (z_out[11]) | (z_out_1[9]) | (~ (p2planets_1_sva[0]));
  assign nl_if_acc_4_itm = conv_u2u_12_13(conv_u2u_11_12(p1y_rsc_mgc_in_wire_d) +
      conv_u2u_11_12(~ vga_y_rsc_mgc_in_wire_d)) + 13'b1100000110011;
  assign if_acc_4_itm = nl_if_acc_4_itm[12:0];
  assign nl_if_acc_2_itm = conv_u2u_12_13(conv_u2u_11_12(vga_y_rsc_mgc_in_wire_d)
      + conv_u2u_11_12(~ p1y_rsc_mgc_in_wire_d)) + 13'b1100000110011;
  assign if_acc_2_itm = nl_if_acc_2_itm[12:0];
  assign else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm_mx0w1
      = (~ (z_out[11])) & (reg_p1planets_1_sva_tmp[6]);
  assign else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm_mx0w1
      = (~ (else_else_else_if_else_else_else_else_else_else_if_acc_2[9])) & (~ (else_else_else_if_else_else_else_else_else_else_aif_acc_2[11]))
      & (p2planets_1_sva[6]);
  assign else_else_else_else_land_lpi_dfm_mx0w0 = ~((readslicef_11_1_10((conv_u2s_10_11(~
      (vga_x_1_sva[9:0])) + 11'b10011101101))) | (readslicef_8_1_7((conv_u2u_7_8(vga_x_1_sva[10:4])
      + 8'b10110101))));
  assign else_else_else_else_land_lpi_dfm_mx1 = MUX_s_1_2_2({else_else_else_else_land_lpi_dfm_mx0w0
      , else_else_else_else_land_lpi_dfm}, and_24_cse | or_dcpl_156 | and_dcpl_19);
  assign C1047552_30_dfmergedata_lpi_dfm_20_mx0w0 = MUX1HOT_v_30_6_2({C1047552_30_dfmergedata_lpi_dfm_20
      , 30'b101010100001010101000000000000 , RGB_rsc_mgc_in_wire_d , 30'b111111111100000000000000000000
      , 30'b1111111111 , 30'b11111111110000000000}, {(((~ else_else_else_if_or_4_tmp)
      & else_else_and_m1c) | ((~ else_else_else_else_if_or_tmp) & else_else_else_and_m1c))
      , ((else_else_else_if_or_4_tmp & else_else_and_m1c) | (else_else_else_else_if_or_tmp
      & else_else_else_and_m1c)) , and_itm , (else_else_land_lpi_dfm & nor_m1c) ,
      (else_land_lpi_dfm & (~ land_lpi_dfm)) , land_lpi_dfm});
  assign nl_acc_itm = conv_u2s_11_12(vga_x_rsc_mgc_in_wire_d) + 12'b111101111111;
  assign acc_itm = nl_acc_itm[11:0];
  assign else_else_else_land_lpi_dfm_mx0w0 = ~((else_else_else_if_acc_itm[7]) | (else_else_else_acc_itm[11]));
  assign else_else_land_lpi_dfm_mx0w0 = ~((else_else_if_acc_10_itm[8]) | (else_else_if_acc_9_itm[8])
      | (else_else_if_acc_8_itm[8]) | (else_else_if_acc_itm[8]));
  assign nl_else_else_else_if_acc_itm = ({1'b1 , (~ (vga_x_1_sva[10:4]))}) + 8'b101;
  assign else_else_else_if_acc_itm = nl_else_else_else_if_acc_itm[7:0];
  assign nl_else_else_else_acc_itm = conv_u2s_11_12(vga_x_1_sva) + 12'b111111101101;
  assign else_else_else_acc_itm = nl_else_else_else_acc_itm[11:0];
  assign nl_else_else_if_acc_10_itm = conv_u2u_8_9(readslicef_12_8_4((conv_u2u_11_12(by_rsc_mgc_in_wire_d)
      + conv_u2u_11_12(~ vga_y_1_sva)))) + 9'b110000001;
  assign else_else_if_acc_10_itm = nl_else_else_if_acc_10_itm[8:0];
  assign nl_else_else_if_acc_9_itm = conv_u2u_8_9(readslicef_12_8_4((conv_u2u_11_12(vga_y_1_sva)
      + conv_u2u_11_12(~ by_rsc_mgc_in_wire_d)))) + 9'b110000001;
  assign else_else_if_acc_9_itm = nl_else_else_if_acc_9_itm[8:0];
  assign nl_else_else_if_acc_8_itm = conv_u2u_8_9(readslicef_12_8_4((conv_u2u_11_12(bx_rsc_mgc_in_wire_d)
      + conv_u2u_11_12(~ vga_x_1_sva)))) + 9'b110000001;
  assign else_else_if_acc_8_itm = nl_else_else_if_acc_8_itm[8:0];
  assign nl_else_else_if_acc_itm = conv_u2u_8_9(readslicef_12_8_4((conv_u2u_11_12(vga_x_1_sva)
      + conv_u2u_11_12(~ bx_rsc_mgc_in_wire_d)))) + 9'b110000001;
  assign else_else_if_acc_itm = nl_else_else_if_acc_itm[8:0];
  assign nor_m1c_mx0w0 = ~(else_land_lpi_dfm | land_lpi_dfm);
  assign nl_else_else_else_if_else_else_else_else_else_if_acc_2 = ({1'b1 , (~ (vga_y_1_sva[10:2]))})
      + 10'b10111111;
  assign else_else_else_if_else_else_else_else_else_if_acc_2 = nl_else_else_else_if_else_else_else_else_else_if_acc_2[9:0];
  assign nl_else_else_else_if_else_else_else_else_if_acc_2 = ({1'b1 , (~ (vga_y_1_sva[10:2]))})
      + 10'b10011111;
  assign else_else_else_if_else_else_else_else_if_acc_2 = nl_else_else_else_if_else_else_else_else_if_acc_2[9:0];
  assign nl_else_else_else_if_else_else_else_if_acc_2 = ({1'b1 , (~ (vga_y_1_sva[10:2]))})
      + 10'b1111111;
  assign else_else_else_if_else_else_else_if_acc_2 = nl_else_else_else_if_else_else_else_if_acc_2[9:0];
  assign nl_else_else_else_if_else_else_if_acc_2 = ({1'b1 , (~ (vga_y_1_sva[10:2]))})
      + 10'b1011111;
  assign else_else_else_if_else_else_if_acc_2 = nl_else_else_else_if_else_else_if_acc_2[9:0];
  assign nl_else_else_else_if_else_if_acc_2 = ({1'b1 , (~ (vga_y_1_sva[10:2]))})
      + 10'b111111;
  assign else_else_else_if_else_if_acc_2 = nl_else_else_else_if_else_if_acc_2[9:0];
  assign nl_else_else_else_if_else_else_else_else_else_else_if_acc_2 = ({1'b1 , (~
      (vga_y_1_sva[10:2]))}) + 10'b11011111;
  assign else_else_else_if_else_else_else_else_else_else_if_acc_2 = nl_else_else_else_if_else_else_else_else_else_else_if_acc_2[9:0];
  assign nl_else_else_else_if_else_else_else_else_else_else_aif_acc_2 = conv_u2s_11_12(vga_y_1_sva)
      + 12'b110011111101;
  assign else_else_else_if_else_else_else_else_else_else_aif_acc_2 = nl_else_else_else_if_else_else_else_else_else_else_aif_acc_2[11:0];
  assign nl_else_else_else_if_else_else_else_else_else_aif_acc_2 = conv_u2s_11_12(vga_y_1_sva)
      + 12'b110101111101;
  assign else_else_else_if_else_else_else_else_else_aif_acc_2 = nl_else_else_else_if_else_else_else_else_else_aif_acc_2[11:0];
  assign nl_else_else_else_if_else_else_else_else_aif_acc_2 = conv_u2s_11_12(vga_y_1_sva)
      + 12'b110111111101;
  assign else_else_else_if_else_else_else_else_aif_acc_2 = nl_else_else_else_if_else_else_else_else_aif_acc_2[11:0];
  assign nl_else_else_else_if_else_else_else_aif_acc_2 = conv_u2s_11_12(vga_y_1_sva)
      + 12'b111001111101;
  assign else_else_else_if_else_else_else_aif_acc_2 = nl_else_else_else_if_else_else_else_aif_acc_2[11:0];
  assign nl_else_else_else_if_else_else_aif_acc_2 = conv_u2s_11_12(vga_y_1_sva) +
      12'b111011111101;
  assign else_else_else_if_else_else_aif_acc_2 = nl_else_else_else_if_else_else_aif_acc_2[11:0];
  assign nl_else_else_else_if_else_aif_acc_2 = conv_u2s_11_12(vga_y_1_sva) + 12'b111101111101;
  assign else_else_else_if_else_aif_acc_2 = nl_else_else_else_if_else_aif_acc_2[11:0];
  assign else_else_else_else_if_else_else_else_else_else_else_else_land_lpi_dfm =
      (~ (z_out_1[9])) & (~ (z_out[11])) & (p2planets_1_sva[7]);
  assign mux_3_nl = MUX_s_1_2_2({else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm_mx0w1
      , else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm}, or_dcpl_156
      | else_else_land_lpi_dfm | (~ else_else_else_land_lpi_dfm));
  assign else_else_else_if_or_4_tmp = ((~ (z_out_1[9])) & (mux_3_nl)) | else_else_else_if_else_else_else_else_else_else_land_lpi_dfm
      | else_else_else_if_else_else_else_else_else_land_lpi_dfm | else_else_else_if_else_else_else_else_land_lpi_dfm
      | else_else_else_if_else_else_else_land_lpi_dfm | else_else_else_if_else_else_land_lpi_dfm
      | else_else_else_if_else_land_lpi_dfm | else_else_else_if_land_lpi_dfm;
  assign mux_9_nl = MUX_s_1_2_2({else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm_mx0w1
      , else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm}, or_dcpl_184
      | or_dcpl_182 | else_else_land_lpi_dfm | (~ else_else_else_else_land_lpi_dfm)
      | else_else_else_land_lpi_dfm);
  assign else_else_else_else_if_or_tmp = else_else_else_else_if_else_else_else_else_else_else_else_land_lpi_dfm
      | (mux_9_nl) | else_else_else_else_if_else_else_else_else_else_land_lpi_dfm
      | else_else_else_else_if_else_else_else_else_land_lpi_dfm | else_else_else_else_if_else_else_else_land_lpi_dfm
      | else_else_else_else_if_else_else_land_lpi_dfm | else_else_else_else_if_else_land_lpi_dfm
      | else_else_else_else_if_land_lpi_dfm;
  assign and_dcpl_19 = ~((else_else_else_acc_itm[11]) | (else_else_else_if_acc_itm[7]));
  assign or_dcpl_132 = (else_else_else_if_else_else_aif_acc_2[11]) | (else_else_else_if_else_else_if_acc_2[9]);
  assign and_dcpl_95 = ~(else_else_land_lpi_dfm | else_else_else_if_land_lpi_dfm);
  assign or_dcpl_156 = else_land_lpi_dfm | land_lpi_dfm;
  assign and_dcpl_107 = (~ else_else_else_if_land_lpi_dfm) & else_else_else_land_lpi_dfm
      & (fsm_output[2]);
  assign and_dcpl_109 = nor_m1c_mx0w0 & (~ else_else_land_lpi_dfm);
  assign or_dcpl_182 = else_else_else_else_if_else_land_lpi_dfm | else_else_else_else_if_else_else_land_lpi_dfm;
  assign or_dcpl_184 = or_dcpl_156 | else_else_else_else_if_land_lpi_dfm;
  assign and_dcpl_142 = else_else_else_else_land_lpi_dfm & (~ else_else_else_land_lpi_dfm)
      & (fsm_output[2]);
  assign or_249_cse = (fsm_output[3]) | or_177_cse;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      vga_x_1_sva <= 11'b0;
      else_land_lpi_dfm <= 1'b0;
      vga_y_1_sva <= 11'b0;
      else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm <= 1'b0;
      else_else_else_if_else_else_else_else_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_if_else_else_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_if_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_else_if_else_else_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_else_if_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_else_if_land_lpi_dfm <= 1'b0;
      else_else_else_else_land_lpi_dfm <= 1'b0;
      C1047552_30_dfmergedata_lpi_dfm_20 <= 30'b0;
      RGB_o_rsc_mgc_out_stdreg_d <= 30'b0;
      land_lpi_dfm <= 1'b0;
      else_else_else_if_land_lpi_dfm <= 1'b0;
      p2planets_1_sva <= 8'b0;
      else_else_else_land_lpi_dfm <= 1'b0;
      else_else_land_lpi_dfm <= 1'b0;
      else_else_and_m1c <= 1'b0;
      else_else_else_and_m1c <= 1'b0;
      and_itm <= 1'b0;
      nor_m1c <= 1'b0;
      else_else_else_if_else_else_else_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_if_else_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_if_else_land_lpi_dfm <= 1'b0;
      else_else_else_else_if_else_else_else_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_else_if_else_else_else_land_lpi_dfm <= 1'b0;
      else_else_else_else_if_else_land_lpi_dfm <= 1'b0;
      reg_p1planets_1_sva_tmp <= 7'b0;
    end
    else begin
      if ( en ) begin
        vga_x_1_sva <= vga_x_rsc_mgc_in_wire_d;
        else_land_lpi_dfm <= MUX_s_1_2_2({(~((readslicef_13_1_12((conv_u2u_12_13(conv_u2u_11_12(p2y_rsc_mgc_in_wire_d)
            + conv_u2u_11_12(~ vga_y_rsc_mgc_in_wire_d)) + 13'b1100000110011))) |
            (readslicef_13_1_12((conv_u2u_12_13(conv_u2u_11_12(vga_y_rsc_mgc_in_wire_d)
            + conv_u2u_11_12(~ p2y_rsc_mgc_in_wire_d)) + 13'b1100000110011))) | (readslicef_10_1_9((conv_u2s_9_10(~
            (vga_x_rsc_mgc_in_wire_d[9:1])) + 10'b1000101011))) | (readslicef_12_1_11((conv_u2s_11_12(vga_x_rsc_mgc_in_wire_d)
            + 12'b101111010011))))) , else_land_lpi_dfm}, ~((~((~((acc_itm[11]) |
            (z_out[10]))) & (~((if_acc_2_itm[12]) | (if_acc_4_itm[12]))))) & (fsm_output[0])));
        vga_y_1_sva <= MUX_v_11_2_2({vga_y_rsc_mgc_in_wire_d , vga_y_1_sva}, or_177_cse);
        else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm <= MUX_s_1_2_2({else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm
            , else_else_else_if_else_else_else_else_else_else_else_land_1_lpi_dfm_mx0w1},
            nor_m1c_mx0w0 & (~ else_else_else_if_else_land_lpi_dfm) & (~(else_else_else_if_else_else_land_lpi_dfm
            | else_else_else_if_else_else_else_land_lpi_dfm | else_else_else_if_else_else_else_else_land_lpi_dfm))
            & (~(else_else_else_if_else_else_else_else_else_land_lpi_dfm | else_else_else_if_else_else_else_else_else_else_land_lpi_dfm))
            & (fsm_output[3]) & and_dcpl_95 & else_else_else_land_lpi_dfm);
        else_else_else_if_else_else_else_else_else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_if_else_else_else_else_else_else_land_lpi_dfm
            , ((~ (else_else_else_if_else_else_else_else_else_else_if_acc_2[9]))
            & (~ (else_else_else_if_else_else_else_else_else_else_aif_acc_2[11]))
            & (reg_p1planets_1_sva_tmp[5]))}, or_163_cse & or_161_cse & or_159_cse
            & ((~ (reg_p1planets_1_sva_tmp[3])) | (else_else_else_if_else_else_else_else_aif_acc_2[11])
            | (else_else_else_if_else_else_else_else_if_acc_2[9])) & ((~ (reg_p1planets_1_sva_tmp[4]))
            | (else_else_else_if_else_else_else_else_else_aif_acc_2[11]) | (else_else_else_if_else_else_else_else_else_if_acc_2[9]))
            & and_dcpl_109 & and_dcpl_107);
        else_else_else_if_else_else_else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_if_else_else_else_else_land_lpi_dfm
            , ((~ (else_else_else_if_else_else_else_else_if_acc_2[9])) & (~ (else_else_else_if_else_else_else_else_aif_acc_2[11]))
            & (reg_p1planets_1_sva_tmp[3]))}, or_163_cse & or_161_cse & or_159_cse
            & and_dcpl_109 & and_dcpl_107);
        else_else_else_if_else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_if_else_else_land_lpi_dfm
            , ((~ (else_else_else_if_else_else_if_acc_2[9])) & (~ (else_else_else_if_else_else_aif_acc_2[11]))
            & (reg_p1planets_1_sva_tmp[1]))}, or_163_cse & nor_m1c_mx0w0 & and_dcpl_95
            & else_else_else_land_lpi_dfm & (fsm_output[2]));
        else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm
            , else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm_mx0w1},
            nor_m1c_mx0w0 & (~ else_else_else_else_if_land_lpi_dfm) & (~(else_else_else_else_if_else_land_lpi_dfm
            | else_else_else_else_if_else_else_land_lpi_dfm | else_else_else_else_if_else_else_else_land_lpi_dfm))
            & (~(else_else_else_else_if_else_else_else_else_land_lpi_dfm | else_else_else_else_if_else_else_else_else_else_land_lpi_dfm))
            & (fsm_output[3]) & (~ else_else_land_lpi_dfm) & else_else_else_else_land_lpi_dfm
            & (~ else_else_else_land_lpi_dfm));
        else_else_else_else_if_else_else_else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_else_if_else_else_else_else_land_lpi_dfm
            , ((~ (else_else_else_if_else_else_else_else_if_acc_2[9])) & (~ (else_else_else_if_else_else_else_else_aif_acc_2[11]))
            & (p2planets_1_sva[4]))}, or_175_cse & or_173_cse & (or_dcpl_132 | (~
            (p2planets_1_sva[2]))) & ((~ (p2planets_1_sva[3])) | (else_else_else_if_else_else_else_aif_acc_2[11])
            | (else_else_else_if_else_else_else_if_acc_2[9])) & and_dcpl_109 & and_dcpl_142);
        else_else_else_else_if_else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_else_if_else_else_land_lpi_dfm
            , ((~ (else_else_else_if_else_else_if_acc_2[9])) & (~ (else_else_else_if_else_else_aif_acc_2[11]))
            & (p2planets_1_sva[2]))}, or_175_cse & or_173_cse & and_dcpl_109 & and_dcpl_142);
        else_else_else_else_if_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_else_if_land_lpi_dfm
            , ((~ (z_out_1[9])) & (~ (z_out[11])) & (p2planets_1_sva[0]))}, and_dcpl_109
            & and_dcpl_142);
        else_else_else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_else_land_lpi_dfm_mx0w0
            , else_else_else_else_land_lpi_dfm}, and_24_cse | else_land_lpi_dfm |
            and_dcpl_19 | land_lpi_dfm | (~ (fsm_output[1])));
        C1047552_30_dfmergedata_lpi_dfm_20 <= MUX_v_30_2_2({C1047552_30_dfmergedata_lpi_dfm_20
            , C1047552_30_dfmergedata_lpi_dfm_20_mx0w0}, fsm_output[3]);
        RGB_o_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({C1047552_30_dfmergedata_lpi_dfm_20_mx0w0
            , RGB_o_rsc_mgc_out_stdreg_d}, ~((fsm_output[3]) & ((MUX_s_1_2_2({(else_else_else_else_if_else_else_else_else_else_else_else_land_lpi_dfm
            | (MUX_s_1_2_2({else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm_mx0w1
            , else_else_else_else_if_else_else_else_else_else_else_land_lpi_dfm},
            or_dcpl_184 | or_dcpl_182)) | else_else_else_else_if_else_else_else_else_else_land_lpi_dfm
            | else_else_else_else_if_else_else_else_else_land_lpi_dfm | else_else_else_else_if_else_else_else_land_lpi_dfm
            | else_else_else_else_if_else_else_land_lpi_dfm | else_else_else_else_if_else_land_lpi_dfm
            | else_else_else_else_if_land_lpi_dfm | (~ else_else_else_else_land_lpi_dfm))
            , else_else_else_if_or_4_tmp}, else_else_else_land_lpi_dfm)) | else_else_land_lpi_dfm
            | else_land_lpi_dfm | land_lpi_dfm)));
        land_lpi_dfm <= MUX_s_1_2_2({land_lpi_dfm , (~((if_acc_4_itm[12]) | (if_acc_2_itm[12])
            | (z_out[10]) | (acc_itm[11])))}, fsm_output[0]);
        else_else_else_if_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_if_land_lpi_dfm
            , ((~ (z_out_1[9])) & (~ (z_out[11])) & (p1planets_rsc_mgc_in_wire_d[0]))},
            fsm_output[1]);
        p2planets_1_sva <= MUX_v_8_2_2({p2planets_rsc_mgc_in_wire_d , ({(p2planets_1_sva[7:6])
            , 6'b0})}, fsm_output[2]);
        else_else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_else_land_lpi_dfm ,
            else_else_else_land_lpi_dfm_mx0w0}, fsm_output[1]);
        else_else_land_lpi_dfm <= MUX_s_1_2_2({else_else_land_lpi_dfm , else_else_land_lpi_dfm_mx0w0},
            fsm_output[1]);
        else_else_and_m1c <= MUX_s_1_2_2({else_else_and_m1c , (else_else_else_land_lpi_dfm_mx0w0
            & (~ else_else_land_lpi_dfm_mx0w0) & nor_m1c_mx0w0)}, fsm_output[1]);
        else_else_else_and_m1c <= MUX_s_1_2_2({else_else_else_and_m1c , (else_else_else_else_land_lpi_dfm_mx1
            & (~ else_else_else_land_lpi_dfm_mx0w0) & (~ else_else_land_lpi_dfm_mx0w0)
            & nor_m1c_mx0w0)}, fsm_output[1]);
        and_itm <= MUX_s_1_2_2({and_itm , ((~(else_else_else_else_land_lpi_dfm_mx1
            | else_else_else_land_lpi_dfm_mx0w0 | else_else_land_lpi_dfm_mx0w0))
            & nor_m1c_mx0w0)}, fsm_output[1]);
        nor_m1c <= MUX_s_1_2_2({nor_m1c , nor_m1c_mx0w0}, fsm_output[1]);
        else_else_else_if_else_else_else_else_else_land_lpi_dfm <= (~ (else_else_else_if_else_else_else_else_else_if_acc_2[9]))
            & (~ (else_else_else_if_else_else_else_else_else_aif_acc_2[11])) & (reg_p1planets_1_sva_tmp[4]);
        else_else_else_if_else_else_else_land_lpi_dfm <= (~ (else_else_else_if_else_else_else_if_acc_2[9]))
            & (~ (else_else_else_if_else_else_else_aif_acc_2[11])) & (reg_p1planets_1_sva_tmp[2]);
        else_else_else_if_else_land_lpi_dfm <= (~ (else_else_else_if_else_if_acc_2[9]))
            & (~ (else_else_else_if_else_aif_acc_2[11])) & (reg_p1planets_1_sva_tmp[0]);
        else_else_else_else_if_else_else_else_else_else_land_lpi_dfm <= (~ (else_else_else_if_else_else_else_else_else_if_acc_2[9]))
            & (~ (else_else_else_if_else_else_else_else_else_aif_acc_2[11])) & (p2planets_1_sva[5]);
        else_else_else_else_if_else_else_else_land_lpi_dfm <= (~ (else_else_else_if_else_else_else_if_acc_2[9]))
            & (~ (else_else_else_if_else_else_else_aif_acc_2[11])) & (p2planets_1_sva[3]);
        else_else_else_else_if_else_land_lpi_dfm <= (~ (else_else_else_if_else_if_acc_2[9]))
            & (~ (else_else_else_if_else_aif_acc_2[11])) & (p2planets_1_sva[1]);
        reg_p1planets_1_sva_tmp <= MUX_v_7_2_2({(p1planets_rsc_mgc_in_wire_d[7:1])
            , ({(reg_p1planets_1_sva_tmp[6]) , 6'b0})}, fsm_output[2]);
      end
    end
  end
  assign mux_50_nl = MUX_v_11_2_2({({1'b1 , (~ (vga_x_rsc_mgc_in_wire_d[10:1]))})
      , vga_y_1_sva}, or_177_cse | (fsm_output[3]));
  assign nl_z_out = conv_u2u_11_12(mux_50_nl) + conv_s2u_11_12({(({(fsm_output[3])
      , 3'b0}) | ({{3{or_177_cse}}, or_177_cse})) , 1'b1 , or_249_cse , 1'b1 , or_249_cse
      , 3'b101});
  assign z_out = nl_z_out[11:0];
  assign mux_49_nl = MUX_v_9_2_2({(~ (vga_y_1_sva[10:2])) , (~ (vga_y_1_sva[10:2]))},
      fsm_output[3]);
  assign nl_z_out_1 = ({1'b1 , (mux_49_nl)}) + conv_u2u_8_10(signext_8_6({(fsm_output[3])
      , 5'b11111}));
  assign z_out_1 = nl_z_out_1[9:0];

  function [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
  end
  endfunction


  function [0:0] readslicef_8_1_7;
    input [7:0] vector;
    reg [7:0] tmp;
  begin
    tmp = vector >> 7;
    readslicef_8_1_7 = tmp[0:0];
  end
  endfunction


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


  function [29:0] MUX1HOT_v_30_6_2;
    input [179:0] inputs;
    input [5:0] sel;
    reg [29:0] result;
    integer i;
  begin
    result = inputs[0+:30] & {30{sel[0]}};
    for( i = 1; i < 6; i = i + 1 )
      result = result | (inputs[i*30+:30] & {30{sel[i]}});
    MUX1HOT_v_30_6_2 = result;
  end
  endfunction


  function [7:0] readslicef_12_8_4;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 4;
    readslicef_12_8_4 = tmp[7:0];
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


  function [0:0] readslicef_10_1_9;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 9;
    readslicef_10_1_9 = tmp[0:0];
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


  function [29:0] MUX_v_30_2_2;
    input [59:0] inputs;
    input [0:0] sel;
    reg [29:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[59:30];
      end
      1'b1 : begin
        result = inputs[29:0];
      end
      default : begin
        result = inputs[59:30];
      end
    endcase
    MUX_v_30_2_2 = result;
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


  function [6:0] MUX_v_7_2_2;
    input [13:0] inputs;
    input [0:0] sel;
    reg [6:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[13:7];
      end
      1'b1 : begin
        result = inputs[6:0];
      end
      default : begin
        result = inputs[13:7];
      end
    endcase
    MUX_v_7_2_2 = result;
  end
  endfunction


  function [8:0] MUX_v_9_2_2;
    input [17:0] inputs;
    input [0:0] sel;
    reg [8:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[17:9];
      end
      1'b1 : begin
        result = inputs[8:0];
      end
      default : begin
        result = inputs[17:9];
      end
    endcase
    MUX_v_9_2_2 = result;
  end
  endfunction


  function [7:0] signext_8_6;
    input [5:0] vector;
  begin
    signext_8_6= {{2{vector[5]}}, vector};
  end
  endfunction


  function  [12:0] conv_u2u_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2u_12_13 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function signed [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 = {1'b0, vector};
  end
  endfunction


  function  [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
  end
  endfunction


  function signed [11:0] conv_u2s_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_12 = {1'b0, vector};
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function signed [9:0] conv_u2s_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2s_9_10 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_s2u_11_12 ;
    input signed [10:0]  vector ;
  begin
    conv_s2u_11_12 = {vector[10], vector};
  end
  endfunction


  function  [9:0] conv_u2u_8_10 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_10 = {{2{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    ImageUnit
//  Generated from file(s):
//    2) $PROJECT_HOME/drawscreen.c
// ------------------------------------------------------------------


module ImageUnit (
  vga_x_rsc_z, vga_y_rsc_z, p1y_rsc_z, p2y_rsc_z, bx_rsc_z, by_rsc_z, p1planets_rsc_z,
      p2planets_rsc_z, RGB_rsc_z, RGB_o_rsc_z, clk, en, arst_n
);
  input [10:0] vga_x_rsc_z;
  input [10:0] vga_y_rsc_z;
  input [10:0] p1y_rsc_z;
  input [10:0] p2y_rsc_z;
  input [10:0] bx_rsc_z;
  input [10:0] by_rsc_z;
  input [7:0] p1planets_rsc_z;
  input [7:0] p2planets_rsc_z;
  input [29:0] RGB_rsc_z;
  output [29:0] RGB_o_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [10:0] vga_x_rsc_mgc_in_wire_d;
  wire [10:0] vga_y_rsc_mgc_in_wire_d;
  wire [10:0] p1y_rsc_mgc_in_wire_d;
  wire [10:0] p2y_rsc_mgc_in_wire_d;
  wire [10:0] bx_rsc_mgc_in_wire_d;
  wire [10:0] by_rsc_mgc_in_wire_d;
  wire [7:0] p1planets_rsc_mgc_in_wire_d;
  wire [7:0] p2planets_rsc_mgc_in_wire_d;
  wire [29:0] RGB_rsc_mgc_in_wire_d;
  wire [29:0] RGB_o_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(11)) vga_x_rsc_mgc_in_wire (
      .d(vga_x_rsc_mgc_in_wire_d),
      .z(vga_x_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(11)) vga_y_rsc_mgc_in_wire (
      .d(vga_y_rsc_mgc_in_wire_d),
      .z(vga_y_rsc_z)
    );
  mgc_in_wire #(.rscid(3),
  .width(11)) p1y_rsc_mgc_in_wire (
      .d(p1y_rsc_mgc_in_wire_d),
      .z(p1y_rsc_z)
    );
  mgc_in_wire #(.rscid(4),
  .width(11)) p2y_rsc_mgc_in_wire (
      .d(p2y_rsc_mgc_in_wire_d),
      .z(p2y_rsc_z)
    );
  mgc_in_wire #(.rscid(5),
  .width(11)) bx_rsc_mgc_in_wire (
      .d(bx_rsc_mgc_in_wire_d),
      .z(bx_rsc_z)
    );
  mgc_in_wire #(.rscid(6),
  .width(11)) by_rsc_mgc_in_wire (
      .d(by_rsc_mgc_in_wire_d),
      .z(by_rsc_z)
    );
  mgc_in_wire #(.rscid(7),
  .width(8)) p1planets_rsc_mgc_in_wire (
      .d(p1planets_rsc_mgc_in_wire_d),
      .z(p1planets_rsc_z)
    );
  mgc_in_wire #(.rscid(8),
  .width(8)) p2planets_rsc_mgc_in_wire (
      .d(p2planets_rsc_mgc_in_wire_d),
      .z(p2planets_rsc_z)
    );
  mgc_in_wire #(.rscid(9),
  .width(30)) RGB_rsc_mgc_in_wire (
      .d(RGB_rsc_mgc_in_wire_d),
      .z(RGB_rsc_z)
    );
  mgc_out_stdreg #(.rscid(10),
  .width(30)) RGB_o_rsc_mgc_out_stdreg (
      .d(RGB_o_rsc_mgc_out_stdreg_d),
      .z(RGB_o_rsc_z)
    );
  ImageUnit_core ImageUnit_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .vga_x_rsc_mgc_in_wire_d(vga_x_rsc_mgc_in_wire_d),
      .vga_y_rsc_mgc_in_wire_d(vga_y_rsc_mgc_in_wire_d),
      .p1y_rsc_mgc_in_wire_d(p1y_rsc_mgc_in_wire_d),
      .p2y_rsc_mgc_in_wire_d(p2y_rsc_mgc_in_wire_d),
      .bx_rsc_mgc_in_wire_d(bx_rsc_mgc_in_wire_d),
      .by_rsc_mgc_in_wire_d(by_rsc_mgc_in_wire_d),
      .p1planets_rsc_mgc_in_wire_d(p1planets_rsc_mgc_in_wire_d),
      .p2planets_rsc_mgc_in_wire_d(p2planets_rsc_mgc_in_wire_d),
      .RGB_rsc_mgc_in_wire_d(RGB_rsc_mgc_in_wire_d),
      .RGB_o_rsc_mgc_out_stdreg_d(RGB_o_rsc_mgc_out_stdreg_d)
    );
endmodule



