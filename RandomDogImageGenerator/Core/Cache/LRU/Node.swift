//
//  Node.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 17/01/25.
//

import Foundation
import UIKit

class Node {
    var key: String
    var value: UIImage
    var next: Node?
    var previous: Node?

    init(key: String, value: UIImage) {
        self.key = key
        self.value = value
    }
}
