

#include <stdio.h>
#include "cache_c674x.h"

#define L2CFG    (volatile UInt32 *)0x01840000
#define L1PCFG   (volatile UInt32 *)0x01840020
#define L1PCC    (volatile UInt32 *)0x01840024
#define L1DCFG   (volatile UInt32 *)0x01840040
#define L1DCC    (volatile UInt32 *)0x01840044
#define L2WBAR   (volatile UInt32 *)0x01844000
#define L2WWC    (volatile UInt32 *)0x01844004
#define L2WIBAR  (volatile UInt32 *)0x01844010
#define L2IBAR   (volatile UInt32 *)0x01844018
#define L2WB     (volatile UInt32 *)0x01845000
#define L2WBINV  (volatile UInt32 *)0x01845004
#define L1PINV   (volatile UInt32 *)0x01845028
#define MAR      (volatile UInt32 *)0x01848000
#define MAR128   (volatile UInt32 *)0x01848200
#define MAR129   (volatile UInt32 *)0x01848204
#define MAR130   (volatile UInt32 *)0x01848208
#define MAR131   (volatile UInt32 *)0x0184820C
#define MAR192   (volatile UInt32 *)0x01848300
#define MAR193   (volatile UInt32 *)0x01848304
#define MAR194   (volatile UInt32 *)0x01848308
#define MAR195   (volatile UInt32 *)0x0184830C

#define MAXWC    0xFF00      /* Max word count per cache operations */


/*
 *  ======== Cache_setSize ========
 *  Set the L1D, L1P, and L2 cache sizes
 */
void Cache_setSize()
{
   // 32KB L1P
    *L1PCFG  = (*L1PCFG | 0x4);

    // 32KB L1D
    *L1DCFG  = (*L1DCFG | 0x4);

    //Reset L2 settings first
    *L2CFG  = (*L2CFG & 0x8);

    
    // 32KB L2
    //*L2CFG  = (*L2CFG | 0x1);

    // 64KB L2
    *L2CFG  = (*L2CFG | 0x2);

    // 128KB L2
    //*L2CFG  = (*L2CFG | 0x3);

    // 256KB L2
    //*L2CFG  = (*L2CFG | 0x4);


	//Map required address space to L2 cache

    //Map from 0x80000000 - 0x80FFFFFF
    *MAR128  = (*MAR128 | 0x1);
    //Map from 0x81000000 - 0x81FFFFFF
    *MAR129  = (*MAR129 | 0x1);
    //Map from 0x82000000 - 0x82FFFFFF
    *MAR130  = (*MAR130 | 0x1);
    //Map from 0x83000000 - 0x83FFFFFF
    *MAR131  = (*MAR131 | 0x1);
  

    //Map from 0xC0000000 -  0xC0FFFFFF
    *MAR192  = (*MAR192 | 0x1);
    //Map from 0xC1000000 -  0xC1FFFFFF
    *MAR193  = (*MAR193 | 0x1);
    //Map from 0xC2000000 -  0xC2FFFFFF
    *MAR194  = (*MAR194 | 0x1);
    //Map from 0xC3000000 -  0xC3FFFFFF
    *MAR195  = (*MAR195 | 0x1);

}


/*
 *  ======== Cache_wait ========
 *  Wait for the L2 count to complete.  This function needs only to wait
 *  for L2 word count since all block cache operations in BIOS are done
 *  through the L2 registers and all global cache operations must already
 *  wait until the operation completes.  Note:  Its sufficient to wait
 *  on one of the L2 count registers since all 3 count registers are
 *  mirrors of one another and map to the same bits.
 */
void Cache_wait()
{
    /* wait for L2 word count to be zero */
    while (*L2WWC != 0) {
        ;
    }
}

/*
 *  ======== all ========
 */
static void all(volatile UInt32 *cacheReg)
{
    /* wait for any previous cache operation to complete */
    Cache_wait();

    /* perform global write back of cache */
    *cacheReg = 1;

    /* wait until cache operation completes */
    while (*cacheReg) {
        ;
    }
}

/*
 *  ======== block ========
 *  This is a static function used by the block cache APIs.
 */
static void block(void* blockPtr, SizeT byteCnt, unsigned char wait,
    volatile UInt32 *barReg)
{
    volatile UInt32 *bar;
    volatile UInt32 *wc;
	UInt32 * emifAddr = NULL;
    short wordCnt;
    UInt32 alignAddr;

    /*
     *  Get the base address and word count register.
     *  wc is one word after bar on c64x+ cache.
     */
    bar = barReg;
    wc = bar + 1;

    /* word align the base address */
    alignAddr = ((UInt32)blockPtr & ~3);

    /* convert from byte to word since cache operation takes words */
    wordCnt = (byteCnt + 3 + ((UInt32)blockPtr - alignAddr)) >> 2;

    /* loop until word count is zero or less */
    while (wordCnt > 0) {

        /* wait for any previous cache operation to complete */
        Cache_wait();

        /* get the emif config for the address */
        emifAddr = (UInt32 *)alignAddr;

        /* set the word address and number of words to invalidate */
        *bar = alignAddr;
        *wc = (wordCnt > MAXWC) ? MAXWC : wordCnt;

        /*
         * reduce word count by _BCACHE_MAXWC and
         * increase base address by BCACHE_MAXWC
         */
        wordCnt -= MAXWC;
        alignAddr += (MAXWC * sizeof(short));
    }

    /* wait for cache operation to complete */
    if (wait) {
        Cache_wait();

		if (emifAddr != NULL) {
	        *(emifAddr) = 0;
	    }

    }
}


/*
 *  ======== Cache_invL1pAll ========
 *  Performs a global invalidate of L1P cache.
 *  Polls the L1P invalidate register until done.
 */
void Cache_invL1pAll()
{
    all(L1PINV);
}

/*
 *  ======== Cache_wbAll ========
 *  Perform a global write back.  There is no effect on L1P cache.  All cache
 *  lines are left valid in L1D cache and the data in L1D cache is written
 *  back L2 or external.  All cache lines are left valid in L2 cache and the
 *  data in L2 cache is written back to external.
 */
void Cache_wbAll()
{
    all(L2WB);
}

/*
 *  ======== Cache_wbInvAll ========
 *  Performs a global write back and invalidate.  All cache lines are
 *  invalidated in L1P cache.  All cache lines are written back to L2 or
 *  or external then invalidated in L1D cache.  All cache lines are
 *  written back to external and then invalidated in L2 cache.
 */
void Cache_wbInvAll()
{
    all(L2WBINV);
}

/*
 *  ======== Cache_inv ========
 *  Invalidate the range of memory within the specified starting address and
 *  byte count.  The range of addresses operated on gets quantized to whole
 *  cache lines in each cache.  All cache lines in range are invalidated in L1P
 *  cache.  All cache lines in range are invalidated in L1D cache.
 *  All cache lines in range are invaliated in L2 cache.
 */
void Cache_inv(void* blockPtr, SizeT byteCnt, Bits16 type, unsigned char wait)
{
    block(blockPtr, byteCnt, wait, L2IBAR);
}

/*
 *  ======== Cache_wb ========
 *  Writes back the range of memory within the specified starting address
 *  and byte count.  The range of addresses operated on gets quantized to
 *  whole cache lines in each cache.  There is no effect on L1P cache.
 *  All cache lines within the range are left valid in L1D cache and the data
 *  within the range in L1D cache will be written back to L2 or external.
 *  All cache lines within the range are left valid in L2 cache and the data
 *  within the range in L2 cache will be written back to external.
 */
void Cache_wb(void* blockPtr, SizeT byteCnt, Bits16 type, unsigned char wait)
{
    block(blockPtr, byteCnt, wait, L2WBAR);
}

/*
 *  ======== Cache_wbInv ========
 *  Writes back and invalidates the range of memory within the specified
 *  starting address and byte count.  The range of addresses operated on gets
 *  quantized to whole cache lines in each cache.  All cache lines within range
 *  are invalidated in L1P cache.  All cache lines within the range are
 *  written back to L2 or external and then invalidated in L1D cache
 *  All cache lines within the range are written back to external and then
 *  invalidated in L2 cache.
 */
void Cache_wbInv(void* blockPtr, SizeT byteCnt, Bits16 type, unsigned char wait)
{
    block(blockPtr, byteCnt, wait, L2WIBAR);
}


