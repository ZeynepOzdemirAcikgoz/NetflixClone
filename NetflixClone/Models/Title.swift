//
//  Movie.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 6.12.2022.
//

import Foundation

struct TrendingTitleResponse: Codable{
    
    let results: [Title]
    
}
struct Title: Codable{
    
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let realese_date: String?
    let vote_average: Double
}





/*
 
 {
adult = 0;
"backdrop_path" = "/dGOhplPZTL0SKyb0ocTFBHIuKUC.jpg";
"first_air_date" = "2019-11-03";
"genre_ids" =             (
 10765,
 18
);
id = 68507;
"media_type" = tv;
name = "His Dark Materials";
"origin_country" =             (
 GB
);
"original_language" = en;
"original_name" = "His Dark Materials";
overview = "Lyra is an orphan who lives in a parallel universe in which science, theology and magic are entwined. Her search for a kidnapped friend uncovers a sinister plot involving stolen children, and turns into a quest to understand a mysterious phenomenon called Dust. She is later joined on her journey by Will, a boy who possesses a knife that can cut windows between worlds. As she learns the truth about her parents and her prophesied destiny, the two young people are caught up in a war against celestial powers that ranges across many worlds.";
popularity = "117.875";
"poster_path" = "/1ljcoM9hFNiXpcoevZQwwc7oCYT.jpg";
"vote_average" = "7.987";
"vote_count" = 1196;
}
 
 */
