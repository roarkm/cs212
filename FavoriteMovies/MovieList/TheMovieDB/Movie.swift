//
//  Movie.swift
//  TheMovieDB
//
//  Created by Jason on 1/11/15.
//

import UIKit

struct Movie {
    
    struct Keys {
        static let Title = "title"
        static let PosterPath = "poster_path"
        static let Overview = "overview"
    }
    
    var title = ""
    var id = 0
    var posterPath: String? = nil
    var overview = ""
    
    init(dictionary: [String : AnyObject]) {
        title = dictionary[Keys.Title] as! String
        id = dictionary[TMDB.Keys.ID] as! Int
        posterPath = dictionary[Keys.PosterPath] as? String
        overview = dictionary[Keys.Overview] as! String
    }
}

extension Movie {
    
    var JSONForm: AnyObject {
        get {
            var d: [String : AnyObject] = [
                Keys.Title : self.title,
                TMDB.Keys.ID : self.id,
                Keys.Overview : self.overview
            ]
            
            if let path = posterPath {
                d[Keys.PosterPath] = path
            }
            
            return d
        }
    }
}

extension Movie {
    /**
     posterImage is a computed property. From outside of the struct it should look like objects
     have a direct handle to their image. In fact, they store them in an imageCache. The
     cache stores the images into the documents directory, and keeps a resonable number of
     them in memory.
     */
    
    var posterImage: UIImage? {
        
        get {
            return TMDB.Caches.imageCache.imageWithIdentifier(posterPath)
        }
        
        set {
            TMDB.Caches.imageCache.storeImage(newValue, withIdentifier: posterPath!)
        }
    }
}



