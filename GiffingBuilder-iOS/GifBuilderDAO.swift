//
//  GifBuilderDAO.swift
//  GiffingBuilder-iOS
//
//  Created by Pietro Ribeiro Pepe on 10/4/15.
//  Copyright (c) 2015 Pietro Pepe. All rights reserved.
//

import UIKit

class GifBuilderDAO{
    
    class func saveGif(gif : [FaceView], imgs : [UIImage]) -> Bool{
        
        var frames = NSMutableArray();
        let quant = gif.count;
        for(var i=0; i<quant; i++){
            let frame = gif[i];
            let frameInfo = NSDictionary(objects: [dictFromPoint(frame.taxPos), dictFromPoint(frame.taxPos), frame.rotation], forKeys: ["position","size","rotation"]);
            frames.insertObject(frameInfo, atIndex: frames.count);
        }
        let dict = NSDictionary(objects: ["dmitriGif",frames], forKeys: ["name","framesInfo"]);
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)[0] as! String;
        let path = documentPath.stringByAppendingPathComponent("dmitriInfo.plist");
        
        println(dict);
        
        
        
        if(dict.writeToFile(path, atomically: true)){
            println("Document sucessfully created");
            return true;
        }
        else{
            println("Error saving document. Check for nil values");
            return false;
        }
        
    }
    
    class private func dictFromPoint(point : CGPoint) -> NSDictionary{
        return NSDictionary(objects: [point.x,point.y], forKeys: ["x","y"]);
    }
    
}