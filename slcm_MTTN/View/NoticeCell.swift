//
//  NoticeCell.swift
//  slcm_MTTN
//
//  Created by Sarthak Jha  on 02/08/20.
//  Copyright © 2020 Sarthak Jha . All rights reserved.
//

import UIKit

protocol hitURL {
    func didTapDownloadButton(index: Int, page: Int)
}

class NoticeCell: UITableViewCell {

@IBOutlet weak var title: UILabel!
    var delegate: hitURL?
    var index: Int = 0
    var page: Int = 0
    
    func setVideo(cellContents: ContentTitles) {
        title.text = cellContents.title
        index = cellContents.index
        page = cellContents.page
    }
    
    
@IBAction func downloadPressed(_ sender: UIButton) {
    delegate?.didTapDownloadButton(index: index, page: page)
    }
}
