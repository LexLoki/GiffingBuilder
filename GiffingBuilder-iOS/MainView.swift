//
//  MainView.swift
//  GifBuilder
//
//  Created by Pietro Pepe on 9/19/15.
//  Copyright (c) 2015 Pietro Pepe. All rights reserved.
//

import UIKit

class MainView: UIView {

    let collection : UICollectionView;
    let actualImg : UIImageView;
    var actualFace : FaceView!;
    //let scroll : NSScrollView;
    let okButton : UIButton;
    
    override init(frame: CGRect) {
        
        okButton = UIButton(frame: CGRect(x: frame.width*0.9, y: 0, width: 0.1*frame.width, height: 0.1*frame.height));
        okButton.setImage(UIImage(named: "ok")!, forState: UIControlState.Normal);
        
        //scroll = NSScrollView(frame: NSRect(x: 0, y: 0, width: frameRect.width, height: 0.2*frameRect.height));
        let ss = 0.2*frame.height;
        let lay: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        lay.itemSize = CGSize(width: ss, height: ss);
        lay.minimumInteritemSpacing = 10;
        lay.scrollDirection = UICollectionViewScrollDirection.Horizontal;
        lay.sectionInset = UIEdgeInsets(top: 0,
            left: 0,
            bottom: 0,
            right: 0);
        
        collection = UICollectionView(frame: CGRect(x: 0, y: frame.height-ss, width: frame.width, height: ss), collectionViewLayout: lay);
        collection.registerClass(FrameItem.self, forCellWithReuseIdentifier: "cellIdentifier");
        
        //let maxSize = CGSize(width: frame.width-okButton.frame.width*2, height: collection.frame.minY-okButton.frame.maxY);
        //let center = CGPoint(x: okButton.frame.width + maxSize.width*0.5, y: okButton.frame.height+maxSize.height*0.5);
        //let actualSize = MainView.getBestSize(<#source: CGSize#>, target: <#CGSize#>)
        actualImg = UIImageView(frame: CGRect(x: okButton.frame.width, y: okButton.frame.maxY, width: frame.width-okButton.frame.width*2, height: collection.frame.minY-okButton.frame.maxY));
        actualImg.layer.borderWidth = 5;
        actualImg.layer.borderColor = UIColor.whiteColor().CGColor;
        actualImg.contentMode = UIViewContentMode.ScaleAspectFit;
        
        super.init(frame: frame);
        
        //addSubview(scroll);
        addSubview(collection);
        addSubview(actualImg);
        addSubview(okButton);
    }
    
    func prepareImgView(){
        let imgSize = actualImg.image!.size;
        var imgViewSize = actualImg.frame.size;
        imgViewSize = MainView.getBestSize(imgSize, target: imgViewSize);
        let dif = CGPoint(x: imgViewSize.width-imgSize.width, y: imgViewSize.height-imgSize.height);
        actualImg.frame = CGRect(x: actualImg.frame.origin.x + dif.x*0.5,
            y: actualImg.frame.origin.y + dif.y*0.5,
            width: actualImg.frame.width - dif.x,
            height: actualImg.frame.height - dif.y)
    }
    
    private class func getBestSize(source : CGSize, target : CGSize) -> CGSize{
        let w = target.width / source.width;
        let h = target.height / source.height;
        let s = (w<h) ? w : h;
        return CGSize(width: s*source.width, height: s*source.height);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
