//
//  Github.swift
//  Github
//
//  Created by DxO Labs on 02/05/2018.
//  Copyright © 2018 DxO Labs. All rights reserved.
//

import UIKit

private let baseURL = URL(string:"https://api.github.com/users/")!

enum User: String {
    case apple, google
}

extension User {
    var url: URL {
        return URL(string:rawValue, relativeTo:baseURL)!
    }
}

struct UserDetails : Codable {
    let avatar_url : URL?
    let repos_url : URL
    let location : String?
    let blog : URL?
    let name : String
    let html_url : URL
}

extension UserDetails {
    var short_url: String {
        return html_url.host! + html_url.path
    }
}

struct RepoDetails : Codable {
    let name: String
    let full_name: String
    let desc: String?
    let created_at: Date
    let language: String?
    let watchers: Int
    let html_url: URL
}

struct Github {
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    func getData<T: Decodable>(ofType type: T.Type, at url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try jsonDecoder.decode(type, from: data)
    }
    
    func getImage(from userDetails: UserDetails) throws -> UIImage? {
        guard let avatar_url = userDetails.avatar_url else {
            return nil
        }
        return try UIImage(data: Data(contentsOf : avatar_url))
    }
}
