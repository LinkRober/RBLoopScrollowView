//
//  RBLoopScrollowView.swift
//  RBLoopScrollowView
//
//  Created by LinkRober on 21/08/2017.
//  Copyright © 2017 LinkRober. All rights reserved.
//

import UIKit

enum RBImageType:String {
    case RBLocal,RBRemote
}

class RBLoopScrollowView: UIView {
    
    //MARK: - Property
    private(set) var contentView:UIScrollView!
    private(set) var images = [String]()
    private(set) var imageViews = [UIImageView]()

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        contentView.showsHorizontalScrollIndicator = false
        contentView.isPagingEnabled = true
        contentView.delegate = self
        addSubview(contentView)
    }
    
    convenience init(images:[String],imageType:RBImageType,frame:CGRect){
        self.init(frame: frame)
        self.images = [images[images.count - 1]] + images + [images[0]]
        contentView.contentSize = CGSize(width:frame.size.width * CGFloat(self.images.count), height: frame.size.height)
        contentView.contentOffset = CGPoint(x: frame.size.width, y: 0)
        switch imageType {
        case .RBLocal:
            
            imageViews = self.images.map({ (localImageString) -> UIImageView in
                let imageview = UIImageView.init(image: UIImage.init(named: localImageString))
                contentView.addSubview(imageview)
                return imageview
            })
        case .RBRemote: break
            //
        }
        
        for imageview in imageViews.enumerated(){
            imageview.element.frame = CGRect(x: CGFloat(imageview.offset)*frame.size.width,
                                             y: 0,
                                             width: frame.size.width,
                                             height: frame.size.height)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private Method
    func reRangeImage(scrollowView:UIScrollView){
        
        let currentOffset = scrollowView.contentOffset
        let currentImageIndex = Int(currentOffset.x) / Int(scrollowView.frame.size.width)

        if currentOffset.x > scrollowView.frame.size.width {
            if currentImageIndex == images.count - 2 {
                scrollowView.scrollRectToVisible(CGRect.init(x: 0,
                                                             y: 0,
                                                             width: frame.size.width,
                                                             height: frame.size.height),
                                                 animated: false)
            }
        }
        
        if currentOffset.x < scrollowView.frame.size.width {
            if currentImageIndex == 0 {
                scrollowView.scrollRectToVisible(CGRect.init(x: frame.size.width*CGFloat(images.count - 2),
                                                             y: 0,
                                                             width: frame.size.width,
                                                             height: frame.size.height),
                                                 animated: false)
            }
        }
        
    }
    
}

extension RBLoopScrollowView:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reRangeImage(scrollowView: scrollView)
    }
}
