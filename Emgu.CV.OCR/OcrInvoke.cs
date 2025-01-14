﻿//----------------------------------------------------------------------------
//  Copyright (C) 2004-2015 by EMGU Corporation. All rights reserved.       
//----------------------------------------------------------------------------

#if !NETFX_CORE

using System;
using System.Collections.Generic;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Text;
using System.IO;
using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.Util;
using System.Diagnostics;

namespace Emgu.CV.OCR
{
   /// <summary>
   /// Library to invoke Tesseract OCR functions
   /// </summary>
   public static class OcrInvoke
   {
      static OcrInvoke()
      {
         //dummy code that is used to involve the static constructor of CvInvoke, if it has not already been called.
         CvInvoke.CheckLibraryLoaded();
      }

      #region Tesseract
      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern IntPtr TessBaseAPICreate();

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern int TessBaseAPIInit(
         IntPtr ocr,
         [MarshalAs(CvInvoke.StringMarshalType)]
         String dataPath,
         [MarshalAs(CvInvoke.StringMarshalType)]
         String language,
         OcrEngineMode mode);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern void TessBaseAPIRelease(ref IntPtr ocr);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern void TessBaseAPIRecognizeArray(IntPtr ocr, IntPtr image);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern void TessBaseAPIGetUTF8Text(
         IntPtr ocr,
         IntPtr text);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern void TessBaseAPIExtractResult(IntPtr ocr, IntPtr charSeq, IntPtr resultSeq);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      [return: MarshalAs(CvInvoke.BoolMarshalType)]
      internal static extern bool TessBaseAPISetVariable(
         IntPtr ocr,
         [MarshalAs(CvInvoke.StringMarshalType)]
         String varName,
         [MarshalAs(CvInvoke.StringMarshalType)]
         String value);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern IntPtr TesseractGetVersion();

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern void TessBaseAPISetPageSegMode(IntPtr ocr, PageSegMode mode);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern PageSegMode TessBaseAPIGetPageSegMode(IntPtr ocr);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern int TessBaseAPIGetOpenCLDevice(IntPtr ocr, ref IntPtr device);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern IntPtr TessBaseAPIAnalyseLayout(
         IntPtr ocr,
         [MarshalAs(CvInvoke.BoolMarshalType)]
         bool mergeSimilarWords);
      #endregion

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern void TessPageIteratorRelease(ref IntPtr iterator);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      internal static extern void TessPageIteratorGetOrientation(IntPtr iterator, ref PageOrientation orientation, ref WritingDirection writingDirection, ref TextlineOrder order, ref float deskewAngle);

      [DllImport(CvInvoke.ExternLibrary, CallingConvention = CvInvoke.CvCallingConvention)]
      [return: MarshalAs(CvInvoke.BoolMarshalType)]
      internal static extern bool TessPageIteratorGetBaseLine(
         IntPtr iterator,
         PageIteratorLevel level,
         ref int x1, ref int y1, ref int x2, ref int y2);

   }
}
#endif
