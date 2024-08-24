//
//  DeveloperDetail.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 24.08.2024.
//

import Foundation

struct DeveloperDetail: Identifiable, Decodable {
    let id: Int
    let login: String
    let avatar_url: String
    let name: String?
    let company: String?
    let location: String?
    let bio: String?
    let public_repos: Int
    let public_gists: Int
    let followers: Int
    let html_url: String
    let blog: String?
    let created_at: String
    let updated_at: String
}
