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
    var photo: UIImage?
    var story: String
    
    
    // MARK: Initalization
    init?(headline: String, photo: UIImage?, story: String){
        
        // Headline must not be empty
        guard !headline.isEmpty else {
            return nil
        }
        
        // Initialize stored properties
        self.headline = headline
        self.photo = photo
        self.story = story
        
    }
    
}



