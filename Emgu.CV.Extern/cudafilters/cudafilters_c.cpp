//----------------------------------------------------------------------------
//
//  Copyright (C) 2004-2015 by EMGU Corporation. All rights reserved.
//
//----------------------------------------------------------------------------

#include "cudafilters_c.h"

cv::cuda::Filter* cudaCreateSobelFilter(int srcType, int dstType,  int dx, int dy, int ksize, double scale, int rowBorderType, int columnBorderType)
{
   cv::Ptr<cv::cuda::Filter> ptr =  cv::cuda::createSobelFilter(srcType, dstType, dx, dy, ksize, scale, rowBorderType, columnBorderType);
   ptr.addref();
   return ptr.get();
}

cv::cuda::Filter* cudaCreateGaussianFilter(int srcType, int dstType, emgu::size* ksize, double sigma1, double sigma2, int rowBorderType, int columnBorderType)
{
   cv::Size s(ksize->width, ksize->height);
   cv::Ptr<cv::cuda::Filter> ptr = cv::cuda::createGaussianFilter(srcType, dstType, s, sigma1, sigma2, rowBorderType, columnBorderType); 
   ptr.addref();
   return ptr.get();
}

cv::cuda::Filter* cudaCreateLaplacianFilter(int srcType, int dstType, int ksize, double scale, int borderMode, CvScalar* borderValue)
{
   cv::Ptr<cv::cuda::Filter> ptr = cv::cuda::createLaplacianFilter(srcType, dstType, ksize, scale, borderMode, *borderValue);
   ptr.addref();
   return ptr.get();
}

cv::cuda::Filter* cudaCreateLinearFilter(int srcType, int dstType, cv::_InputArray* kernel, CvPoint* anchor, int borderMode, CvScalar* borderValue)
{
   cv::Ptr<cv::cuda::Filter> ptr = cv::cuda::createLinearFilter(srcType, dstType, *kernel, *anchor, borderMode, *borderValue);
   ptr.addref();
   return ptr.get();
}

cv::cuda::Filter* cudaCreateBoxMaxFilter( int srcType, emgu::size* ksize, CvPoint* anchor, int borderMode, CvScalar* borderValue)
{
   cv::Size s(ksize->width, ksize->height);
   cv::Ptr<cv::cuda::Filter> ptr = cv::cuda::createBoxMaxFilter(srcType, s, *anchor, borderMode, *borderValue);
   ptr.addref();
   return ptr.get();
}

cv::cuda::Filter* cudaCreateBoxMinFilter( int srcType, emgu::size* ksize, CvPoint* anchor, int borderMode, CvScalar* borderValue)
{
   cv::Size s(ksize->width, ksize->height);
   cv::Ptr<cv::cuda::Filter> ptr = cv::cuda::createBoxMinFilter(srcType, s, *anchor, borderMode, *borderValue);
   ptr.addref();
   return ptr.get();
}

cv::cuda::Filter* cudaCreateMorphologyFilter( int op, int srcType, cv::_InputArray* kernel, CvPoint* anchor, int iterations)
{
   cv::Ptr<cv::cuda::Filter> ptr = cv::cuda::createMorphologyFilter(op, srcType, *kernel, *anchor, iterations);
   ptr.addref();
   return ptr.get();
}

//----------------------------------------------------------------------------
//
//  CudaFilter
//
//----------------------------------------------------------------------------
void cudaFilterApply(cv::cuda::Filter* filter, cv::_InputArray* image, cv::_OutputArray* dst, cv::cuda::Stream* stream)
{
   filter->apply(*image, *dst, stream ? *stream : cv::cuda::Stream::Null());
}
void cudaFilterRelease(cv::cuda::Filter** filter)
{
   delete *filter;
   *filter = 0;
}