//
//  DataManager.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 22/08/22.
//

import Foundation

class DataManager {
    
    static let sharedInstance = DataManager()
    
    func saveFavorite(post: Post) {
        var favorites = loadFavorites()
        favorites.append(post)
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: "favorites")
        }
    }
    
    func loadFavorites() -> [Post] {
        if let resultData = UserDefaults.standard.data(forKey: "favorites"),
            let result = try? JSONDecoder().decode([Post].self, from: resultData) {
            return result
        }
        return []
    }
    
    func removeFavorite(id: Int) {
        var favorites = loadFavorites()
        favorites.removeAll(where: { $0.id == id })
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: "favorites")
        }
    }
    
    func removeAllFavorites() {
        UserDefaults.standard.removeObject(forKey: "favorites")
        UserDefaults.standard.synchronize()
    }
    
    func containFavorite(id: Int) -> Bool {
        let favorites = loadFavorites()
        return favorites.contains(where: { $0.id == id })
    }
}
