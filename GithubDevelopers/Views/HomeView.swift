//
//  HomeView.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 19.08.2024.
//

import SwiftUI


struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedCity: City? = nil
    @State private var isDropDownOpen = false

    let cities = [
        City(name: "Sivas"),
        City(name: "Istanbul"),
        City(name: "Ankara"),
        City(name: "Izmir"),
        City(name: "Antalya"),
        City(name: "Bursa")
    ]

    var body: some View {
        VStack {
            // Center content
            Spacer()
            
            VStack {
                // Logo
                Image(systemName: "person.3.fill") // Replace with your logo
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                // Search Bar
                HStack {
                    TextField("Search for a city", text: $searchText)
                        .padding(.leading, 10)
                        .foregroundColor(.white)
                        
                    
                    Button(action: {
                        // Navigate to listing view by search text
                        navigateToListingView(bySearchText: searchText)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
                
                
                VStack(alignment: .leading) {
                    Text("Select a city:")
                        .foregroundColor(.white)
                        .font(.custom("Barlow-Medium", size: 16))
                    Menu {
                        ForEach(cities , id: \.id) { item in
                            Button(item.name) {
                                selectedCity = item
                                navigateToListingView(bySearchText: item.name)
                            }
                        }
                    } label: {
                        HStack {
                            if selectedCity == nil {
                                Text("Select..")
                                    .foregroundColor(.white)
                            } else {
                                Text(selectedCity?.name ?? "")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .frame(maxWidth: .infinity)
                }
                //.disabled(!searchText.isEmpty)
                .padding(.top)
                .padding([.leading, .trailing])
            }
            
            Spacer()
        }
        .background(Color.appBackground.ignoresSafeArea())
        
        
    }

    private func navigateToListingView(bySearchText searchText: String) {
        let listingView = ListingView(city: searchText)
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: listingView)
            window.makeKeyAndVisible()
        }
    }
}

#Preview {
    HomeView()
}




//
//struct HomeView: View {
//    @State private var searchText = ""
//    @State private var selectedCity: City? = nil
//    @State private var selectedCountry: Country? = nil
//    @State private var isCityDropdownOpen = false
//    @State private var isCountryDropdownOpen = false
//    @State private var countries: [Country] = []
//    @State private var cities: [City] = []
//    @State private var isLoading = false
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            
//            VStack {
//                // Logo
//                Image(systemName: "person.3.fill") // Replace with your logo
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(.white)
//                    .padding(.bottom, 20)
//                
//                // Search Bar
//                HStack {
//                    TextField("Search for a city", text: $searchText)
//                        .padding(.leading, 10)
//                        .foregroundColor(.white)
//                    
//                    Button(action: {
//                        navigateToListingView(bySearchText: searchText)
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                            .padding(.trailing, 10)
//                    }
//                }
//                .padding()
//                .background(Color.blue.opacity(0.2))
//                .cornerRadius(8)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.gray, lineWidth: 1)
//                )
//                .padding(.horizontal)
//                
//                VStack(alignment: .leading) {
//                    // Country Selector
//                    Text("Select a country:")
//                        .foregroundColor(.white)
//                        .font(.custom("Barlow-Medium", size: 16))
//                    
//                    Menu {
//                        ForEach(countries) { country in
//                            Button(country.name) {
//                                selectedCountry = country
//                                fetchCities(for: country)
//                            }
//                        }
//                    } label: {
//                        HStack {
//                            if selectedCountry == nil {
//                                Text("Select a country")
//                                    .foregroundColor(.white)
//                            } else {
//                                Text(selectedCountry?.name ?? "")
//                                    .foregroundColor(.white)
//                            }
//                            Spacer()
//                            Image(systemName: "chevron.down")
//                                .foregroundColor(.white)
//                        }
//                        .padding()
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
//                    }
//                    .frame(maxWidth: .infinity)
//                    
//                    // City Selector
//                    Text("Select a city:")
//                        .foregroundColor(.white)
//                        .font(.custom("Barlow-Medium", size: 16))
//                        .padding(.top)
//                    
//                    Menu {
//                        ForEach(cities) { city in
//                            Button(city.name) {
//                                selectedCity = city
//                                navigateToListingView(bySearchText: city.name)
//                            }
//                        }
//                    } label: {
//                        HStack {
//                            if selectedCity == nil {
//                                Text("Select a city")
//                                    .foregroundColor(.white)
//                            } else {
//                                Text(selectedCity?.name ?? "")
//                                    .foregroundColor(.white)
//                            }
//                            Spacer()
//                            Image(systemName: "chevron.down")
//                                .foregroundColor(.white)
//                        }
//                        .padding()
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//                .padding([.leading, .trailing])
//                .padding(.top)
//            }
//            
//            Spacer()
//        }
//        .background(Color.appBackground.ignoresSafeArea())
//        .onAppear {
//            fetchCountries()
//        }
//    }
//    
//    private func fetchCountries() {
//        let url = URL(string: "https://countriesnow.space/api/v0.1/countries/positions")!
//        
//        isLoading = true
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error fetching countries: \(error?.localizedDescription ?? "Unknown error")")
//                isLoading = false
//                return
//            }
//            
//            do {
//                let result = try JSONDecoder().decode(CountriesResponse.self, from: data)
//                DispatchQueue.main.async {
//                    self.countries = result.data.map { Country(name: $0.name) }
//                    self.isLoading = false
//                }
//            } catch {
//                print("Error decoding countries: \(error.localizedDescription)")
//                self.isLoading = false
//            }
//        }.resume()
//    }
//    
//    private func fetchCities(for country: Country) {
//        guard let countryName = country.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
//        let url = URL(string: "https://countriesnow.space/api/v0.1/countries/cities")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Create JSON body
//        let body: [String: String] = ["country": countryName]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//        
//        // Start loading
//        isLoading = true
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error fetching cities: \(error.localizedDescription)")
//                DispatchQueue.main.async { self.isLoading = false }
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received")
//                DispatchQueue.main.async { self.isLoading = false }
//                return
//            }
//            
//            do {
//                let result = try JSONDecoder().decode(CitiesResponse.self, from: data)
//                DispatchQueue.main.async {
//                    if !result.error {
//                        self.cities = result.data.map { City(name: $0) }
//                    } else {
//                        print("Error in API response: \(result.msg)")
//                    }
//                    self.isLoading = false
//                }
//            } catch {
//                print("Error decoding cities: \(error.localizedDescription)")
//                DispatchQueue.main.async { self.isLoading = false }
//            }
//        }.resume()
//    }
//
//    
////    private func fetchCities(for country: Country) {
////        guard let countryName = country.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
////        let url = URL(string: "https://countriesnow.space/api/v0.1/countries/cities")!
////        var request = URLRequest(url: url)
////        request.httpMethod = "POST"
////        let body = ["country": countryName]
////        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
////
////        isLoading = true
////        URLSession.shared.dataTask(with: request) { data, response, error in
////            guard let data = data, error == nil else {
////                print("Error fetching cities: \(error?.localizedDescription ?? "Unknown error")")
////                isLoading = false
////                return
////            }
////
////            print("Respo=====>>>> \(data)")
////            print("Respo=====>>>> \(response)")
////            print("Respo=====>>>> \(error)")
////
////            do {
////                let result = try JSONDecoder().decode(CitiesResponse.self, from: data)
////                DispatchQueue.main.async {
////                    //self.cities = result.data.map { City(name: $0.self) }
////                    if !result.error {
////                        self.cities = result.data.map { City(name: $0) }
////                    } else {
////                        print("Error in API response: \(result.msg)")
////                    }
////                    self.isLoading = false
////                }
////            } catch {
////                print("Error decoding cities: \(error.localizedDescription)")
////                self.isLoading = false
////            }
////        }.resume()
////    }
//    
//    private func navigateToListingView(bySearchText searchText: String) {
//        let listingView = ListingView(city: searchText)
//        if let window = UIApplication.shared.windows.first {
//            window.rootViewController = UIHostingController(rootView: listingView)
//            window.makeKeyAndVisible()
//        }
//    }
//}
//
//struct Country: Identifiable {
//    let id = UUID()
//    let name: String
//}
//
//struct City: Identifiable {
//    let id = UUID()
//    let name: String
//}
//
//struct CountriesResponse: Decodable {
//    let error: Bool
//    let msg: String
//    let data: [CountryData]
//    
//    struct CountryData: Decodable {
//        let name: String
//    }
//}
//
//struct CitiesResponse: Decodable {
//    let error: Bool
//    let msg: String
//    let data: [String]
//}
//
//struct Developer: Identifiable, Decodable {
//    let id: Int
//    let login: String
//    let avatar_url: String
//}
//
//#Preview {
//    HomeView()
//}
//
