//
//  APICall.swift
//  slcm_MTTN
//
//  Created by Sarthak Jha  on 02/08/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import Foundation

class APICall {
    var url: URL
    private var recievedData: List?
    init(url: URL) {
        self.url = url
    }
    
    func networkCall() -> List {
        
        let url = self.url
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let recData = try decoder.decode(List.self, from: data)
                self.recievedData = recData

            } catch {
                print(error.localizedDescription)
                return
            }
        }
        dataTask.resume()
        return recievedData!
        
    }
    
    
}
