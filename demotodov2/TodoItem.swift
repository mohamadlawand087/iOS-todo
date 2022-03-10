//
//  TodoItem.swift
//  demotodov2
//
//  Created by Mohamad Lawand on 09/03/2022.
//

import Foundation

struct TodoItem : Codable {
    let id: Int
    let title: String
    let done: Bool
}
