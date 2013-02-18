/** ==================================================================
* Copyright (c) Texas Instruments Inc 2006
*
* Use of this software is controlled by the terms and conditions found
in the license agreement under which this software has been supplied *
=====================================================================*/

-c
-heap  0x170000
-stack 0x11000

/* Memory Map 1 - the default */
MEMORY
{
    RAM_MEMORY:    o = 80001000h   l = 001D0000h   /* .bss, .sysmem, .stack, .cinit */
    ROM_MEMORY:    o = 801D1000h   l = 00E30000h 

} 

SECTIONS
{
    .stack      >       RAM_MEMORY
    .bss        >       RAM_MEMORY
    .cinit      >       ROM_MEMORY
    .cio        >       RAM_MEMORY 
    .data       >       RAM_MEMORY
    .switch     >       ROM_MEMORY 
    .sysmem     >       RAM_MEMORY
    .far        >       RAM_MEMORY

    .bios > RAM_MEMORY


    GROUP : {
            /* API functions */
            .text:algAlloc:_AACDEC_TII_algAlloc
            .text:algNumAlloc:_AACDEC_TII_algNumAlloc
            .text:algInit:_AACDEC_TII_algInit
            .text:algFree:_AACDEC_TII_algFree

            .text:_AACDEC_TII_control
            .text:_AACDEC_TII_getStatus
            .text:_AACDEC_TII_reset
            .text:_AACDEC_TII_decode

            /* Decoder functions */

            .text:_AACDEC_TII_Decoder 
            .text:_AACDEC_TII_SyncCheck 
            .text:_AACDEC_TII_SuperSyncSeek 
            .text:_AACDEC_TII_SyncSeek 
            .text:_AACDEC_TII_GetAdifHeader 
            .text:_AACDEC_TII_DecodeBlock
            .text:_AACDEC_TII_Set_Pointers  
            .text:_AACDEC_TII_ParseBlock
            .text:_AACDEC_TII_DQCoef  
            .text:_AACDEC_TII_ParseBlock_Adts_Header
            .text:_AACDEC_TII_Parse_Element
            .text:_AACDEC_TII_GetAdtsHeader 
            .text:_AACDEC_TII_GetBits 
            .text:_AACDEC_TII_ParseChannelElement
            .text:_AACDEC_TII_EnterChannel 
            .text:_AACDEC_TII_GetIcsInfo 
            .text:_AACDEC_TII_Infoinit 
            .text:_AACDEC_TII_GetGroup 
            .text:_AACDEC_TII_CalcGsfbTable 
            .text:_AACDEC_TII_GetMask 
            .text:_AACDEC_TII_GetIcs 
            .text:_AACDEC_TII_Huffcb 
            .text:_AACDEC_TII_Hufffac
            .text:_AACDEC_TII_GetPrefix  
            .text:_AACDEC_TII_HuffDecodeLoop0 
            .text:_AACDEC_TII_HuffDecodeLoop1 
            .text:_AACDEC_TII_HuffDecodeLoop2 
            .text:_AACDEC_TII_HuffDecodeLoop3 
            .text:_AACDEC_TII_HuffDecodeLoop4 
            .text:_AACDEC_TII_HuffDecodeLoop5 
            .text:_AACDEC_TII_CB_11_Handler 
            .text:_AACDEC_TII_get_pulse_nc 
            .text:_AACDEC_TII_pulse_nc 
            .text:_AACDEC_TII_GetTns 
            .text:_AACDEC_TII_Huffspec 
            .text:_AACDEC_TII_GetProgConfig 
            .text:_AACDEC_TII_GetFill 
            .text:_AACDEC_TII_GetData 
            .text:_AACDEC_TII_BitstreamSetBookmark 
            .text:_AACDEC_TII_BitstreamDistanceFromBookmark
            .text:_AACDEC_TII_BitstreamGotoBookmark 
            .text:_AACDEC_TII_AccumulateCRCFromStream
            .text:_AACDEC_TII_AccumulateCRCWord 
            .text:_AACDEC_TII_IntensityStereo 
            .text:_AACDEC_TII_MapMask 
            .text:_AACDEC_TII_Intensity 
            .text:_AACDEC_TII_InverseQuantizer 
            .text:_AACDEC_TII_InverseQuantize 
            .text:_AACDEC_TII_Rescale 
            .text:_AACDEC_TII_MS_Stereo 
            .text:_AACDEC_TII_MSTool 
            .text:_AACDEC_TII_ScalefactorToQpt 
            .text:_AACDEC_TII_FindMaxQptInCh 
            .text:_AACDEC_TII_AdjustQptInCh 
            .text:_AACDEC_TII_deinterleave 
            .text:_AACDEC_TII_ApplyPNS 
            .text:_AACDEC_TII_GenRandVector 
            .text:_AACDEC_TII_Random 
            .text:_AACDEC_TII_TnsDecodeSubblock2
            .text:_AACDEC_TII_TnsDecodeCoef 
            .text:_AACDEC_TII_TnsPostscale 
            .text:_AACDEC_TII_DetermineQpt 
            .text:_AACDEC_TII_TnsArFilter 
            .text:_AACDEC_TII_IFilterBank
            .text:_AACDEC_TII_Post_Processing 
            .text:_AACDEC_TII_IMDCTWrapper 
            .text:_AACDEC_TII_PreTwiddle 
            .text:_AACDEC_TII_BitReverse 
            .text:_AACDEC_TII_IFFT 
            .text:_AACDEC_TII_IFFTStage1and2 
            .text:_AACDEC_TII_IFFTStage3 
            .text:_AACDEC_TII_IFFTStagex 
            .text:_AACDEC_TII_PostTwiddle 
            .text:_AACDEC_TII_StateBookkeeping 
            .text:_AACDEC_TII_WinOvaddLong 
            .text:_AACDEC_TII_ShortWindowing 
            .text:_AACDEC_TII_WinOvaddShort 
            .text:_AACDEC_TII_WinLFT 
            .text:_AACDEC_TII_WinLFF 
            .text:_AACDEC_TII_WinEFT 
            .text:_AACDEC_TII_WinEFF 
            .text:_AACDEC_TII_WinMFT 
            .text:_AACDEC_TII_WinMFF 
            .text:_AACDEC_TII_Rounding 
            .text:_AACDEC_TII_Rounding_16bit 
            .text:_AACDEC_TII_Rounding_24bit 
            .text:_AACDEC_TII_MonoToStereo 
            .text:_AACDEC_TII_StereoToMono 
            .text:_AACDEC_TII_DecoderErr 
            .text:_AACDEC_TII_init 
            .text:_AACDEC_TII_Restarttio
            .text:_AACDEC_TII_exit  
               
        } > ROM_MEMORY

    .text > ROM_MEMORY
    .const > ROM_MEMORY              

}
