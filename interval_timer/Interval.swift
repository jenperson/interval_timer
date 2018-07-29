//
//  Interval.swift
//  interval_timer
//
//  Created by Jen Person on 7/23/18.
//  Copyright © 2018 Jen Person. All rights reserved.
//

import Foundation

class Interval {
  
  var timer = Timer()
  
  class TimerInfo {
    
    var count: Int

    // Pointer to function or closure to call when value changes
    var callback: ((String, Int) -> Void)?
    
    init(start: Int, callback: @escaping (String, Int) -> Void) {
      count = start
      self.callback = callback
    }
    
    deinit {
      print("TimerInfo deinit")
    }
  }
   //@objc func decreaseGameTimer(_ timer: Timer) {
  @objc func decreaseGameTimer() {
    guard let userInfo = timer.userInfo as? TimerInfo else { return }
      userInfo.count -= 1
      let currTime = timeFormatted(userInfo.count)
      
      // call callback with new value
      userInfo.callback?(currTime, userInfo.count)
      
      if userInfo.count == 0 {
        timer.invalidate()
      }
  }
  
  func timeFormatted(_ totalSeconds: Int) -> String {
    let seconds: Int = totalSeconds % 60
    let minutes: Int = (totalSeconds / 60) % 60
    return String(format: "%02d:%02d", minutes, seconds)
  }
  
  func pauseTimer(callback: @escaping (Int) -> Void) {
    guard let userInfo = timer.userInfo as? TimerInfo else { return }
    timer.invalidate()
    // pass the current remaining time through the closure
    callback(userInfo.count)
  }
  
  func gameTimerMethod(timeParam: Int, callback: @escaping (String, Int) -> Void) {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                             selector: #selector(decreaseGameTimer),
                             userInfo: TimerInfo(start: timeParam, callback: callback),
                             repeats: true)
  }
}

