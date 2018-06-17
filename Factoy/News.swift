//
//  PreviewData.swift
//  Factoy
//
//  Created by Mateo Došlić on 07/06/2018.
//  Copyright © 2018 Mateo Došlić. All rights reserved.
//

import UIKit

class Preview: NSObject {
    
    // MARK: properties
    
    var headline: String
    var photo_url: String
    var story: String
    
    
    // MARK: Initalization
    init?(headline: String, photo_url: String, story: String){
        
        // Headline must not be empty
        guard !headline.isEmpty else {
            return nil
        }
        
        // Initialize stored properties
        self.headline = headline
        self.photo_url = photo_url
        self.story = story
        
    }
    
}



