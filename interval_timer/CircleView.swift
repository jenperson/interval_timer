//
//  CircleView.swift
//  interval_timer
//
//  Created by Jen Person on 7/23/18.
//  Copyright © 2018 Jen Person. All rights reserved.
//

import UIKit


class CircleView: UIView {

  var circleLayer = CAShapeLayer()
  var backgroundCircleLayer = CAShapeLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = UIColor.clear
    
//    makeBackgroundCircle()
//    makeCircle()
    makeCircle(isAnimated: false)
    makeCircle(isAnimated: true)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func makeCircle(isAnimated: Bool) {
    // Use UIBezierPath as an easy way to create the CGPath for the layer.
    // The path should be the entire circle.
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width)/2.5, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
    
    // Setup the CAShapeLayer with the path, colors, and line width
    circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.cgPath
    circleLayer.fillColor = UIColor.clear.cgColor
    
    circleLayer.lineWidth = 40.0;
    
    if isAnimated {
      circleLayer.strokeColor = UIColor.blue.cgColor
      // Don't draw the circle initially
      circleLayer.strokeEnd = 0.0
    } else {
      circleLayer.strokeColor = UIColor.red.cgColor
    }
    
    // Add the circleLayer to the view's layer's sublayers
    layer.addSublayer(circleLayer)
  }
  
  func makeCircle() {
    // Use UIBezierPath as an easy way to create the CGPath for the layer.
    // The path should be the entire circle.
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width)/2.5, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
  
    // Setup the CAShapeLayer with the path, colors, and line width
    circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.cgPath
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.strokeColor = UIColor.blue.cgColor
    circleLayer.lineWidth = 40.0;
  
    // Don't draw the circle initially
    circleLayer.strokeEnd = 0.0
  
    // Add the circleLayer to the view's layer's sublayers
    layer.addSublayer(circleLayer)
  }
  
  func makeBackgroundCircle() {
    let backgroundCirclePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width)/2.5, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
    
    // Setup the CAShapeLayer with the path, colors, and line width
    backgroundCircleLayer = CAShapeLayer()
    backgroundCircleLayer.path = backgroundCirclePath.cgPath
    backgroundCircleLayer.fillColor = UIColor.clear.cgColor
    backgroundCircleLayer.strokeColor = UIColor.red.cgColor
    backgroundCircleLayer.lineWidth = 40.0;
    
    // Add the circleLayer to the view's layer's sublayers
    layer.addSublayer(backgroundCircleLayer)
  }
  
  func animateCircle(duration: TimeInterval) {
    // We want to animate the strokeEnd property of the circleLayer
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    // Set the animation duration appropriately
    animation.duration = duration
    
    // Animate from 0 (no circle) to 1 (full circle)
    animation.fromValue = 0
    animation.toValue = 1

    // Do a linear animation (i.e. the speed of the animation stays the same)
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
    // right value when the animation ends.
    circleLayer.strokeEnd = 1.0
    
    // Do the actual animation
    circleLayer.add(animation, forKey: "animateCircle")
  }
  
  func animateCirclePart(fromValue: Double, duration: TimeInterval) {
    let animation = CABasicAnimation(keyPath: "strokeEnd")

    // We want to animate the strokeEnd property of the circleLayer

    
    // Set the animation duration appropriately
    animation.duration = duration
    
    // Animate from 0 (no circle) to 1 (full circle)
    animation.fromValue = fromValue
    animation.toValue = 1
    
    // Do a linear animation (i.e. the speed of the animation stays the same)
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
    // right value when the animation ends.
    circleLayer.strokeEnd = 1.0
    
    // Do the actual animation
    circleLayer.add(animation, forKey: "animateCircle")
  }
  
  func pauseAnimation() {
    let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
    layer.speed = 0.0
    layer.timeOffset = pausedTime
  }
  
  func resumeAnimation() {
    let pausedTime = layer.timeOffset
    layer.speed = 1.0
    layer.timeOffset = 0.0
    layer.beginTime = 0.0
    let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    layer.beginTime = timeSincePause
  }

}
