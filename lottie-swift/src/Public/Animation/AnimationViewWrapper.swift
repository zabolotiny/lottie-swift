//
//  AnimationViewWrapper.swift
//  Maneno
//
//  Created by Yura Zabolotin on 12/2/19.
//  Copyright © 2019 Knowlge Aps. All rights reserved.
//

import UIKit

public typealias AnimationCompletionBlock = (Bool) -> Void

class AnimationViewWrapper: AnimationView {
    static var shouldBlockAnimations = false
    
    @objc static func animationNamed(_ name: String) -> AnimationViewWrapper {
        if shouldBlockAnimations {
            return AnimationViewWrapper()
        }
        return AnimationViewWrapper(name: name)
    }
    
    @objc override var animationSpeed: CGFloat {
        set {
            super.animationSpeed = newValue
        }
        get {
            return super.animationSpeed
        }
    }
    
    @objc var loopAnimation: Bool {
        set {
            super.loopMode = newValue ? .loop : .playOnce
        }
        get {
            if super.loopMode == .loop {
                return true
            }
            return false
        }
    }
    
    @objc var animationProgress: CGFloat {
        return currentProgress
    }
    
    @objc var endFrame: CGFloat {
        return CGFloat(animation?.endFrame ?? 0)
    }
    
    @objc func play() {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        play(completion: nil)
    }
    
    @objc override func pause() {
        super.pause()
    }
    
    @objc func clearAnimation() {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        stop()
        animation = nil
    }
    
    @objc func setAnimation(named: String) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        animation = Animation.named(named)
    }
    
    @objc func setAnimation(path: String) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        imageProvider = FilepathImageProvider(filepath: path.stringByDeletingLastPathComponent)
        animation = Animation.filepath(path)
    }
    
    @objc func setAnimationAndSaveToCache(path: String, link: String) -> Bool {
        if AnimationViewWrapper.shouldBlockAnimations {
            return true
        }
        let animation = Animation.filepath(path)
        guard let unwrappedAnimation = animation else {
            return false
        }
        LOTAnimationCacheProvider.sharedCache.setAnimation(unwrappedAnimation, forKey: link, path: path.stringByDeletingLastPathComponent)
        imageProvider = FilepathImageProvider(filepath: path.stringByDeletingLastPathComponent)
        self.animation = unwrappedAnimation
        return true
    }
    
    @objc func addSubview(_ subview: UIView, forLayerAt keypathString: String) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        let animationSubview = AnimationSubview()
        animationSubview.addSubview(subview)
        let keypath = AnimationKeypath(keypath: keypathString)
        addSubview(animationSubview, forLayerAt: keypath)
    }
    
    @objc func replaceSubview(_ subview: UIView, forLayerAt keypathString: String) -> Bool {
        if AnimationViewWrapper.shouldBlockAnimations {
            return true
        }
        let animationSubview = AnimationSubview()
        animationSubview.frame = subview.frame
        animationSubview.addSubview(subview)
        subview.frame = animationSubview.bounds
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let keypath = AnimationKeypath(keypath: keypathString)
        return replaceSubview(animationSubview, forLayerAt: keypath)
    }
    
    @objc func replaceThumbnailSubview(_ subview: UIView, forLayerAt keypathString: String) -> Bool {
        if AnimationViewWrapper.shouldBlockAnimations {
            return true
        }
        let animationSubview = AnimationSubview()
        animationSubview.addSubview(subview)
        subview.frame = animationSubview.bounds
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let height: CGFloat = 240.0
        let width: CGFloat = 179.0
        animationSubview.frame = CGRect(x: -(width / 2), y: -(height / 2), width: width, height: height)
        let keypath = AnimationKeypath(keypath: keypathString)
        return replaceSubview(animationSubview, forLayerAt: keypath)
    }
    
    @objc func replaceImage(_ image: UIImage, forLayerAt keypathString: String) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        let keypath = AnimationKeypath(keypath: keypathString)
        replaceImage(image, forLayerAt: keypath)
    }
    
    @objc func setProgress(with frame: NSNumber) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        currentFrame = AnimationFrameTime(frame.intValue)
    }
    
    @objc func playTo(progress: NSNumber, completion: AnimationCompletionBlock?) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        play(fromProgress: nil, toProgress: AnimationProgressTime(progress.floatValue), loopMode: nil, completion: completion)
    }
    
    @objc func playTo(frame: NSNumber, completion: AnimationCompletionBlock?) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        play(fromFrame: nil, toFrame: AnimationFrameTime(frame.floatValue), loopMode: nil, completion: completion)
    }
    
    @objc func play(fromFrame: NSNumber, toFrame: NSNumber, completion: AnimationCompletionBlock?) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        play(fromFrame: AnimationFrameTime(fromFrame.floatValue), toFrame: AnimationFrameTime(toFrame.floatValue), loopMode: nil, completion: completion)
    }
    
    @objc func play(fromProgress: CGFloat, toProgress: CGFloat, completion: AnimationCompletionBlock?) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        play(fromProgress: fromProgress, toProgress: toProgress, loopMode: nil, completion: completion)
    }
    
    @objc override func play(completion: AnimationCompletionBlock?) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        super.play(completion: completion)
    }
    
    override func play(fromMarker: String? = nil, toMarker: String, loopMode: LottieLoopMode? = nil, completion: LottieCompletionBlock? = nil) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        super.play(fromMarker: fromMarker, toMarker: toMarker, loopMode: loopMode, completion: completion)
    }
    
    override func play(fromFrame: AnimationFrameTime? = nil, toFrame: AnimationFrameTime, loopMode: LottieLoopMode? = nil, completion: LottieCompletionBlock? = nil) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        super.play(fromFrame: fromFrame, toFrame: toFrame, loopMode: loopMode, completion: completion)
    }
    
    override func play(fromProgress: AnimationProgressTime? = nil, toProgress: AnimationProgressTime, loopMode: LottieLoopMode? = nil, completion: LottieCompletionBlock? = nil) {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        // Disable animation for simulator:
        #if targetEnvironment(simulator)
            return
        #endif
        super.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: loopMode, completion: completion)
    }
    
    @objc override func stop() {
        super.stop()
    }
    
    @objc func loadAnimation(with link: String) -> Bool {
        if AnimationViewWrapper.shouldBlockAnimations {
            return true
        }
        if let path = LOTAnimationCacheProvider.sharedCache.imageFolderPath(forKey: link) {
            imageProvider = FilepathImageProvider(filepath: path)
        }
        guard let animation = LOTAnimationCacheProvider.sharedCache.animation(forKey: link) else {
            return false
        }
        self.animation = animation
        return true
    }
    
    @objc func updateAnimationLayouts() {
        if AnimationViewWrapper.shouldBlockAnimations {
            return
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.forceDisplayUpdate()
    }
    
    @objc func hasLoadedAnimation() -> Bool {
        if AnimationViewWrapper.shouldBlockAnimations {
            return true
        }
        return animation != nil
    }
}

extension String {
    var ns: NSString {
        return self as NSString
    }
    
    var pathExtension: String {
        return ns.pathExtension
    }
    
    var lastPathComponent: String {
        return ns.lastPathComponent
    }
    
    var stringByDeletingLastPathComponent: String {
        return ns.deletingLastPathComponent
    }
}
