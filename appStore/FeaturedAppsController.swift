//
//  FeaturedAppsController.swift
//  appStore
//
//  Created by Edward on 2/2/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class FeaturedAppsController {
    
    static func fetchFeaturedApps(completionHandler: @escaping ([AppCategory]) -> ()) {
        let urlString = "http://www.statsallday.com/appstore/featured"
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if statusCode == 200 {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    
                    var appCategories = [AppCategory]()
                    
                    if let categories = json["categories"] as? [[String: AnyObject]] {
                        
                        for category in categories {
                            let appCategory = AppCategory()
                            appCategory.setValuesForKeys(category)
                            appCategories.append(appCategory)
                        }
                    }
                    
                    // Completion handler "returns" the value of our populated appCategories
                    DispatchQueue.main.async(execute: {
                        completionHandler(appCategories)
                    })
                    
                } catch {
                    print("Error with JSON: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    static func sampleAppCategories() -> [AppCategory] {
        // Create one new category
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var bestNewApps = [App]()
        
        // Create an app to place in the category
        let frozenApp = App()
        frozenApp.name = "Disney Build It: Frozen"
        frozenApp.imageName = "frozen"
        frozenApp.category = "Entertainment"
        frozenApp.price = NSNumber(floatLiteral: 3.99)
        
        bestNewApps.append(frozenApp)
        
        // Create one new category
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestGameApps = [App]()
        
        // Create an app to place in the category
        let telepaint = App()
        telepaint.name = "Telepaint"
        telepaint.imageName = "telepaint"
        telepaint.category = "Games"
        telepaint.price = NSNumber(floatLiteral: 2.99)
        
        bestGameApps.append(telepaint)
        bestNewGamesCategory.apps = bestGameApps
        
        
        return [bestNewAppsCategory, bestNewGamesCategory]
    }
}
