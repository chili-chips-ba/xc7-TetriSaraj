
module progmem (
    // Clock & reset
    input wire clk,
    input wire rstn,

    // PicoRV32 bus interface
    input  wire        valid,
    output wire        ready,	
    input  wire [31:0] addr,
    output wire [31:0] rdata,
	// Rewrite firmware
    input  wire        wen,
	input  wire [31:0] waddr,
	input  wire [31:0] wdata
);

  // ============================================================================

  localparam MEM_SIZE_BITS = 13;  // In 32-bit words
  localparam MEM_SIZE = 1 << MEM_SIZE_BITS;
  localparam MEM_ADDR_MASK = 32'h0010_0000;

  // ============================================================================

  wire [MEM_SIZE_BITS-1:0] mem_addr;
  reg  [             31:0] mem_data;
  reg  [             31:0] mem      [0:MEM_SIZE];

  initial begin
    mem['h0000] <= 32'h00000093;
    mem['h0001] <= 32'h00000193;
    mem['h0002] <= 32'h00000213;
    mem['h0003] <= 32'h00000293;
    mem['h0004] <= 32'h00000313;
    mem['h0005] <= 32'h00000393;
    mem['h0006] <= 32'h00000413;
    mem['h0007] <= 32'h00000493;
    mem['h0008] <= 32'h00000513;
    mem['h0009] <= 32'h00000593;
    mem['h000A] <= 32'h00000613;
    mem['h000B] <= 32'h00000693;
    mem['h000C] <= 32'h00000713;
    mem['h000D] <= 32'h00000793;
    mem['h000E] <= 32'h00000813;
    mem['h000F] <= 32'h00000893;
    mem['h0010] <= 32'h00000913;
    mem['h0011] <= 32'h00000993;
    mem['h0012] <= 32'h00000A13;
    mem['h0013] <= 32'h00000A93;
    mem['h0014] <= 32'h00000B13;
    mem['h0015] <= 32'h00000B93;
    mem['h0016] <= 32'h00000C13;
    mem['h0017] <= 32'h00000C93;
    mem['h0018] <= 32'h00000D13;
    mem['h0019] <= 32'h00000D93;
    mem['h001A] <= 32'h00000E13;
    mem['h001B] <= 32'h00000E93;
    mem['h001C] <= 32'h00000F13;
    mem['h001D] <= 32'h00000F93;
    mem['h001E] <= 32'h00000513;
    mem['h001F] <= 32'h00000593;
    mem['h0020] <= 32'h00B52023;
    mem['h0021] <= 32'h00450513;
    mem['h0022] <= 32'hFE254CE3;
    mem['h0023] <= 32'h00001517;
    mem['h0024] <= 32'hEC850513;
    mem['h0025] <= 32'h00000593;
    mem['h0026] <= 32'h07C00613;
    mem['h0027] <= 32'h00C5DC63;
    mem['h0028] <= 32'h00052683;
    mem['h0029] <= 32'h00D5A023;
    mem['h002A] <= 32'h00450513;
    mem['h002B] <= 32'h00458593;
    mem['h002C] <= 32'hFEC5C8E3;
    mem['h002D] <= 32'h07C00513;
    mem['h002E] <= 32'h53000593;
    mem['h002F] <= 32'h00B55863;
    mem['h0030] <= 32'h00052023;
    mem['h0031] <= 32'h00450513;
    mem['h0032] <= 32'hFEB54CE3;
    mem['h0033] <= 32'h099000EF;
    mem['h0034] <= 32'h0000006F;
    mem['h0035] <= 32'hFF010113;
    mem['h0036] <= 32'h00812623;
    mem['h0037] <= 32'h01010413;
    mem['h0038] <= 32'h030007B7;
    mem['h0039] <= 32'h0007A783;
    mem['h003A] <= 32'h0107D793;
    mem['h003B] <= 32'h0FF7F713;
    mem['h003C] <= 32'h52E00623;
    mem['h003D] <= 32'h00000013;
    mem['h003E] <= 32'h00C12403;
    mem['h003F] <= 32'h01010113;
    mem['h0040] <= 32'h00008067;
    mem['h0041] <= 32'hFE010113;
    mem['h0042] <= 32'h00812E23;
    mem['h0043] <= 32'h02010413;
    mem['h0044] <= 32'h000017B7;
    mem['h0045] <= 32'hFFF78793;
    mem['h0046] <= 32'hFEF42623;
    mem['h0047] <= 32'hFE0405A3;
    mem['h0048] <= 32'h4E40006F;
    mem['h0049] <= 32'hFE040523;
    mem['h004A] <= 32'h4C40006F;
    mem['h004B] <= 32'hFE0404A3;
    mem['h004C] <= 32'h4A40006F;
    mem['h004D] <= 32'hFEB44783;
    mem['h004E] <= 32'h04079863;
    mem['h004F] <= 32'hFEA44783;
    mem['h0050] <= 32'h00078863;
    mem['h0051] <= 32'hFEA44703;
    mem['h0052] <= 32'h00100793;
    mem['h0053] <= 32'h00F71863;
    mem['h0054] <= 32'h22200793;
    mem['h0055] <= 32'hFEF42623;
    mem['h0056] <= 32'h4300006F;
    mem['h0057] <= 32'hFE944703;
    mem['h0058] <= 32'h01E00793;
    mem['h0059] <= 32'h00F70863;
    mem['h005A] <= 32'hFE944703;
    mem['h005B] <= 32'h01F00793;
    mem['h005C] <= 32'h00F71863;
    mem['h005D] <= 32'h11100793;
    mem['h005E] <= 32'hFEF42623;
    mem['h005F] <= 32'h40C0006F;
    mem['h0060] <= 32'hFE042623;
    mem['h0061] <= 32'h4040006F;
    mem['h0062] <= 32'hFEB44703;
    mem['h0063] <= 32'h00100793;
    mem['h0064] <= 32'h04F71C63;
    mem['h0065] <= 32'hFEA44783;
    mem['h0066] <= 32'h00078863;
    mem['h0067] <= 32'hFEA44703;
    mem['h0068] <= 32'h00100793;
    mem['h0069] <= 32'h00F71863;
    mem['h006A] <= 32'h08000793;
    mem['h006B] <= 32'hFEF42623;
    mem['h006C] <= 32'h3D80006F;
    mem['h006D] <= 32'hFE944703;
    mem['h006E] <= 32'h01E00793;
    mem['h006F] <= 32'h00F70863;
    mem['h0070] <= 32'hFE944703;
    mem['h0071] <= 32'h01F00793;
    mem['h0072] <= 32'h00F71863;
    mem['h0073] <= 32'h08000793;
    mem['h0074] <= 32'hFEF42623;
    mem['h0075] <= 32'h3B40006F;
    mem['h0076] <= 32'h000017B7;
    mem['h0077] <= 32'h8B478793;
    mem['h0078] <= 32'hFEF42623;
    mem['h0079] <= 32'h3A40006F;
    mem['h007A] <= 32'hFEB44703;
    mem['h007B] <= 32'h00200793;
    mem['h007C] <= 32'h04F71A63;
    mem['h007D] <= 32'hFEA44783;
    mem['h007E] <= 32'h00078863;
    mem['h007F] <= 32'hFEA44703;
    mem['h0080] <= 32'h00100793;
    mem['h0081] <= 32'h00F71863;
    mem['h0082] <= 32'h00B00793;
    mem['h0083] <= 32'hFEF42623;
    mem['h0084] <= 32'h3780006F;
    mem['h0085] <= 32'hFE944703;
    mem['h0086] <= 32'h01E00793;
    mem['h0087] <= 32'h00F70863;
    mem['h0088] <= 32'hFE944703;
    mem['h0089] <= 32'h01F00793;
    mem['h008A] <= 32'h00F71863;
    mem['h008B] <= 32'h00B00793;
    mem['h008C] <= 32'hFEF42623;
    mem['h008D] <= 32'h3540006F;
    mem['h008E] <= 32'h00900793;
    mem['h008F] <= 32'hFEF42623;
    mem['h0090] <= 32'h3480006F;
    mem['h0091] <= 32'hFEB44703;
    mem['h0092] <= 32'h00300793;
    mem['h0093] <= 32'h06F71063;
    mem['h0094] <= 32'hFEA44783;
    mem['h0095] <= 32'h00078863;
    mem['h0096] <= 32'hFEA44703;
    mem['h0097] <= 32'h00100793;
    mem['h0098] <= 32'h00F71A63;
    mem['h0099] <= 32'h000017B7;
    mem['h009A] <= 32'hA0078793;
    mem['h009B] <= 32'hFEF42623;
    mem['h009C] <= 32'h3180006F;
    mem['h009D] <= 32'hFE944703;
    mem['h009E] <= 32'h01E00793;
    mem['h009F] <= 32'h00F70863;
    mem['h00A0] <= 32'hFE944703;
    mem['h00A1] <= 32'h01F00793;
    mem['h00A2] <= 32'h00F71A63;
    mem['h00A3] <= 32'h000017B7;
    mem['h00A4] <= 32'hB0078793;
    mem['h00A5] <= 32'hFEF42623;
    mem['h00A6] <= 32'h2F00006F;
    mem['h00A7] <= 32'h000017B7;
    mem['h00A8] <= 32'hF0078793;
    mem['h00A9] <= 32'hFEF42623;
    mem['h00AA] <= 32'h2E00006F;
    mem['h00AB] <= 32'hFEB44703;
    mem['h00AC] <= 32'h00400793;
    mem['h00AD] <= 32'h06F71063;
    mem['h00AE] <= 32'hFEA44783;
    mem['h00AF] <= 32'h00078863;
    mem['h00B0] <= 32'hFEA44703;
    mem['h00B1] <= 32'h00100793;
    mem['h00B2] <= 32'h00F71A63;
    mem['h00B3] <= 32'h000017B7;
    mem['h00B4] <= 32'hFD878793;
    mem['h00B5] <= 32'hFEF42623;
    mem['h00B6] <= 32'h2B00006F;
    mem['h00B7] <= 32'hFE944703;
    mem['h00B8] <= 32'h01E00793;
    mem['h00B9] <= 32'h00F70863;
    mem['h00BA] <= 32'hFE944703;
    mem['h00BB] <= 32'h01F00793;
    mem['h00BC] <= 32'h00F71A63;
    mem['h00BD] <= 32'h000017B7;
    mem['h00BE] <= 32'hFD478793;
    mem['h00BF] <= 32'hFEF42623;
    mem['h00C0] <= 32'h2880006F;
    mem['h00C1] <= 32'h000017B7;
    mem['h00C2] <= 32'hFF078793;
    mem['h00C3] <= 32'hFEF42623;
    mem['h00C4] <= 32'h2780006F;
    mem['h00C5] <= 32'hFEB44703;
    mem['h00C6] <= 32'h00500793;
    mem['h00C7] <= 32'h04F71A63;
    mem['h00C8] <= 32'hFEA44783;
    mem['h00C9] <= 32'h00078863;
    mem['h00CA] <= 32'hFEA44703;
    mem['h00CB] <= 32'h00100793;
    mem['h00CC] <= 32'h00F71863;
    mem['h00CD] <= 32'h75D00793;
    mem['h00CE] <= 32'hFEF42623;
    mem['h00CF] <= 32'h24C0006F;
    mem['h00D0] <= 32'hFE944703;
    mem['h00D1] <= 32'h01E00793;
    mem['h00D2] <= 32'h00F70863;
    mem['h00D3] <= 32'hFE944703;
    mem['h00D4] <= 32'h01F00793;
    mem['h00D5] <= 32'h00F71863;
    mem['h00D6] <= 32'h74D00793;
    mem['h00D7] <= 32'hFEF42623;
    mem['h00D8] <= 32'h2280006F;
    mem['h00D9] <= 32'h70D00793;
    mem['h00DA] <= 32'hFEF42623;
    mem['h00DB] <= 32'h21C0006F;
    mem['h00DC] <= 32'hFEB44703;
    mem['h00DD] <= 32'h00600793;
    mem['h00DE] <= 32'h06F71063;
    mem['h00DF] <= 32'hFEA44783;
    mem['h00E0] <= 32'h00078863;
    mem['h00E1] <= 32'hFEA44703;
    mem['h00E2] <= 32'h00100793;
    mem['h00E3] <= 32'h00F71A63;
    mem['h00E4] <= 32'h000017B7;
    mem['h00E5] <= 32'hFAF78793;
    mem['h00E6] <= 32'hFEF42623;
    mem['h00E7] <= 32'h1EC0006F;
    mem['h00E8] <= 32'hFE944703;
    mem['h00E9] <= 32'h01E00793;
    mem['h00EA] <= 32'h00F70863;
    mem['h00EB] <= 32'hFE944703;
    mem['h00EC] <= 32'h01F00793;
    mem['h00ED] <= 32'h00F71A63;
    mem['h00EE] <= 32'h000017B7;
    mem['h00EF] <= 32'hF6F78793;
    mem['h00F0] <= 32'hFEF42623;
    mem['h00F1] <= 32'h1C40006F;
    mem['h00F2] <= 32'h000017B7;
    mem['h00F3] <= 32'hF0F78793;
    mem['h00F4] <= 32'hFEF42623;
    mem['h00F5] <= 32'h1B40006F;
    mem['h00F6] <= 32'hFEB44703;
    mem['h00F7] <= 32'h00700793;
    mem['h00F8] <= 32'h06F71063;
    mem['h00F9] <= 32'hFEA44783;
    mem['h00FA] <= 32'h00078863;
    mem['h00FB] <= 32'hFEA44703;
    mem['h00FC] <= 32'h00100793;
    mem['h00FD] <= 32'h00F71A63;
    mem['h00FE] <= 32'h000017B7;
    mem['h00FF] <= 32'hFB078793;
    mem['h0100] <= 32'hFEF42623;
    mem['h0101] <= 32'h1840006F;
    mem['h0102] <= 32'hFE944703;
    mem['h0103] <= 32'h01E00793;
    mem['h0104] <= 32'h00F70863;
    mem['h0105] <= 32'hFE944703;
    mem['h0106] <= 32'h01F00793;
    mem['h0107] <= 32'h00F71A63;
    mem['h0108] <= 32'h000017B7;
    mem['h0109] <= 32'hF9078793;
    mem['h010A] <= 32'hFEF42623;
    mem['h010B] <= 32'h15C0006F;
    mem['h010C] <= 32'h000017B7;
    mem['h010D] <= 32'hFA078793;
    mem['h010E] <= 32'hFEF42623;
    mem['h010F] <= 32'h14C0006F;
    mem['h0110] <= 32'hFEB44703;
    mem['h0111] <= 32'h00800793;
    mem['h0112] <= 32'h00F71863;
    mem['h0113] <= 32'h0A000793;
    mem['h0114] <= 32'hFEF42623;
    mem['h0115] <= 32'h1340006F;
    mem['h0116] <= 32'hFEB44703;
    mem['h0117] <= 32'h00900793;
    mem['h0118] <= 32'h04F71E63;
    mem['h0119] <= 32'hFE944703;
    mem['h011A] <= 32'h01E00793;
    mem['h011B] <= 32'h00F70863;
    mem['h011C] <= 32'hFE944703;
    mem['h011D] <= 32'h01F00793;
    mem['h011E] <= 32'h00F71A63;
    mem['h011F] <= 32'h000017B7;
    mem['h0120] <= 32'hCCC78793;
    mem['h0121] <= 32'hFEF42623;
    mem['h0122] <= 32'h1000006F;
    mem['h0123] <= 32'hFEA44783;
    mem['h0124] <= 32'h00078863;
    mem['h0125] <= 32'hFEA44703;
    mem['h0126] <= 32'h00100793;
    mem['h0127] <= 32'h00F71863;
    mem['h0128] <= 32'h11100793;
    mem['h0129] <= 32'hFEF42623;
    mem['h012A] <= 32'h0E00006F;
    mem['h012B] <= 32'h000017B7;
    mem['h012C] <= 32'hAAA78793;
    mem['h012D] <= 32'hFEF42623;
    mem['h012E] <= 32'h0D00006F;
    mem['h012F] <= 32'hFEB44703;
    mem['h0130] <= 32'h00A00793;
    mem['h0131] <= 32'h04F71A63;
    mem['h0132] <= 32'hFEA44783;
    mem['h0133] <= 32'h00078863;
    mem['h0134] <= 32'hFEA44703;
    mem['h0135] <= 32'h00100793;
    mem['h0136] <= 32'h00F71863;
    mem['h0137] <= 32'h00B00793;
    mem['h0138] <= 32'hFEF42623;
    mem['h0139] <= 32'h0A40006F;
    mem['h013A] <= 32'hFE944703;
    mem['h013B] <= 32'h01E00793;
    mem['h013C] <= 32'h00F70863;
    mem['h013D] <= 32'hFE944703;
    mem['h013E] <= 32'h01F00793;
    mem['h013F] <= 32'h00F71863;
    mem['h0140] <= 32'h00B00793;
    mem['h0141] <= 32'hFEF42623;
    mem['h0142] <= 32'h0800006F;
    mem['h0143] <= 32'h00700793;
    mem['h0144] <= 32'hFEF42623;
    mem['h0145] <= 32'h0740006F;
    mem['h0146] <= 32'hFEB44703;
    mem['h0147] <= 32'h00B00793;
    mem['h0148] <= 32'h00F71A63;
    mem['h0149] <= 32'h000017B7;
    mem['h014A] <= 32'hAA078793;
    mem['h014B] <= 32'hFEF42623;
    mem['h014C] <= 32'h0580006F;
    mem['h014D] <= 32'hFEB44703;
    mem['h014E] <= 32'h00C00793;
    mem['h014F] <= 32'h00F71863;
    mem['h0150] <= 32'h0AA00793;
    mem['h0151] <= 32'hFEF42623;
    mem['h0152] <= 32'h0400006F;
    mem['h0153] <= 32'hFEB44703;
    mem['h0154] <= 32'h00D00793;
    mem['h0155] <= 32'h00F71A63;
    mem['h0156] <= 32'h000017B7;
    mem['h0157] <= 32'hA0A78793;
    mem['h0158] <= 32'hFEF42623;
    mem['h0159] <= 32'h0240006F;
    mem['h015A] <= 32'hFEB44703;
    mem['h015B] <= 32'h00E00793;
    mem['h015C] <= 32'h00F71A63;
    mem['h015D] <= 32'h000017B7;
    mem['h015E] <= 32'hFFF78793;
    mem['h015F] <= 32'hFEF42623;
    mem['h0160] <= 32'h0080006F;
    mem['h0161] <= 32'hFE042623;
    mem['h0162] <= 32'hFEB44703;
    mem['h0163] <= 32'h00070793;
    mem['h0164] <= 32'h00179793;
    mem['h0165] <= 32'h00E787B3;
    mem['h0166] <= 32'h00379793;
    mem['h0167] <= 32'h00078713;
    mem['h0168] <= 32'hFEA44783;
    mem['h0169] <= 32'h00F707B3;
    mem['h016A] <= 32'h00579713;
    mem['h016B] <= 32'hFE944783;
    mem['h016C] <= 32'h00F707B3;
    mem['h016D] <= 32'h00279713;
    mem['h016E] <= 32'h051007B7;
    mem['h016F] <= 32'h00F707B3;
    mem['h0170] <= 32'hFEC42703;
    mem['h0171] <= 32'h00E7A023;
    mem['h0172] <= 32'hFE944783;
    mem['h0173] <= 32'h00178793;
    mem['h0174] <= 32'hFEF404A3;
    mem['h0175] <= 32'hFE944703;
    mem['h0176] <= 32'h01F00793;
    mem['h0177] <= 32'hB4E7FCE3;
    mem['h0178] <= 32'hFEA44783;
    mem['h0179] <= 32'h00178793;
    mem['h017A] <= 32'hFEF40523;
    mem['h017B] <= 32'hFEA44703;
    mem['h017C] <= 32'h01700793;
    mem['h017D] <= 32'hB2E7FCE3;
    mem['h017E] <= 32'hFEB44783;
    mem['h017F] <= 32'h00178793;
    mem['h0180] <= 32'hFEF405A3;
    mem['h0181] <= 32'hFEB44703;
    mem['h0182] <= 32'h00F00793;
    mem['h0183] <= 32'hB0E7FCE3;
    mem['h0184] <= 32'h00000013;
    mem['h0185] <= 32'h00000013;
    mem['h0186] <= 32'h01C12403;
    mem['h0187] <= 32'h02010113;
    mem['h0188] <= 32'h00008067;
    mem['h0189] <= 32'hFD010113;
    mem['h018A] <= 32'h02812623;
    mem['h018B] <= 32'h03010413;
    mem['h018C] <= 32'hFCA42E23;
    mem['h018D] <= 32'hFCB42C23;
    mem['h018E] <= 32'hFCC42A23;
    mem['h018F] <= 32'hFE042623;
    mem['h0190] <= 32'hFD442703;
    mem['h0191] <= 32'h41F75793;
    mem['h0192] <= 32'h01E7D793;
    mem['h0193] <= 32'h00F70733;
    mem['h0194] <= 32'h00377713;
    mem['h0195] <= 32'h40F707B3;
    mem['h0196] <= 32'h00300713;
    mem['h0197] <= 32'h08E78063;
    mem['h0198] <= 32'h00300713;
    mem['h0199] <= 32'h08F74C63;
    mem['h019A] <= 32'h00200713;
    mem['h019B] <= 32'h04E78863;
    mem['h019C] <= 32'h00200713;
    mem['h019D] <= 32'h08F74463;
    mem['h019E] <= 32'h00078863;
    mem['h019F] <= 32'h00100713;
    mem['h01A0] <= 32'h02E78063;
    mem['h01A1] <= 32'h0780006F;
    mem['h01A2] <= 32'hFD842783;
    mem['h01A3] <= 32'h00279793;
    mem['h01A4] <= 32'hFDC42703;
    mem['h01A5] <= 32'h00F707B3;
    mem['h01A6] <= 32'hFEF42623;
    mem['h01A7] <= 32'h0600006F;
    mem['h01A8] <= 32'hFD842783;
    mem['h01A9] <= 32'h00C78713;
    mem['h01AA] <= 32'hFDC42783;
    mem['h01AB] <= 32'h00279793;
    mem['h01AC] <= 32'h40F707B3;
    mem['h01AD] <= 32'hFEF42623;
    mem['h01AE] <= 32'h0440006F;
    mem['h01AF] <= 32'hFD842783;
    mem['h01B0] <= 32'h00279793;
    mem['h01B1] <= 32'h00F00713;
    mem['h01B2] <= 32'h40F70733;
    mem['h01B3] <= 32'hFDC42783;
    mem['h01B4] <= 32'h40F707B3;
    mem['h01B5] <= 32'hFEF42623;
    mem['h01B6] <= 32'h0240006F;
    mem['h01B7] <= 32'h00300713;
    mem['h01B8] <= 32'hFD842783;
    mem['h01B9] <= 32'h40F70733;
    mem['h01BA] <= 32'hFDC42783;
    mem['h01BB] <= 32'h00279793;
    mem['h01BC] <= 32'h00F707B3;
    mem['h01BD] <= 32'hFEF42623;
    mem['h01BE] <= 32'h00000013;
    mem['h01BF] <= 32'hFEC42783;
    mem['h01C0] <= 32'h00078513;
    mem['h01C1] <= 32'h02C12403;
    mem['h01C2] <= 32'h03010113;
    mem['h01C3] <= 32'h00008067;
    mem['h01C4] <= 32'hFD010113;
    mem['h01C5] <= 32'h02112623;
    mem['h01C6] <= 32'h02812423;
    mem['h01C7] <= 32'h03010413;
    mem['h01C8] <= 32'hFCA42E23;
    mem['h01C9] <= 32'hFCB42C23;
    mem['h01CA] <= 32'hFCC42A23;
    mem['h01CB] <= 32'hFCD42823;
    mem['h01CC] <= 32'hFE042623;
    mem['h01CD] <= 32'h0FC0006F;
    mem['h01CE] <= 32'hFE042423;
    mem['h01CF] <= 32'h0DC0006F;
    mem['h01D0] <= 32'hFD842603;
    mem['h01D1] <= 32'hFE842583;
    mem['h01D2] <= 32'hFEC42503;
    mem['h01D3] <= 32'hED9FF0EF;
    mem['h01D4] <= 32'hFEA42223;
    mem['h01D5] <= 32'hFD042703;
    mem['h01D6] <= 32'hFE842783;
    mem['h01D7] <= 32'h00F70733;
    mem['h01D8] <= 32'h00070793;
    mem['h01D9] <= 32'h00279793;
    mem['h01DA] <= 32'h00E787B3;
    mem['h01DB] <= 32'h00379793;
    mem['h01DC] <= 32'h00078693;
    mem['h01DD] <= 32'hFD442703;
    mem['h01DE] <= 32'hFEC42783;
    mem['h01DF] <= 32'h00F707B3;
    mem['h01E0] <= 32'h00F687B3;
    mem['h01E1] <= 32'hFEF42023;
    mem['h01E2] <= 32'hFD442703;
    mem['h01E3] <= 32'hFEC42783;
    mem['h01E4] <= 32'h00F707B3;
    mem['h01E5] <= 32'h0607CC63;
    mem['h01E6] <= 32'hFD442703;
    mem['h01E7] <= 32'hFEC42783;
    mem['h01E8] <= 32'h00F70733;
    mem['h01E9] <= 32'h02700793;
    mem['h01EA] <= 32'h06E7C263;
    mem['h01EB] <= 32'hFD042703;
    mem['h01EC] <= 32'hFE842783;
    mem['h01ED] <= 32'h00F707B3;
    mem['h01EE] <= 32'h0407CA63;
    mem['h01EF] <= 32'hFD042703;
    mem['h01F0] <= 32'hFE842783;
    mem['h01F1] <= 32'h00F70733;
    mem['h01F2] <= 32'h01D00793;
    mem['h01F3] <= 32'h04E7C063;
    mem['h01F4] <= 32'h00000713;
    mem['h01F5] <= 32'hFDC42783;
    mem['h01F6] <= 32'h00479793;
    mem['h01F7] <= 32'h00F70733;
    mem['h01F8] <= 32'hFE442783;
    mem['h01F9] <= 32'h00F707B3;
    mem['h01FA] <= 32'h0007C783;
    mem['h01FB] <= 32'h02078063;
    mem['h01FC] <= 32'h07C00713;
    mem['h01FD] <= 32'hFE042783;
    mem['h01FE] <= 32'h00F707B3;
    mem['h01FF] <= 32'h0007C783;
    mem['h0200] <= 32'h00078663;
    mem['h0201] <= 32'h00000793;
    mem['h0202] <= 32'h0380006F;
    mem['h0203] <= 32'hFE842783;
    mem['h0204] <= 32'h00178793;
    mem['h0205] <= 32'hFEF42423;
    mem['h0206] <= 32'hFE842703;
    mem['h0207] <= 32'h00300793;
    mem['h0208] <= 32'hF2E7D0E3;
    mem['h0209] <= 32'hFEC42783;
    mem['h020A] <= 32'h00178793;
    mem['h020B] <= 32'hFEF42623;
    mem['h020C] <= 32'hFEC42703;
    mem['h020D] <= 32'h00300793;
    mem['h020E] <= 32'hF0E7D0E3;
    mem['h020F] <= 32'h00100793;
    mem['h0210] <= 32'h00078513;
    mem['h0211] <= 32'h02C12083;
    mem['h0212] <= 32'h02812403;
    mem['h0213] <= 32'h03010113;
    mem['h0214] <= 32'h00008067;
    mem['h0215] <= 32'hFD010113;
    mem['h0216] <= 32'h02812623;
    mem['h0217] <= 32'h03010413;
    mem['h0218] <= 32'hFCA42E23;
    mem['h0219] <= 32'hFDC42783;
    mem['h021A] <= 32'h0007A783;
    mem['h021B] <= 32'hFEF42623;
    mem['h021C] <= 32'hFEC42783;
    mem['h021D] <= 32'h00D79793;
    mem['h021E] <= 32'hFEC42703;
    mem['h021F] <= 32'h00F747B3;
    mem['h0220] <= 32'hFEF42623;
    mem['h0221] <= 32'hFEC42783;
    mem['h0222] <= 32'h0117D793;
    mem['h0223] <= 32'hFEC42703;
    mem['h0224] <= 32'h00F747B3;
    mem['h0225] <= 32'hFEF42623;
    mem['h0226] <= 32'hFEC42783;
    mem['h0227] <= 32'h00579793;
    mem['h0228] <= 32'hFEC42703;
    mem['h0229] <= 32'h00F747B3;
    mem['h022A] <= 32'hFEF42623;
    mem['h022B] <= 32'hFDC42783;
    mem['h022C] <= 32'hFEC42703;
    mem['h022D] <= 32'h00E7A023;
    mem['h022E] <= 32'hFEC42783;
    mem['h022F] <= 32'h00078513;
    mem['h0230] <= 32'h02C12403;
    mem['h0231] <= 32'h03010113;
    mem['h0232] <= 32'h00008067;
    mem['h0233] <= 32'hFF010113;
    mem['h0234] <= 32'h00112623;
    mem['h0235] <= 32'h00812423;
    mem['h0236] <= 32'h01010413;
    mem['h0237] <= 32'h07400513;
    mem['h0238] <= 32'hF75FF0EF;
    mem['h0239] <= 32'h00050793;
    mem['h023A] <= 32'h0017F793;
    mem['h023B] <= 32'h00078513;
    mem['h023C] <= 32'h00C12083;
    mem['h023D] <= 32'h00812403;
    mem['h023E] <= 32'h01010113;
    mem['h023F] <= 32'h00008067;
    mem['h0240] <= 32'hFD010113;
    mem['h0241] <= 32'h02112623;
    mem['h0242] <= 32'h02812423;
    mem['h0243] <= 32'h03010413;
    mem['h0244] <= 32'hFCA42E23;
    mem['h0245] <= 32'hFCB42C23;
    mem['h0246] <= 32'hFD842703;
    mem['h0247] <= 32'hFDC42783;
    mem['h0248] <= 32'h40F707B3;
    mem['h0249] <= 32'h00178793;
    mem['h024A] <= 32'hFEF42623;
    mem['h024B] <= 32'h07800513;
    mem['h024C] <= 32'hF25FF0EF;
    mem['h024D] <= 32'h00050713;
    mem['h024E] <= 32'hFEC42783;
    mem['h024F] <= 32'h02F77733;
    mem['h0250] <= 32'hFDC42783;
    mem['h0251] <= 32'h00F707B3;
    mem['h0252] <= 32'hFEF42423;
    mem['h0253] <= 32'hFE842783;
    mem['h0254] <= 32'h00078513;
    mem['h0255] <= 32'h02C12083;
    mem['h0256] <= 32'h02812403;
    mem['h0257] <= 32'h03010113;
    mem['h0258] <= 32'h00008067;
    mem['h0259] <= 32'hFB010113;
    mem['h025A] <= 32'h04112623;
    mem['h025B] <= 32'h04812423;
    mem['h025C] <= 32'h04912223;
    mem['h025D] <= 32'h05010413;
    mem['h025E] <= 32'h020007B7;
    mem['h025F] <= 32'h00478793;
    mem['h0260] <= 32'h0D900713;
    mem['h0261] <= 32'h00E7A023;
    mem['h0262] <= 32'h001017B7;
    mem['h0263] <= 32'hF3078513;
    mem['h0264] <= 32'h4D0000EF;
    mem['h0265] <= 32'hFC0405A3;
    mem['h0266] <= 32'hFC040523;
    mem['h0267] <= 32'hFC0404A3;
    mem['h0268] <= 32'hFC040423;
    mem['h0269] <= 32'hFC0403A3;
    mem['h026A] <= 32'h030007B7;
    mem['h026B] <= 32'h0007A023;
    mem['h026C] <= 32'hF54FF0EF;
    mem['h026D] <= 32'hFE041723;
    mem['h026E] <= 32'h00300793;
    mem['h026F] <= 32'hFEF406A3;
    mem['h0270] <= 32'hFE040623;
    mem['h0271] <= 32'h00F00793;
    mem['h0272] <= 32'hFEF405A3;
    mem['h0273] <= 32'h00F00793;
    mem['h0274] <= 32'hFCF40323;
    mem['h0275] <= 32'hFE040523;
    mem['h0276] <= 32'h00300793;
    mem['h0277] <= 32'hFCF402A3;
    mem['h0278] <= 32'hFC040223;
    mem['h0279] <= 32'h00100793;
    mem['h027A] <= 32'hFCF401A3;
    mem['h027B] <= 32'hFE041423;
    mem['h027C] <= 32'hFE041323;
    mem['h027D] <= 32'hFA042C23;
    mem['h027E] <= 32'hFC040123;
    mem['h027F] <= 32'hFC0400A3;
    mem['h0280] <= 32'hFC040023;
    mem['h0281] <= 32'hFA040FA3;
    mem['h0282] <= 32'hFA040F23;
    mem['h0283] <= 32'hFE0402A3;
    mem['h0284] <= 32'h07002783;
    mem['h0285] <= 32'hFFF78713;
    mem['h0286] <= 32'h06E02823;
    mem['h0287] <= 32'hEB8FF0EF;
    mem['h0288] <= 32'h52C04783;
    mem['h0289] <= 32'h1007E713;
    mem['h028A] <= 32'h030007B7;
    mem['h028B] <= 32'h00E7A023;
    mem['h028C] <= 32'h07002783;
    mem['h028D] <= 32'hFC079EE3;
    mem['h028E] <= 32'h00002737;
    mem['h028F] <= 32'h71070713;
    mem['h0290] <= 32'h06E02823;
    mem['h0291] <= 32'hFEA44783;
    mem['h0292] <= 32'h00178793;
    mem['h0293] <= 32'hFEF40523;
    mem['h0294] <= 32'hFEA44703;
    mem['h0295] <= 32'hFC644783;
    mem['h0296] <= 32'h40F707B3;
    mem['h0297] <= 32'h0017B793;
    mem['h0298] <= 32'hFCF40223;
    mem['h0299] <= 32'hFC444783;
    mem['h029A] <= 32'h22078863;
    mem['h029B] <= 32'hFE040523;
    mem['h029C] <= 32'hFE845783;
    mem['h029D] <= 32'h00178793;
    mem['h029E] <= 32'hFEF41423;
    mem['h029F] <= 32'hFEE45703;
    mem['h02A0] <= 32'hFED44583;
    mem['h02A1] <= 32'hFEC44783;
    mem['h02A2] <= 32'h00178793;
    mem['h02A3] <= 32'hFEB44683;
    mem['h02A4] <= 32'h00078613;
    mem['h02A5] <= 32'h00070513;
    mem['h02A6] <= 32'hC79FF0EF;
    mem['h02A7] <= 32'h00050793;
    mem['h02A8] <= 32'h00078E63;
    mem['h02A9] <= 32'hFE544783;
    mem['h02AA] <= 32'h00079A63;
    mem['h02AB] <= 32'hFEC44783;
    mem['h02AC] <= 32'h00178793;
    mem['h02AD] <= 32'hFEF40623;
    mem['h02AE] <= 32'h1E00006F;
    mem['h02AF] <= 32'hFEE45703;
    mem['h02B0] <= 32'hFED44583;
    mem['h02B1] <= 32'hFEC44783;
    mem['h02B2] <= 32'hFFF78793;
    mem['h02B3] <= 32'hFEB44683;
    mem['h02B4] <= 32'h00078613;
    mem['h02B5] <= 32'h00070513;
    mem['h02B6] <= 32'hC39FF0EF;
    mem['h02B7] <= 32'h00050793;
    mem['h02B8] <= 32'h00078E63;
    mem['h02B9] <= 32'hFE544783;
    mem['h02BA] <= 32'h00078A63;
    mem['h02BB] <= 32'hFEC44783;
    mem['h02BC] <= 32'hFFF78793;
    mem['h02BD] <= 32'hFEF40623;
    mem['h02BE] <= 32'h1A00006F;
    mem['h02BF] <= 32'hFE042023;
    mem['h02C0] <= 32'h0B00006F;
    mem['h02C1] <= 32'hFC042E23;
    mem['h02C2] <= 32'h0900006F;
    mem['h02C3] <= 32'hFEE45483;
    mem['h02C4] <= 32'hFED44783;
    mem['h02C5] <= 32'h00078613;
    mem['h02C6] <= 32'hFDC42583;
    mem['h02C7] <= 32'hFE042503;
    mem['h02C8] <= 32'hB05FF0EF;
    mem['h02C9] <= 32'h00050693;
    mem['h02CA] <= 32'h00000713;
    mem['h02CB] <= 32'h00449793;
    mem['h02CC] <= 32'h00F707B3;
    mem['h02CD] <= 32'h00D787B3;
    mem['h02CE] <= 32'h0007C783;
    mem['h02CF] <= 32'h04078863;
    mem['h02D0] <= 32'hFEE45783;
    mem['h02D1] <= 32'h0FF7F693;
    mem['h02D2] <= 32'hFEB44703;
    mem['h02D3] <= 32'hFDC42783;
    mem['h02D4] <= 32'h00F70733;
    mem['h02D5] <= 32'h00070793;
    mem['h02D6] <= 32'h00279793;
    mem['h02D7] <= 32'h00E787B3;
    mem['h02D8] <= 32'h00379793;
    mem['h02D9] <= 32'h00078613;
    mem['h02DA] <= 32'hFEC44703;
    mem['h02DB] <= 32'hFE042783;
    mem['h02DC] <= 32'h00F707B3;
    mem['h02DD] <= 32'h00F607B3;
    mem['h02DE] <= 32'h00168713;
    mem['h02DF] <= 32'h0FF77713;
    mem['h02E0] <= 32'h07C00693;
    mem['h02E1] <= 32'h00F687B3;
    mem['h02E2] <= 32'h00E78023;
    mem['h02E3] <= 32'hFDC42783;
    mem['h02E4] <= 32'h00178793;
    mem['h02E5] <= 32'hFCF42E23;
    mem['h02E6] <= 32'hFDC42703;
    mem['h02E7] <= 32'h00300793;
    mem['h02E8] <= 32'hF6E7D6E3;
    mem['h02E9] <= 32'hFE042783;
    mem['h02EA] <= 32'h00178793;
    mem['h02EB] <= 32'hFEF42023;
    mem['h02EC] <= 32'hFE042703;
    mem['h02ED] <= 32'h00300793;
    mem['h02EE] <= 32'hF4E7D6E3;
    mem['h02EF] <= 32'hFE544783;
    mem['h02F0] <= 32'hFAF40FA3;
    mem['h02F1] <= 32'hFE645783;
    mem['h02F2] <= 32'h00178793;
    mem['h02F3] <= 32'hFEF41323;
    mem['h02F4] <= 32'hFC244783;
    mem['h02F5] <= 32'h02078263;
    mem['h02F6] <= 32'hFC244783;
    mem['h02F7] <= 32'h01400713;
    mem['h02F8] <= 32'h00F717B3;
    mem['h02F9] <= 32'h01079713;
    mem['h02FA] <= 32'h01075713;
    mem['h02FB] <= 32'hFE645783;
    mem['h02FC] <= 32'h00F707B3;
    mem['h02FD] <= 32'hFEF41323;
    mem['h02FE] <= 32'h00100793;
    mem['h02FF] <= 32'hFAF40F23;
    mem['h0300] <= 32'h01300593;
    mem['h0301] <= 32'h00200513;
    mem['h0302] <= 32'hCF9FF0EF;
    mem['h0303] <= 32'h00050793;
    mem['h0304] <= 32'hFEF405A3;
    mem['h0305] <= 32'hCB9FF0EF;
    mem['h0306] <= 32'h00050793;
    mem['h0307] <= 32'hFEF402A3;
    mem['h0308] <= 32'hFE544783;
    mem['h0309] <= 32'h00079A63;
    mem['h030A] <= 32'h00300793;
    mem['h030B] <= 32'hFEF406A3;
    mem['h030C] <= 32'hFE040623;
    mem['h030D] <= 32'h0140006F;
    mem['h030E] <= 32'h00300793;
    mem['h030F] <= 32'hFEF406A3;
    mem['h0310] <= 32'h02400793;
    mem['h0311] <= 32'hFEF40623;
    mem['h0312] <= 32'hFE845703;
    mem['h0313] <= 32'h00700793;
    mem['h0314] <= 32'h02F777B3;
    mem['h0315] <= 32'hFEF41723;
    mem['h0316] <= 32'hFEE45783;
    mem['h0317] <= 32'hFED44703;
    mem['h0318] <= 32'hFEC44603;
    mem['h0319] <= 32'hFEB44683;
    mem['h031A] <= 32'h00070593;
    mem['h031B] <= 32'h00078513;
    mem['h031C] <= 32'hAA1FF0EF;
    mem['h031D] <= 32'h00050793;
    mem['h031E] <= 32'h00F037B3;
    mem['h031F] <= 32'h0FF7F793;
    mem['h0320] <= 32'h0017C793;
    mem['h0321] <= 32'h0FF7F793;
    mem['h0322] <= 32'hFCF400A3;
    mem['h0323] <= 32'hFC144783;
    mem['h0324] <= 32'h0017F793;
    mem['h0325] <= 32'hFCF400A3;
    mem['h0326] <= 32'hFC042C23;
    mem['h0327] <= 32'h0900006F;
    mem['h0328] <= 32'hFC042A23;
    mem['h0329] <= 32'h0700006F;
    mem['h032A] <= 32'hFD842703;
    mem['h032B] <= 32'h00070793;
    mem['h032C] <= 32'h00279793;
    mem['h032D] <= 32'h00E787B3;
    mem['h032E] <= 32'h00379793;
    mem['h032F] <= 32'h00078713;
    mem['h0330] <= 32'hFD442783;
    mem['h0331] <= 32'h00F707B3;
    mem['h0332] <= 32'h07C00713;
    mem['h0333] <= 32'h00F707B3;
    mem['h0334] <= 32'h0007C683;
    mem['h0335] <= 32'hFD842703;
    mem['h0336] <= 32'h00070793;
    mem['h0337] <= 32'h00279793;
    mem['h0338] <= 32'h00E787B3;
    mem['h0339] <= 32'h00379793;
    mem['h033A] <= 32'h00078713;
    mem['h033B] <= 32'hFD442783;
    mem['h033C] <= 32'h00F707B3;
    mem['h033D] <= 32'h00279713;
    mem['h033E] <= 32'h052007B7;
    mem['h033F] <= 32'h00F707B3;
    mem['h0340] <= 32'h00068713;
    mem['h0341] <= 32'h00E7A023;
    mem['h0342] <= 32'hFD442783;
    mem['h0343] <= 32'h00178793;
    mem['h0344] <= 32'hFCF42A23;
    mem['h0345] <= 32'hFD442703;
    mem['h0346] <= 32'h02700793;
    mem['h0347] <= 32'hF8E7D6E3;
    mem['h0348] <= 32'hFD842783;
    mem['h0349] <= 32'h00178793;
    mem['h034A] <= 32'hFCF42C23;
    mem['h034B] <= 32'hFD842703;
    mem['h034C] <= 32'h01D00793;
    mem['h034D] <= 32'hF6E7D6E3;
    mem['h034E] <= 32'hFC042823;
    mem['h034F] <= 32'h0B00006F;
    mem['h0350] <= 32'hFC042623;
    mem['h0351] <= 32'h0900006F;
    mem['h0352] <= 32'hFEE45483;
    mem['h0353] <= 32'hFED44783;
    mem['h0354] <= 32'h00078613;
    mem['h0355] <= 32'hFCC42583;
    mem['h0356] <= 32'hFD042503;
    mem['h0357] <= 32'h8C9FF0EF;
    mem['h0358] <= 32'h00050693;
    mem['h0359] <= 32'h00000713;
    mem['h035A] <= 32'h00449793;
    mem['h035B] <= 32'h00F707B3;
    mem['h035C] <= 32'h00D787B3;
    mem['h035D] <= 32'h0007C783;
    mem['h035E] <= 32'h04078863;
    mem['h035F] <= 32'hFEE45783;
    mem['h0360] <= 32'h00178693;
    mem['h0361] <= 32'hFEB44703;
    mem['h0362] <= 32'hFCC42783;
    mem['h0363] <= 32'h00F70733;
    mem['h0364] <= 32'h00070793;
    mem['h0365] <= 32'h00279793;
    mem['h0366] <= 32'h00E787B3;
    mem['h0367] <= 32'h00379793;
    mem['h0368] <= 32'h00078613;
    mem['h0369] <= 32'hFEC44703;
    mem['h036A] <= 32'hFD042783;
    mem['h036B] <= 32'h00F707B3;
    mem['h036C] <= 32'h00F607B3;
    mem['h036D] <= 32'h00279713;
    mem['h036E] <= 32'h052007B7;
    mem['h036F] <= 32'h00F707B3;
    mem['h0370] <= 32'h00068713;
    mem['h0371] <= 32'h00E7A023;
    mem['h0372] <= 32'hFCC42783;
    mem['h0373] <= 32'h00178793;
    mem['h0374] <= 32'hFCF42623;
    mem['h0375] <= 32'hFCC42703;
    mem['h0376] <= 32'h00300793;
    mem['h0377] <= 32'hF6E7D6E3;
    mem['h0378] <= 32'hFD042783;
    mem['h0379] <= 32'h00178793;
    mem['h037A] <= 32'hFCF42823;
    mem['h037B] <= 32'hFD042703;
    mem['h037C] <= 32'h00300793;
    mem['h037D] <= 32'hF4E7D6E3;
    mem['h037E] <= 32'hFC0405A3;
    mem['h037F] <= 32'hFC040523;
    mem['h0380] <= 32'hFC0404A3;
    mem['h0381] <= 32'hFC040423;
    mem['h0382] <= 32'hFC0403A3;
    mem['h0383] <= 32'hC05FF06F;
    mem['h0384] <= 32'hFE010113;
    mem['h0385] <= 32'h00112E23;
    mem['h0386] <= 32'h00812C23;
    mem['h0387] <= 32'h02010413;
    mem['h0388] <= 32'h00050793;
    mem['h0389] <= 32'hFEF407A3;
    mem['h038A] <= 32'hFEF44703;
    mem['h038B] <= 32'h00A00793;
    mem['h038C] <= 32'h00F71663;
    mem['h038D] <= 32'h00D00513;
    mem['h038E] <= 32'hFD9FF0EF;
    mem['h038F] <= 32'h020007B7;
    mem['h0390] <= 32'h00878793;
    mem['h0391] <= 32'hFEF44703;
    mem['h0392] <= 32'h00E7A023;
    mem['h0393] <= 32'h00000013;
    mem['h0394] <= 32'h01C12083;
    mem['h0395] <= 32'h01812403;
    mem['h0396] <= 32'h02010113;
    mem['h0397] <= 32'h00008067;
    mem['h0398] <= 32'hFE010113;
    mem['h0399] <= 32'h00112E23;
    mem['h039A] <= 32'h00812C23;
    mem['h039B] <= 32'h02010413;
    mem['h039C] <= 32'hFEA42623;
    mem['h039D] <= 32'h01C0006F;
    mem['h039E] <= 32'hFEC42783;
    mem['h039F] <= 32'h00178713;
    mem['h03A0] <= 32'hFEE42623;
    mem['h03A1] <= 32'h0007C783;
    mem['h03A2] <= 32'h00078513;
    mem['h03A3] <= 32'hF85FF0EF;
    mem['h03A4] <= 32'hFEC42783;
    mem['h03A5] <= 32'h0007C783;
    mem['h03A6] <= 32'hFE0790E3;
    mem['h03A7] <= 32'h00000013;
    mem['h03A8] <= 32'h00000013;
    mem['h03A9] <= 32'h01C12083;
    mem['h03AA] <= 32'h01812403;
    mem['h03AB] <= 32'h02010113;
    mem['h03AC] <= 32'h00008067;
    mem['h03AD] <= 32'hFD010113;
    mem['h03AE] <= 32'h02812623;
    mem['h03AF] <= 32'h03010413;
    mem['h03B0] <= 32'hFCA42E23;
    mem['h03B1] <= 32'hFCB42C23;
    mem['h03B2] <= 32'hFD842783;
    mem['h03B3] <= 32'hFFF78793;
    mem['h03B4] <= 32'h00279793;
    mem['h03B5] <= 32'hFEF42623;
    mem['h03B6] <= 32'h03C0006F;
    mem['h03B7] <= 32'hFEC42783;
    mem['h03B8] <= 32'hFDC42703;
    mem['h03B9] <= 32'h00F757B3;
    mem['h03BA] <= 32'h00F7F793;
    mem['h03BB] <= 32'h00101737;
    mem['h03BC] <= 32'hF4070713;
    mem['h03BD] <= 32'h00F707B3;
    mem['h03BE] <= 32'h0007C703;
    mem['h03BF] <= 32'h020007B7;
    mem['h03C0] <= 32'h00878793;
    mem['h03C1] <= 32'h00E7A023;
    mem['h03C2] <= 32'hFEC42783;
    mem['h03C3] <= 32'hFFC78793;
    mem['h03C4] <= 32'hFEF42623;
    mem['h03C5] <= 32'hFEC42783;
    mem['h03C6] <= 32'hFC07D2E3;
    mem['h03C7] <= 32'h00000013;
    mem['h03C8] <= 32'h00000013;
    mem['h03C9] <= 32'h02C12403;
    mem['h03CA] <= 32'h03010113;
    mem['h03CB] <= 32'h00008067;
    mem['h03CC] <= 32'h72746554;
    mem['h03CD] <= 32'h72615369;
    mem['h03CE] <= 32'h0A216A61;
    mem['h03CF] <= 32'h00000000;
    mem['h03D0] <= 32'h33323130;
    mem['h03D1] <= 32'h37363534;
    mem['h03D2] <= 32'h42413938;
    mem['h03D3] <= 32'h46454443;
    mem['h03D4] <= 32'h00000000;
    mem['h03D5] <= 32'h01010101;
    mem['h03D6] <= 32'h00000000;
    mem['h03D7] <= 32'h00000000;
    mem['h03D8] <= 32'h00000000;
    mem['h03D9] <= 32'h00010000;
    mem['h03DA] <= 32'h00010100;
    mem['h03DB] <= 32'h00010000;
    mem['h03DC] <= 32'h00000000;
    mem['h03DD] <= 32'h00000000;
    mem['h03DE] <= 32'h00010100;
    mem['h03DF] <= 32'h00010100;
    mem['h03E0] <= 32'h00000000;
    mem['h03E1] <= 32'h00010000;
    mem['h03E2] <= 32'h00010100;
    mem['h03E3] <= 32'h00000100;
    mem['h03E4] <= 32'h00000000;
    mem['h03E5] <= 32'h00000100;
    mem['h03E6] <= 32'h00010100;
    mem['h03E7] <= 32'h00010000;
    mem['h03E8] <= 32'h00000000;
    mem['h03E9] <= 32'h00000100;
    mem['h03EA] <= 32'h00000100;
    mem['h03EB] <= 32'h00010100;
    mem['h03EC] <= 32'h00000000;
    mem['h03ED] <= 32'h00010000;
    mem['h03EE] <= 32'h00010000;
    mem['h03EF] <= 32'h00010100;
    mem['h03F0] <= 32'h00000000;
    mem['h03F1] <= 32'h00002710;
    mem['h03F2] <= 32'h075BCD15;
    mem['h03F3] <= 32'h075BCD15;

  end

  always @(posedge clk) mem_data <= mem[mem_addr];

  // ============================================================================

  reg o_ready;

  always @(posedge clk or negedge rstn)
    if (!rstn) o_ready <= 1'd0;
    else o_ready <= valid && ((addr & MEM_ADDR_MASK) != 0);

  // Output connectins
  assign ready    = o_ready;
  assign rdata    = mem_data;
  assign mem_addr = addr[MEM_SIZE_BITS+1:2];

  always @(posedge clk) begin    
    if (wen) mem[waddr] <= wdata;				
  end

endmodule