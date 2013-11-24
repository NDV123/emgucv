﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Emgu.CV.UI.GLView
{
   public struct GeometricChange
   {
      public int Rotation;
      public Emgu.CV.CvEnum.FLIP FlipMode;

      public bool IsEmpty
      {
         get
         {
            return Rotation == 0 && FlipMode == Emgu.CV.CvEnum.FLIP.NONE;
         }
      }
   }
}
