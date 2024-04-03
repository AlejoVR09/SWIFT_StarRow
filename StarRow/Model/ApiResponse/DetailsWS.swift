//
//  DetailsWS.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 7/02/24.
//

import Foundation

// MARK: Struct Declaration
struct DetailsWS {
    func execute(id: Int, completionHandle: @escaping (_ arrayMovies: DetailsWS.MovieDTO?) -> Void){
        let url: String = AppConstant.APIUrl.detailsEndPoint(id: id)
        
        guard let url = URL(string: url) else { return }
            
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url){ data, response, error in
            guard error == nil else {
                completionHandle(nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
                case 400...500:
                    completionHandle(nil)
                    break
            default:
                guard let imageData = data else {
                    completionHandle(nil)
                    return
                }
                let movie = self.parseJSON(movieData: imageData)
                completionHandle(movie)
            }
        }
        task.resume()
    }
    
    func parseJSON(movieData: Data?) -> MovieDTO{
        guard let movieData = movieData else { return MovieDTO.getDTIO()
    }
        
        do{
            let decodeData = try JSONDecoder().decode(MovieDTO.self, from: movieData)
            return decodeData
        }catch {
            return MovieDTO.getDTIO()
        }
    }
}
