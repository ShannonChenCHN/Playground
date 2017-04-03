//
//  RCDVideoFrameObserver.mm
//  RongCallLib
//
//  Created by litao on 16/5/16.
//  Copyright © 2016年 Rong Cloud. All rights reserved.
//

#include "RCDVideoFrameObserver.h"

#import <GPUImage.h>

static NSLock *s_lock;
RCDVideoFrameObserver *RCDVideoFrameObserver::sharedObserver() {
  static RCDVideoFrameObserver sharedObserver;
  return &sharedObserver;
}

RCDVideoFrameObserver::RCDVideoFrameObserver() {
  m_width = 0;
  m_height = 0;
  m_yStride = 0;
  m_uStride = 0;
  m_vStride = 0;

  m_yBuffer = NULL;
  m_uBuffer = NULL;
  m_vBuffer = NULL;
  s_lock = [[NSLock alloc] init];
}

RCDVideoFrameObserver::~RCDVideoFrameObserver() {
  if (m_yBuffer) {
    delete[] m_yBuffer;
  }
  if (m_uBuffer) {
    delete[] m_uBuffer;
  }
  if (m_vBuffer) {
    delete[] m_vBuffer;
  }
  s_lock = nil;
}

bool RCDVideoFrameObserver::onCaptureVideoFrame(agora::media::IVideoFrameObserver::VideoFrame& videoFrame)  {
  if (!m_width) { //没有初始化内存，在这里初始化内存

    m_height = videoFrame.height;
    m_yStride = videoFrame.yStride;
    m_uStride = videoFrame.uStride;
    m_vStride = videoFrame.vStride;
    
    m_yBuffer = new unsigned char[m_yStride * m_height];
    m_uBuffer = new unsigned char[m_height * m_uStride * m_uStride / m_yStride];
    m_vBuffer = new unsigned char[m_height * m_vStride * m_vStride / m_yStride];
    memset(m_yBuffer, 0, m_yStride * m_height);
    memset(m_uBuffer, 0, m_height * m_uStride * m_uStride / m_yStride);
    memset(m_vBuffer, 0, m_height * m_vStride * m_vStride / m_yStride);
    
    m_width = videoFrame.width;
    
  } else { // copy内存到媒体engine中
    [s_lock lock];
      
      /*
       struct VideoFrame {
           VIDEO_FRAME_TYPE type;
           int width;  //width of video frame
           int height;  //height of video frame
           int yStride;  //stride of Y data buffer
           int uStride;  //stride of U data buffer
           int vStride;  //stride of V data buffer
           void* yBuffer;  //Y data buffer
           void* uBuffer;  //U data buffer
           void* vBuffer;  //V data buffer
           int rotation; // rotation of this frame (0, 90, 180, 270)
       };
       */
      
    unsigned char *y = (unsigned char *)(videoFrame.yBuffer);
      // 画一个十字
      // 竖直
//      for (int i = videoFrame.height / 2 - 1; i < videoFrame.height / 2; i++) {
//          for (int j = 0; j < videoFrame.width; j++) {
//              *(y + i * videoFrame.yStride + j) = 0;
//              
//          }
//      }
      
      // 水平
      for (int i = 0; i < videoFrame.height / 2; i++) {  // 第几列
          for (int j = 50; j < videoFrame.width - 50; j++) {  // 第几行
              *(y + i * videoFrame.yStride + j) = 150;
              // *(y + i * 640 + j) = 150;    width == 640, height == 360
              /*
               y + 0 + 50 = 150;
               y + 0 + 51 = 150;
               ...
               y + 0 + (640 - 50) = 150;
               
               y + 1 * 640 + 50 = 150;
               ...
               y + 1 * 640 + (640 - 50) = 150;
               
               
               ...
               
               y + 360 / 2 * 640 + (640 - 50) = 150;
               */
          }
      }
      
    [s_lock unlock];
  }
    
  return true;
}
bool RCDVideoFrameObserver::onRenderVideoFrame(unsigned int uid, agora::media::IVideoFrameObserver::VideoFrame& videoFrame) {
  NSString *userId = rcGetUserIdFromAgoraUID(uid);
  
  return true;
}
void RCDVideoFrameObserver::setYUV(unsigned char *yBuffer,
                                   unsigned char *uBuffer,
                                   unsigned char *vBuffer, int width,
                                   int height) {
  if (m_width) {
    [s_lock lock];
    for (int i = 0; i < height; i++) {
      if (i >= m_height) {
        break;
      }
      for (int j = 0; j < width; j++) {
        if (j >= m_width) {
          break;
        }
        *(m_yBuffer + i * m_yStride + j) = *(yBuffer + i * width + j);

        if (j < m_width * m_uStride / m_yStride) {
          *(m_uBuffer + i * (m_uStride * m_uStride / m_yStride) + j) =
              *(uBuffer + i * (m_uStride * m_uStride / m_yStride) + j);
        }

        if (j < m_width * m_vStride / m_yStride) {
          *(m_vBuffer + i * (m_vStride * m_vStride / m_yStride) + j) =
              *(vBuffer + i * (m_vStride * m_vStride / m_yStride) + j);
        }
      }
    }
    [s_lock unlock];
  }
}
