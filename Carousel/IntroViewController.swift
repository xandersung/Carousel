//
//  IntroViewController.swift
//  Carousel
//
//  Created by Sung, Alexander on 9/27/16.
//  Copyright © 2016 Capital One. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var introImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tile1: UIImageView!
    @IBOutlet weak var tile2: UIImageView!
    @IBOutlet weak var tile3: UIImageView!
    @IBOutlet weak var tile4: UIImageView!
    @IBOutlet weak var tile5: UIImageView!
    @IBOutlet weak var tile6: UIImageView!
    
    @IBOutlet var tilesForAnimation: Array<UIImageView>?
    
    
    var yOffsets : [Float] = [-385, -340, -390, -408, -480, -550]
    var xOffsets : [Float] = [-30, 75, -66, 10, -150, -15]
    var scales : [Float] = [1, 1.65, 1.7, 1.6, 1.65, 1.65]
    var rotations : [Float] = [-0.1744, -0.1744, 0.1744, 0.1744, 0.1744, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = introImageView.frame.size
        scrollViewDidScroll(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> CGFloat {
        let ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return CGFloat(value * ratio + r2Min - r1Min * ratio)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = Float(scrollView.contentOffset.y)
        var count = 0
        for tile in tilesForAnimation! {
            tile.transform = CGAffineTransform(translationX: convertValue(value: offset, r1Min: 0, r1Max: 667, r2Min: xOffsets[count], r2Max: 0),
                                               y: convertValue(value: offset, r1Min: 0, r1Max: 667, r2Min: yOffsets[count], r2Max: 0)).scaledBy(
                                                x: convertValue(value: offset, r1Min: 0, r1Max: 667, r2Min: scales[count], r2Max:1 ),
                                                y:convertValue(value: offset, r1Min: 0, r1Max: 667, r2Min: scales[count], r2Max: 1)).rotated(
                                                    by: convertValue(value: offset, r1Min: 0, r1Max: 667, r2Min: rotations[count], r2Max: 0))
            count = count + 1
        }
    }
}
