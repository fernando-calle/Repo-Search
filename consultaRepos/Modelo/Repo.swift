//
//  Repo.swift
//  consultaRepos
//
//  Created by fernando.calle.silos on 3/5/18.
//  Copyright © 2018 fernando.calle.silos. All rights reserved.
//

import Foundation


struct Repo: Codable {
    let id: Int
    let name: String
    let fullName: String
    
    
    enum CodingKeys: String,CodingKey {
        case id,name,owner
        case fullName = "full_name"
    }
    
    
    struct Owner:Codable {
        let login: String
    }
    
    let owner:Owner
}

struct RepoSearch:Codable {
    
    let items: [Repo]
    let totalCount: Int
    
    enum CodingKeys: String,CodingKey {
        case items
        case totalCount = "total_count"
    }

    
}
