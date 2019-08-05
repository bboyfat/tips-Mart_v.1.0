//
//  BarCodeGenerator.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum BarCodeQrCode{
    case barCode
    case QRCode
}

class BarCodeGenerator{
    
    func generateBrCode(qrOrBar: BarCodeQrCode ,from string: String) -> UIImage?{
        
        let data = string.data(using: String.Encoding.ascii)
        switch qrOrBar {
        case .barCode:
            if let filter = CIFilter(name: "CICode128BarcodeGenerator"){
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                
                if let output = filter.outputImage?.transformed(by: transform){
                    return UIImage(ciImage: output)
                }
            }
        case .QRCode:
            if let filter = CIFilter(name: "CIQRCodeGenerator"){
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                
                if let output = filter.outputImage?.transformed(by: transform){
                    return UIImage(ciImage: output)
                }
            }
        }
//        if let filter = CIFilter(name: "CICode128BarcodeGenerator"){
//            filter.setValue(data, forKey: "inputMessage")
//            let transform = CGAffineTransform(scaleX: 3, y: 3)
//            
//            if let output = filter.outputImage?.transformed(by: transform){
//                return UIImage(ciImage: output)
//            }
//        }
        
        
        
        return nil
    }
    
}
