//
//  List.swift
//  slcm_MTTN
//
//  Created by Sarthak Jha  on 02/08/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import Foundation

struct ContentTitles: Decodable {
    var title: String
    var page: Int
    var index: Int
}

struct List: Decodable {
    
    var contentLength: Int
    var contentTitles: [ContentTitles]
}
