//
//  ContentView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var viewModel: ContentViewModel

    var body: some View {
        List {
            if !viewModel.characters.isEmpty {
                ForEach(viewModel.characters) { character in
                    Text(character.displayName)
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear(perform: onContentViewAppear)
    }

    private func onContentViewAppear() {
        viewModel.populateCharacters()
    }
}

class ContentViewModel: ObservableObject {
    @Published var characters = [Character]()

    func populateCharacters() {
        Networker.getCharacters { result in
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let characters):
                DispatchQueue.main.async {
                    self.characters = characters
                }
            }
        }
    }
}

struct Character: Codable, Hashable, Identifiable {
    let colorTheme: String
    let displayName: String
    let id: String
    let ownerId: Int
    let fullUrl: String
    let mainImageUrl: String
    let thumbnailUrl: String
    let game: String
    let related: Related

    struct Related: Codable, Hashable {
        let ultimate: Ultimate

        struct Ultimate: Codable, Hashable {
            let itSelf: String
            let moves: String

            private enum CodingKeys: String, CodingKey {
                case itSelf = "Self"
                case moves = "Moves"
            }
        }

        private enum CodingKeys: String, CodingKey {
            case ultimate = "Ultimate"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case colorTheme = "ColorTheme"
        case displayName = "DisplayName"
        case id = "InstanceId"
        case ownerId = "OwnerId"
        case fullUrl = "FullUrl"
        case mainImageUrl = "MainImageUrl"
        case thumbnailUrl = "ThumbnailUrl"
        case game = "Game"
        case related = "Related"
    }
}

class Networker {

    static func getCharacters(completion: @escaping (Result<[Character], Error>) -> ()) {
        DispatchQueue(label: "api-call-thread", qos: .utility, attributes: .concurrent).async {
            get([Character].self, from: "/characters") { response in
                completion(response)
            }
        }
    }

    static private let baseUrl = "https://api.kuroganehammer.com/api"

    static private func get<T: Codable>(_ type: T.Type, from path: String, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: "\(Self.baseUrl)\(path)") else {
            completion(.failure(NSError(domain: "url error", code: 400, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let dataResponse = data else {
                    completion(.failure(NSError(domain: "data error", code: 400, userInfo: nil)))
                    return
                }
                let jsonResponse = try JSONDecoder().decode(type, from: dataResponse)
                guard (response as? HTTPURLResponse) != nil else {
                    completion(.failure(NSError(domain: "response error", code: 400, userInfo: nil)))
                    return
                }
                completion(.success(jsonResponse))
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }.resume()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
