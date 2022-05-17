import Foundation
import UIKit
import QuartzCore

struct AnimationHelper {
    enum AnimationType {
        case vertical
        case horizontal
    }
    enum CardSide {
        case front
        case back
    }
    func firstAnimation(frontView: UIView, backView: UIView, completion:@escaping () -> ()) {
        let delayOffset: Double = 2
        
        let firstScene = frontView.layer.transform
        let secondScene = backView.layer.transform
        let transform = makeRotateRoute(scene: secondScene, xAngle: 0, yAngle: -99.8, zAngle: -0.8)
        backView.layer.transform = makeRotateRoute(scene: transform, xAngle: 0, yAngle: 180, zAngle: 0)
        UIView.animate(withDuration: delayOffset * 0.04, delay: 0, options: .curveEaseIn, animations: {
            frontView.layer.transform = makeRotateRoute(scene: firstScene, xAngle: 0, yAngle: -6, zAngle: 1)
        }, completion: {_ in
            UIView.animate(withDuration: delayOffset * 0.07, delay: 0, options: [], animations: {
                frontView.layer.transform = makeRotateRoute(scene: firstScene, xAngle: 0, yAngle: 73, zAngle: -1)
            }, completion: {_ in
                UIView.animate(withDuration: delayOffset * 0.02, delay: 0, options: [], animations: {
                    frontView.layer.transform = makeRotateRoute(scene: firstScene, xAngle: 0, yAngle: 99.8, zAngle: -0.8)
                }, completion: {_ in
                    frontView.isHidden = true
                    backView.isHidden = false
            
                    UIView.animate(withDuration: delayOffset * 0.06, delay: 0, options: .curveEaseOut, animations: {
                        backView.layer.transform = makeRotateRoute(scene: secondScene, xAngle: 0, yAngle: 0, zAngle: -0.8)
                    }, completion: {_ in
                        UIView.animate(withDuration: delayOffset * 0.02, delay: 0, options: .curveEaseInOut, animations: {
                            backView.layer.transform = makeRotateRoute(scene: secondScene, xAngle: 0, yAngle: -5, zAngle: 0)
                        }, completion: {_ in
                            UIView.animate(withDuration: delayOffset * 0.03, delay: 0, options: .curveEaseInOut, animations: {
                                backView.layer.transform = makeRotateRoute(scene: secondScene, xAngle: 0, yAngle: 0, zAngle: 0)
                            }, completion: {_ in
                                completion()
                                backView.transform = .identity
                                frontView.transform = .identity
                            })
                        })
                    })
                })
            })
        })
    }
    func secondAnimation(frontView: UIView, backView: UIView, completion:@escaping () -> ()) {
        let delayOffset: Double = 2
        
        let firstScene = frontView.layer.transform
        let secondScene = backView.layer.transform
        let transform = makeRotateRoute(scene: secondScene, xAngle: -93, yAngle: -2.7, zAngle: 5)
        backView.layer.transform = makeRotateRoute(scene: transform, xAngle: 180, yAngle: 0, zAngle: 0)
        
        UIView.animate(withDuration: delayOffset * 0.09, delay: 0, options: .curveEaseIn, animations: {
            frontView.layer.transform = makeRotateRoute(scene: firstScene, xAngle: -78, yAngle: -8, zAngle: 4.5)
        }, completion: {_ in
            UIView.animate(withDuration: delayOffset * 0.01, delay: 0, options: [], animations: {
                frontView.layer.transform = makeRotateRoute(scene: firstScene, xAngle: -93, yAngle: -2.7, zAngle: 5)
            }, completion: {_ in
                frontView.isHidden = true
                backView.isHidden = false
                
                UIView.animate(withDuration: delayOffset * 0.02, delay: 0, options: [], animations: {
                    backView.layer.transform = makeRotateRoute(scene: secondScene, xAngle: (180 - 123), yAngle: 2.7, zAngle: -5)
                }, completion: {_ in
                    UIView.animate(withDuration: delayOffset * 0.05, delay: 0, options: [], animations: {
                        backView.layer.transform = makeRotateRoute(scene: secondScene, xAngle: (180 - 174), yAngle: 8, zAngle: 6)
                    }, completion: {_ in
                        UIView.animate(withDuration: delayOffset * 0.06, delay: 0, options: .curveEaseOut, animations: {
                            backView.layer.transform = makeRotateRoute(scene: secondScene, xAngle: (180 - 185), yAngle: 0, zAngle: 0)
                        }, completion: {_ in
                            UIView.animate(withDuration: delayOffset * 0.04, delay: 0, options: .curveEaseInOut, animations: {
                                backView.layer.transform = makeRotateRoute(scene: secondScene, xAngle: (180 - 180), yAngle: 0, zAngle: 0)
                            }, completion: {_ in
                                completion()
                                frontView.transform = .identity
                                backView.transform = .identity
                            })
                        })
                    })
                })
            })
        })
    }
    private func makeRotateRoute(scene: CATransform3D, xAngle: Double, yAngle: Double, zAngle: Double) -> CATransform3D {
        var transform = CATransform3DRotate(scene, xAngle * (Double.pi / 180), 1, 0, 0)
        transform = CATransform3DRotate(transform, yAngle * (Double.pi / 180), 0, 1, 0)
        transform = CATransform3DRotate(transform, zAngle * (Double.pi / 180), 0, 0, 1)
        return transform
    }
}
