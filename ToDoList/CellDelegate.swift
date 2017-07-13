//
//  CellProtocol.swift
//  ToDoList
//
//  Created by Александр on 12.07.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import Foundation

protocol CellDelegate: class {
    
    func textFieldDidChange(value text: String)
    
    func texViewDidChange(value text: String)
}
