//
//  CameraViewController.swift
//  Snap Note
//
//  Created by King Justin on 7/7/16.
//  Copyright © 2016 justinleesf. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    
    var note : Note?
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var didTakePhoto = Bool()
    var sendImage : UIImage?
    
    var listNotesTableViewController: ListNotesTableViewController?
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        print("saveButtonTapped")
        
        let newNote = Note()
        newNote.title =  "NEW NOTE FROM CAMERA"
        
        if let actualImage = sendImage {
            let imageData = UIImageJPEGRepresentation(actualImage, 0.5)
            newNote.image = imageData
        }
        
        RealmHelper.addNote(newNote)
        listNotesTableViewController?.notes = RealmHelper.retrieveNotes()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.hidden = true
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error : NSError?
        
        //        var input = AVCaptureDeviceInput(device: backCamera)
        
        do {
            
            var input = try AVCaptureDeviceInput(device: backCamera)
            
            captureSession?.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [ AVVideoCodecKey : AVVideoCodecJPEG]
            
            if ((captureSession?.canAddOutput(stillImageOutput)) != nil) {
                captureSession?.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                cameraView.layer.addSublayer(previewLayer!)
                captureSession?.startRunning()
            }
        }
        catch _ {
            print("saf")
        }
    }
    
    func didPressTakePhoto() {
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                
                if imageDataSampleBuffer != nil {
                    print("image buffer")
                    var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    var dataProvider = CGDataProviderCreateWithCFData(imageData)
                    var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    var image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    // Image to put into note
                    self.sendImage = image
                    
                    self.tempImageView.image = image
                    self.tempImageView.hidden = false
                    self.view.sendSubviewToBack(self.cameraView)
                }
            }
        }
    }
    
    func didPressTakeAnother() {
        if didTakePhoto == true {
            saveButton.hidden = true
            tempImageView.hidden = true
            didTakePhoto = false
        } else {
            print("Show button")
            captureSession?.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
            self.saveButton.hidden = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("didPressTakeAnother()")
        didPressTakeAnother()
    }
}
