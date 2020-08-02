//
//  PostObject.swift
//  slcm_MTTN
//
//  Created by Sarthak Jha  on 03/08/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import Foundation

class PostObject: Encodable {
    var page: Int
    var index: Int
    init(index: Int, page: Int) {
        self.index = index
        self.page = page
    }
}
