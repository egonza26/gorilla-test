//
//  ImageManager.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import Foundation

struct ImageManager {

    static let shared = ImageManager()
    private var imageCache = NSCache<AnyObject, AnyObject>()
    private init() { }

    func saveImage(url: String, imageData: Data) {
        imageCache.setObject(imageData as AnyObject, forKey: url as AnyObject)
    }

    func getImage(url: String) -> Data? {
        guard let imageFromCache = imageCache.object(forKey: url as AnyObject) as? Data else {
            return nil
        }

        return imageFromCache
    }
}
