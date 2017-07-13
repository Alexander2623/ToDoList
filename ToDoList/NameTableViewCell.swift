//
//  NameTableViewCell.swift
//  ToDoList
//
//  Created by Александр on 11.07.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    weak var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
    }
    
    func didChangeText() {
        if let unwrappedText = textField.text {
            delegate?.textFieldDidChange(value: unwrappedText)
        }
    }
}
