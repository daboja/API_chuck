//
//  ViewController.swift
//  API_chuck
//
//  Created by Gosia Connors on 5/3/21.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var chuckLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //url is an optional so we need to guard it
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            fatalError("Error getting Chuck Norris URL")
        }

        let session = URLSession.shared //create instance of URL session
        session.dataTask(with: url) { (data, response, error) in  //data is in JSON format - JSON is in dictionary format (key:value format)
            if let data = data {
                print("Data: \(data)")
                print("Response: \(response)")
                print("Error: \(error)")
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let  dict = json as? [String : Any] {
                        print("dict: \(dict)")
                        //update label with value
                        if let value = dict["value"] as? String {
                            DispatchQueue.main.async {
                                self.chuckLabel.text = value
                            }
                        }
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
}
