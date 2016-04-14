//
//  MovieListViewController.swift
//  MovieList
//
//  Created by ccsfcomputers on 10/29/15.
//  Copyright (c) 2015 Jason Schatz. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = [Movie]()
    
    // This will store out task for downloading movies.
    var task: NSURLSessionTask?
    
    // Here we make a queue that is guaranteed to execute blocks one at a time
    var serialQueue = dispatch_queue_create("MovieListViewController.SerialQueue", DISPATCH_QUEUE_SERIAL)
    
    
    // MARK: - Search Task
    
    func taskForMoviesWithQuerry(querry: String) -> NSURLSessionTask {
    
        let parameters = ["query" : querry]
        
        let url = TMDBURLs.URLForResource(TMDB.Resources.SearchMovie, parameters: parameters)
        
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
                    self.movies = self.moviesFromData(data)
            
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
                self.movies = [Movie]()
                
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
  
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      let movie = movies[indexPath.row]
//      print(movie)
      let detailVC = MovieDetailViewController()
      detailVC.movie = movie
      self.navigationController?.pushViewController(detailVC, animated: true)
    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    var cellNumber = 0
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TaskAwareTableViewCell
        
        cell.cellNumber = cellNumber++
        
        print("Using Cell: \(cell.cellNumber)")
        
        let movie = movies[indexPath.row]
        
        cell.textLabel!.text = movie.title
        
        // Set the placeholder
        cell.imageView!.image = UIImage(named: "placeHolder")
        moviePosterForPosterPath(movie, completion: {
          image in
          dispatch_async(dispatch_get_main_queue()) {
              cell.imageView!.image = image
          }
        })
      
        return cell
    }
  
    func moviePosterForPosterPath(var movie: Movie, completion:(image: UIImage) -> Void) {
      if movie.posterPath == nil {
          // api node has no imagepath
        completion(image: UIImage(named: "noImage")!)
      } else if let image = movie.posterImage {
          // already cached
        completion(image: image)
      } else {
        // get url,
        let url = TMDBURLs.URLForPosterWithPath(movie.posterPath!)

        // create task
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
          data, response, error in

          if let error = error {
              print(error)
          }

                if let data = data, image = UIImage(data: data) {
                    dispatch_async(dispatch_get_main_queue()) {
                        cell.imageView!.image = image
                    }
                    movie.posterImage = image
                    print("caching \(movie.title)")
                }
            }
            
            // resume task
            cell.taskToCancelWhenReused = task
            task.resume()
            
        }
        
        // resume task
        task.resume()
      }
    }
  
    // MARK: - Parser
    
    func moviesFromData(data: NSData) -> [Movie] {
        // Parse the Data into a JSON Object
        let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
        
        // Insist that this object must be a dictionary
        guard let JSONDictionary = JSONObject as? [String : AnyObject] else {
            assertionFailure("Failed to parse data. data.length: \(data.length)")
            return [Movie]()
        }
        
        // Print the object, for now, so we can take a look
//        print(JSONDictionary)
        let movieDicts = JSONDictionary["results"] as! [[String : AnyObject]]
        return  movieDicts.map() { Movie(dictionary: $0) }
    }
}
