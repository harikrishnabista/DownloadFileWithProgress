//
//  ViewController.swift
//  HelloProgressBar
//
//  Created by Hari Krishna Bista on 1/14/18.
//  Copyright © 2018 meroapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {

    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: URLSession!
    
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "background")
        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    func fileDownload() {
        let url = URL(string: "http://publications.gbdirect.co.uk/c_book/thecbook.pdf")!
        downloadTask = backgroundSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    
    //MARK: URLSessionTaskDelegate
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL){
        
        print("didFinishDownloadingTo")
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64){
        
        progressView.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
    }
    @IBAction func btnDownloadTapped(_ sender: Any) {
        self.progressView.setProgress(0, animated: false)
        self.fileDownload()
    }
    
   
    func urlSession(_ session: URLSession,task: URLSessionTask,didCompleteWithError error: Error?){
        
        print(error.debugDescription)
        print("didComplete")
    }
}

