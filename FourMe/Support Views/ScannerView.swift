//
//  ScannerView.swift
//  FourMe
//
//  Created by Lars Klassen on 10/26/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerView: UIView, AVCaptureMetadataOutputObjectsDelegate {

    let captureSession = AVCaptureSession()
    var completionHandler: ((_ barcode: String) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            NSLog("\(error)")
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .upce]
        }
        
        self.layer.session = captureSession
        self.layer.videoGravity = .resizeAspectFill
        
        captureSession.startRunning()
    }
    
    override class var layerClass: AnyClass  {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let completionHandler = self.completionHandler {
            completionHandler("Barcode")
        }
    }

}
