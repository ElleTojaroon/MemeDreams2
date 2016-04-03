//
//  ViewController.swift
//  TotoesGoats
//
//  Created by Daniel Hauagge on 2/20/16.
//  Copyright © 2016 Daniel Hauagge. All rights reserved.
//

import UIKit
import AVFoundation

var megustab = false
var afaceb = false
var trollfaceb = false
var pepeb = false
var path1 = NSBundle.mainBundle().pathForResource("me_gusta_by_rober_raik-d4clrpu", ofType: "png")!
var goatFace = UIImage(contentsOfFile: path1)
class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var ChooseAMeme: UILabel!
    
    @IBOutlet weak var MeGusta: UIButton!
    func setGoatFace() {
        
        if megustab == true {
            path1 = NSBundle.mainBundle().pathForResource("me_gusta_by_rober_raik-d4clrpu", ofType: "png")!
            megustab = false
            
        } else if pepeb == true {
            path1 = NSBundle.mainBundle().pathForResource("pepe", ofType: "png")!
            print("pepepepepepeppe")
            pepeb = false
        } else if afaceb == true {
            path1 = NSBundle.mainBundle().pathForResource("awesome_face", ofType: "png")!
            afaceb = false
        } else if trollfaceb == true {
            path1 = NSBundle.mainBundle().pathForResource("megusta", ofType: "png")!
            trollfaceb = false
        }
        goatFace = UIImage(contentsOfFile: path1)
        
    }
    @IBAction func MeGustaButton(sender: AnyObject) {
        aface.hidden = true
        trollface.hidden = true
        pepe.hidden = true
        ChooseAMeme.hidden = true
        megustab = true
        setGoatFace()
    }
    @IBOutlet weak var aface: UIButton!
    
    @IBAction func afaceButton(sender: AnyObject) {
        MeGusta.hidden = true
        trollface.hidden = true
        pepe.hidden = true
        ChooseAMeme.hidden = true
        afaceb = true
        setGoatFace()
    }
    @IBOutlet weak var trollface: UIButton!
    
    @IBAction func trollfaceButton(sender: AnyObject) {
        MeGusta.hidden = true
        aface.hidden = true
        pepe.hidden = true
        ChooseAMeme.hidden = true
        trollfaceb = true
        setGoatFace()
    }
    @IBOutlet weak var pepe: UIButton!
    
    @IBAction func pepeButton(sender: AnyObject) {
        MeGusta.hidden = true
        aface.hidden = true
        trollface.hidden = true
        ChooseAMeme.hidden = true
        pepeb = true
        setGoatFace()
    }
    @IBAction func ShowFaces(sender: AnyObject) {
        MeGusta.hidden = false
        aface.hidden = false
        pepe.hidden = false
        trollface.hidden = false
        self.view.bringSubviewToFront(ChooseAMeme)
        self.view.bringSubviewToFront(MeGusta)
        self.view.bringSubviewToFront(pepe)
        self.view.bringSubviewToFront(aface)
        self.view.bringSubviewToFront(trollface)
    }
    @IBOutlet weak var FilterButton: UIButton!
    let captureSession = AVCaptureSession()
    
    // switch front and back camera
    var isSwitchProcessing = false
    @IBAction func switchCameraButton(sender: UIButton) {
        session.beginConfiguration()
        
        // print("switch cam pressed")
        session.removeInput(session.inputs[0] as! AVCaptureInput)

        
        if currentDevice!.position == AVCaptureDevicePosition.Front {
            
            
            currentDevice = setCamera(AVCaptureDevicePosition.Back)
            
            switchCamOutlet.setTitle("Front Camera", forState: .Normal)
            switchCamOutlet.backgroundColor = UIColor.greenColor()
            print("front cam")
        } else {
            currentDevice = setCamera(AVCaptureDevicePosition.Front)
            
            switchCamOutlet.setTitle("Back Camera", forState: .Normal)
            switchCamOutlet.backgroundColor = UIColor.redColor()
            print("back cam")
        }
        
        let newVideoInput = try! AVCaptureDeviceInput(device: currentDevice!)
        assert(session.canAddInput(newVideoInput))
        session.addInput(newVideoInput)
        session.commitConfiguration()
    }
    
    func setCamera(currentCamPos: AVCaptureDevicePosition) -> AVCaptureDevice {
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if device.position == currentCamPos {
                return device as! AVCaptureDevice
            }
        }
        return AVCaptureDevice()
    }
    
    
    @IBOutlet weak var switchCamOutlet: UIButton!
    
    
    // switch face detection and filter
    var isFaceOrFilter = false
    @IBOutlet weak var faceFilterSwitch: UIButton!
    @IBAction func faceFilterSwitchButton(sender: UIButton) {
        // Filter
        isFaceOrFilter = !isFaceOrFilter
        // Face 
        
        // Do i need to call the output function here???
    }
    
    
    @IBOutlet weak var button: UIButton!
    @IBAction func buttonClicked(sender: AnyObject) {
        isProcessing = !isProcessing
        
        if isProcessing {
            processedLayer.hidden = false
            processedLayer.backgroundColor = nil // sets layer to be transparent, so we can see the video feed being shown in the preview layer
            previewLayer.hidden = false
            button.backgroundColor = UIColor.greenColor()
        } else {
            processedLayer.hidden = true
            previewLayer.hidden = false
            button.backgroundColor = UIColor.redColor()
        }
    }
    
    var session = AVCaptureSession()
    var currentDevice: AVCaptureDevice! = nil
    var previewLayer : AVCaptureVideoPreviewLayer!
    var processedLayer : CALayer!
    
    var isProcessing = false
    var frameNo = 0
    
    var faceDetector = CIDetector(ofType: CIDetectorTypeFace,
        context: nil, options: [
            CIDetectorAccuracy: CIDetectorAccuracyHigh,
            CIDetectorTracking: true
        ])

    override func viewDidLoad() { //WHAT IS NIB???
        super.viewDidLoad()
        let myCGFloat = CGFloat(M_PI/2)
        MeGusta.transform = CGAffineTransformMakeRotation(myCGFloat)
        MeGusta.layer.borderWidth = 1
        MeGusta.layer.masksToBounds = false
        MeGusta.layer.borderColor = UIColor.whiteColor().CGColor
        MeGusta.layer.cornerRadius = MeGusta.frame.size.width/2
        MeGusta.clipsToBounds = true
        pepe.transform = CGAffineTransformMakeRotation(myCGFloat)
        pepe.layer.borderWidth = 1
        pepe.layer.masksToBounds = false
        pepe.layer.borderColor = UIColor.whiteColor().CGColor
        pepe.layer.cornerRadius = pepe.frame.size.width/2
        pepe.clipsToBounds = true
        aface.transform = CGAffineTransformMakeRotation(myCGFloat)
        aface.layer.borderWidth = 1
        aface.layer.masksToBounds = false
        aface.layer.borderColor = UIColor.whiteColor().CGColor
        aface.layer.cornerRadius = aface.frame.size.width/2
        aface.clipsToBounds = true
        trollface.transform = CGAffineTransformMakeRotation(myCGFloat)
        trollface.layer.borderWidth = 1
        trollface.layer.masksToBounds = false
        trollface.layer.borderColor = UIColor.whiteColor().CGColor
        trollface.layer.cornerRadius = trollface.frame.size.width/2
        trollface.clipsToBounds = true
        
        // Get all devices on my phone and out them in a list
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as! [AVCaptureDevice]
        
//        let device = devices.first!
        
        currentDevice = devices.filter({ (dev) -> Bool in
            dev.position == .Back
        }).first!

        // let x = devices.filter { (dev) -> Bool in
        //    dev.position == .Front
        // }
        // let device = devices.filter({ $0.position == .Front }).first!
        
        
        // need to create a variable obtaining information from devices: blue box: APCaptureDevice Input
        let input = try! AVCaptureDeviceInput(device: currentDevice)
        //        do {
        //            input =AVCaptureDeviceInput(device: device)
        //        } catch {
        //            assert(false)
        //        }
        
        assert(session.canAddInput(input))
        session.addInput(input)
        
        // Create preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer)
        
        // Create processed video layer
        processedLayer = CALayer()
        processedLayer.frame = self.view.bounds
        processedLayer.hidden = true
        processedLayer.backgroundColor = UIColor.redColor().CGColor // <- Just for debugging
        self.view.layer.addSublayer(processedLayer)
        
        // Create data output
        let frameProcessingQueue = dispatch_queue_create("goatface.frameprocessing", DISPATCH_QUEUE_SERIAL);
        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [ kCVPixelBufferPixelFormatTypeKey: Int(kCVPixelFormatType_32BGRA) ]
        output.setSampleBufferDelegate(self, queue: frameProcessingQueue)
        assert(session.canAddOutput(output))
        session.addOutput(output)
        
        // Button
        
        self.view.bringSubviewToFront(FilterButton)
        self.view.bringSubviewToFront(button)
        self.view.bringSubviewToFront(switchCamOutlet)
        self.view.bringSubviewToFront(faceFilterSwitch)
        button.layer.cornerRadius = button.frame.width / 2.0
        
        // Start actually capturing
        session.startRunning()
    }

    func hackFixOrientation(img: UIImage) -> CGImageRef {
        let debug = CIImage(CGImage: img.CGImage!).imageByApplyingOrientation(6)
        let context = CIContext()
        let fixedImg = context.createCGImage(debug, fromRect: debug.extent)
        return fixedImg
    }
    
    func detectFaces(imageBuffer : CVImageBufferRef) {
        CVPixelBufferLockBaseAddress(imageBuffer, 0)
        
        let height = CVPixelBufferGetHeight(imageBuffer)
       // let width = CVPixelBufferGetWidth(imageBuffer)
        let ciImage = CIImage(CVImageBuffer: imageBuffer)
        let faces = faceDetector.featuresInImage(ciImage,
            options:[CIDetectorImageOrientation: 6]) as! [CIFaceFeature]

        //print("\(faces.count) faces detected")

        // Draw rectangles on detected faces
        UIGraphicsBeginImageContext(ciImage.extent.size)
        let context = UIGraphicsGetCurrentContext()
        
        // Set line properties color and width

        // Transform that flips the Y axis
        var T = CGAffineTransformIdentity
        T = CGAffineTransformScale(T, 1, -1)
        T = CGAffineTransformTranslate(T, 0, -CGFloat(height))
        
        for face in faces {
            let faceLoc = CGRectApplyAffineTransform(face.bounds, T)
           // CGContextAddEllipseInRect(context, faceLoc)
            
            CGContextDrawImage(context, faceLoc, goatFace!.CGImage)
        }
        
        CGContextStrokePath(context)
        
        let drawnFaces = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0)
        
        
        // Send to main queue to update UI
        dispatch_async(dispatch_get_main_queue()) {
            self.processedLayer.contents = self.hackFixOrientation(drawnFaces)
        }

    }
    
    func colorFilter(imageBuffer : CVImageBufferRef) {
        CVPixelBufferLockBaseAddress(imageBuffer, 0)

        var pixels = UnsafeMutablePointer<UInt8>(CVPixelBufferGetBaseAddress(imageBuffer))
        // pixels are stored as (blue, green, red, alpha), one byte per channel
        
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        
        let blueValue = UInt8((1.0 + sin(Double(frameNo) / 10.0)) * 0.5 * 255)
        
        for _ in 0 ..< height {
            var idx = 0
            for _ in 0 ..< width {
                pixels[idx    ] = blueValue  // Blue
                //pixels[idx + 1] = 0  // Green
                //pixels[idx + 2] = 0  // Red
                //pixels[idx + 3] = 0  // Alpha
                idx += 4
            }
            pixels += bytesPerRow
        }
        
        // Create an image with this buffer
        let context = CIContext()
        let ciImage = CIImage(CVImageBuffer: imageBuffer).imageByApplyingOrientation(6)
        let cgImage = context.createCGImage(ciImage, fromRect: ciImage.extent)
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0)
        
        // Send to main queue to update UI
        dispatch_async(dispatch_get_main_queue()) {
            self.processedLayer.contents = cgImage
        }
    }
    
    // Method that receives the frame buffers
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        if(isProcessing) {
            guard let frameBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            // let frameBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            // if frameBuffer == nil {
            //     return
            // }
            
            // To face
            if isFaceOrFilter {
                faceFilterSwitch.setTitle("Filter", forState: .Normal)
                detectFaces(frameBuffer)
            }
            // To filter
            else {
                faceFilterSwitch.setTitle("Face Detection", forState: .Normal)
                colorFilter(frameBuffer)
            }
            
            frameNo += 1
        }
    }

}

