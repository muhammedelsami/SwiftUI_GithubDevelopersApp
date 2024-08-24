//
//  GitHubResponse.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 24.08.2024.
//

import Foundation

struct GitHubResponse: Decodable {
    let total_count: Int
    let items: [Developer]
}
