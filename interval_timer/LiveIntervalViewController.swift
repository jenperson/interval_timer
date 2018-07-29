//
//  ViewController.swift
//  interval_timer
//
//  Created by Jen Person on 7/23/18.
//  Copyright © 2018 Jen Person. All rights reserved.
//

import UIKit

class LiveIntervalViewController: UIViewController {

  // MARK: Properties
  var startseconds = 60
  var currseconds = 60
  var modelInstance = Interval()
  var circleView: CircleView?
  // MARK: Outlets
  
  @IBOutlet weak var circleTimerView: UIView!
  @IBOutlet weak var timerDisplayLabel: UILabel!
  
  @IBOutlet weak var timerButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
   // addCircleView()
  
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // if circleView is not yet declared,
    // make it
    guard let _ = circleView else {
      print(circleTimerView.bounds.width)
      addCircleView()
      return
    }
  }
  
  func addCircleView() {
    let circleWidth = circleTimerView.bounds.width
    let circleHeight = circleWidth
    print(circleWidth)
    
    // Create a new CircleView
    circleView = CircleView(frame: CGRect(x: 00.0, y: 00.0, width: circleWidth, height: circleHeight))
    guard let circleView = circleView else { return }
    circleTimerView.addSubview(circleView)
    circleTimerView.layer.borderColor = UIColor.blue.cgColor
    circleTimerView.layer.borderWidth = 10.0
    print(circleTimerView.bounds.width)
  }
  
  func activateTimer() {
    // if timer isn't valid, not running
    if modelInstance.timer.isValid {
      pauseTimer()
    } else {
      runTimer()
    }
  }
  
  func runTimer() {
    // if startseconds and currseconds are equal
    // timer hasn't started
    if (startseconds == currseconds) {
      circleView?.animateCircle(duration: TimeInterval(startseconds))
      modelInstance.gameTimerMethod(timeParam: self.startseconds) { display, value in
        // update currseconds based on time
        self.currseconds = value
        print(self.currseconds)
        self.timerDisplayLabel.text = display
      }
    } else {
      self.circleView?.resumeAnimation()
      modelInstance.gameTimerMethod(timeParam: self.currseconds) { display, value in
        // update currseconds based on time
        self.currseconds = value
        self.timerDisplayLabel.text = display
      }
    }

  }
  
  // to pause timer, pause the countdown
  // and pause animation
  func pauseTimer() {
    modelInstance.pauseTimer { timeLeft in
      self.circleView?.pauseAnimation()
      self.currseconds = timeLeft
    }
  }

  @IBAction func didTapTimerButton(_ sender: Any) {
    activateTimer()
  }
}

