

#include <stdio.h>


typedef unsigned int UInt32;
typedef unsigned short UInt;
typedef short Bits16;
typedef int SizeT;


/*
 *  ======== Cache_setSize ========
 *  Set the L1D, L1P, and L2 cache sizes
 */
void Cache_setSize();


/*
 *  ======== Cache_wait ========
 *  Wait for the L2 count to complete.  This function needs only to wait
 *  for L2 word count since all block cache operations in BIOS are done
 *  through the L2 registers and all global cache operations must already
 *  wait until the operation completes.  Note:  Its sufficient to wait
 *  on one of the L2 count registers since all 3 count registers are
 *  mirrors of one another and map to the same bits.
 */
void Cache_wait();
/*
 *  ======== all ========
 */
static void all(volatile UInt32 *cacheReg);
/*
 *  ======== block ========
 *  This is a static function used by the block cache APIs.
 */
static void block(void* blockPtr, SizeT byteCnt, unsigned char wait,
    volatile UInt32 *barReg);


/*
 *  ======== Cache_invL1pAll ========
 *  Performs a global invalidate of L1P cache.
 *  Polls the L1P invalidate register until done.
 */
void Cache_invL1pAll();

/*
 *  ======== Cache_wbAll ========
 *  Perform a global write back.  There is no effect on L1P cache.  All cache
 *  lines are left valid in L1D cache and the data in L1D cache is written
 *  back L2 or external.  All cache lines are left valid in L2 cache and the
 *  data in L2 cache is written back to external.
 */
void Cache_wbAll();

/*
 *  ======== Cache_wbInvAll ========
 *  Performs a global write back and invalidate.  All cache lines are
 *  invalidated in L1P cache.  All cache lines are written back to L2 or
 *  or external then invalidated in L1D cache.  All cache lines are
 *  written back to external and then invalidated in L2 cache.
 */
void Cache_wbInvAll();

/*
 *  ======== Cache_inv ========
 *  Invalidate the range of memory within the specified starting address and
 *  byte count.  The range of addresses operated on gets quantized to whole
 *  cache lines in each cache.  All cache lines in range are invalidated in L1P
 *  cache.  All cache lines in range are invalidated in L1D cache.
 *  All cache lines in range are invaliated in L2 cache.
 */
void Cache_inv(void* blockPtr, SizeT byteCnt, Bits16 type, unsigned char wait);
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
void Cache_wb(void* blockPtr, SizeT byteCnt, Bits16 type, unsigned char wait);

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
void Cache_wbInv(void* blockPtr, SizeT byteCnt, Bits16 type, unsigned char wait);


