//
//  ImageCacheManager.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 17/01/25.
//

import Foundation
import UIKit

class LRUCache {
    private var capacity: Int
    var cache = [String: Node]()
    private var head: Node?
    private var tail: Node?
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func moveNodeToFront(_ node: Node) {
        if node === head { return } // Node is already at the front
        removeNode(node) // Remove from current position

        // Insert at the front
        node.next = head
        node.previous = nil
        head?.previous = node
        head = node

        // If the list was empty, set tail to this node
        if tail == nil {
            tail = node
        }
    }
    
    func removeNode(_ node: Node) {
        if node === head {
            head = node.next
        }
        if node === tail {
            tail = node.previous
        }
        node.previous?.next = node.next
        node.next?.previous = node.previous

        // Break references for safety
        node.next = nil
        node.previous = nil
    }
    
    func put(key: String, value: UIImage) {
        if let node = cache[key] {
            // Update value and move to the front
            node.value = value
            moveNodeToFront(node)
        } else {
            if cache.count >= capacity {
                // Remove the least recently used node (tail)
                if let tailNode = tail {
                    cache[tailNode.key] = nil
                    removeNode(tailNode)
                }
            }
            
            // Add the new node
            let newNode = Node(key: key, value: value)
            cache[key] = newNode
            moveNodeToFront(newNode)
        }
    }
    
    func get(key: String) -> UIImage? {
        guard let node = cache[key] else { return nil }
        moveNodeToFront(node)
        return node.value
    }
    
    func clearCache() {
        cache.removeAll()
        head = nil
        tail = nil
    }
    
    func getAllImages() -> [UIImage] {
        var images = [UIImage]()
        var current = head
        while let node = current {
            images.append(node.value)
            current = node.next
        }
        return images
    }
}
