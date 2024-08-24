import SwiftUI

struct ListingView: View {
    let city: String
    @State private var developers: [Developer] = []
    @State private var isGridView: Bool = false
    @State private var currentPage = 1
    @State private var count = 20
    @State private var isLoading = false
    @State private var totalDevelopers = 0
    
    var body: some View {
        NavigationView {
            VStack {
                // Üst Başlık (Navbar)
                HeaderView(isGridView: $isGridView)

                if developers.isEmpty {
                    // Eğer geliştirici listesi boşsa yüklenme durumu göster
                    EmptyStateView()
                } else {
                    // Eğer geliştirici listesi doluysa grid veya liste görünümünde göster
                    if isGridView {
                        GridView(developers: developers, isLoading: $isLoading, loadMore: loadMoreDevelopers)
                    } else {
                        ListView(developers: developers, isLoading: $isLoading, loadMore: loadMoreDevelopers)
                    }
                }
            }
            .onAppear {
                fetchDevelopers(page: currentPage)
            }
            //.navigationBarTitle("\(city) Developers (\(totalDevelopers))", displayMode: .inline)
            .background(Color.appBackground)
        }
    }

    private func fetchDevelopers(page: Int) {
        let urlString = "https://api.github.com/search/users?q=location:\(city)&page=\(page)&per_page=\(count)"
        guard let url = URL(string: urlString) else { return }

        isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }
            if let data = data {
                if let response = try? JSONDecoder().decode(GitHubResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.developers.append(contentsOf: response.items)
                        self.totalDevelopers = response.total_count 
                    }
                }
            }
        }.resume()
    }
    
    private func loadMoreDevelopers() {
        currentPage += 1
        fetchDevelopers(page: currentPage)
    }
}

struct HeaderView: View {
    @Binding var isGridView: Bool

    var body: some View {
        HStack {
            Button(action: {
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: HomeView())
                    window.makeKeyAndVisible()
                }
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .padding()
            }
            
            Spacer()
            
            Button(action: {
                isGridView.toggle()
            }) {
                Image(systemName: isGridView ? "rectangle.grid.2x2" : "list.bullet")
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(Color.appBackground)
    }
}

struct EmptyStateView: View {
    var body: some View {
        Spacer()
        ProgressView("Loading developers...")
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .foregroundColor(.white)
            .scaleEffect(1.0)
            .padding()
            .font(.body)
        Spacer()
    }
}

struct GridView: View {
    let developers: [Developer]
    @Binding var isLoading: Bool
    let loadMore: () -> Void

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(developers) { developer in
                    NavigationLink(destination: DeveloperDetailView(username: developer.login)) {
                        DeveloperCard(developer: developer)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                if isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Color.clear
                        .onAppear {
                            loadMore()
                        }
                }
            }
            .padding()
        }
        .background(Color.appBackground)
    }
}

struct ListView: View {
    let developers: [Developer]
    @Binding var isLoading: Bool
    let loadMore: () -> Void

    var body: some View {
        List {
            
            ForEach(developers) { developer in
                ZStack {
                    NavigationLink(destination: DeveloperDetailView(username: developer.login)) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    DeveloperRow(developer: developer)
                        .listRowBackground(Color.appBackground)
                }
                .listRowBackground(Color.clear)
            }
            
            if isLoading {
                HStack(alignment: .center) {
                    ProgressView()
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .frame(alignment: .center)
                .listRowBackground(Color.clear)
            } else {
                Color.clear
                    .onAppear {
                        loadMore()
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct DeveloperRow: View {
    let developer: Developer

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: developer.avatar_url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(developer.login)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("GitHub Developer")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.2))
        .cornerRadius(10)
    }
}

struct DeveloperCard: View {
    let developer: Developer

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: developer.avatar_url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .padding()

            Text(developer.login)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .lineLimit(1)
        }
        .frame(minWidth: 180)
        .background(Color(.systemGray6).opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    ListingView(city: "Sivas")
}
