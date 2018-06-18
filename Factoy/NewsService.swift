
import Foundation
import Alamofire
import AlamofireImage

class NewsService {
    
    func getNews(_ callBack:@escaping([Preview]) -> Void){

        // Validating URL response
        let url = "https://newsapi.org/v1/articles?apiKey=6946d0c07a1c4555a4186bfcade76398&sortBy=top&source=bbc-news"
        Alamofire.request(url)
            .validate()
            .responseJSON
            {
                response in
                
                switch response.result
                {
                case .success:
                    print("Validation Successful")
                    
                    // Parsing data
                    let JSON = response.result.value as! [String: Any]
                    let JSONArticles = JSON["articles"] as! NSArray
                    for Articles in JSONArticles
                    {
                        // Saving important values
                        var Values = Articles as! [String: String]
                        let headline = (Values["title"] as String?) ?? ""
                        let photo_url = (Values["urlToImage"] as String?) ?? ""
                        let story = (Values["description"] as String?) ?? ""
                        
                        guard let preview = Preview(headline: headline, photo_url: photo_url, story: story) else
                        {
                            errorOccured()
                            return
                        }
                        print(preview)
                        print([preview])
                        callBack([preview])
                    }
                    
                case .failure(let error):
                    errorOccured(value: error)
                }
            }
    }
    
}
