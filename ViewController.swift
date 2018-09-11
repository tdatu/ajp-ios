//
//  ViewController.swift
//  Kids Play
//
//  Created by Anthony Datu on 9/2/18.
//  Copyright © 2018 Anthony Datu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import WebKit

struct User:Decodable {
    let email: String
    let website: URL
    let id: Int
    let name: String
    let phone: String
    let address: Address
    let username: String
    let company: Company
    
}

struct Address: Decodable {
    let city: String
    let street: String
    let suite: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Decodable {
    let lat: Float
    let lng: Float
}

struct Company: Decodable {
    let bs: String
    let catchPhrase: String
    let name: String
}

class ViewController: UIViewController,WKUIDelegate {
    
    @IBOutlet weak var mediaButton: UIButton!
    var webView: WKWebView!
    var audioplayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do{
            audioplayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource:"04 Videoke Queen",ofType: "m4a")!))
        }catch{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func videoBtnClick(_ sender: Any) {
        _ = URL.init(fileURLWithPath: Bundle.main.path(forResource: "test", ofType:"mov")!)
        let webVideo = URL.init(string: "https://zeydhan.me/drive/index.php?id=6KeEtt8HDnyy3oytfX2Z9AHOsBAqxOnES7zeJOYgPkAdgsW0%2BAcUuzGvKCBcyH6PcZKSL80yISlbVbgpjR5XEt6UDccpL32Qls1UBLXI7C4g%3D%3D&ref=http%3A%2F%2Fwww2.animestreams.net%2Faho-girl%2F")!
        
        let player = AVPlayer(url: webVideo)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true)
    }
    
    @IBAction func websiteClick(_ sender: Any) {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
        super.viewDidLoad()
        
        let myURL = URL(string: "http://www2.animestreams.net/aho-girl/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        
    }
    
    @IBAction func mediaTap(_ sender: UIButton) {
        let stopBtn = UIImage(named:"stop_button")
        let playBtn = UIImage(named:"play_button")
        
        if sender.currentImage == stopBtn {
            sender.setImage(playBtn,for:UIControlState.normal)
                audioplayer.stop()
        }
        else{
            sender.setImage(stopBtn,for:UIControlState.normal)
                audioplayer.play()
        }
    }


    @IBAction func newsBtnClick(_ sender: Any) {
        print("newsBtnClick")
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let session = URLSession.shared
        session.dataTask(with: url) { (data, res, err) in
            if let content = data {
                do {
                    //serialize json objects
                    guard let users:[User] = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.allowFragments) as! [User] else { return }
                    
                    //Iterate to each user json object
                    for user in users {
                        print(user)
                    }
                    
                }catch {
                    print(error)
                }
            }
        }.resume()
        
    }
    
    
}

