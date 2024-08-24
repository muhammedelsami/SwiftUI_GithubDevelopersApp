//
//  DeveloperDetailViewModel.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 24.08.2024.
//

import Foundation
import SwiftUI

class DeveloperDetailViewModel: ObservableObject {
    @Published var developerDetail: DeveloperDetail?
    @Published var isLoading = false

    let username: String
    private let service: DeveloperDetailService

    init(username: String, service: DeveloperDetailService = DeveloperDetailService()) {
        self.username = username
        self.service = service
    }

    func fetchDeveloperDetail() {
        isLoading = true
        service.fetchDeveloperDetail(for: username) { [weak self] detail in
            self?.isLoading = false
            self?.developerDetail = detail
        }
    }

    func formatDate(_ isoDate: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: isoDate) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return "N/A"
    }

    func formatURL(_ urlString: String) -> String {
        if urlString.lowercased().hasPrefix("http://") || urlString.lowercased().hasPrefix("https://") {
            return urlString
        } else {
            return "http://\(urlString)"
        }
    }
}
