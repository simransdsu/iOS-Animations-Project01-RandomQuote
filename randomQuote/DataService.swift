//
//  DataService.swift
//  randomQuote
//
//  Created by Sandy L on 2016-03-08.
//  Copyright © 2016 Sandy L. All rights reserved.
//


import Foundation
import UIKit


class DataService {
    
    func getQuoteData(completion:@escaping (_ quote: String, _ author: String?) -> ()) {
        
        let url = URL(string: "https://uselessfacts.jsph.pl/random.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                
                guard let data = data,
                      let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, String> else {
                    return
                }
                
                let aQuote = jsonDictionary["text", default: "N/A"]
                let aAuthor = jsonDictionary["source", default: "N/A"]
            
                DispatchQueue.main.async {
                    print(aQuote, aAuthor)
                    completion(aQuote, aAuthor)
                }
            } catch {
                print("invalid json query")
            }
        }.resume()
    }
    
}
