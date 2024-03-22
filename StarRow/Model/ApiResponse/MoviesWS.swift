import Foundation

struct MoviesWS {
    
    private let url: String = AppConstant.APIUrl.moviesUrl
    
    func execute(completionHandle: @escaping (_ arrayMovies: [Response.MovieDTO]) -> Void){
        
        guard let url = URL(string: self.url) else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            let movies = self.parseJSON(movieData: data)
            completionHandle(movies)
        }
        task.resume()
    }
    
    func parseJSON(movieData: Data?) -> [Response.MovieDTO]{
        guard let movieData = movieData else { return [] }
        do{
            let decodeData = try JSONDecoder().decode(Response.self, from: movieData)
            return decodeData.results ?? []
        }catch {
            return []
        }
    }
}
