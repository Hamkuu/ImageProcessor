//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!
let rgbaImage = RGBAImage(image: image)!



class ImageProcessor {
    
    var contrast_scale: Int
    var brightness_percent: Int
    
    init(contrast: Int, brightness: Int) {
        contrast_scale = contrast
        brightness_percent = brightness
    }
    
    convenience init(){
        self.init(contrast: 1, brightness: 100)
    }
    
    func startProcess() {
        contrast(rgbaImage, scale: contrast_scale)
        brightness(rgbaImage, percent: brightness_percent)
    }
    
    func contrast(let rgbaImage: RGBAImage, scale: Int) {
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                let pixel = rgbaImage.pixels[index]
                
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        let pixelCount = rgbaImage.width * rgbaImage.height
        let avgRed = totalRed / pixelCount
        let avgGreen = totalGreen / pixelCount
        let avgBlue = totalBlue / pixelCount
        
        //let sum = avgRed + avgGreen + avgBlue
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - avgRed
                let greenDelta = Int(pixel.green) - avgGreen
                let blueDelta = Int(pixel.blue) - avgBlue
                
                /*
                if(Int(pixel.red) + Int(pixel.green) + Int(pixel.blue) < sum){
                scale = scale / 2
                }
                */
                
                pixel.red = UInt8(max(min(255, avgRed + scale * redDelta), 0))
                pixel.green = UInt8(max(min(255, avgGreen + scale * greenDelta), 0))
                pixel.blue = UInt8(max(min(255, avgBlue + scale * blueDelta), 0))
                
                
                rgbaImage.pixels[index] = pixel
            }
        }
    }
    
    func brightness(let rgbaImage: RGBAImage, percent: Int) {
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                pixel.red = UInt8(max(min(255, Int(pixel.red) * percent/100), 0))
                pixel.green = UInt8(max(min(255, Int(pixel.green) * percent/100), 0))
                pixel.blue = UInt8(max(min(255, Int(pixel.blue) * percent/100), 0))
                
                
                rgbaImage.pixels[index] = pixel
            }
        }
    }

}


//"contrast" should provided in scale
//"brightness" should provided in percentage
let processor_1 = ImageProcessor()
let processor_2 = ImageProcessor(contrast: 2, brightness: 100)
let processor_3 = ImageProcessor(contrast: 1, brightness: 200)
let processor_4 = ImageProcessor(contrast: 1, brightness: 50)
let processor_5 = ImageProcessor(contrast: 2, brightness: 25)


processor_5.startProcess()

let newImage = rgbaImage.toUIImage()!








