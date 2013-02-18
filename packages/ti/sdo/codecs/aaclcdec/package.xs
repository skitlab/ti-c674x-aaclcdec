/*
 *  ======== package.xs ========
 *
 */

/*
 *  ======== getLibs ========
 */
function getLibs(prog)
{
    var lib = null;
  
    if ((prog.build.target.isa == "674") ||  (prog.build.target.isa == "64P")){        
        if ( this.AACLCDEC.watermark == false ) {
                lib = "lib/aacdec_tii_lc_elf.l64P";
        }
        else {
                lib = null;
        }
        print("    will link with " + this.$name + ":" + lib);
    }
    return (lib);
}

/*
 *  ======== getSects ========
 */
function getSects()
{
    var template = null;

    if ((Program.build.target.isa == "674") || (Program.build.target.isa == "64P")) {
        template = "ti/sdo/codecs/aaclcdec/link.xdt";
    }

    return (template);
}
