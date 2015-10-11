//
//  FaceView.swift
//  GiffingBuilder-iOS
//
//  Created by Pietro Pepe on 9/21/15.
//  Copyright (c) 2015 Pietro Pepe. All rights reserved.
//

import UIKit

class FaceView : UIView{
    
    var taxPos = CGPoint(x: 0.5, y: 0.5);
    var taxSize = CGSize(width: 0.24, height: 0.4);
    var rotation = CGFloat(0);
    
    override init(frame : CGRect){
        
        super.init(frame: frame);
        layer.borderColor = UIColor.redColor().CGColor;
        layer.borderWidth = 4;
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculatePos(withSize : CGSize){
        center = CGPoint(x: withSize.width*taxPos.x, y: withSize.height*taxPos.y);
        //frame.origin = CGPoint(x: withSize.width*taxPos.x, y: withSize.height*taxPos.y);
    }
    
    func calculateSize(withSize : CGSize){
        bounds.size = CGSize(width: withSize.width*taxSize.width, height: withSize.height*taxSize.height);
    }
    
    func calculateProperties(withSize : CGSize){
        
        calculatePos(withSize);
        calculateSize(withSize);
    }
    
    func saveProperties(withSize : CGSize){
        
        taxPos = CGPoint(x: center.x/withSize.width, y: center.y/withSize.height);
        taxSize = CGSize(width: bounds.size.width/withSize.width, height: bounds.size.height/withSize.height);
        
        print(taxPos);
        print(taxSize);
        
    }
    
    func copy2() -> FaceView {
        let obj = FaceView(frame: frame);
        obj.taxPos = taxPos;
        obj.taxSize = taxSize;
        obj.rotation = rotation;
        obj.transform = transform;
        return obj
    }
    
}
