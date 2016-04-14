//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by m on 4/14/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

  @IBOutlet weak var summaryTextView: UITextView!
  @IBOutlet weak var posterView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var movie: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    titleLabel.text = movie!.title
    posterView.image = movie!.posterImage!
    summaryTextView.text = ""
    descriptionForMovie(movie!, completion: {
      desc in
      self.movie!.desc = desc
      dispatch_async(dispatch_get_main_queue()) {
          self.summaryTextView.text = desc
      }
    })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func descriptionForMovie(movie: Movie, completion:(desc: String) -> Void) {
    let url = TMDBURLs.URLForResource(TMDB.Resources.MovieID, parameters: ["id" : movie.id])
    print(url)
    print(movie.id)

    // create task
    let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
      data, response, error in

      if let error = error {
          print(error)
      }

      if let data = data {
        completion(desc: self.movieDetailFromData(data))
      }
    }
    
    // resume task
    task.resume()
  }

    func movieDetailFromData(data: NSData) -> String {
        // Parse the Data into a JSON Object
        let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
        
        // Insist that this object must be a dictionary
        guard let JSONDictionary = JSONObject as? [String : AnyObject] else {
            assertionFailure("Failed to parse data. data.length: \(data.length)")
            return ""
        }
        
        // Print the object, for now, so we can take a look
        print(JSONDictionary)
//        let  = JSONDictionary["results"] as! [[String : AnyObject]]
//        return  movieDicts.map() { Movie(dictionary: $0) }
      return JSONDictionary["overview"] as! String
    }
  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}
