//
//  PreviewData.swift
//  Factoy
//
//  Created by Mateo Došlić on 07/06/2018.
//  Copyright © 2018 Mateo Došlić. All rights reserved.
//

import UIKit

struct News: Decodable {
    
    // MARK: properties
    let status: String
    let source: String
    let sortBy: String
    let articles: [Articles]
}


struct Articles: Decodable {
    
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
}





