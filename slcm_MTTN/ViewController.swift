//
//  ViewController.swift
//  slcm_MTTN
//
//  Created by Sarthak Jha  on 02/08/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var recievedList: [ContentTitles] = []

    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var listTable: UITableView!
    
    func downloadJson() {
        let urlString = "http://127.0.0.1:5000/"
        let url = URL(string: urlString)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let recData = try decoder.decode(List.self, from: data)
                self.recievedList = recData.contentTitles
                DispatchQueue.main.async {
                     self.listTable.reloadData()
                    self.navigationItem.leftBarButtonItem?.isEnabled = true
                }
                print("data recieved")
                
            } catch {
                print(error.localizedDescription)
                return
            }
        }
        dataTask.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTable.delegate = self
        listTable.dataSource = self
        self.navigationItem.rightBarButtonItem = refreshButton
        navigationItem.leftBarButtonItem?.isEnabled = false
        downloadJson()
        
}
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        recievedList = []
        downloadJson()
    }
    
}
extension ViewController: hitURL {
    func didTapDownloadButton(index: Int, page: Int) {
        let urlString = "http://127.0.0.1:5000/getpdf"
        let postObject = PostObject(index: index, page: page)
        let url = URL(string: urlString)
        var postRequest = URLRequest(url: url!)
        
        postRequest.httpMethod = "POST"
        postRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            print("post request sent")
            postRequest.httpBody = try JSONEncoder().encode(postObject)
        } catch {
            print(error.localizedDescription)
        }
        
        let dataTask = URLSession.shared.dataTask(with: postRequest) { (data, response, error) in
            print(data!)
        }
        dataTask.resume()
        
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return recievedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listItem = recievedList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:"noticeCell" ) as! NoticeCell
        cell.setVideo(cellContents: listItem)
        cell.delegate = self
        return cell
    }
    
    
}

