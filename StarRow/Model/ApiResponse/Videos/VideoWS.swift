//
//  VideoWS.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 3/04/24.
//

import Foundation
// MARK: Struct Declaration
struct VideoWS{
    func execute(id: Int, completionHandle: @escaping (_ arrayVideos: [VideoDTO.Result]) -> Void){
        let url: String = AppConstant.APIUrl.videoEndPoint(id: id) + ""
        print(url)
        
        guard let url = URL(string: url) else { return }
            
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url){ data, response, error in
            guard error == nil else {
                completionHandle([])
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
                case 400...500:
                    completionHandle([])
                    break
            default:
                guard let data = data else {
                    completionHandle([])
                    return
                }
                print(1)
                let video = self.parseJSON(videoData: data)
                completionHandle(video)
            }
        }
        task.resume()
    }
    
    func parseJSON(videoData: Data?) -> [VideoDTO.Result]{
        guard let videoData = videoData else { return [] }
        do{
            let decodeData = try JSONDecoder().decode(VideoDTO.self, from: videoData)
            return decodeData.results ?? []
        }catch {
            return []
        }
    }
}

