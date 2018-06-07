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
    
    
    // MARK: Initalization
    init?(headline: String, photo: UIImage?){
        
        // Headline must not be empty
        guard !headline.isEmpty else {
            return nil
        }
        
        // Initialize stored properties
        self.headline = headline
        self.photo = photo
        
    }
    
}



