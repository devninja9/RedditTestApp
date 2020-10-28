//
//  RedditClient.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import Combine

struct Agent {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum RedditAPI {
    static let agent = Agent()
    static let base = URL(string: "https://www.reddit.com/.json")!
}

extension RedditAPI {
    static func fetchPost() -> AnyPublisher<PostData, Error> {
        let request = URLRequest(url: base)
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
