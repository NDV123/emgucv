﻿//----------------------------------------------------------------------------
//  Copyright (C) 2004-2015 by EMGU Corporation. All rights reserved.       
//----------------------------------------------------------------------------

using System;
using System.IO;
using System.Diagnostics;
using System.Collections.Generic;
using System.Drawing;

using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;
using Android.Graphics;

using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.Util;

using TrafficSignRecognition;

namespace AndroidExamples
{
   [Activity(Label = "Traffic Sign Recognition")]
   public class TrafficSignRecognitionActivity : ButtonMessageImageActivity
   {
      public TrafficSignRecognitionActivity()
         : base("Find Stop Sign")
      {
      }

      protected override void OnCreate(Bundle bundle)
      {
         base.OnCreate(bundle);

         OnButtonClick += delegate 
         { 
            using (Image<Bgr, byte> stopSignModel = new Image<Bgr, byte>(Assets, "stop-sign-model.png"))
            using (Image<Bgr, Byte> image = PickImage("stop-sign.jpg"))
            {             
               if (image == null)
                  return;

               Stopwatch watch = Stopwatch.StartNew(); // time the detection process

               List<Mat> stopSignList = new List<Mat>();
               List<Rectangle> stopSignBoxList = new List<Rectangle>();
               StopSignDetector detector = new StopSignDetector(stopSignModel);
               detector.DetectStopSign(image.Mat, stopSignList, stopSignBoxList);

               watch.Stop(); //stop the timer
               SetMessage(String.Format("Detection time: {0} milli-seconds", watch.Elapsed.TotalMilliseconds));

               foreach (Rectangle rect in stopSignBoxList)
                  image.Draw(rect, new Bgr(System.Drawing.Color.Red), 2);

               SetImageBitmap(image.ToBitmap());
            }
         };
      }
   }
}

