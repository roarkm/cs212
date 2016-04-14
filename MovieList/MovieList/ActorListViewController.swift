//
//  ActorListViewController.swift
//  MovieList
//
//  Created by m on 4/14/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import UIKit

class ActorListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
    var people: [Person] = [Person]()
    
    // This will store out task for downloading movies.
    var task: NSURLSessionTask?
    
    // Here we make a queue that is guaranteed to execute blocks one at a time
    var serialQueue = dispatch_queue_create("ActorListViewController.SerialQueue", DISPATCH_QUEUE_SERIAL)
    
    // MARK: - Search Task
    func taskForMoviesWithQuerry(querry: String) -> NSURLSessionTask {
    
        let parameters = ["query" : querry]
        
        let url = TMDBURLs.URLForResource(TMDB.Resources.SearchPerson, parameters: parameters)
        
        print(url)

        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            dispatch_async(self.serialQueue) {
                
                self.task = nil
                
                // Error
                if let error = error {print(error);return}

                // Data
                if let data = data {
                    self.people = self.peopleFromData(data)
            
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        return task
    }
    
    
    // MARK: - Search Bar Delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        dispatch_async(serialQueue) {
            
            if let task = self.task {
                task.cancel()
            }
            
            if searchText.isEmpty {
                self.task = nil
                self.people = [Person]()
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            } else {
                self.task = self.taskForMoviesWithQuerry(searchText)
                self.task!.resume()
            }
        }
    }
    
    
    // MARK: - Toggle UI while downloading
    
    func setUIToDownloading(isDownloading: Bool) {
        
        if isDownloading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        
        self.activityIndicator.hidden = isDownloading
        self.tableView.alpha = isDownloading ? 0.2 : 1.0
    }
    
    // MARK: - Table View
  
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//      let movie = people[indexPath.row]
////      print(movie)
//      let detailVC = MovieDetailViewController()
//      detailVC.movie = movie
//      self.navigationController?.pushViewController(detailVC, animated: true)
//    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        let person = people[indexPath.row]
        
        cell.textLabel!.text = person.name
        
        // Set the placeholder
        cell.imageView!.image = UIImage(named: "placeHolder")
        personPosterForPosterPath(person, completion: {
          image in
          dispatch_async(dispatch_get_main_queue()) {
              cell.imageView!.image = image
          }
        })
      
        return cell
    }
  
    func personPosterForPosterPath(var person: Person, completion:(image: UIImage) -> Void) {
      if person.imagePath == nil {
          // api node has no imagepath
        completion(image: UIImage(named: "noImage")!)
      } else if let image = person.profileImage {
          // already cached
        completion(image: image)
      } else {
        // get url,
        let url = TMDBURLs.URLForPosterWithPath(person.imagePath!)

        // create task
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
          data, response, error in

          if let error = error {
              print(error)
          }

          if let data = data, image = UIImage(data: data) {
            completion(image: image)
            person.profileImage = image
            print("caching \(person.name)")
          }
        }
        
        // resume task
        task.resume()
      }
    }
  
    // MARK: - Parser
    
    func peopleFromData(data: NSData) -> [Person] {
        // Parse the Data into a JSON Object
        let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
        
        // Insist that this object must be a dictionary
        guard let JSONDictionary = JSONObject as? [String : AnyObject] else {
            assertionFailure("Failed to parse data. data.length: \(data.length)")
            return [Person]()
        }
        
        // Print the object, for now, so we can take a look
//        print(JSONDictionary)
        let movieDicts = JSONDictionary["results"] as! [[String : AnyObject]]
        return  movieDicts.map() { Person(dictionary: $0) }
    }
}