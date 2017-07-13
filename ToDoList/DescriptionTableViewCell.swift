//
//  DescriptionTableViewCell.swift
//  ToDoList
//
//  Created by Александр on 11.07.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    weak var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
    }
}

extension DescriptionTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.texViewDidChange(value: textView.text)
    }
}
