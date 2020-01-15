//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// TODO: get permission
		
		showCamera()
		
	}
    
    private func requestPermissionAndShowCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
            
        case .notDetermined:
            // First time user - they havent seen the dialog to give permission
            requestPermission()
            
        case .restricted:
            // Parental controls disabled camera
            fatalError("Video is disable for use (parental controls)")
        
        case .denied:
            // User did not give access
            fatalError("Tell the user they need to enbale privacy for video")
        
        case .authorized:
            // We asked for permission 2nd time they've used the app
            showCamera()
            
        @unknown default:
            fatalError("A new status was added that we need to handle")
        }
    }
    
    private func requestPermission() {
        // TODO: Implement
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            guard granted else {
                fatalError("Tell user they need to enable privacy for video")
            }
            DispatchQueue.main.async { [weak self] in
                self?.showCamera()
            }
        }
    }
	
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
}
