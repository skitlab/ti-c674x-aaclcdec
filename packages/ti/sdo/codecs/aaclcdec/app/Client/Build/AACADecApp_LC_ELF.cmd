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
    .rodata     >       RAM_MEMORY
    .neardata   >       RAM_MEMORY
    .fardata    >       RAM_MEMORY
    .far        >       RAM_MEMORY

    .bios > RAM_MEMORY


    GROUP : {
            /* API functions */
            .text:algAlloc:AACDEC_TII_algAlloc
            .text:algNumAlloc:AACDEC_TII_algNumAlloc
            .text:algInit:AACDEC_TII_algInit
            .text:algFree:AACDEC_TII_algFree

            .text:AACDEC_TII_control
            .text:AACDEC_TII_getStatus
            .text:AACDEC_TII_reset
            .text:AACDEC_TII_decode

            /* Decoder functions */

            .text:AACDEC_TII_Decoder 
            .text:AACDEC_TII_SyncCheck 
            .text:AACDEC_TII_SuperSyncSeek 
            .text:AACDEC_TII_SyncSeek 
            .text:AACDEC_TII_GetAdifHeader 
            .text:AACDEC_TII_DecodeBlock
            .text:AACDEC_TII_Set_Pointers  
            .text:AACDEC_TII_ParseBlock
            .text:AACDEC_TII_DQCoef  
            .text:AACDEC_TII_ParseBlock_Adts_Header
            .text:AACDEC_TII_Parse_Element
            .text:AACDEC_TII_GetAdtsHeader 
            .text:AACDEC_TII_GetBits 
            .text:AACDEC_TII_ParseChannelElement
            .text:AACDEC_TII_EnterChannel 
            .text:AACDEC_TII_GetIcsInfo 
            .text:AACDEC_TII_Infoinit 
            .text:AACDEC_TII_GetGroup 
            .text:AACDEC_TII_CalcGsfbTable 
            .text:AACDEC_TII_GetMask 
            .text:AACDEC_TII_GetIcs 
            .text:AACDEC_TII_Huffcb 
            .text:AACDEC_TII_Hufffac
            .text:AACDEC_TII_GetPrefix  
            .text:AACDEC_TII_HuffDecodeLoop0 
            .text:AACDEC_TII_HuffDecodeLoop1 
            .text:AACDEC_TII_HuffDecodeLoop2 
            .text:AACDEC_TII_HuffDecodeLoop3 
            .text:AACDEC_TII_HuffDecodeLoop4 
            .text:AACDEC_TII_HuffDecodeLoop5 
            .text:AACDEC_TII_CB_11_Handler 
            .text:AACDEC_TII_get_pulse_nc 
            .text:AACDEC_TII_pulse_nc 
            .text:AACDEC_TII_GetTns 
            .text:AACDEC_TII_Huffspec 
            .text:AACDEC_TII_GetProgConfig 
            .text:AACDEC_TII_GetFill 
            .text:AACDEC_TII_GetData 
            .text:AACDEC_TII_BitstreamSetBookmark 
            .text:AACDEC_TII_BitstreamDistanceFromBookmark
            .text:AACDEC_TII_BitstreamGotoBookmark 
            .text:AACDEC_TII_AccumulateCRCFromStream
            .text:AACDEC_TII_AccumulateCRCWord 
            .text:AACDEC_TII_IntensityStereo 
            .text:AACDEC_TII_MapMask 
            .text:AACDEC_TII_Intensity 
            .text:AACDEC_TII_InverseQuantizer 
            .text:AACDEC_TII_InverseQuantize 
            .text:AACDEC_TII_Rescale 
            .text:AACDEC_TII_MS_Stereo 
            .text:AACDEC_TII_MSTool 
            .text:AACDEC_TII_ScalefactorToQpt 
            .text:AACDEC_TII_FindMaxQptInCh 
            .text:AACDEC_TII_AdjustQptInCh 
            .text:AACDEC_TII_deinterleave 
            .text:AACDEC_TII_ApplyPNS 
            .text:AACDEC_TII_GenRandVector 
            .text:AACDEC_TII_Random 
            .text:AACDEC_TII_TnsDecodeSubblock2
            .text:AACDEC_TII_TnsDecodeCoef 
            .text:AACDEC_TII_TnsPostscale 
            .text:AACDEC_TII_DetermineQpt 
            .text:AACDEC_TII_TnsArFilter 
            .text:AACDEC_TII_IFilterBank
            .text:AACDEC_TII_Post_Processing 
            .text:AACDEC_TII_IMDCTWrapper 
            .text:AACDEC_TII_PreTwiddle 
            .text:AACDEC_TII_BitReverse 
            .text:AACDEC_TII_IFFT 
            .text:AACDEC_TII_IFFTStage1and2 
            .text:AACDEC_TII_IFFTStage3 
            .text:AACDEC_TII_IFFTStagex 
            .text:AACDEC_TII_PostTwiddle 
            .text:AACDEC_TII_StateBookkeeping 
            .text:AACDEC_TII_WinOvaddLong 
            .text:AACDEC_TII_ShortWindowing 
            .text:AACDEC_TII_WinOvaddShort 
            .text:AACDEC_TII_WinLFT 
            .text:AACDEC_TII_WinLFF 
            .text:AACDEC_TII_WinEFT 
            .text:AACDEC_TII_WinEFF 
            .text:AACDEC_TII_WinMFT 
            .text:AACDEC_TII_WinMFF 
            .text:AACDEC_TII_Rounding 
            .text:AACDEC_TII_Rounding_16bit 
            .text:AACDEC_TII_Rounding_24bit 
            .text:AACDEC_TII_MonoToStereo 
            .text:AACDEC_TII_StereoToMono 
            .text:AACDEC_TII_DecoderErr 
            .text:AACDEC_TII_init 
            .text:AACDEC_TII_Restarttio
            .text:AACDEC_TII_exit  
               
        } > ROM_MEMORY

    .text > ROM_MEMORY
    .const > ROM_MEMORY              

}
