//
//  AppDelegate.swift
//  TwitterLaunchScreenAnimation
//
//  Created by chenjunpu on 16/2/27.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var nav: UINavigationController = UINavigationController(rootViewController: ViewController())
    lazy var backgroundView: UIView = UIView()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.rootViewController = nav

        window?.makeKeyAndVisible()

        self.window?.backgroundColor = UIColor(red: 0, green: 140/255, blue: 246/255, alpha: 1)
        
//        start animation
        lauchScreenAnimation()
        
        return true
    }
    
    func lauchScreenAnimation(){

//        add CALayer
        let mask = CALayer()
        mask.contents = UIImage(named: "twitter")?.CGImage
        mask.bounds = CGRectMake(0, 0, 100, 81)
        mask.position = nav.view.center
        nav.view.layer.mask = mask
        
        backgroundView.frame = nav.view.frame
        backgroundView.backgroundColor = UIColor.whiteColor()
        nav.view.addSubview(backgroundView)
        nav.view.bringSubviewToFront(backgroundView)

//        set CAKeyframeAnimation
        let transformAnim = CAKeyframeAnimation(keyPath: "bounds")
        transformAnim.delegate = self
        transformAnim.duration = 1
        transformAnim.beginTime = CACurrentMediaTime() + 1
        
        let beginValue = NSValue(CGRect: mask.bounds)
        let secondValue = NSValue(CGRect: CGRectMake(0, 0, 90, 73))
        let finalValue = NSValue(CGRect: CGRectMake(0, 0, 2000, 2000))
        transformAnim.values = [beginValue,secondValue,finalValue]
        
        transformAnim.keyTimes = [0, 0.5, 1]
        
        transformAnim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        
        transformAnim.removedOnCompletion = false
        
        transformAnim.fillMode = kCAFillModeForwards
        nav.view.layer.mask?.addAnimation(transformAnim, forKey: "transformAnimation")
        
        let time: NSTimeInterval = 1.5
        let delay = dispatch_time(DISPATCH_TIME_NOW,
            Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            self.backgroundView.removeFromSuperview()

        }

        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.nav.view.layer.mask = nil
    
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

