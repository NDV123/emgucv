﻿//----------------------------------------------------------------------------
//  Copyright (C) 2004-2015 by EMGU Corporation. All rights reserved.       
//----------------------------------------------------------------------------

using System;

using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;

using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.Util;
using System.Drawing;
using Android.Graphics;
using PedestrianDetection;

namespace AndroidExamples
{
   [Activity(Label = "Pedestrian Detection")]
   public class PedestrianDetectionActivity : ButtonMessageImageActivity
   {
      public PedestrianDetectionActivity()
         : base("Detect Pedestrian")
      {
      }

      protected override void OnCreate(Bundle bundle)
      {
         base.OnCreate(bundle);

         OnButtonClick += delegate
         {
            long time;
            using (Image<Bgr, Byte> image = PickImage("pedestrian.png"))
            {
               if (image == null)
                  return;
               Rectangle[] pedestrians = FindPedestrian.Find(image.Mat, false, true, out time);

               SetMessage(String.Format("Detection completed with {1} in {0} milliseconds.", time, CvInvoke.UseOpenCL ? "OpenCL" : "CPU"));
               foreach (Rectangle rect in pedestrians)
               {
                  image.Draw(rect, new Bgr(System.Drawing.Color.Red), 2);
               }

               SetImageBitmap(image.ToBitmap());
            }
         };
      }
   }
}

