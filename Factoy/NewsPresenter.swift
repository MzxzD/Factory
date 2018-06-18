import Foundation


struct NewsViewData {
    
    let headline: String
    let image_url: String
    let story: String
}

protocol NewsView {
    
    func startLoading()
    func fininshLoading()
    func setNews(_ news: [NewsViewData])
    func setEmptyNews()
}

class NewsPresenter {
    
    fileprivate let newsService:NewsService
    fileprivate var newsView:NewsView?
    
    init(newsService:NewsService) {
        self.newsService = newsService
    }
    
    func attachView(_ view:NewsView){
        newsView = view
    }
    
    func detachView(){
        newsView = nil
    }
    
    func getNews(){
        self.newsView?.startLoading()
        newsService.getNews{[weak self] news in
            self?.newsView?.fininshLoading()
            if(news.count == 0){
                self?.newsView?.setEmptyNews()
            }else{
                let mappedNews = news.map{
                    return NewsViewData(headline: "\($0.headline)", image_url: "\($0.photo_url)", story: "\($0.story)")
                }
                self?.newsView?.setNews(mappedNews)
            }
 
        }
        
    }
    
    
}
