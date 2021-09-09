//
//  NetworkDataFetcher.swift
//  TestProject_Nasa
//
//  Created by Mike on 09.09.2021.
//

import Foundation

//API key - oIVaSoj8Rc2L3tkhxxvShcbzKLQwaBcSnvHeMPPi
//example request - https://api.nasa.gov/planetary/apod?api_key=oIVaSoj8Rc2L3tkhxxvShcbzKLQwaBcSnvHeMPPi

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchPhotos(response: @escaping (Photos?) -> Void) {
        networkService.request(urlString: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2021-9-7&api_key=oIVaSoj8Rc2L3tkhxxvShcbzKLQwaBcSnvHeMPPi") { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Photos.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}

