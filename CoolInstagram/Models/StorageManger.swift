//
//  StorageManger.swift
//  CoolInstagram
//
//  Created by Vincent Moyo on 2022/02/01.
//

import Foundation
import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, Error>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(IGStorageManagerError.failedToDownload))
                return
            }
            completion(.success(url))
        }
    }
    
}
