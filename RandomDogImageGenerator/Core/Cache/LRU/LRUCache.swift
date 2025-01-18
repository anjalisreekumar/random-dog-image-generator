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
        if node === head { return }
        removeNode(node)
        
        // Insert the node at the front
        node.next = head
        node.previous = nil
        head?.previous = node
        head = node
        
        // If tail is nil, it means the list was empty before, so the new node is also the tail
        if tail == nil {
            tail = node
        }
    }
    
    func removeNode(_ node: Node) {
        if let prev = node.previous {
            prev.next = node.next
        } else {
            head = node.next
        }
        
        if let next = node.next {
            next.previous = node.previous
        } else {
            tail = node.previous
        }
    }
    
    func put(key: String, value: UIImage) {
        if let node = cache[key] {
            // If the node exists, update its value and move it to the front
            node.value = value
            moveNodeToFront(node)
        } else {
            // If the cache is full, remove the least recently used (tail)
            if cache.count >= capacity {
                if let tailNode = tail {
                    cache[tailNode.key] = nil
                    removeNode(tailNode)
                }
            }
            
            // Create a new node and insert it at the front
            let newNode = Node(key: key, value: value)
            cache[key] = newNode
            moveNodeToFront(newNode)
        }
    }
    
    // Retrieve a node from the cache and move it to the front (most recently used)
    func get(key: String) -> UIImage? {
        guard let node = cache[key] else { return nil }
        moveNodeToFront(node)
        return node.value
    }
    
    // Clear the cache
    func clearCache() {
        cache.removeAll()
        head = nil
        tail = nil
    }
    
    func getAllImages() -> [UIImage] {
        return cache.values.map { $0.value }
    }
}
