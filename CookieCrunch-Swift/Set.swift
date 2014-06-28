//
//  Set.swift
//  CookieCrunch-Swift
//
//  Created by Ryoichi Hara on 2014/06/28.
//  Copyright (c) 2014 Ryoichi Hara. All rights reserved.
//

class Set<T: Hashable>: Sequence, Printable {
    var dictionary = Dictionary<T, Bool>()  // private

    func addElement(newElement: T) {
        dictionary[newElement] = true
    }

    func removeElement(element: T) {
        dictionary[element] = nil
    }

    func containsElement(element: T) -> Bool {
        return dictionary[element] != nil
    }

    func allElements() -> T[] {
        return Array(dictionary.keys)
    }

    var count: Int {
        return dictionary.count
    }

    func unionSet(otherSet: Set<T>) -> Set<T> {
        var combined = Set<T>()

        for obj in dictionary.keys {
            combined.dictionary[obj] = true
        }

        for obj in otherSet.dictionary.keys {
            combined.dictionary[obj] = true
        }

        return combined
    }

    // Allows you to use the set in 'for-in' loops
    func generate() -> IndexingGenerator<Array<T>> {
        return allElements().generate()
    }

    var description: String {
        return dictionary.description
    }
}
